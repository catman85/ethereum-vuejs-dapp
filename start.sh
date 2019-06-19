#! /bin/sh

cd app-users/
xterm -e npm run serve --hold &
cd ../
xterm -e expect trufflexp.exp --hold &

