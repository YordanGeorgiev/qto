#------------------------------------------------------------------------------
# usage example:
# source $PRODUCT/lib/bash/funcs/read-conf-section.sh
# do_read_conf_section '.env.db'
#------------------------------------------------------------------------------
do_read_conf_section(){

   PROJ_CONF_FILE=$1; shift

   test -f ${PROJ_CONF_FILE:-} || {
      echo "ERROR : the json_file: $PROJ_CONF_FILE does not exist !!! Nothing to do" && exit 1
   }

   section="$1"
   test -z "$section" && \
      echo "ERROR : the section in do_read_conf_section is empty !!! Nothing to do !!!" && exit 1

   do_flush_screen

   echo "INFO : exporting vars from cnf ${PROJ_CONF_FILE:-}: "
   while read -r l ; do
      key=$(echo $l|cut -d'=' -f1)
      val=$(echo $l|cut -d'=' -f2)
      eval "$(echo -e 'export '$key=\"\"$val\"\")"
      echo "INFO : $key=$val"
   done < <(cat $PROJ_CONF_FILE| jq -r "$section"'|keys_unsorted[] as $key|"\($key)=\"\(.[$key])\""')
}
