#!/bin/bash
# file: src/bash/run/check-perl-syntax.func.sh

do_check_perl_syntax() {

  export PATH=$PATH:~/perl5/bin/
  export PERL5LIB=${PERL5LIB:-}:~/perl5/lib/perl5/:$PRODUCT_DIR/src/perl/qto/t/lib:$PRODUCT_DIR/src/perl/qto/public/lib:$PRODUCT_DIR/src/perl/qto/lib

  find . -name autosplit.ix | xargs rm -fv # because idempotence
  declare -a rv
  rv=0

  # foreach perl file check the syntax by setting the correct INC dirs
  while read -r dir; do

    echo -e "\n start compiling $dir ..."
    cd $PRODUCT_DIR/src/perl/$dir

    # run the autoloader utility
    find . -name '*.pm' -exec perl -MAutoSplit -e 'autosplit($ARGV[0], $ARGV[1], 0, 1, 1)' {} \;

    c=0
    # feel free to adjust to 5, more might get you the "Out of memory!" error
    amount_of_perl_syntax_checks_to_run_in_parallel=1
    while read -r file; do
      c=$((c + 1))
      test $c -eq $amount_of_perl_syntax_checks_to_run_in_parallel && sleep 1 && export c=0
      (
        echo -e "\t ::: running: cd src/perl/qto ; perl -MCarp::Always -I $(pwd) -I $(pwd)/lib -wc \"$file\" ; cd -"
        perl -MCarp::Always -I $(pwd) -I $(pwd)/lib -wc "$file"
        # rv=$? ;  # probably not needed ... better just to spit out the error for the
        # test $rv -ne 0 && break 2 ;
      ) &
    done < <(find "." -type f \( -name "*.pl" -or -name "*.pm" -or -name '*.t' \))
    test $rv -ne 0 && break

    echo -e "stop compiling $dir ... \n\n"
    cd $PRODUCT_DIR || exit 1

  done < <(ls -1 "src/perl")

  test $rv -ne 0 && do_exit 4 "Perl syntax error"

  do_flush_screen
  export exit_code=0
}
