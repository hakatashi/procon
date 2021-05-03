if [ `whoami` != 'root' ]; then
  echo 'Run with sudo!'
  exit
fi

if [ ! -d /usr/local/include/atcoder ]; then
  wget https://github.com/atcoder/ac-library/releases/download/v1.3/ac-library.zip -O /tmp/ac-library-original.zip
  unzip /tmp/ac-library-original.zip -d /tmp
  unzip /tmp/ac-library.zip -d /tmp
  mv /tmp/atcoder /usr/local/include/
fi

if [ ! -d /usr/local/share/crystal-0.33.0-1/bin/crystal ]; then
  wget https://github.com/crystal-lang/crystal/releases/download/0.33.0/crystal-0.33.0-1-linux-x86_64.tar.gz -O /tmp/crystal-0.33.0-1-linux-x86_64.tar.gz
  tar xf /tmp/crystal-0.33.0-1-linux-x86_64.tar.gz -C /usr/local/share
fi
