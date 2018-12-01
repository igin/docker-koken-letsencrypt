FROM nicokaiser/koken

RUN apt-get update && apt-get install -y \
    ssl-cert \
    && rm -rf /var/lib/apt/lists/*

# Enable SSL for loopback connections
RUN a2ensite default-ssl
RUN a2enmod ssl
RUN make-ssl-cert generate-default-snakeoil --force-overwrite 
EXPOSE 443

# Enable mode rewrite
RUN a2enmod rewrite
