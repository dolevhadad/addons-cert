#!/usr/bin/with-contenv bashio

date 
now_epoch=$( date +%s )

if bashio::config.has_value 'CertLocation'; then
    echo $(bashio::config 'CertLocation')
fi

if bashio::config.has_value 'KeyLocation'; then
    echo $(bashio::config 'KeyLocation')
fi

if bashio::config.has_value 'MIN_CERT_DATE'; then
    echo "MIN_CERT_DATE: " $(bashio::config 'MIN_CERT_DATE')
fi


start(){
    if bashio::config.exists 'SERVERS.SERVER1' && bashio::config.exists 'SERVERS.PORT1'; then
        echo "$(bashio::config 'SERVERS.SERVER1')"
        DOM="$(bashio::config 'SERVERS.SERVER1')"
        PORT="$(bashio::config 'SERVERS.PORT1')"
        check
    else 
        echo "SERVER1 not defined"
    fi

    if bashio::config.exists 'SERVERS.SERVER2' && bashio::config.exists 'SERVERS.PORT2'; then
        echo "$(bashio::config 'SERVERS.SERVER2')"
        DOM="$(bashio::config 'SERVERS.SERVER2')"
        PORT="$(bashio::config 'SERVERS.PORT2')"
        check
    else 
        echo "SERVER2 not defined"
    fi

    if bashio::config.exists 'SERVERS.SERVER3' && bashio::config.exists 'SERVERS.PORT3'; then
        echo "$(bashio::config 'SERVERS.SERVER3')"
        DOM="$(bashio::config 'SERVERS.SERVER3')"
        PORT="$(bashio::config 'SERVERS.PORT3')"
        check
    else 
        echo "SERVER3 not defined"
    fi
}

check(){
    echo -n "$DOM:"
    echo ""
    openssl s_client -showcerts -servername $DOM -connect $DOM:$PORT 2>/dev/null | openssl x509 -inform pem -noout -enddate | cut -d "=" -f 2
    echo ""
    expiry_date=$( echo | openssl s_client -showcerts -servername $DOM -connect $DOM:$PORT 2>/dev/null | openssl x509 -inform pem -noout -enddate | cut -d "=" -f 2 )
    echo -n " $expiry_date";
    expiry_epoch=$( date -d "$expiry_date" +%s )
    expiry_days="$(( ($expiry_epoch - $now_epoch) / (3600 * 24) ))"

    echo "    $expiry_days days"

    echo "expiry_days: "$expiry_days
    if [ $MIN_CERT_DATE -gt "$expiry_days" ] ;then
        echo "Cert was update"
        update_cert
    else
        echo "Cert was not update"
    fi
}


update_cert(){
    echo "scp"
}

main(){
  start
}

main 