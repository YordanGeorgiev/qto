#
# Informs the user that DB provisioning is done
# and that they can start the Mojo server now.
#
# Pops up in the end of execution of DB provisioning:
# ./src/bash/qto/qto.sh -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3 -a notify-success
# ==
# ./src/bash/qto/qto.sh -a set-roles -a create-db -a fill-db -a success
# 
doNotifyProvisioningSuccess(){
   
   cat << EOF_FINAL_SUCCESS
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      QTO installation completed succesfully.

      Please run this command to start the web server:

      ./3-start-server.sh
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
EOF_FINAL_SUCCESS

}
