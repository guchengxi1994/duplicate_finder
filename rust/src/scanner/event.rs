use std::sync::RwLock;

use crate::frb_generated::StreamSink;

#[derive(Debug)]
pub struct Event {
    pub event_type: String,
    pub data: String,
}

pub static EVENT_SINK: RwLock<Option<StreamSink<Event>>> = RwLock::new(None);
