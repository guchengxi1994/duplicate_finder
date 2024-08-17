use std::{
    sync::{mpsc, Arc, RwLock},
    thread,
};

use walkdir::WalkDir;

use super::{
    compare_result::CompareResult,
    event::{Event, EVENT_SINK},
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

        send_event("LocalScanner".to_string(), "scan start".to_string());

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
                let count = format!("{}", *total.read().unwrap());
                send_event("LocalScanner".to_string(), count);
                Self::store_results(path_list.clone())?;
                // 达到限制，清空列表
                path_list.clear();
            }
        }

        Self::store_results(path_list.clone())?;
        let count = format!("{}", *total.read().unwrap());
        send_event("LocalScanner".to_string(), count);
        self.on_finished()?;

        anyhow::Ok(())
    }

    fn on_finished(&self) -> anyhow::Result<()> {
        let fileset;
        {
            fileset = GLOBAL_FILESET.read().unwrap();
        }

        let compare_result = CompareResult::from_set(fileset.clone());

        // match SCANNER_COMPARE_RESULTS_SINK.try_read() {
        //     Ok(s) => match s.as_ref() {
        //         Some(s0) => {
        //             let _ = s0.add(compare_result.clone());
        //         }
        //         None => {
        //             println!("[rust-error] Stream is None");
        //         }
        //     },
        //     Err(_) => {
        //         println!("[rust-error] Stream read error");
        //     }
        // }

        compare_result.refresh();

        send_event("LocalScanner".to_string(), "done".to_string());

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
