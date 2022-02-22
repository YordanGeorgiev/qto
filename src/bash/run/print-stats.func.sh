doPrintStats(){
   echo -e "\nprint the line numbers per file type \n"
   echo cnf md txt html css sql html.ep js.html.ep sh pm pl t | tr ' ' "\n" | \
   while read ftype ; do lines=$(find . -name "*.$ftype" -exec cat {} + | wc -l); \
   printf "%-20s %12d \n" $ftype $lines ; done | sort -nr -k 2

}
