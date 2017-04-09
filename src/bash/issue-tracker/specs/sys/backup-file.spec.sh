#!/bin/bash 

#
# ---------------------------------------------------------
# backups the file to the product versiodir under a host specific dir
# and also a timestamped version of it
# and includes them bothh ito the include file 
# ---------------------------------------------------------
doSpecBackupFile(){
	cd $product_instance_dir

	doLog "START doBackupFile"
	test -z "$file_to_backup" && doExit 3 "no file to backup -> do export file_to_backup=<<file>>"
	cur_rel_file=cnf/hosts/`hostname -s`/$file_to_backup

	if [[ "$file_to_backup" != /* ]]
		then file_to_backup="$product_instance_dir/$file_to_backup"
	fi
	
	test -z "$backup_root_dir" && \
		backup_root_dir=$product_instance_dir/cnf/hosts/`hostname -s` && \
			mkdir -p "$backup_root_dir"

	cmd="test -f $file_to_backup"
 	set -e ; doRunCmdOrExit "$cmd" ; set +e

	#define the version
	file_version=$(grep 'export version' $file_to_backup | cut -d= -f2)
	test -z "$file_version" && file_version='1.0.0'
	#todo: parametrize 
	mkdir -p $backup_root_dir/`dirname $file_to_backup`

	cur_file=$backup_root_dir/$file_to_backup
	cmd="cp -v $file_to_backup $cur_file"
	doRunCmdAndLog "$cmd"

	# the file to be backup should be included in the full package of the app
	test -z $include_file         && \
		include_file="$product_instance_dir/met/.include.$run_unit"

	
	# the timestamped file to be backup should be included in the full package of the app
	ts_file=$file_to_backup.$file_version.`date +%Y%m%d_%H%M%S`.backup
	ts_rel_file=cnf/hosts/`hostname -s`"$ts_file"
	ts_file=$backup_root_dir/$ts_file
	# copy the file to backup by preserving the file permissions
	cp -vp $file_to_backup $ts_file

	
	
	doLog "and verify"
	doLog $'\n'"#-----------------------------------------------------"$'\n'
	output="$output"$(stat -c "%a %U:%G %n" $backup_root_dir$file_to_backup* | sort -nr|uniq -u)
	output=$'\n\n'"$output"$'\n\n'
	doLog "$output"
	doLog $'\n'"#-----------------------------------------------------"$'\n'


	# if the files to backup list file is not cnfigured set default
	test -z "$files_to_backup_list_file" && \
		files_to_backup_list_file="$wrap_bash_dir/.$host_name.files-to-backup.lst"
	test -r $files_to_backup_list_file || touch $files_to_backup_list_file
	doLog "files_to_backup_list_file : $files_to_backup_list_file"

	flag_file_is_found=$(grep -c "$file_to_backup" "$include_file")
	msg="the file to backup : $file_to_backup was not found in this host\'s list of files to backup"
	msg="$msg adding it to the list of files to backup"
	doLog "flag_file_is_found:$flag_file_is_found"

	# add only once the 
	test -z "$flag_file_is_found" && echo $cur_rel_file >> $include_file
	echo $ts_rel_file >> $include_file

	test -z "$flag_file_is_found" && doLog "$msg"doLog "$msg"
	test $flag_file_is_found -lt 1 && echo "$file_to_backup" >> "$files_to_backup_list_file"
	test $flag_file_is_found -eq 1 && doLog " only once do nothing"
	test $flag_file_is_found -gt 1 && doLog " more than once do nothing"
	#output=$(cat "$files_to_backup_list_file")
	#output=$'\n\n'"$output"$'\n\n'
	#doLog "$output"

	doLog "STOP doBackupFile"
}
#eof spec doBackupFile
