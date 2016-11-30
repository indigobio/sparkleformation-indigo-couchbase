## sparkleformation-indigo-couchbase
This repository contains a SparkleFormation template that creates a Couchbase
EC2 instance.

Additionally, the template creates a private Route53 (DNS) CNAME record:
memcached.`ENV['private_domain']`.

### Dependencies

The template requires external Sparkle Pack gems, which are noted in
the Gemfile and the .sfn file.  These gems interact with AWS through the
`aws-sdk-core` gem to identify or create  availability zones, subnets, and 
security groups.

### Parameters

When launching the compiled CloudFormation template, you will be prompted for
some stack parameters:

| Parameter | Default Value | Purpose |
|-----------|---------------|---------|
| ChefRunlist | role[base],role[openvpn\_as] | No need to change |
| ChefServer | https://api.opscode.com/organizations/product\_dev | No need to change |
| ChefValidationClientName | product\_dev-validator | No need to change |
| ChefVersion | 12.4.0 | No need to change |
| CouchbaseAssociatePublicIpAddress | false | No need to change |
| CouchbaseDeleteEbsVolumesOnTermination | true | Set to false if you want the EBS volumes to persist when the instance is terminated |
| CouchbaseDesiredCapacity | 1 | No need to change |
| CouchbaseEbsOptimized| false | Enable EBS optimization for the instance (instance type must be an m3, m4, c3 or c4 type; maybe others) |
| CouchbaseEbsProvisionedIops| 300 | Number of provisioned IOPS to request for io1 EBS volumes |
| CouchbaseEbsVolumeSize | 10 | Size (in GB) of additional EBS volumes |
| CouchbaseEbsVolumeType | gp2 | EBS volume type (gp2, or general purpose, or io1, provisioned IOPS).  Provisioned IOPS volumes incur additional expense. |
| CouchbaseInstanceMonitoring | false | Set to true to enable detailed cloudwatch monitoring (additional costs incurred) |
| CouchbaseInstanceType | t2.small | Increase the instance size for more network throughput |
| CouchbaseMaxSize | 1 | No need to change |
| CouchbaseMinSize | 0 | No need to change |
| CouchbaseNotificationTopic | auto-determined | No need to change |
| RootVolumeSize | 12 | No need to change |
| SshKeyPair | indigo-bootstrap | No need to change |
