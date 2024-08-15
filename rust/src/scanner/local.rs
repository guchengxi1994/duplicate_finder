use std::{sync::mpsc, thread};

use walkdir::WalkDir;

use super::{
    compare_result::{CompareResult, SCANNER_COMPARE_RESULTS_SINK},
    event::{Event, EVENT_SINK},
    file::{File, GLOBAL_FILESET},
    interface::Scanner,
};

pub struct LocalScanner(pub String);

const LIMIT: usize = 100;

#[async_trait::async_trait]
impl Scanner for LocalScanner {
    async fn scan(&self) -> anyhow::Result<()> {
        let (tx, rx) = mpsc::channel::<Option<String>>();
        let s = self.0.clone();

        send_event("LocalScanner".to_string(), "scan start".to_string());

        thread::spawn(move || {
            for entry in WalkDir::new(&s).into_iter().filter_map(|e| e.ok()) {
                if entry.path().is_file() {
                    let l = entry.path().display().to_string();
                    // 发送文件路径
                    tx.send(Some(l)).unwrap();
                }
            }
            // 发送结束信号
            tx.send(None).unwrap();
        });

        let mut path_list: Vec<String> = Vec::new();

        for received in rx {
            match received {
                Some(path) => {
                    path_list.push(path);
                    let _ = Self::store_results(path_list.clone()).await;
                    if path_list.len() >= LIMIT {
                        // 达到限制，清空列表
                        path_list.clear();
                    }
                }
                None => {
                    let _ = self.on_finished();
                    break;
                }
            }
        }

        anyhow::Ok(())
    }

    fn on_finished(&self) -> anyhow::Result<()> {
        let fileset;
        {
            fileset = GLOBAL_FILESET.read().unwrap();
        }

        let compare_result = CompareResult::from_set(fileset.clone());

        match SCANNER_COMPARE_RESULTS_SINK.try_read() {
            Ok(s) => match s.as_ref() {
                Some(s0) => {
                    let _ = s0.add(compare_result);
                }
                None => {
                    println!("[rust-error] Stream is None");
                }
            },
            Err(_) => {
                println!("[rust-error] Stream read error");
            }
        }

        send_event("LocalScanner".to_string(), "done".to_string());

        anyhow::Ok(())
    }

    async fn store_results(p: Vec<String>) -> anyhow::Result<()> {
        let mut results: Vec<File> = Vec::new();
        for path in p {
            if let Ok(f) = File::from_path(path) {
                results.push(f);
            }
        }

        let mut fileset = GLOBAL_FILESET.write().unwrap();
        (*fileset).update_list(results);
        anyhow::Ok(())
    }
}

fn send_event(event_type: String, data: String) {
    match EVENT_SINK.try_read() {
        Ok(s) => match s.as_ref() {
            Some(s0) => {
                let _ = s0.add(Event { event_type, data });
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
