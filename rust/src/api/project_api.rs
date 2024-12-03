use flutter_rust_bridge::frb;

use crate::{
    frb_generated::StreamSink,
    project::{ProjectDetail, ProjectView, PROJECT_DETAIL_SINK},
};

#[frb(sync)]
pub fn project_scan_stream(s: StreamSink<ProjectDetail>) -> anyhow::Result<()> {
    let mut stream = PROJECT_DETAIL_SINK.write().unwrap();
    *stream = Some(s);
    anyhow::Ok(())
}

pub fn project_scan(p: String) {
    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async {
        let pv = ProjectView { 0: p };
        let r = pv.scan().await;
        match r {
            Ok(_) => {}
            Err(e) => {
                println!("[rust] error {}", e);
            }
        }
    });
}

pub fn project_scan_really_fast(p: String) {
    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async {
        let pv = ProjectView { 0: p };
        let r = pv.scan_in_multi_threads().await;
        match r {
            Ok(_) => {}
            Err(e) => {
                println!("[rust] error {}", e);
            }
        }
    });
}
