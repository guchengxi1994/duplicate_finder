#[derive(PartialEq, PartialOrd)]
pub struct Difference {
    pub distance: usize,
    pub similarity: f64,
}

impl Eq for Difference {}

impl Ord for Difference {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.similarity.total_cmp(&other.similarity)
    }
}
