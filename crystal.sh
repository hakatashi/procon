if [ "$1" -nt a.out ]; then
	crystal build "$1" -o a.out -p
fi
if [ ! -f in.txt ]; then
	touch in.txt
fi
./a.out < in.txt | tee out.txt
