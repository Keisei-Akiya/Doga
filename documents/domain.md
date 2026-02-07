# ドメイン設計仕様書：Doga

## 1. 境界付けられたコンテキスト（再定義）

システムを「ライブラリ管理」と「利用ログ管理」の2つの主要な関心事に整理します。

| コンテキスト | 責務 | 主要概念 |
| :--- | :--- | :--- |
| **Library (ライブラリ)** | 動画ファイルとメタデータの整合性・分類を管理 | Video, Tag, Fingerprint, Storage |
| **Journal (ジャーナル)** | ユーザーの心理的・物理的な記録を管理 | Nut (実行記録), Note, Stats |

## 2. ドメインエンティティ詳細

### A. Library Domain

- **Video (Entity)**
  - `id`: UUID v7
  - `fingerprint`: ファイル内容のハッシュ。重複検知・追跡の要。
  - `storage_info`: `storage_path` と `filename` の不変条件。
  - `duration`: 動画の長さ（秒）。
- **Tag (Entity)**
  - `id`: UUID v7
  - `name`: シンプルな文字列。
- **In-Memory File Index (Domain Service)**
  - Rustバックエンド側で、物理ディスク上のスキャン結果とDB内の `fingerprint` を照合し、移動や削除を検知する役職。

### B. Journal Domain

- **NutEntry (Entity)**
  - `id`: UUID v7 (Nut日時を内包).
  - `video_id`: 対象動画.
- **UsageStatistics (Domain Service)**
  - 指定期間内のNut数、頻度、ストリーク（継続日数）の計算ロジック。

## 3. アーキテクチャ方針 (Frontend)

設計レビューに基づき、過剰な抽象化（Repository Patternの厳格な適用等）を避け、**Svelte 5の機能を活かした実用的な構成**にします。

### ディレクトリ構造

```text
src/lib/
├── server/            # Rust APIとの通信用ヘルパー
├── shared/
│   ├── components/    # shadcn/ui 等
│   └── models/        # ドメインの型定義（単なるTypeScript Type/Interface）
└── routes/            # TanStack Router/SvelteKit のルート
```

### 実装のシンプル化

- **API通信**: 複雑な注入(DI)は行わず、`$lib/server/api.ts` 等に集約したシンプルな `fetch` 関数を使用します。
- **ステート管理**: ドメインロジックは Svelte 5 の `module state` または `Context API` を使って、画面間で必要な場合にのみ共有します。

## 4. ユビキタス言語

- **Nut**: 「実行（抜いた）」のシステム内呼称。
- **Journal**: 利用履歴全体。
- **Sync**: ストレージとDBの整合性を取る行為。
