filename="$1"
task="$(echo $filename | cut -d. -f1)"
ext="${filename##*.}"
bin="./bin/${filename%.*}"
if grep -q -i 'contest: ' "$filename"; then
  contest=$(grep -P '(?<=contest: )\S+' -o "$filename")
else
  contest=$(echo "$task" | rev | cut -d _ -f 2- | rev | tr _ -)
fi
TEST_DIR="tests/$task"

if [[ "$task" == yukicoder_* ]]; then
  task="${task#"yukicoder_"}"
fi

if [ -x ~/.pyenv/shims/oj ]; then
  OJ=~/.pyenv/shims/oj
elif [ -x ~/.local/bin/oj ]; then
  OJ=~/.local/bin/oj
else
  OJ=oj
fi

echo "contest id: $contest"
echo "task id: $task"

if [ ! -d "${TEST_DIR}" ]; then
  echo "Directory ${TEST_DIR} not exists. Downloading..."
  mkdir -p "${TEST_DIR}"
  if [ $contest == "yukicoder" ]; then
    $OJ download "https://yukicoder.me/problems/no/${task}" --directory "${TEST_DIR}"
  else
    $OJ download "https://atcoder.jp/contests/${contest}/tasks/${task}" --directory "${TEST_DIR}"
  fi
fi

./.vscode/build.sh "$filename" || exit 1

TESTFLAGS=--ignore-spaces
if grep -q -i 'mode: float' "$filename"; then
  echo "Setting testing mode to float..."
  TESTFLAGS+=" --error 0.000001"
fi

if [ "$ext" == "cr" ] || [ "$ext" == "cpp" ]; then
  if [ -d /usr/local/share/crystal-0.33.0-1 ] || [ -d /tmp/crystal-0.33.0-1 ]; then
    $OJ test $TESTFLAGS -t 3 --directory "${TEST_DIR}" --command "${bin}"
  else
    $OJ test $TESTFLAGS -t 10 -c "docker run -v '$PWD':/mnt -i crystallang/crystal:0.33.0 /mnt/${bin}" --directory "${TEST_DIR}"
  fi
elif [ "$ext" == "vim" ]; then
  $OJ test $TESTFLAGS -t 3 -c "sh -c 'cat - > /tmp/out; TERM=dumb vim -n -N -u NONE -i NONE -s ${bin} /tmp/out > /dev/null 2>&1; cat /tmp/out'" --directory "${TEST_DIR}"
fi