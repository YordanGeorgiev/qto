# src/bash/issue-tracker/funcs/start-selenium.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/start-selenium.func.txt
# ---------------------------------------------------------
doStartSelenium(){

	doLog "DEBUG START doStartSelenium"
	
   selenium='/usr/lib/selenium-server-standalone.jar'
   chrome_driver=$(which chromedriver)

   test -f $(which java) || export exit_code=1 ; doExit 1 " java is not installed. v1.8 required "
   test -f "$selenium" || export exit_code=1 ; doExit 1 " the selenium jar $selenium is not installed" 
   test -f "$chrome_driver" || export exit_code=1 ; doExit 1 " the chrome driver: $chrome_driver is not installed"
	
	sleep "$sleep_interval"
   echo "clean-up before start "
   rm -rv /tmp/.X99-lock
   rm -vr /tmp/.*-lock
   rm -rv /tmp/.X*

   echo check for already running instances 
   ps -ef | grep -i java 

	# Action !!!
   xvfb-run -e /dev/stdout java -Dwebdriver.chrome.driver=$chrome_driver -jar "$selenium" &

	doLog "DEBUG STOP  doStartSelenium"
}
# eof func doStartSelenium

# eof file: src/bash/issue-tracker/funcs/start-selenium.func.sh
