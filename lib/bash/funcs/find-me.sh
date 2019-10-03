find_me(){
   to_srch=$1
   find src -type f -exec grep -nHi --color=always "$to_srch" {} \; | less -R
}
