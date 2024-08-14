#[async_trait::async_trait]
pub trait Scanner {
    async fn scan(&self) -> anyhow::Result<()>;

    async fn store_results(p: Vec<String>) -> anyhow::Result<()>;
}
