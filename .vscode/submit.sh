filename="$1"
task="$(echo $filename | cut -d. -f1)"
bin="./bin/${filename%.*}"
if grep -q -i 'contest: ' "$filename"; then
  contest=$(grep -P '(?<=contest: )\S+' -o "$filename")
else
  contest=$(echo "$task" | rev | cut -d _ -f 2- | rev | tr _ -)
fi

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

if [ $contest == "yukicoder" ]; then
  task_url="https://yukicoder.me/problems/no/${task}"
else
  task_url="https://atcoder.jp/contests/${contest}/tasks/${task}"
fi

echo "filename: $filename"
echo "contest id: $contest"
echo "task id: $task"
echo "task url: $task_url"

if [[ ! `cat /usr/bin/sensible-browser` =~ '"${BROWSER}"' ]]; then
  sudo sed -i 's/${BROWSER} /"${BROWSER}" /' /usr/bin/sensible-browser
fi

export BROWSER="/mnt/c/Program Files/Firefox Developer Edition/firefox.exe"

if [ "${filename##*.}" = "cpp" ]; then
  $OJ submit "${task_url}" "${filename}" --no-guess --language "C++ (GCC 9.2.1)" --yes
elif [ "${filename##*.}" = "cr" ]; then
  $OJ submit "${task_url}" "${filename}" --no-guess --language Crystal --yes
elif [ "${filename##*.}" = "vim" ]; then
  ./.vscode/build.sh "$filename" || exit 1
  $OJ submit "${task_url}" "${bin}" --no-guess --language Vim --yes
fi