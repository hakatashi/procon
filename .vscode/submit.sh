filename="$1"
task="$(echo $filename | cut -d. -f1)"
bin="./bin/${filename%.*}"
if grep -q -i 'contest: ' "$filename"; then
  contest=$(grep -P '(?<=contest: )\S+' -o "$filename")
else
  contest=$(echo "$task" | rev | cut -d _ -f 2- | rev | tr _ -)
fi

if [ -x ~/.pyenv/shims/oj ]; then
  OJ=~/.pyenv/shims/oj
elif [ -x ~/.local/bin/oj ]; then
  OJ=~/.local/bin/oj
else
  OJ=oj
fi

echo "filename: $filename"
echo "contest id: $contest"
echo "task id: $task"

if [[ ! `cat /usr/bin/sensible-browser` =~ '"${BROWSER}"' ]]; then
  sudo sed -i 's/${BROWSER} /"${BROWSER}" /' /usr/bin/sensible-browser
fi

if [ "${filename##*.}" = "cpp" ]; then
  BROWSER="/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" $OJ submit "https://atcoder.jp/contests/${contest}/tasks/${task}" "${filename}" --no-guess --language C++14 --yes
elif [ "${filename##*.}" = "cr" ]; then
  BROWSER="/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" $OJ submit "https://atcoder.jp/contests/${contest}/tasks/${task}" "${filename}" --no-guess --language Crystal --yes
elif [ "${filename##*.}" = "vim" ]; then
  ./.vscode/build.sh "$filename" || exit 1
  BROWSER="/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" $OJ submit "https://atcoder.jp/contests/${contest}/tasks/${task}" "${bin}" --no-guess --language Vim --yes
fi