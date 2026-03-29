# Competitive Programming Docker Environment

C++ / Python / Rust をホストを汚さずに使うための、単一サービス構成の Docker 開発環境です。

## 使い方

1. 設定ファイルを作成

   ```bash
   cp .env.example .env
   ```

2. （必要なら）追加ポート用 override を作成

   ```bash
   cp compose.override.yaml.example compose.override.yaml
   ```

3. コンテナを起動

   ```bash
   docker compose up -d --build
   ```

4. 開発シェルに入る

   ```bash
   docker compose exec dev bash
   ```

## VS Code Dev Container

- `.devcontainer/devcontainer.json` は `compose.yaml` の `dev` サービスをそのまま利用
- `remoteUser` は `root`（管理者ユーザー）に固定
- Apple Silicon では `platform` 未固定のため arm64 ネイティブで動作
- x86 専用ツールが必要なときだけ `compose.override.yaml` の `platform: linux/amd64` コメントを有効化

## ポイント

- ソースコードは `./:/workspace` の bind mount で共有
- ポート公開は `127.0.0.1` に限定し、ホスト側ポートは `.env` で変更可能
- 追加ポートや x86 切り替えは `compose.override.yaml` 側で拡張しやすい
- 通常ユーザーは `root`（管理者権限）
- `init: true` で PID 1 の signal handling / zombie 回収を安定化
- Rust のツールチェーン・キャッシュは named volume で永続化
- `Dockerfile` は apt セクションを伸ばすだけでツール追加しやすい構成
- `APPUSER=root` を明示し、スクリプトから利用できるように環境変数を設定
- `compose.yaml` / `Dockerfile` / `.devcontainer` の構成は相互に整合する
- Rust のキャッシュは `/root` 配下の named volume に保存
