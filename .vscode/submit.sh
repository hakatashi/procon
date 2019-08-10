filename="$1"
task="${filename%.*}"
contest=$(echo "$task" | rev | cut -d _ -f 2- | rev | tr _ -)

echo "filename: $filename"
echo "contest id: $contest"
echo "task id: $task"

if [[ ! `cat /usr/bin/sensible-browser` =~ '"${BROWSER}"' ]]; then
  sudo sed -i 's/${BROWSER} /"${BROWSER}" /' /usr/bin/sensible-browser
fi

if [ "${filename##*.}" = ".cpp" ]; then
  BROWSER="/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" ~/.pyenv/shims/oj submit "https://atcoder.jp/contests/${contest}/tasks/${task}" "${filename}" --no-guess --language C++14
else
  BROWSER="/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" ~/.pyenv/shims/oj submit "https://atcoder.jp/contests/${contest}/tasks/${task}" "${filename}" --no-guess --language Crystal
fi