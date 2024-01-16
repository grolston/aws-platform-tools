#!/bin/bash
regions=$(aws ec2 describe-regions --query 'Regions[*].RegionName' --output text)
for region in $regions; do
    echo "Processing region: $region"
    recorder_exists=$(aws configservice describe-configuration-recorders --region $region --query 'ConfigurationRecorders | length')
    if [ "$recorder_exists" -gt 0 ] || [ -n "$recorder_exists" ]; then
        echo "Deleting AWS Config recorder in $region..."
        aws configservice delete-configuration-recorder --region $region
        echo "AWS Config recorder deleted in $region."
    else
        echo "No AWS Config recorder found in $region."
    fi
    channel_exists=$(aws configservice describe-delivery-channels --region $region --query 'DeliveryChannels | length')
    if [ "$channel_exists" -gt 0 ] || [ -n "$channel_exists" ]; ; then
        echo "Deleting AWS Config delivery channel in $region..."
        aws configservice delete-delivery-channel --region $region
        echo "AWS Config delivery channel deleted in $region."
    else
        echo "No AWS Config delivery channel found in $region."
    fi
    echo "-------------------------"
done
