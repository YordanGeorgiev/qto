

do_check_install_chromium_headless(){
   which chromium-browser 2>/dev/null || {
      sudo apt-get update
      sudo apt-get install -y software-properties-common
      sudo apt-get install -y chromium-browser 
      sudo apt-get update
   }
}
