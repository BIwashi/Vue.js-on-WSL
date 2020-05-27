#!/bin/sh

echo Android SDK のダウンロードした後，共有ディレクトリにtoolsを移した後に実行
sudo mkdir -p /usr/lib/android/sdk/

sudo mv ~/shareWithWindows/tools /usr/lib/android/sdk/

export ANDROID_HOME="/usr/lib/android/sdk/" >> ~/.bashrc
export PATH="${PATH}:${ANDROID_HOME}tools/:${ANDROID_HOME}platform-tools/" >>  ~/.bashrc

exec $SHELL -l

echo 必要なパッケージのインストール
sudo $ANDROID_HOME/tools/bin/sdkmanager "tools" "emulator" "platform-tools" "platforms;android-28" "build-tools;28.0.3" "extras;android;m2repository" "extras;google;m2repository"

exec $SHELL -l

echo No issues were detected. が出力されれば成功
tns doctor

echo Vue 関連パッケージのインストール
sudo npm install -g @vue/cli @vue/cli-init
