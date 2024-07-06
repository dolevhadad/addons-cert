#!/bin/bash

DOM="www.nixcraft.com"
PORT="443"
FORCE_UPDATE=FALSE
MIN_CERT_DATE=78
now_epoch=$( date +%s )



check(){
    echo -n "$DOM:"
    expiry_date=$( echo | openssl s_client -showcerts -servername $DOM -connect $DOM:$PORT 2>/dev/null | openssl x509 -inform pem -noout -enddate | cut -d "=" -f 2 | sed 's/ GMT//g')
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
  check
}

main 