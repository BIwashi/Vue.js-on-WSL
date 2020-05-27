#!/bin/sh

echo リポジトリを日本のサーバに変更（sudo 利用時、パスワード入力を求められます）
echo Do you wanna change Japanese server?(Y/n)
read answer

if [$answer = y] || [$answer = Y] || [$answer = yes] ||[$answer = YES];then
sudo sed -i -e 's%http://.*.ubuntu.com%http://ftp.jaist.ac.jp/pub/Linux%g' /etc/apt/sources.list
else
fi

echo パッケージのアップデート
sudo apt update
sudo apt upgrade

echo Windows との共有ディレクトリを作成Windows との共有ディレクトリを作成
echo Windowsのusename以下にshareWithUbuntuファイルを作成してください
echo -n INPUT_username:
read username
ln -s /mnt/c/Users/$username/shareWithUbuntu ~/shareWithWindows # (username)はWindows側のユーザ名に置き換え

echo Node.js のインストール
sudo apt install -y nodejs npm # node、npmのインストール
sudo npm install n -g          # n package導入
sudo n stable                  # nを使用してnodeのstable版をインストール
sudo apt purge -y nodejs npm   # 最初に入れた古いnode、npmは削除
exec $SHELL -l                 # 再ログイン
node -v                        # バージョン確認

cd ..
cd ..
sudo chmod 777 root # rootに権限がないと言われるので，無理やり許可（あんまりよくないかも）
echo NativeScript CLI のインストール
sudo npm install -g nativescript

echo G++ （C++ のコンパイラ）のインストール
sudo apt install g++

echo JDK8 の設定
sudo apt install openjdk-8-jdk         # JDK8インストール
sudo update-alternatives --config java # JAVAのバージョンが複数あればJDK8を選択

echo 環境変数 JAVA_HOME の追加
export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p') >> ~/.bashrc
