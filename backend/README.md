# Doga - Backend

Rust (Axum) を使用した Doga の API サーバーです。

## 🚀 技術スタック

- **Framework**: Axum 0.8
- **Runtime**: Tokio
- **Database**: PostgreSQL + SQLx
- **Documentation**: utoipa (Swagger UI)
- **Serialization**: serde

## 🛠 開発サイクル

### 環境変数の設定

`.env` ファイルを作成し、データベース URL を設定してください。

```env
DATABASE_URL="postgres://user:password@localhost:5432/doga"
```

### サーバーの起動

```bash
cargo run
```

サーバーはデフォルトで `http://localhost:8000` で起動します。

### データベース・マイグレーション

SQLx CLI を使用してマイグレーションを実行します。

```bash
# 基本コマンド
sqlx migrate run
```

```bash
sqlx migrate run --database-url "postgres://user:password@localhost:5432/doga"
```

## 📂 ディレクトリ構造

- `src/main.rs`: サーバーのエントリポイント
- `migrations/`: SQLx マイグレーションファイル
- `src/lib.rs`: コアロジックとドメイン（予定）
