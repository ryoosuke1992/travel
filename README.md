# アプリケーションの概要
オリジナルの旅行を企画してユーザー同士で海外旅行を楽しめるマッチングサイト
 <https://ryotraveler.herokuapp.com/>

# 技術的ポイント
・**RSpec**でModel, Request, Systemテスト記述
・**Ajax**を用いた非同期処理（フォロー/未フォロー、お気に入り登録/未登録,
参加申し込み/申し込みを辞めるなどの切り替え表示）
・**Bootstrap**によるレスポンシブ対応
・**Rubocop**を使用したコード規約に沿った開発

# アプリケーションの機能
・オリジナルの旅行企画を投稿
・気に入った旅行の企画に参加
・おすすめの旅行企画をランダムに５つ表示させる
・画像を正方形に整形して投稿（CarrierWaveを使用）
・フォロー
・お気に入り登録
・コメント
・通知（お気に入り登録 or コメントがあった場合）
・検索（Ransackを使用）
・ログイン
・ログイン状態の保持
・モデルに対するバリデーション

# 環境
■フレームワーク
　Ruby on Rails
■データベース
　PostgreSQL
