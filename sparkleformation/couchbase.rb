ENV['volume_count']       ||= '2'
ENV['volume_size']        ||= '10'
ENV['sg']                 ||= 'private_sg'
ENV['chef_run_list']      ||= 'role[base],role[couchbase_server]'
ENV['notification_topic'] ||= "#{ENV['org']}_#{ENV['environment']}_deregister_chef_node"


SparkleFormation.new('couchbase').load(:base, :chef_base, :trusty_ami, :ssh_key_pair).overrides do
  description <<"EOF"
Couchbase EC2 instance, configured by Chef.  Route53 record: memcached.#{ENV['private_domain']}.
EOF

  dynamic!(:iam_instance_profile, 'couchbase',
           :policy_statements => [ :modify_route53 ],
           :chef_bucket => registry!(:my_s3_bucket, 'chef')
          )

  dynamic!(:launch_config, 'couchbase',
           :iam_instance_profile => 'CouchbaseIAMInstanceProfile',
           :iam_role => 'CouchbaseIAMRole',
           :create_ebs_volumes => true,
           :volume_count => ENV['volume_count'].to_i,
           :volume_size => ENV['volume_size'].to_i,
           :security_groups => _array( registry!(:my_security_group_id) ),
           :chef_run_list => ENV['chef_run_list']
          )

  dynamic!(:auto_scaling_group, 'couchbase',
           :min_size => 0,
           :desired_capacity => 1,
           :max_size => 1,
           :launch_config => :couchbase_auto_scaling_launch_configuration,
           :subnet_ids => registry!(:my_private_subnet_ids),
           :notification_topic => registry!(:my_sns_topics, ENV['notification_topic'])
          )
end
