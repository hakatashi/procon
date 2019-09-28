filename="$1"
task="${filename%.*}"
bin="./bin/${filename%.*}"
contest=$(echo "$task" | rev | cut -d _ -f 2- | rev | tr _ -)
TEST_DIR="tests/$task"

OJ=oj
if [ -x ~/.pyenv/shims/oj ]; then
  OJ=~/.pyenv/shims/oj
fi

echo "contest id: $contest"
echo "task id: $task"

if [ ! -d "${TEST_DIR}" ]; then
  echo "Directory ${TEST_DIR} not exists. Downloading..."
  mkdir -p "${TEST_DIR}"
  $OJ download "https://atcoder.jp/contests/${contest}/tasks/${task}" --directory "${TEST_DIR}"
fi

./.vscode/build.sh "$filename" || exit 1

TESTFLAGS=
if grep -q -i 'mode: float' "$filename"; then
  echo "Setting testing mode to float..."
  TESTFLAGS+=" --error 0.000001"
fi

TEST_DIR="tests/$task"

if [ -d /usr/local/share/crystal-0.20.5-1 ] || [ -d /tmp/crystal-0.20.5-1 ]; then
  $OJ test $TESTFLAGS -t 3 --directory "${TEST_DIR}" --command "${bin}"
else
  $OJ test $TESTFLAGS -t 10 -c "docker run -v '$PWD':/mnt -i crystallang/crystal:0.20.5 /mnt/${bin}" --directory "${TEST_DIR}"
fi