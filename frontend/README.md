# Doga - Frontend

SvelteKit を使用した Doga のフロントエンドアプリケーションです。

## 🚀 技術スタック

- **Framework**: Svelte 5 + SvelteKit
- **Styling**: Tailwind CSS
- **Components**: shadcn-svelte
- **Icons**: Lucide Svelte
- **Formatter/Linter**: Biome

## 🛠 開発サイクル

### パッケージのインストール

```bash
bun install
```

### 開発サーバーの起動

```bash
bun run dev
```

サーバーはデフォルトで `http://localhost:3000` で起動します。

### フォーマットとリント

```bash
bun run format  # Biome による自動整形
bun run lint    # チェックのみ
```

### Storybook

コンポーネントを独立して開発・カタログ化するためのツールです。

```bash
bun run sb               # Storybook を起動 (http://localhost:6006)
bun run build-storybook  # ビルド
```

## 📂 ディレクトリ構造

- `src/routes/`: ページとルーティング
- `src/lib/`: 共有ロジック、コンポーネント、型定義
- `static/`: 静的アセット
