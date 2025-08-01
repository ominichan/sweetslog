# README
# sweetslog
**画面遷移図**
https://www.figma.com/design/5ghPDVa1H0XGVk0rYGJTNL/Sweets%E3%80%80Log?node-id=0-1&t=fZT9xtMZ4bpbWeuy-1

**サービス概要**<br/>
このサービスは、ユーザーが訪れたカフェやレストランで食べた「スイーツ」を記録、他のユーザーと共有ができるアプリです。ユーザーは、スイーツの写真、感想、店舗情報を保存し、自分の「食の思い出」としてアルバムのように振り返ることもできます。また、他のユーザーの投稿を「食べたいスイーツリスト」として保存することも可能です。

**このサービスへの思い・作りたい理由**<br/>
コーヒーと一緒にスイーツを楽しむのが好きで、よくレビューサイトやSNS等で調べて見つけた美味しそうなスイーツを食べに行きます。
しかし調べる時にスイーツ以外の情報が混ざっていたり、一度投稿の詳細を開かないと料理の写真が見れなかったりと調べづらいなと感じることがありました。
このことから、投稿のサムネイルに料理の写真が出るようにし、料理名や場所で検索できるようにすることで、これを解決することが出来ると考えこのアプリを作成を決意しました。
加えてシェア機能やいいね機能等も実装することで、使いやすくニーズに合うアプリを目指します。

**ユーザー層について**<br/>
・カフェ、スイーツ巡りが好きな方
・食べたものを写真を撮って記録する方
・スイーツの情報収集をしたい方
・旅行先のグルメを記録したい人

**サービスの利用イメージ**<br/>
<ins>TOPページ</ins><br/>
　・サービスの概要や使い方をイメージしていただける内容を記載します。<br/>
<ins>ログインページ</ins><br/>
　・一般的なログイン方法（Emailとパスワード）だけでなく、Googleでログイン機能でログインできます。<br/>
<ins>一覧ページ</ins><br/>
　・ユーザーが投稿したものが一覧として出るだけでなく、投稿内容からおすすめ投稿を上部に表示します。<br/>
<ins>新規投稿ページ</ins><br/>
　・フォームより各項目と入力、料理の画像を添付して投稿できます。<br/>
　・投稿の公開/非公開を選択可能です。<br/>
<ins>詳細ページ</ins><br/>
　・各投稿を選択することで投稿詳細を見ることが出来ます。<br/>
　・添付された画像、料理名、場所（店名・マップ表示）、投稿者の感想を見ることが出来ます。<br/>
　・その投稿に対してコメントやいいね機能を利用できます。<br/>
<ins>マイページ</ins><br/>
　・自分が投稿した料理一覧、いいねした投稿一覧を確認できます。<br/>
　・自分が投稿について編集・削除が出来ます。<br/>
　・プロフィールや登録情報の編集が出来ます。<br/>

**ユーザーの獲得について**<br/>
マターモーストでの共有<br/>
XやInstagramなどのSNSでシェア<br/>
友人への紹介<br/>
Notion等でスイーツ・アプリ紹介記事を書く<br/>

**サービスの差別化ポイント・推しポイント**<br/>
競合サービスとしては以下が挙げられます。<br/>
・Instagram<br/>
・食べログ、Rettyなどのレビューサービス<br/>
・もぐレコ<br/>
上記サービスとの差別化ポイントは以下の通りです。<br/>
・スイーツに特化したCGM型アプリ<br/>
・お店ではなく料理を主軸にしており、投稿一覧ページではスイーツの写真を表示<br/>
・場所や料理名、スイーツに特化したタグやカテゴリによる複数検索<br/>
・公開/非公開切り替え機能<br/>

**機能候補**<br/>
MVPリリース<br/>
・ユーザー登録、ログイン機能<br/>
・投稿機能<br/>
・投稿一覧表示、詳細ページ<br/>
・タグ投稿、編集、削除<br/>
・他ユーザーの投稿をお気に入り登録、解除(ajax)<br/>
・検索機能（料理名、タグ、都道府県、キーワード）<br/>
・店舗のマップ表示<br/>
・マイページ（投稿・いいね保存一覧）<br/>
・カレンダー表示<br/>
・今食べたいデザート診断<br/>

本リリース<br/>
・パスワード変更機能<br/>
・メールアドレス変更機能<br/>
・利用規約、プライバシーポリシー、問い合わせフォームの作成<br/>
・スマートフォンで使いやすいようレスポンシブル対応に整える<br/>
・テスト機能(RubocopによるLintチェック,RSpecによるモデルチェック)<br/>
・コメント投稿、編集、削除（ajax）<br/>
・各ユーザーへのおすすめ投稿表示<br/>
・Instagramへのシェア導線の案内<br/>
・SNSシェアボタン（X向け）<br/>
・検索オートコンプリート <br/>
・メールアドレス、パスワード変更 <br/>
・公開/非公開切り替え機能<br/>

**機能の実装方針予定**<br/>
Googleマップ連携（訪問店舗表示）<br/>
・Google Maps API(Maps JavaScript API）を使用しマップ表示<br/>
カレンダー表示<br/>
・simple_calendarを使用<br/>
・投稿した日をカレンダーに表示<br/>
Google ログイン機能<br/>
・OAuthを使用しGoogle ログイン機能を追加<br/>
投稿の検索・絞り込み<br/>
・ransackを使用し検索・絞り込みを実装<br/>
各ユーザーへのおすすめ投稿表示（レコメンド機能）<br/>
・Rubyでアルゴリズムを使用して独自に実装<br/>
