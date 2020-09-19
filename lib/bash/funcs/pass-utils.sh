escape(){
        echo "$1"|perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"'
}
unescape(){
        echo "$1"|perl -MURI::Escape -ne 'chomp;print uri_unescape($_),"\n"'
}
encrypt_pass(){
 echo "$1"| perl -ne '$_=crypt($_,$_); s/[#\-%&\$*+()\/]//g; print substr (sprintf("%s%s", $_ ,"56!"), 8, 10, "")'
}
