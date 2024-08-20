#[allow(unused_imports)]
mod tests {
    use levenshtein::levenshtein;
    use walkdir::WalkDir;

    use crate::tools::{
        move_file_to_trash::move_file_to_trash,
        openfile_and_highlight::open_folder_and_highlight_file,
    };

    #[test]
    fn test_similar() {
        let a = "Hello World\nThis is the second line.\nThis is the third.";
        let b = "Hallo Welt\nThis is the second line.\nThis is life.\nMoar and more";

        let diff = levenshtein(a, b);

        println!("{}", diff);

        let max_value = std::cmp::max(a.len(), b.len());

        let similarity = 1.0 - (diff as f64 / max_value as f64);

        println!("{}", similarity)
    }

    #[test]
    fn test_scan() {
        let s = r"D:\github_repo\duplicate_finder";
        let mut count = 0;
        for entry in WalkDir::new(&s).into_iter().filter_map(|e| e.ok()) {
            if entry.path().is_file() {
                count += 1;
                let l = entry.path().display().to_string();
                // 发送文件路径
                println!("{}", l);
            }
        }

        println!("{}", count);
    }

    #[test]
    fn openfile_and_highlight_test() {
        open_folder_and_highlight_file(r"D:\github_repo\duplicate_finder\rust\Cargo.toml")
    }

    #[test]
    fn move_file_to_trash_test() {
        let _ = move_file_to_trash(r"D:\duplicate_finder\README.md");
    }
}
