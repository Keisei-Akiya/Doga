# Doga

個人向け動画管理システム。
自分専用の動画ライブラリをストレージ上に構築し、快適な視聴・管理・履歴記録を提供します。

## 🚀 技術スタック

- **Frontend**: Svelte 5 + SvelteKit
- **Backend**: Rust (Axum)
- **Database**: PostgreSQL
- **Styling**: Tailwind CSS + shadcn-svelte
- **Infrastructure**: Docker / Docker Compose

## 🛠 セットアップ

### 1. 環境構築

Docker がインストールされていることを確認してください。

### 2. コンテナの起動

```bash
docker-compose up -d db
```

※ 現時点ではデータベースのみ起動可能です。バックエンド・フロントエンドは順次構築中です。

## 📂 ドキュメント

詳細は `documents/` ディレクトリを参照してください。

- [要件定義](documents/requirements.md)
- [ドメイン設計](documents/domain.md)
- [データベース設計](documents/database.md)

## ⚖️ License

MIT
