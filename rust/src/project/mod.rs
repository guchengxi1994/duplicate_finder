use std::{sync::RwLock, thread};

use crossbeam::channel;
use walkdir::WalkDir;

use crate::frb_generated::StreamSink;

fn get_file_size(path: &String) -> u64 {
    let meta = std::fs::metadata(path);
    match meta {
        Ok(m) => m.len(),
        Err(_) => 0,
    }
}

fn get_folder_size(path: &String) -> anyhow::Result<(u64, u64)> {
    let mut size: u64 = 0;
    let mut count: u64 = 0;
    for entry in WalkDir::new(&path).into_iter().filter_map(|e| e.ok()) {
        if entry.path().is_file() {
            let l = entry.path().display().to_string();
            size += get_file_size(&l);
            count += 1;
        }
    }

    anyhow::Ok((size, count))
}

#[derive(Debug)]
pub struct ProjectDetail {
    pub path: String,
    pub size: u64,
    pub count: u64,
}

pub static PROJECT_DETAIL_SINK: RwLock<Option<StreamSink<ProjectDetail>>> = RwLock::new(None);

fn send_detail_event(p: String, si: u64, count: u64) {
    let d = ProjectDetail {
        path: p,
        size: si,
        count,
    };
    send_detail_event_(d);
}

fn send_detail_event_(d: ProjectDetail) {
    match PROJECT_DETAIL_SINK.try_read() {
        Ok(s) => match s.as_ref() {
            Some(s0) => {
                let _ = s0.add(d);
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
                send_detail_event(l, size, 1);
            } else {
                let size = get_folder_size(&l);
                match size {
                    Ok(_u) => {
                        send_detail_event(l, _u.0, _u.1);
                    }
                    Err(_e) => {
                        println!("project view Error: {:?}", _e)
                    }
                }
            }
        }

        send_detail_event("last".to_string(), 0, 0);

        anyhow::Ok(())
    }

    pub async fn scan_in_multi_threads(&self) -> anyhow::Result<()> {
        let (sender, receiver) = channel::unbounded::<String>();

        // 生产者线程：扫描路径并将路径发送到通道
        let producer = thread::spawn({
            let root_path = self.0.clone();
            let sender = sender.clone();
            move || {
                for entry in WalkDir::new(&root_path)
                    .max_depth(1)
                    .into_iter()
                    .filter_map(|e| e.ok())
                {
                    if entry.path() == std::path::Path::new(&root_path) {
                        continue; // 跳过根目录
                    }
                    sender
                        .send(entry.path().display().to_string())
                        .expect("Failed to send path");
                }
            }
        });

        // 消费者线程：处理路径
        let mut consumers = Vec::new();
        for _ in 0..4 {
            let receiver = receiver.clone();
            let consumer = thread::spawn(move || {
                while let Ok(path) = receiver.recv() {
                    if let Ok(detail) = ProjectView::process_path(&path) {
                        send_detail_event_(detail);
                    }
                }
            });
            consumers.push(consumer);
        }

        // 等待生产者完成
        producer.join().expect("Producer thread panicked");
        drop(sender); // 关闭发送端，通知消费者退出

        // 等待消费者完成
        for consumer in consumers {
            consumer.join().expect("Consumer thread panicked");
        }

        send_detail_event("last".to_string(), 0, 0);

        anyhow::Ok(())
    }

    fn process_path(path: &str) -> anyhow::Result<ProjectDetail> {
        let metadata = std::fs::metadata(path)?;
        if metadata.is_dir() {
            let (size, count) = get_folder_size(&path.to_string())?;
            return Ok(ProjectDetail {
                path: path.to_string(),
                size,
                count,
            });
        } else if metadata.is_file() {
            let size = get_file_size(&path.to_string());
            return Ok(ProjectDetail {
                path: path.to_string(),
                size,
                count: 1,
            });
        }
        anyhow::bail!("Invalid path or unknown type")
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_file_size() {
        let path = "C:\\Users\\Administrator\\Desktop\\test.txt";
        let size = get_file_size(&path.to_string());
        println!("size: {}", size);
    }

    #[tokio::test]
    async fn test_scan() -> anyhow::Result<()> {
        let p = ProjectView(r"D:\github_repo".to_string());
        p.scan_in_multi_threads().await?;

        anyhow::Ok(())
    }
}
