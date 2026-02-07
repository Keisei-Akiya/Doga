use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use utoipa::ToSchema;
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct Video {
    pub id: Uuid,
    pub title: String,
    pub storage_path: String,
    pub filename: String,
    pub fingerprint: String,
    pub thumbnail_path: Option<String>,
    pub duration_seconds: Option<i32>,
    pub is_favorite: bool,
    pub updated_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct Tag {
    pub id: Uuid,
    pub name: String,
    pub updated_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VideoTag {
    pub video_id: Uuid,
    pub tag_id: Uuid,
}
