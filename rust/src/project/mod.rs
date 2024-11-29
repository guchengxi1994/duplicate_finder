use std::sync::RwLock;

use walkdir::WalkDir;

use crate::frb_generated::StreamSink;

fn get_file_size(path: &String) -> u64 {
    let meta = std::fs::metadata(path);
    match meta {
        Ok(m) => m.len(),
        Err(_) => 0,
    }
}

fn get_folder_size(path: &String) -> anyhow::Result<u64> {
    let mut size: u64 = 0;
    for entry in WalkDir::new(&path).into_iter().filter_map(|e| e.ok()) {
        if entry.path().is_file() {
            let l = entry.path().display().to_string();
            size += get_file_size(&l);
        }
    }

    anyhow::Ok(size)
}

#[derive(Debug)]
pub struct ProjectDetail {
    pub path: String,
    pub size: u64,
}

pub static PROJECT_DETAIL_SINK: RwLock<Option<StreamSink<ProjectDetail>>> = RwLock::new(None);

fn send_detail_event(p: String, si: u64) {
    match PROJECT_DETAIL_SINK.try_read() {
        Ok(s) => match s.as_ref() {
            Some(s0) => {
                let _ = s0.add(ProjectDetail { path: p, size: si });
            }
            None => {
                println!("[rust-error] Stream is None");
            }
        },
        Err(_) => {
            println!("[rust-error] Stream read error");
        }
    }
}

pub struct ProjectView(pub String);

impl ProjectView {
    pub async fn scan(&self) -> anyhow::Result<()> {
        for entry in WalkDir::new(&self.0)
            .max_depth(1)
            .into_iter()
            .filter_map(|e| e.ok())
        {
            if entry.path() == std::path::Path::new(&self.0) {
                // 跳过起始目录
                continue;
            }
            let l = entry.path().display().to_string();
            println!("[rust] scanning {:?}", l);
            if entry.path().is_file() {
                let size = get_file_size(&l);
                send_detail_event(l, size);
            } else {
                let size = get_folder_size(&l);
                match size {
                    Ok(_u) => {
                        send_detail_event(l, _u);
                    }
                    Err(_e) => {
                        println!("project view Error: {:?}", _e)
                    }
                }
            }
        }

        anyhow::Ok(())
    }
}
