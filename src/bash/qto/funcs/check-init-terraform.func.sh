# attempt to install terraform, if it is missing !!! Obs needs sudo !!!
doCheckInitTerraform(){

   which terraform  2>/dev/null || { 
      ver='0.12.8'
      wget -O "/tmp/terraform_""$ver'_linux_amd64.zip" \
         "https://releases.hashicorp.com/terraform/$ver/terraform_""$ver"'_linux_amd64.zip'
      sudo unzip -o "/tmp/terraform_""$ver'_linux_amd64.zip" -d '/usr/local/bin'
      terraform --version
   }

   which terraform  2>/dev/null || { 
      echo >&2 "The terraform binary is missing ! Aborting ..."; exit 1; }
   which terraform && echo "ok"
   
}
