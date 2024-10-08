use std::collections::HashMap;
use std::ffi::OsStr;
use std::hash::DefaultHasher;
use std::hash::Hash;
use std::hash::Hasher;
use std::sync::RwLock;

use levenshtein::levenshtein;
use once_cell::sync::Lazy;
use serde::Deserialize;
use serde::Serialize;
use sha2::Digest;
use sha2::Sha256;

use super::difference::Difference;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct File {
    pub path: String,
    pub name: String,
    pub size: u64,
}

impl Hash for File {
    fn hash<H: std::hash::Hasher>(&self, state: &mut H) {
        self.size.hash(state);
    }
}

impl File {
    pub fn default_hash(&self) -> u64 {
        let mut hasher = DefaultHasher::new();
        self.hash(&mut hasher);
        hasher.finish()
    }

    pub fn from_path(s: String) -> anyhow::Result<Self> {
        let path = std::path::Path::new(&s);
        let name = path
            .file_name()
            .unwrap_or(OsStr::new(""))
            .to_str()
            .unwrap_or("")
            .to_string();
        if name == "" {
            anyhow::bail!("Invalid path")
        }

        let size = path.metadata()?.len();
        anyhow::Ok(File {
            path: s,
            name,
            size,
        })
    }

    pub fn get_file_hash(&self) -> anyhow::Result<String> {
        if self.size == 0 {
            return Ok("".to_string());
        }

        let mut buffer = vec![0; 1024];
        let mut file = std::fs::File::open(&self.path)?;
        let _ = std::io::Read::read(&mut file, &mut buffer)?;
        // buffer.truncate(bytes_read);
        let mut hasher = Sha256::new();
        hasher.update(&buffer);
        let result = hasher.finalize();
        anyhow::Ok(format!("{:x}", result))
    }

    pub fn get_full_hash(&self) -> anyhow::Result<String> {
        if self.size == 0 {
            return Ok("".to_string());
        }

        let mut buffer = vec![0; 1024 * 1024];
        let mut file = std::fs::File::open(&self.path)?;
        let mut hasher = Sha256::new();

        loop {
            // 读取文件中的一块内容
            let bytes_read = std::io::Read::read(&mut file, &mut buffer)?;
            if bytes_read == 0 {
                break; // 文件读取完毕
            }

            // 将读取的内容写入哈希计算器
            hasher.update(&buffer[..bytes_read]);
        }

        // 计算最终的哈希值
        let result = hasher.finalize();

        // 将哈希值转换为十六进制字符串
        let hash_string = format!("{:x}", result);

        Ok(hash_string)
    }

    pub fn compare_hash(&self, other: &File) -> bool {
        let self_simple_hash =
            self.get_or_insert_hash(&GLOBAL_FILE_HASH, |file| file.get_file_hash());
        let other_simple_hash =
            other.get_or_insert_hash(&GLOBAL_FILE_HASH, |file| file.get_file_hash());

        if self_simple_hash != other_simple_hash {
            return false;
        }

        let self_full_hash =
            self.get_or_insert_hash(&GLOBAL_FILE_FULL_HASH, |file| file.get_full_hash());
        let other_full_hash =
            other.get_or_insert_hash(&GLOBAL_FILE_FULL_HASH, |file| file.get_full_hash());

        self_full_hash == other_full_hash
    }

    fn get_or_insert_hash<F>(&self, map: &RwLock<HashMap<String, String>>, hash_fn: F) -> String
    where
        F: Fn(&File) -> anyhow::Result<String>,
    {
        let key = self.path.clone();
        let mut binding = map.write().unwrap();
        binding
            .entry(key.clone())
            .or_insert_with(|| hash_fn(self).unwrap_or_default())
            .clone()
    }

    pub fn fuzzy_compare(&self, other: &File) -> Difference {
        let max_value = std::cmp::max(self.name.len(), other.name.len());
        let distance = levenshtein(&self.name, &other.name);
        let similarity = 1.0 - (distance as f64 / max_value as f64);

        Difference {
            distance,
            similarity,
        }
    }
}

impl Eq for File {}

impl PartialEq for File {
    fn eq(&self, other: &Self) -> bool {
        if self.size == 0 && other.size == 0 {
            return true;
        }

        if self.size != other.size {
            return false;
        }

        self.compare_hash(other)
    }
}

#[derive(Debug, Clone)]
pub struct FileSet(pub HashMap<u64, Vec<File>>);

impl FileSet {
    pub fn new() -> Self {
        FileSet(HashMap::new())
    }

    pub fn update_list(&mut self, files: Vec<File>) {
        for file in files {
            if self.0.contains_key(&file.size) {
                self.0.get_mut(&file.size).unwrap().push(file);
            } else {
                self.0.insert(file.size, vec![file]);
            }
        }
    }

    pub fn clear(&mut self) {
        self.0.clear();
    }
}

pub static GLOBAL_FILESET: Lazy<RwLock<FileSet>> = Lazy::new(|| RwLock::new(FileSet::new()));

pub static GLOBAL_FILE_HASH: Lazy<RwLock<HashMap<String, String>>> =
    Lazy::new(|| RwLock::new(HashMap::new()));

pub static GLOBAL_FILE_FULL_HASH: Lazy<RwLock<HashMap<String, String>>> =
    Lazy::new(|| RwLock::new(HashMap::new()));
