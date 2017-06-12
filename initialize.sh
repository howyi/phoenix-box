#!/usr/bin/env bash

test -f /etc/initialized && exit

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb

apt-get update
apt-get install -y git npm esl-erlang postgresql-9.4 inotify-tools
rm -f erlang-solutions_1.0_all.deb

npm cache clean
npm install n -g
n 7
apt-get purge -y npm
ln -sf /usr/local/bin/npm /usr/bin/npm

git clone -b v1.4 https://github.com/elixir-lang/elixir.git
cd elixir/
make
make install
cd
rm -rf elixir/

su - postgres -c "psql -c \"alter role postgres with password 'postgres'\""

ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

yes | mix local.hex
yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.4.ez

date > /etc/initialized
