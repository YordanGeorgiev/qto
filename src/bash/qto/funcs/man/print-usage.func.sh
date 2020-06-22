#v1.0.7 
#------------------------------------------------------------------------------
# prints the usage of this script
#------------------------------------------------------------------------------
doPrintUsage(){

   printf "\033[2J";printf "\033[0;0H"
   
	cat <<END_HELP

   #
   ## START --- USAGE `basename $0`
   #-----------------------------------------------------------------------------
      bash $0
      bash $0 -u
      bash $0 -usage
      bash $0 --usage

      bash $0 -h
      bash $0 -help
      bash $0 --help
      
   1. setup a project : 
   doParseCnfEnvVars /vagrant/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cn
   
   2. run an action:  

      bash src/bash/qto/qto.sh -a xls-to-db -t daily_issues,monthly_issues
      bash src/bash/qto/qto.sh -a db-to-xls -t daily_issues,monthly_issues
      bash src/bash/qto/qto.sh -a db-to-txt -t daily_issues,monthly_issues
      bash src/bash/qto/qto.sh -a txt-to-db -t daily_issues,monthly_issues

      bash $0 -a run-qto
      bash $0 -a check-perl-modules-prerequisites
      bash $0 -a check-perl-syntax
      bash $0 -a run-functional-tests
      bash $0 -a run-qto
      bash $0 -a clone-to-app
      bash $0 -a gmail-package
      bash $0 -a morph-dir
      bash $0 -a change-env-type
      bash $0 -a restore-tmux-session
      bash $0 -a generate-action-files
      bash $0 -a remove-action-files
      bash $0 -a create-ctags
      bash $0 -a remove-package
      bash $0 -a backup-file
      bash $0 -a remove-package-files
      bash $0 -a tmux-common
      bash $0 -a action-to-remove
      bash $0 -a print-help
      bash $0 -a print-usage
      bash $0 -a action-to-remove
      bash $0 -a create-full-7z-package
      bash $0 -a create-full-package
      bash $0 -a create-relative-7z-package
      bash $0 -a create-relative-package
	
		# and here you have some more packaging calls .. 
      bash $0 -a create-full-package -i <<path_to_include_file>> -a gmail-package
		bash $0 -a create-relative-package -i <<path_to_include_file>> -a gmail-package

      bash $0 -a remove-package-files -i <<path_to_include_file>>

		bash $0 -a to-tst
		bash $0 -a to-dev
		bash $0 -a to-prd
      bash $0 -a to-ver=1.0.5
      bash $0 -a to-app=<<new_app_name>>
	


Note the usage is quite long - you might want to use the less page :
      `basename $0` --usage \| less

   #
   ## STOP  --- USAGE `basename $0`
   #------------------------------------------------------------------------------

END_HELP


}
#eof func doPrintUsage
