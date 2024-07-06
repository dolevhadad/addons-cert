#!/usr/bin/with-contenv bashio


if bashio::config.has_value 'CertLocation'; then
    echo $(bashio::config 'CertLocation')
fi
if bashio::config.has_value 'KeyLocation'; then
    echo $(bashio::config 'KeyLocation')
fi

if  bashio::config.has_value 'ServerUrl' && bashio::config.has_value 'Port'; then
    echo "$(bashio::config 'ServerUrl')"
    printf Q | openssl s_client -servername $(bashio::config 'ServerUrl') -connect $(bashio::config 'ServerUrl'):$(bashio::config 'Port') \
    | openssl x509 -noout -dates
else 
    echo "server not defined"
fi

