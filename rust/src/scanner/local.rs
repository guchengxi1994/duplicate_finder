use std::{
    sync::{mpsc, Arc, RwLock},
    thread,
};

use walkdir::WalkDir;

use super::{
    compare_result::CompareResult,
    event::{CompareEvent, DoneEvent, ResEvent, ScannerEvent, EVENT_SINK},
    file::{File, GLOBAL_FILESET},
    interface::Scanner,
};

pub struct LocalScanner(pub String);

const LIMIT: usize = 100;

#[async_trait::async_trait]
impl Scanner for LocalScanner {
    async fn scan(&self) -> anyhow::Result<()> {
        let (tx, rx) = mpsc::channel::<String>();
        let s = self.0.clone();

        let begin_time = std::time::SystemTime::now();

        // send_event("LocalScanner".to_string(), "scan start".to_string());
        send_scanner_event("LocalScanner".to_string(), 0, 0.0);

        let total = Arc::new(RwLock::new(0));

        {
            let total = Arc::clone(&total);
            thread::spawn(move || {
                for entry in WalkDir::new(&s).into_iter().filter_map(|e| e.ok()) {
                    if entry.path().is_file() {
                        {
                            let mut total_write = total.write().unwrap();
                            *total_write += 1;
                        }

                        let l = entry.path().display().to_string();
                        // 发送文件路径
                        tx.send(l).unwrap();
                    }
                }
            });
        }

        let mut path_list: Vec<String> = Vec::new();

        for received in rx {
            path_list.push(received);
            if path_list.len() >= LIMIT {
                let count = *total.read().unwrap();
                let current = std::time::SystemTime::now();
                // send_event("LocalScanner".to_string(), count);
                send_scanner_event(
                    "LocalScanner".to_string(),
                    count,
                    current.duration_since(begin_time).unwrap().as_secs_f32(),
                );
                Self::store_results(path_list.clone())?;
                // 达到限制，清空列表
                path_list.clear();
            }
        }

        Self::store_results(path_list.clone())?;
        let current = std::time::SystemTime::now();

        let count = *total.read().unwrap();
        send_scanner_event(
            "LocalScanner".to_string(),
            count,
            current.duration_since(begin_time).unwrap().as_secs_f32(),
        );
        self.on_finished()?;
        send_done_event("LocalScanner".to_string());
        anyhow::Ok(())
    }

    fn on_finished(&self) -> anyhow::Result<()> {
        let begin_time = std::time::SystemTime::now();

        let fileset;
        {
            fileset = GLOBAL_FILESET.read().unwrap();
        }

        let compare_result = CompareResult::from_set(fileset.clone());

        compare_result.refresh();

        let current = std::time::SystemTime::now();

        send_compare_event(
            "LocalScanner".to_string(),
            current.duration_since(begin_time).unwrap().as_secs_f32(),
        );

        // send_event("LocalScanner".to_string(), "done".to_string());

        anyhow::Ok(())
    }

    fn store_results(p: Vec<String>) -> anyhow::Result<()> {
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

fn send_scanner_event(event_type: String, count: u64, duration: f32) {
    match EVENT_SINK.try_read() {
        Ok(s) => match s.as_ref() {
            Some(s0) => {
                let _ = s0.add(ResEvent::ScannerEvent(ScannerEvent {
                    event_type,
                    count,
                    duration,
                }));
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

fn send_compare_event(event_type: String, duration: f32) {
    match EVENT_SINK.try_read() {
        Ok(s) => match s.as_ref() {
            Some(s0) => {
                let _ = s0.add(ResEvent::CompareEvent(CompareEvent {
                    event_type,
                    duration,
                }));
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

fn send_done_event(event_type: String) {
    match EVENT_SINK.try_read() {
        Ok(s) => match s.as_ref() {
            Some(s0) => {
                let _ = s0.add(ResEvent::DoneEvent(DoneEvent {
                    event_type,
                    is_done: true,
                }));
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
