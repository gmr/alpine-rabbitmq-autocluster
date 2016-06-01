alpine-rabbitmq-autocluster
===========================
Small RabbitMQ image (~42MB) with the autocluster plugin

RabbitMQ Version: 3.6.2
Autocluster Version: 0.5.0

|Stars| |Pulls|

Enabled plugins
---------------

- Autocluster
- Consistent Hash Exchange
- Delayed Message Exchange
- Federation
- Federation Management
- Management
- Management Visualiser
- Message Timestamp
- MQTT
- Recent History Exchange
- Sharding
- Shovel
- Shovel Management
- Stomp
- Top
- WebStomp

Configuration
-------------
All configuration of the auto-cluster plugin should be done via environment variables.

See the `RabbitMQ AutoCluster <https://github.com/aweber/rabbitmq-autocluster/wiki>`_
plugin Wiki for configuration settings.

Example Usage
-------------
The following example configures the ``autocluster`` plugin for use in an
AWS EC2 Autoscaling group:

.. code-block:: bash

    docker run --name rabbitmq -d \
      -e AUTOCLUSTER_TYPE=aws \
      -e AUTOCLUSTER_CLEANUP=true \
      -e CLEANUP_WARN_ONLY=false \
      -e AWS_DEFAULT_REGION=us-east-1 \
      -p 4369:4369 \
      -p 5672:5672 \
      -p 15672:15672 \
      -p 25672:25672 \
      gavinmroy/alpine-rabbitmq-autocluster

To use the AWS autocluster features, you will need an IAM policy that allows the
plugin to discover the node list. The following is an example of such a policy:

.. code-block:: json

  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "autoscaling:DescribeAutoScalingInstances",
                  "ec2:DescribeInstances"
              ],
              "Resource": [
                  "*"
              ]
          }
      ]
  }

If you do not want to use the IAM role for the instances, you could create a role
and specify the ``AWS_ACCESS_KEY_ID`` and ``AWS_SECRET_ACCESS_KEY`` when starting
the container.

I've included a `CloudFormation template <https://github.com/gmr/alpine-rabbitmq-autocluster/blob/master/cloudformation.json>`_
that should let you test the plugin. The template creates an IAM Policy and Role,
Security Group, ELB, Launch Configuration, and Autoscaling group.

The following is the user data snippet that for the Ubuntu image that is used
in the Launch Configuration:

.. code:: yaml

    #cloud-config
    apt_update: true
    apt_upgrade: true
    apt_sources:
      - source: deb https://apt.dockerproject.org/repo ubuntu-trusty main
        keyid: 58118E89F3A912897C070ADBF76221572C52609D
        filename: docker.list
    packages:
      - docker-engine
    runcmd:
      - export AWS_DEFAULT_REGION=`ec2metadata --availability-zone | sed s'/.$//'`
      - docker run -d --name rabbitmq --net=host -p 4369:4369 -p 5672:5672 -p 15672:15672 -p 25672:25672 -e AUTOCLUSTER_TYPE=aws -e AUTOCLUSTER_CLEANUP=true -e CLEANUP_WARN_ONLY=false -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION gavinmroy/autocluster:latest

.. |Stars| image:: https://img.shields.io/docker/stars/gavinmroy/alpine-rabbitmq-autocluster.svg?style=flat&1
   :target: https://hub.docker.com/r/gavinmroy/alpine-rabbitmq-autocluster/

.. |Pulls| image:: https://img.shields.io/docker/pulls/gavinmroy/alpine-rabbitmq-autocluster.svg?style=flat&1
   :target: https://hub.docker.com/r/gavinmroy/alpine-rabbitmq-autocluster/
 (~42MB)
