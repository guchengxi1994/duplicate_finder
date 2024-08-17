use super::file::{File, FileSet};
use crate::frb_generated::StreamSink;
use std::{collections::HashMap, sync::RwLock};

#[derive(Debug, Clone)]
pub struct CompareResult {
    pub index: u64,
    pub file_size: u64,
    pub all_same_files: Vec<Vec<File>>,
    pub count: u64,
}

#[derive(Debug, Clone)]
pub struct CompareResults(pub Vec<CompareResult>);

impl CompareResult {
    pub fn from_set(set: FileSet) -> CompareResults {
        let mut results = Vec::new();
        for (i, (file_size, files)) in set.0.into_iter().enumerate() {
            let count = files.len() as u64;
            results.push(CompareResult {
                index: i as u64 + 1,
                file_size,
                all_same_files: vec![files],
                count,
            });
        }
        CompareResults(results)
    }

    pub fn group_files(files: Vec<File>) -> (Vec<Vec<File>>, u64) {
        let mut map: HashMap<File, Vec<File>> = HashMap::new();
        let mut count = 0;
        for file in files {
            count += 1;
            map.entry(file.clone()).or_insert_with(Vec::new).push(file);
        }
        (map.into_values().collect(), count)
    }
}

impl CompareResults {
    pub fn refresh(&self) {
        if let Some(sink) = SCANNER_REFRESH_RESULTS_SINK.read().unwrap().as_ref() {
            for result in &self.0 {
                let file_size = result.file_size;
                let r = CompareResult::group_files(result.all_same_files[0].clone());
                let grouped_files = r.0;
                let _ = sink.add(CompareResult {
                    index: result.index,
                    all_same_files: grouped_files,
                    file_size,
                    count: r.1,
                });
            }
        }
    }
}

// pub static SCANNER_COMPARE_RESULTS_SINK: RwLock<Option<StreamSink<CompareResults>>> =
//     RwLock::new(None);

pub static SCANNER_REFRESH_RESULTS_SINK: RwLock<Option<StreamSink<CompareResult>>> =
    RwLock::new(None);
