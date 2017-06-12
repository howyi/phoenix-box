# phoenix-box #
vagrantのubuntu-15.04上で[Phoenix Framework](http://www.phoenixframework.org)を実行可能な状態まで作成するVagrantfile

Windowsの場合, Git for Windows SDKの使用を想定
https://github.com/git-for-windows/build-extra/releases

### 1) Vagrantのセットアップ ###

1. virtualboxのインストール https://www.virtualbox.org/
2. vagrantのインストール https://www.vagrantup.com/docs/installation/index.html
3. `vagrant plugin install vagrant-vbguest`  
synced_folderのバージョン不一致を自動解決するプラグイン : https://github.com/dotless-de/vagrant-vbguest
4. `git clone git@github.com:qrbys/phoenix-box.git`
5. `cd phoenix-box`
6. `vagrant up`

### 2) SSH設定 ###
phoenix-boxのディレクトリ内で実行する
1. `vagrant ssh-config --host phoenix >> ~/.ssh/config`
2. `ssh phoenix`

### 3) プロジェクトの新規作成 ###
**以降の操作はvagrant内で行う**  
最新バージョンではセットアップ方法が変わっている可能性がある  
参考 : http://www.phoenixframework.org/docs/up-and-running
#### synced_folderを有効にしている場合 ####
synced_folderを有効にしている場合、デフォルトのnpm installがコケるため、オプション付きで実行する必要がある。  
1. `mix phoenix.new hello_phoenix`  
**no**
2. `cd hello_phoenix`
3. `mix deps.get`
4. `npm install --no-bin-links`
5. `node node_modules/brunch/bin/brunch build`
6. `mix ecto.create`

#### synced_folderを無効にしている場合 ####
1. `mix phoenix.new hello_phoenix`  
**yes**
2. `cd hello_phoenix`
3. `mix ecto.create`

### 4) サーバーを建てる ###
1. `mix phoenix.server`  
以上で `192.168.33.10:4000` へブラウザからアクセスするとPhoenixのデフォルトページが表示される。  

### synced_folderを有効にしているディレクトリで作業する場合の注意点 ###
synced_folderを通したリモートのファイル変更は inotify-toolsに認識されないため、**live_reload機能が機能しない**  
リモートのファイル変更をトリガーとするには、`vagrant-fsnotify` プラグイン等を介してファイル変更を通知する必要がある。  
参考 : https://github.com/adrienkohlbecker/vagrant-fsnotify
1. `vagrant plugin install vagrant-fsnotify` でインストール  
※. `ruby_dep` が入っていない旨のエラーが出た場合は `gem install --install-dir ~/.vagrant.d/gems/ ruby_dep -v '1.5.0'` を実行  
2. phoenix-box直下で`vagrant fsnotify`を実行することでファイルの通知が有効化される。  
終了した場合通知はされなくなるので注意

上記設定でテンプレートの書き換えによるlive_reloadは有効化されるが、`brunch/sass-brunch`を使用している場合にscssファイルの反映が上手く行かない。解決策不明


### 作成される環境  
|               |       |
| ------------- |-------------|
| Ubuntu        | 15.04         |
| psql (PostgreSQL)      | 9.4.5      |
| node | ^7.10.0      |
| npm | ^4.2.0     |
| Erlang | 7.2      |
| Elixir | 1.4.4      |
| Phoenix Framework | v1.2.4      |

*2017/06/12時点*
