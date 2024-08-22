use std::sync::RwLock;

use crate::frb_generated::StreamSink;

// #[derive(Debug)]
// pub struct Event {
//     pub event_type: String,
//     pub data: String,
// }

pub static EVENT_SINK: RwLock<Option<StreamSink<ResEvent>>> = RwLock::new(None);

#[derive(Debug)]
pub struct ScannerEvent {
    pub event_type: String,
    pub count: u64,
    pub duration: f32,
}

impl ScannerEvent {
    pub fn to_string(&self) -> String {
        format!(
            "scanned {:?} files in {:?} seconds",
            self.count, self.duration
        )
    }
}

#[derive(Debug)]
pub struct CompareEvent {
    pub event_type: String,
    pub duration: f32,
}

impl CompareEvent {
    pub fn to_string(&self) -> String {
        format!("finished in {:?} seconds", self.duration)
    }
}

#[derive(Debug)]
pub struct DoneEvent {
    pub event_type: String,
    pub is_done: bool,
}

impl DoneEvent {
    pub fn to_string(&self) -> String {
        if self.is_done {
            return format!("{:?} is done", self.event_type);
        }
        "".to_string()
    }
}

#[derive(Debug)]
pub enum ResEvent {
    ScannerEvent(ScannerEvent),
    CompareEvent(CompareEvent),
    DoneEvent(DoneEvent),
}

impl ResEvent {
    pub fn to_string(&self) -> String {
        match self {
            ResEvent::ScannerEvent(se) => se.to_string(),
            ResEvent::CompareEvent(ce) => ce.to_string(),
            ResEvent::DoneEvent(de) => de.to_string(),
        }
    }
}
