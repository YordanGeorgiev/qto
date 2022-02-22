#v1.0.7 
#------------------------------------------------------------------------------
# cleans the unneeded during after run-time stuff
#------------------------------------------------------------------------------
doPrintHelp(){

   doSetVars

   do_flush_screen

   test -z $target_dir && target_dir='<<target_dir>>'

   cat <<END_HELP

   #------------------------------------------------------------------------------
   ## START HELP `basename $0`
   #------------------------------------------------------------------------------
      `basename $0` is a the minimalistic scala console stub app to start writing scala
      `basename $0` is is also an utility script with the goodies listed below:

      # go get this help, albeit you knew that already ...
      bash $0 -h
      or
      bash $0 --help

		5. this will create the deployment package into your production version dir: $product_dir
		if you have configured the network_backup_dir in cnf file it will be also copied 
      #--------------------------------------------------------
		bash $0 -a create-deployment-package

		You must specify the files to be be included in the full package from the met/qto.dev 
		file
      
		6. to create a relative package
		this will create the relative package into your production version dir: $product_dir
		if you have configured the network_backup_dir in cnf file it will be also copied 
      #--------------------------------------------------------
		bash $0 -a create-relative-package

		You must specify the files to be be included in the full package from the met/qto.dev 
		file
      
		4. to clone the same version of your product into dev,tst,prd enviroments
      #--------------------------------------------------------
      bash $0 -a to-dev
      bash $0 -a to-tst
      bash $0 -a to-qas
      bash $0 -a to-prd
      
		5. to clone the product into a different version
      #--------------------------------------------------------
      bash $0 -a to-ver=0.1.1
      
		6. to create the tags file in the \$product_dir : $product_dir
      #--------------------------------------------------------
      sh $0 -a create-ctags

		
		9. to save your current tmux session run the following command
      #--------------------------------------------------------
      sh $0 -a save-tmux-session

      #------------------------------------------------------------------------------
      ## INSTALLATION
      #------------------------------------------------------------------------------

		Installation is as simple as unzip -o <<full_package>> -d <<desired_base_dir>>
		where <<full_package>> should look like: qto.0.0.2.prd.20160702_181412.ysg-host-name.zip
		and <<disired_base_dir>> could be /tmp , /opt/ , /var , /even/longer/path
		The required binaries for the $RUN_UNIT are:
		- perl
		If you want to use the vim's jump to tag function you would have to install also:
		- ctags
		

      #------------------------------------------------------------------------------
      ## FOR DEVELOPERS
      #------------------------------------------------------------------------------

      `basename $0` is an utility script having the following purpose
      to provide an easy installable starting template for any app
		based on the following philosophy:
		- there is a huge difference between a software product and a running instance
		- the running istance is properly configured it usually belongs to dev , tst 
		  prd environments 
		- different version of the same software product might or might not require 
		  different binaries 
		- if two instances of the same product having different versions can operate on 
		  the same host simultaniously 
		- in $RUN_UNIT this ability to run multiple versions in multiple environments
        under even different *Nix users is in-built
		- any custom software should be installed and run from a base dir: $base_dir

      with  the following functionalities:
      - printing help with cmd switch -h ( verify with doTestHelp in test-sh )
      - prints the set in the script variables set during run-time
      - separation of host specific vars into separate configuration file :
       <<wrap_bash_dir>>/<<RUN_UNIT>>.<<MyHost>>.cnf
       $ini_file
      - thus easier enabling portability between hosts
      - logging on terminal and into configurable log file set now as:
       $log_file
      - for loop examples with head removal and inline find and replace
      - cmd args parsing
      - doSendReport func to the tail from the log file to pre-configured emails
      - support for parallel run by multiple processes - each process uses its own tmp dir

	Note the help is quite long - you might want to use the less page :
      `basename $0` --help \| less
   #------------------------------------------------------------------------------
   ## STOP HELP `basename $0`
   #------------------------------------------------------------------------------

END_HELP
}
#eof doPrintHelp 
