filename="$1"

if [ "${filename##*.}" = ".cpp" ]; then
  if [ "$filename" -nt a.out ]; then
    echo "Building C++ project ${filename}..."
    g++ "$filename" -O2 -lm -o a.out
  fi
else
  if [ "$filename" -nt a.out ]; then
    echo "Building Crystal project ${filename}..."
    if [ -d /usr/local/share/crystal-0.20.5-1 ]; then
      /usr/local/share/crystal-0.20.5-1/bin/crystal build "$filename" -o a.out --error-trace || exit 1
    else
      docker run -v "$PWD":/mnt crystallang/crystal:0.20.5 crystal build "/mnt/$filename" -o /mnt/a.out --error-trace || exit 1
    fi
  fi
fi

echo "Build completed."