filename="$1"
./.vscode/build.sh "$filename" || exit 1

TESTFLAGS=
if grep -q -i 'mode: float' "$filename"; then
  echo "Setting testing mode to float..."
  TESTFLAGS+=" --error 0.000001"
fi

if [ -d /usr/local/share/crystal-0.20.5-1 ] || [ -d /tmp/crystal-0.20.5-1 ]; then
  ~/.pyenv/shims/oj test $TESTFLAGS -t 3
else
  ~/.pyenv/shims/oj test $TESTFLAGS -t 10 -c "docker run -v '$PWD':/mnt -i crystallang/crystal:0.20.5 /mnt/a.out"
fi