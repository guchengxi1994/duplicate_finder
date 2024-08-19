pub fn move_file_to_trash(file_path: &str) -> anyhow::Result<()> {
    trash::delete(file_path)?;

    anyhow::Ok(())
}
