doDeleteAwsVPC(){

   #
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json"

   do_export_json_section_vars $PROJ_CONF_FILE '.env.aws'
   export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

	# probably a buggy one but just to get you start with something
	# ensure your default output is json + you have default region ...
	aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpc_id \
	  | jq -r ".InternetGateways[].InternetGatewayId"
  # terminate all vpc instances
  while read -r instance_id ; do
	  aws ec2 terminate-instances --instance-ids $instance_id
  done < <(aws ec2 describe-instances --filters 'Name=vpc-id,Values='$vpc_id \
	  | jq -r '.Reservations[].Instances[].InstanceId')

  while read -r sg ; do
	  aws ec2 delete-security-group --group-id $sg
  done < <(aws ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpc_id \
	  | jq -r '.SecurityGroups[].GroupId')

  # delete all vpc subnets
  while read -r subnet_id ; do
	  aws ec2 delete-subnet --subnet-id "$subnet_id"
  done < <(aws ec2 describe-subnets --filters 'Name=vpc-id,Values='$vpc_id | jq -r '.Subnets[].SubnetId')

  # delete all vpc route tables
  while read -r rt_id ; do
	  aws ec2 delete-route-table --route-table-id $rt_id ;
  done < <(aws ec2 describe-route-tables --filters 'Name=vpc-id,Values='$vpc_id | \
	  jq -r .RouteTables[].RouteTableId)

  # detach first all vpc internet gateways
  while read -r ig_id ; do
	  aws ec2 detach-internet-gateway --internet-gateway-id $ig_id --vpc-id $vpc_id
  done < <(aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpc_id  \
	  | jq -r ".InternetGateways[].InternetGatewayId")

  # delete than all vpc internet gateways
  while read -r ig_id ; do
	  aws ec2 delete-internet-gateway --internet-gateway-id $ig_id --vpc-id $vpc_id
  done < <(aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpc_id  \
	  | jq -r ".InternetGateways[].InternetGatewayId")

  # attempt to the delete the whole vpc
  aws ec2 delete-vpc --vpc-id=$vpc_id

   aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpc | grep InternetGatewayId
   aws ec2 describe-subnets --filters 'Name=vpc-id,Values='$vpc | grep SubnetId
   aws ec2 describe-route-tables --filters 'Name=vpc-id,Values='$vpc | grep RouteTableId
   aws ec2 describe-network-acls --filters 'Name=vpc-id,Values='$vpc | grep NetworkAclId
   aws ec2 describe-vpc-peering-connections --filters 'Name=requester-vpc-info.vpc-id,Values='$vpc | grep VpcPeeringConnectionId
   aws ec2 describe-vpc-endpoints --filters 'Name=vpc-id,Values='$vpc | grep VpcEndpointId
   aws ec2 describe-nat-gateways --filter 'Name=vpc-id,Values='$vpc | grep NatGatewayId
   aws ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpc | grep GroupId
   aws ec2 describe-instances --filters 'Name=vpc-id,Values='$vpc | grep InstanceId
   aws ec2 describe-vpn-connections --filters 'Name=vpc-id,Values='$vpc | grep VpnConnectionId
   aws ec2 describe-vpn-gateways --filters 'Name=attachment.vpc-id,Values='$vpc | grep VpnGatewayId
   aws ec2 describe-network-interfaces --filters 'Name=vpc-id,Values='$vpc | grep NetworkInterfaceId

#   while read -r key_pair_id; do
#      aws echo ec2 delete-key-pair --key-name $key_pair_id ;
#   done < <(aws ec2 describe-key-pairs | jq -r '.[] | .[] | .KeyPairId')
}
