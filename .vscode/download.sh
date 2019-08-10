task="$1"
contest=$(echo "$1" | rev | cut -d _ -f 2- | rev | tr _ -)
echo "contest id: $contest"
echo "task id: $task"
rm -rf test
~/.pyenv/shims/oj download "https://atcoder.jp/contests/${contest}/tasks/${task}"