use std::{collections::HashMap, sync::RwLock};

use crate::frb_generated::StreamSink;

use super::file::{File, FileSet};

#[derive(Debug)]
pub struct CompareResult {
    pub index: u64,
    pub file_size: u64,
    pub all_same_files: Vec<Vec<File>>,
    pub count: u64,
}

#[derive(Debug)]
pub struct CompareResults(pub Vec<CompareResult>);

impl CompareResult {
    pub fn from_set(set: FileSet) -> CompareResults {
        let mut i = 0;
        let mut result = Vec::new();
        for (file_size, files) in set.0 {
            i += 1;
            let r = Self::group_files(files);
            result.push(CompareResult {
                index: i,
                file_size,
                all_same_files: r.0,
                count: r.1,
            });
        }

        CompareResults(result)
    }

    fn group_files(files: Vec<File>) -> (Vec<Vec<File>>, u64) {
        if files.len() == 1 {
            return (vec![files], 1);
        }

        let mut map: HashMap<File, Vec<File>> = HashMap::new();
        let mut count = 0;
        for file in files {
            count += 1;
            map.entry(file.clone()).or_insert_with(Vec::new).push(file);
        }

        println!("map.keys().len(): {:?}", map.keys().len());

        // 提取 HashMap 中的所有值，转换为 Vec<Vec<File>>
        (map.into_values().collect(), count)
    }
}

pub static SCANNER_COMPARE_RESULTS_SINK: RwLock<Option<StreamSink<CompareResults>>> =
    RwLock::new(None);
