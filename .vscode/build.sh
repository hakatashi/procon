filename="$1"

if [ "${filename##*.}" = ".cpp" ]; then
  if [ "$filename" -nt a.out ]; then
    echo "Building C++ project ${filename}..."
    g++ "$filename" -O2 -lm -o a.out
  fi
else
  if [ "$filename" -nt a.out ]; then
    echo "Building Crystal project ${filename}..."
    /usr/local/share/crystal-0.20.5-1/bin/crystal build "$filename" -o a.out --error-trace || exit 1
  fi
fi

echo "Build completed."