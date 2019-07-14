if [ "$1" -nt a.out ]; then
	/usr/local/share/crystal-0.20.5-1/bin/crystal build "$1" -o a.out --error-trace || exit
fi
if [ ! -f in.txt ]; then
	touch in.txt
fi
./a.out < in.txt | tee out.txt
