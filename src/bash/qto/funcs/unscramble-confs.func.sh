doUncrambleConfs(){
   while read -r file ; do
      test -f $file.bak || continue
      test -f $file.bak && cp -v $file.bak $file
      test -f $file.bak && rm -v $file.bak
	done < <(find $PRODUCT_DIR/cnf/env/ -type f -name '*.json')
   exit 0
}
