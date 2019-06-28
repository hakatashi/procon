if [ "$1" -nt a.out ]; then
	g++ "$1" -O2 -lm -o a.out
fi
if [ ! -f in.txt ]; then
	touch in.txt
fi
./a.out < in.txt | tee out.txt
