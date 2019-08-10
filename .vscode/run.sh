filename="$1"
./.vscode/build.sh "$filename"
if [ ! -f in.txt ]; then
	touch in.txt
fi
./a.out < in.txt | tee out.txt