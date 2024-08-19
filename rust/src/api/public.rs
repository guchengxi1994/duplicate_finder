const FILE_REMOVE_SUCCESS: &str = "File removed successfully";
const FILE_REMOVE_FAILED: &str = "Failed to remove file";


#[derive(Debug)]
pub struct OperationResult{
    pub success: bool,
    pub message: String,
}

impl OperationResult {
    pub fn file_remove_ok()->Self{
        OperationResult{
            success: true,
            message: FILE_REMOVE_SUCCESS.to_string(),
        }
    }

    pub fn file_remove_failed()->Self{
        OperationResult{
            success: false,
            message: FILE_REMOVE_FAILED.to_string(),
        }
    }
}