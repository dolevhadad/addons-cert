#!/usr/bin/with-contenv bashio


if bashio::config.has_value 'CertLocation'; then
    echo $(bashio::config 'CertLocation')
fi
if bashio::config.has_value 'KeyLocation'; then
    echo $(bashio::config 'KeyLocation')
fi

if bashio::config.exists 'Servers.server1' && bashio::config.exists 'Servers.port1'; then
    echo "$(bashio::config 'ServerUrl')"
    printf Q | openssl s_client -servername $(bashio::config 'Servers.server1') -connect $(bashio::config 'Servers.server1'):$(bashio::config 'Servers.port1') \
    | openssl x509 -noout -dates
else 
    echo "server1 not defined"
fi

if bashio::config.exists 'Servers.server2' && bashio::config.exists 'Servers.port2'; then
    echo "$(bashio::config 'ServerUrl')"
    printf Q | openssl s_client -servername $(bashio::config 'Servers.server2') -connect $(bashio::config 'Servers.server2'):$(bashio::config 'Servers.port2') \
    | openssl x509 -noout -dates
else 
    echo "server2 not defined"
fi

if bashio::config.exists 'Servers.server3' && bashio::config.exists 'Servers.port3'; then
    echo "$(bashio::config 'ServerUrl')"
    printf Q | openssl s_client -servername $(bashio::config 'Servers.server3') -connect $(bashio::config 'Servers.server3'):$(bashio::config 'Servers.port3') \
    | openssl x509 -noout -dates
else 
    echo "server3 not defined"
fi