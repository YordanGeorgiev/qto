do_chk_install_phantom_js(){
   which phantomjs 2>/dev/null || { 
      sudo apt-get install -y build-essential chrpath libssl-dev libxft-dev
      sudo apt-get install -y libfreetype6 libfreetype6-dev
      sudo apt-get install -y libfontconfig1 libfontconfig1-dev
      export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64"
      wget -O /tmp/$PHANTOM_JS.tar.bz2 https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2
      cd /tmp/
      sudo tar xvjf $PHANTOM_JS.tar.bz2
      sudo mv $PHANTOM_JS /usr/local/share
      sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
      phantomjs --version
   }
}
