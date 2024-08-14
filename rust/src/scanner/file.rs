use std::ffi::OsStr;

use levenshtein::levenshtein;
use sha2::Digest;
use sha2::Sha256;

use super::difference::Difference;

pub struct File {
    pub path: String,
    pub name: String,
    pub size: u64,
}

impl File {
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
        let mut buffer = vec![0; 1024 * 1024];
        let mut file = std::fs::File::open(&self.path)?;
        let _ = std::io::Read::read(&mut file, &mut buffer)?;
        // buffer.truncate(bytes_read);
        let mut hasher = Sha256::new();
        hasher.update(&buffer);
        let result = hasher.finalize();
        anyhow::Ok(format!("{:x}", result))
    }

    pub fn compare_hash(&self, other: &File) -> bool {
        if let Ok(hash1) = self.get_file_hash() {
            if let Ok(hash2) = other.get_file_hash() {
                return hash1 == hash2;
            }
        }

        false
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
        self.size == other.size && self.compare_hash(other)
    }
}
