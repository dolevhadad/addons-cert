#!/usr/bin/with-contenv bashio


if bashio::config.has_value 'CertLocation'; then
    echo $(bashio::config 'CertLocation')
fi
if bashio::config.has_value 'KeyLocation'; then
    echo $(bashio::config 'KeyLocation')
fi

if bashio::config.exists 'servers.server1' && bashio::config.exists 'servers.port1'; then
    echo "$(bashio::config 'ServerUrl')"
    printf Q | openssl s_client -servername $(bashio::config 'servers.server1') -connect $(bashio::config 'servers.server1'):$(bashio::config 'servers.port1') \
    | openssl x509 -noout -dates
else 
    echo "server1 not defined"
fi

if bashio::config.exists 'servers.server2' && bashio::config.exists 'servers.port2'; then
    echo "$(bashio::config 'ServerUrl')"
    printf Q | openssl s_client -servername $(bashio::config 'servers.server2') -connect $(bashio::config 'servers.server2'):$(bashio::config 'servers.port2') \
    | openssl x509 -noout -dates
else 
    echo "server2 not defined"
fi

if bashio::config.exists 'servers.server3' && bashio::config.exists 'servers.port3'; then
    echo "$(bashio::config 'ServerUrl')"
    printf Q | openssl s_client -servername $(bashio::config 'servers.server3') -connect $(bashio::config 'servers.server3'):$(bashio::config 'servers.port3') \
    | openssl x509 -noout -dates
else 
    echo "server3 not defined"
fi