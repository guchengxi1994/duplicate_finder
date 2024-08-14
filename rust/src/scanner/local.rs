use std::{sync::mpsc, thread};

use walkdir::WalkDir;

use super::{file::File, interface::Scanner};

pub struct LocalScanner(String);

const LIMIT: usize = 100;

#[async_trait::async_trait]
impl Scanner for LocalScanner {
    async fn scan(&self) -> anyhow::Result<()> {
        let (tx, rx) = mpsc::channel::<String>();
        let s = self.0.clone();

        thread::spawn(move || {
            for entry in WalkDir::new(&s).into_iter().filter_map(|e| e.ok()) {
                if entry.path().is_file() {
                    let l = entry.path().display().to_string();
                    tx.send(l).unwrap();
                }
            }
        });

        let mut path_list: Vec<String> = Vec::new();

        for received in rx {
            path_list.push(received);
            if path_list.len() >= LIMIT {
                path_list.clear();
            }
        }

        anyhow::Ok(())
    }

    async fn store_results(p: Vec<String>) -> anyhow::Result<()> {
        let mut results: Vec<File> = Vec::new();
        for path in p {
            if let Ok(f) = File::from_path(path) {
                results.push(f);
            }
        }

        anyhow::Ok(())
    }
}
