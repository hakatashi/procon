set -xe

pendings=()

for file in *.cr; do
  if [[ "$file" == test.cr ]] || [[ "$file" == bench.cr ]]; then
    continue
  fi

  if [[ "$file" == "yukicoder*" ]]; then
    echo "Skipping $file because it's for yukicoder..."
    continue
  fi

  if grep -q -i 'status: skip' "$file"; then
    echo "Skipping $file because its status is skip..."
    continue
  fi

  if grep -q -i 'status: pending' "$file"; then
    echo "Skipping $file because its status is pending..."
    pendings+=($file)
    continue
  fi

  .vscode/download.sh "${file%.*}"
  rm -f a.out
  .vscode/test.sh "$file"
done

echo "All test passed."
echo "Pending files:"
for pending in "${pendings[@]}"; do
  echo "  - $pending"
done
