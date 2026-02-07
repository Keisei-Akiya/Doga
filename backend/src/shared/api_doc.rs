use crate::domains::journal::models::NutEntry;
use crate::domains::library::models::{Tag, Video};
use utoipa::OpenApi;

#[derive(OpenApi)]
#[openapi(
    paths(),
    components(
        schemas(Video, Tag, NutEntry)
    ),
    tags(
        (name = "doga", description = "Doga Video Management API")
    )
)]
pub struct ApiDoc;
