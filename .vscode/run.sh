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
./a.out < "$sample" | tee out.txt