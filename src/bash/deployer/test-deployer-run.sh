main(){
	do_set_vars
	do_test_usage
   #do_test_cmd_args
}

do_set_vars(){
   set -eu -o pipefail 
   unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   product_base_dir=$(cd $unit_run_dir/../../../..; echo `pwd`)
   product_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
	product_instance_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
   cd $product_instance_dir
   source "$unit_run_dir/../../../.env"
}

do_test_usage(){

   m="test-01 test that the usage is displayed if called with --help"
   count=$(bash ./src/bash/deployer/run.sh --help|grep -ic USAGE)
   echo count:$count
   [[ $count -gt 0 ]] && do_log "ok $m"
   [[ $count -gt 0 ]] || do_log "FAILED $m" && exit 1
   sleep 1 && clearTheScreen
   
   m="test-02 test that the usage is displayed if called with --help"
   count=$(bash ./src/bash/deployer/run.sh --h|grep -ic USAGE)
   echo count:$count
   [[ $count -gt 0 ]] && do_log "ok $m"
   [[ $count -gt 0 ]] || do_log "FAILED $m" && exit 1
   sleep 1 && clearTheScreen

}

do_test_cmd_args(){

   m="test-02 test that the usage is displayed if called with --help"
   count=$(bash ./src/bash/deployer/run.sh --help|grep -ic USAGE)
   echo count:$count
   [[ $count -gt 0 ]] && do_log "ok $m"
   [[ $count -gt 0 ]] || do_log "FAILED $m" && exit 1
   sleep 1 && clearTheScreen

}

do_log(){
   test_num=$1 ; shift
   exit_msg="$*"
   echo -e "\n\n ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
   echo -e "$test_num $exit_msg"
   echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
   echo -e "\n\n"
}

clearTheScreen(){
   printf "\033[2J";printf "\033[0;0H"
}

# Action !!!
main
