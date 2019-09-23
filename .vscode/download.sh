task="$1"
contest=$(echo "$1" | rev | cut -d _ -f 2- | rev | tr _ -)

OJ=oj
if [ -x ~/.pyenv/shims/oj ]; then
  OJ=~/.pyenv/shims/oj
fi

echo "contest id: $contest"
echo "task id: $task"

rm -rf test
$OJ download "https://atcoder.jp/contests/${contest}/tasks/${task}"