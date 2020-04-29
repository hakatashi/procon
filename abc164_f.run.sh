for file in $(ls in); do
  /usr/bin/time -f "$file: %es" --output times2.txt -a python abc164_f.sat.py < in/$file > out/$file
done