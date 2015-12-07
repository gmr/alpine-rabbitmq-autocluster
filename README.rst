alpine-rabbitmq-autocluster
===========================
Minimal RabbitMQ image with the autocluster plugin

Enabled plugins
---------------

- Autocluster
- Consistent Hash Exchange
- Delayed Message Exchange
- Federation
- Federation Management
- Management
- Management Visualiser
- MQTT
- Shovel
- Shovel Management
- Stomp
- Top
- WebStomp

Configuration
-------------
All configuration of the auto-cluster plugin should be done via environment variables.

See the `configuration settings <https://github.com/aweber/rabbitmq-autocluster#general-settings`_
in the the AutoCluster plugin to determine which environment variables to set.

Example Usage
-------------
The following example configures the ``autocluster`` plugin for a Consul based cluster and
will connect to a Consul server running in a container named ``consul`` running on the
same server.

.. code-block::

    docker run --name rabbitmq -d \
      -e AUTOCLUSTER_TYPE=consul \
      -e CONSUL_SCHEME=http \
      -e CONSUL_HOST=consul \
      -e CONSUL_PORT=8500 \
      -e CONSUL_SERVICE=rabbitmq \
      -l consul \
      -p 4369:4369 \
      -p 5672:5672 \
      -p 15672:15672 \
      -p 25672:25672 \
      gavinmroy/alpine-rabbitmq-autocluster

.. |Stars| image:: https://img.shields.io/docker/stars/gavinmroy/alpine-rabbitmq-autocluster.svg?style=flat&1
   :target: https://hub.docker.com/r/gavinmroy/alpine-rabbitmq-autocluster/

.. |Pulls| image:: https://img.shields.io/docker/pulls/gavinmroy/alpine-rabbitmq-autocluster.svg?style=flat&1
   :target: https://hub.docker.com/r/gavinmroy/alpine-rabbitmq-autocluster/

.. |Layers| image:: https://img.shields.io/imagelayers/image-size/gavinmroy/alpine-rabbitmq-autocluster/latest.svg?style=flat&1
    :target: https://hub.docker.com/r/gavinmroy/alpine-rabbitmq-autocluster/
