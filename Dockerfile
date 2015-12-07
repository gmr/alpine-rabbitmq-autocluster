FROM gavinmroy/alpine-rabbitmq
ENV AUTOCLUSTER_VERSION=0.4.1
ADD https://github.com/aweber/rabbitmq-autocluster/releases/download/${AUTOCLUSTER_VERSION}/autocluster-${AUTOCLUSTER_VERSION}.ez /usr/lib/rabbitmq/plugins/
RUN chown -R rabbitmq /usr/lib/rabbitmq/plugins && chmod -R a+r /usr/lib/rabbitmq/plugins/ && rabbitmq-plugins enable --offline autocluster
