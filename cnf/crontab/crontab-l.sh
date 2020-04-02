# file: cnf/crontab/crontab-l.sh
# usage:
# to-deploy this configuration
# crontab cnf/crontab/crontab-l.sh

# every day at 03:00 perform a full db backup in TST
1 3 * * * bash /home/ubuntu/opt/qto/qto.0.8.2.tst.ubuntu@qto.fi/src/bash/qto/qto.sh -a backup-postgres-db -a backup-postgres-db-inserts -a publish-dbdump-to-s3

# every day at 03:15 perform a full restart of the application layer in TST
15 3 * * * bash /home/ubuntu/opt/qto/qto.0.8.2.tst.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-start

# every day at 03:15 perform a full restart of the application layer in PRD
15 3 * * * bash /home/ubuntu/opt/qto/qto.0.8.2.prd.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-start

# every day at 19:00 perform a full db backup in TST
1 19 * * * bash /home/ubuntu/opt/qto/qto.0.8.2.tst.ubuntu@qto.fi/src/bash/qto/qto.sh -a backup-postgres-db -a backup-postgres-db-inserts -a publish-dbdump-to-s3

#
# 0 3 * * *
# * * * * * <<command-to-be-executed>>
# - - - - -
# | | | | |
# | | | | +- - - - day of week (0 - 6) (Sunday=0)
# | | | +- - - - - month (1 - 12)
# | | +- - - - - - day of month (1 - 31)
# | +- - - - - - - hour (0 - 23)
# +--------------- minute

# 
# edit the crontab
# export EDITOR=vim; sudo crontab -e
# 
# to edit the crontab in batch mode
# crontab -l | sed 's/>/>>/' | crontab -
# 
# to view the crontab
# sudo crontab -l
# 
# when in doubt chk also: https://crontab.guru/#0_19_*_*_*
# eof file: cnf/crontab/crontab-l.sh
