task="$1"
contest=$(echo "$1" | rev | cut -d _ -f 2- | rev | tr _ -)

OJ=oj
if [ -x ~/.pyenv/shims/oj ]; then
  OJ=~/.pyenv/shims/oj
fi

TEST_DIR="tests/$task"

echo "contest id: $contest"
echo "task id: $task"

if [ -d "${TEST_DIR}" ]; then
  echo "Directory ${TEST_DIR} already exists. Skipping..."
  exit 0
fi

mkdir -p "${TEST_DIR}"

$OJ download "https://atcoder.jp/contests/${contest}/tasks/${task}" --directory "${TEST_DIR}"