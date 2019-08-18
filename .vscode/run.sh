filename="$1"
sample="test/sample-$2.in"
./.vscode/build.sh "$filename" || exit 1

if [ ! -f "$sample" ]; then
  echo "$sample not exists"
  exit 1
fi

echo "=== Input ==="
cat "$sample"
echo ""

echo "=== Output ==="
if [ -d /usr/local/share/crystal-0.20.5-1 ]; then
  ./a.out < "$sample" | tee out.txt
else
  docker run -v "$PWD":/mnt -i crystallang/crystal:0.20.5 /mnt/a.out < $sample | tee out.txt
fi