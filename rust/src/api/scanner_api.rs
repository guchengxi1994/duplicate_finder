use flutter_rust_bridge::frb;

use crate::{
    frb_generated::StreamSink,
    scanner::{
        compare_result::{CompareResults, SCANNER_COMPARE_RESULTS_SINK},
        event::{Event, EVENT_SINK},
        interface::Scanner,
        local::LocalScanner,
    },
};

#[frb(sync)]
pub fn scanner_compare_results_stream(s: StreamSink<CompareResults>) -> anyhow::Result<()> {
    let mut stream = SCANNER_COMPARE_RESULTS_SINK.write().unwrap();
    *stream = Some(s);
    anyhow::Ok(())
}

#[frb(sync)]
pub fn event_stream(s: StreamSink<Event>) -> anyhow::Result<()> {
    let mut stream = EVENT_SINK.write().unwrap();
    *stream = Some(s);
    anyhow::Ok(())
}

pub fn scan(p: String) {
    let rt = tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .unwrap();

    rt.block_on(async {
        let s = LocalScanner(p);
        let _ = s.scan().await;
    });
}
