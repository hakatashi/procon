filename="$1"
output="bin/${filename%.*}"

if [ "${filename##*.}" = "cpp" ]; then
  if [ "$filename" -nt "${output}" ]; then
    echo "Building C++ project ${filename}..."
    mkdir -p bin
    g++ "$filename" -O2 -lm -o "${output}"
  fi
elif [ "${filename##*.}" = "cr" ]; then
  if [ "$filename" -nt "${output}" ]; then
    echo "Building Crystal project ${filename}..."
    if [ -d /usr/local/share/crystal-0.20.5-1 ]; then
      mkdir -p bin
      /usr/local/share/crystal-0.20.5-1/bin/crystal build "$filename" -o "${output}" --error-trace || exit 1
    elif [ -d /tmp/crystal-0.20.5-1 ]; then
      mkdir -p bin
      /tmp/crystal-0.20.5-1/bin/crystal build "$filename" -o "${output}" --error-trace || exit 1
    else
      mkdir -p /mnt/bin
      docker run -v "$PWD":/mnt crystallang/crystal:0.20.5 crystal build "/mnt/$filename" -o "/mnt/${output}" --error-trace || exit 1
    fi
  fi
elif [ "${filename##*.}" = "vim" ]; then
  if [ "$filename" -nt "${output}" ]; then
    echo "Building Vim project ${filename}..."
    ruby library/vim-compiler.rb "$filename" "${output}"
  fi
fi

echo "Build completed."