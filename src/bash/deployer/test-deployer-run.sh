main(){
	do_set_vars
	do_test_usage
   #do_test_cmd_args
}

do_set_vars(){
   set -eu -o pipefail 
   original_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   product_base_dir=$(cd $original_dir/../../../..; echo `pwd`)  # opt/qto/
   product_dir=$(cd $original_dir/../../..; echo `pwd`)          # opt/qto/qto.dev/
   cd $product_dir
   source "$original_dir/../../../.env"
   source $product_dir/lib/bash/funcs/export-json-section-vars.sh
}

do_test_usage(){

   m="test-01 test that the usage is displayed if called with --help"
   count=$(bash ./src/bash/deployer/run.sh --help|grep -ic USAGE)
   echo count:$count
   [[ $count -gt 0 ]] && do_log "ok $m"
   [[ $count -gt 0 ]] || do_log "FAILED $m" && exit 1
   sleep 1 && do_flush_screen
   
   m="test-02 test that the usage is displayed if called with --help"
   count=$(bash ./src/bash/deployer/run.sh --h|grep -ic USAGE)
   echo count:$count
   [[ $count -gt 0 ]] && do_log "ok $m"
   [[ $count -gt 0 ]] || do_log "FAILED $m" && exit 1
   sleep 1 && do_flush_screen

}

do_test_cmd_args(){

   m="test-02 test that the usage is displayed if called with --help"
   count=$(bash ./src/bash/deployer/run.sh --help|grep -ic USAGE)
   echo count:$count
   [[ $count -gt 0 ]] && do_log "ok $m"
   [[ $count -gt 0 ]] || do_log "FAILED $m" && exit 1
   sleep 1 && do_flush_screen

}

do_log(){
   test_num=$1 ; shift
   exit_msg="$*"
   echo -e "\n\n ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
   echo -e "$test_num $exit_msg"
   echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
   echo -e "\n\n"
}

# Action !!!
main
