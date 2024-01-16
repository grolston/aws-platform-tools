#!/bin/bash

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --query 'Regions[*].RegionName' --output text)
# Loop through each region
for region in $regions; do
  echo "Checking AWS Config in $region..."
  config_status=$(aws configservice describe-configuration-recorders --region $region)
  if [ -z "$config_status" ]; then
    echo "SUCCESS: AWS Config is NOT enabled in $region."
  else 
    echo "WARNING: AWS Config is enabled in $region."
  fi
  delivery_channel_status=$(aws configservice describe-delivery-channel-status --region $region --query 'DeliveryChannelsStatus[0].configSnapshotDeliveryInfo[0].lastStatus' --output text)
  if [ "$delivery_channel_status" == "None" ]; then
    echo "SUCCESS: AWS Config Delivery Channel is not setup for $region."
  else
    echo "WARNING: AWS Config Delivery Channel is set up in $region."
  fi
  echo "-------------------------"
done
