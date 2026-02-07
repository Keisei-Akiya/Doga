-- Initial Migration: Create core tables for Doga

-- 1. videos Table
CREATE TABLE IF NOT EXISTS videos (
    id UUID PRIMARY KEY, -- UUID v7
    title VARCHAR(255) NOT NULL,
    storage_path VARCHAR(1024) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    fingerprint VARCHAR(64) NOT NULL,
    thumbnail_path VARCHAR(1024),
    duration_seconds INTEGER,
    is_favorite BOOLEAN NOT NULL DEFAULT false,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT unique_storage_path_filename UNIQUE(storage_path, filename),
    CONSTRAINT unique_fingerprint UNIQUE(fingerprint)
);

CREATE INDEX idx_videos_updated_at ON videos(updated_at);
CREATE INDEX idx_videos_is_favorite ON videos(is_favorite);
CREATE INDEX idx_videos_title ON videos(title);

-- 2. tags Table
CREATE TABLE IF NOT EXISTS tags (
    id UUID PRIMARY KEY, -- UUID v7
    name VARCHAR(50) NOT NULL UNIQUE,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3. video_tags Table (Many-to-Many)
CREATE TABLE IF NOT EXISTS video_tags (
    video_id UUID NOT NULL REFERENCES videos(id) ON DELETE CASCADE,
    tag_id UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (video_id, tag_id)
);

CREATE INDEX idx_video_tags_tag_id ON video_tags(tag_id);

-- 4. nut_entries Table (Journal)
CREATE TABLE IF NOT EXISTS nut_entries (
    id UUID PRIMARY KEY, -- UUID v7
    video_id UUID NOT NULL REFERENCES videos(id) ON DELETE CASCADE
);

CREATE INDEX idx_nut_entries_video_id ON nut_entries(video_id);
