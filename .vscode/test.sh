filename="$1"
./.vscode/build.sh "$filename" || exit 1

if [ -d /usr/local/share/crystal-0.20.5 ]; then
  ~/.pyenv/shims/oj test -t 3
else
  ~/.pyenv/shims/oj test -t 10 -c "docker run -v '$PWD':/mnt -i crystallang/crystal:0.20.5 /mnt/a.out"
fi