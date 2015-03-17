FROM gliderlabs/alpine:latest

# Install puppet master.
RUN apk-install \
    ca-certificates \
    curl \
    nginx \
    ruby \
    ruby-unicorn \
    ;
RUN gem install -N \
    etcd \
    puppet \
    rack \
    ;
RUN adduser -D -s /sbin/nologin puppet

COPY files /

# Configure unicorn.
RUN cp /usr/lib/ruby/gems/*/gems/puppet-*/ext/rack/config.ru /etc/puppet/; \
    mkdir -p /var/run/puppet && chown puppet:puppet /var/run/puppet

# Install hiera-etcd backend.
RUN cd /usr/lib/ruby/gems/*/gems/hiera-*/lib/hiera/backend/; \
    curl -sS -L -O https://raw.githubusercontent.com/garethr/hiera-etcd/master/lib/hiera/backend/etcd_backend.rb

# Fix up for Passenger 4.x
# https://ask.puppetlabs.com/question/1210/do-puppet-and-puppet-dashboard-work-with-passenger-40x/
#RUN sed -i 's/^.*AutoDetect.*/# &/' /etc/httpd/conf.d/puppet_passenger.conf

#ADD start.sh /usr/local/sbin/start.sh

# We use separate data container for SSL certs.
# (Or, we would like to.)
COPY ssl /var/lib/puppet/ssl/
RUN chown -R puppet:puppet /var/lib/puppet/ssl
VOLUME ["/var/lib/puppet/ssl/"]

# We use dynamic environments.
VOLUME ["/opt/puppet/environments/"]

EXPOSE 8140
ENTRYPOINT ["/bin/sh"]
