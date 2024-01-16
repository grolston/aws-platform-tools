# AWS Platform Tools

Scripts and templates for helping in setup an AWS platform.

## Validate Control Tower Enrollment - Check AWS Config

Prior to enrolling an AWS account into Control Tower there are a few checks that need to be complete. In most cases you need to have AWS Config recorder and delivery channel turned off. Use the following one-liner in AWS CloudSehll to loop through all your regions in an AWS account and check if AWS Config service is running. If Config service is running in a region, go in and delete it.

Deployment example:

```sh
curl -sSL https://raw.githubusercontent.com/grolston/aws-platform-tools/main/validate-for-control-tower.sh| sh
```
