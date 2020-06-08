for file in $(ls in); do
  echo $file
  ./abc164_f.validate in/$file out/$file
done