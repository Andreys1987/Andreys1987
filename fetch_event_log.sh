#!/bin/bash
echo "Fetching Recording Studio Event Log file."
echo "Note: UACF VPN is required. If the connection timeed out, check your VPN."

if [ "$#" -ne 2 ]; then
  echo "usage: <user id> <workout id>" >&2
  echo "ex.  $./fetch_event_log.sh 1234234 9986654" >&2
  exit 1
fi

re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
   echo "error: first argument user id must be an integer" >&2
   exit 1
fi
if ! [[ $1 =~ $re ]] ; then
   echo "error: second argument workout id must be an integer" >&2
   exit 1
fi

curl --location --request GET https://mobile-logstore.uacf.io/event_log/MMF/$1/$2 --header 'UACF-Client-Scopes: customer_happiness,ua_api_user' --connect-timeout 1.0 | gunzip -c > event_log_$1_$2.csv

echo "done."