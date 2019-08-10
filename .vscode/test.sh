filename="$1"
./.vscode/build.sh "$filename" || exit 1
~/.pyenv/shims/oj test -t 3