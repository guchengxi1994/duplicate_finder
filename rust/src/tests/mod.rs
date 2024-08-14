#[allow(unused_imports)]
mod tests {
    use levenshtein::levenshtein;

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
}
