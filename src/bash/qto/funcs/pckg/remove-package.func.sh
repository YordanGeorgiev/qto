#!/usr/bin/env bash


#v0.2.0
#------------------------------------------------------------------------------
# removes all the files from a deployed qto instance
#------------------------------------------------------------------------------
doRemovePackage(){

	doRemovePackageFiles
	
   #remove the dirs as well
   for dir in `cat "$include_file"`; do (
       dir="$PRODUCT_DIR/$dir"
       test -d "$dir" && cmd="rm -fRv $dir" && doRunCmdAndLog "$cmd"
   );
   done

 	cmd="rm -fv $include_file" && \
 	doRunCmdAndLog "$cmd"
	echo "rm -fvr $PRODUCT_DIR">>"$product_dir/remove-""$environment_name".sh
	echo "rm -fv $product_dir/remove-""$environment_name".sh>>"$product_dir/remove-""$environment_name".sh
	nohup bash "$product_dir/remove-""$environment_name".sh &
}
#eof func doRemovePackage
