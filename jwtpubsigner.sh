#!/bin/bash

usage()
{
	echo "This script signs JWT header+payload using server public key"
	echo "[NOTE]: Header and Payload must be base64urlencoded with padding removed"
    echo "Usage: jwtsign [example.com] [header.payload]"
}

##### Main

while [ "$2" == "" ]; do
    case $1 in
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

token=$2
uri=$1

pubkey=$(openssl s_client -servername $uri -connect $uri:443  \
    </dev/null 2>/dev/null | openssl x509 -pubkey -noout)

hexkey=$(echo "$pubkey"| xxd -p | tr -d "\\n" 2>&1)

hex256sign=$(echo -n "$token" | openssl dgst -sha256 -mac HMAC -macopt hexkey:$hexkey)
hex256sign="${hex256sign:9}"
full256sign=$(python -c "exec(\"import base64, binascii\nprint base64.urlsafe_b64encode(binascii.a2b_hex('$hex256sign')).replace('=','')\")")

hex512sign=$(echo -n "$token" | openssl dgst -sha512 -mac HMAC -macopt hexkey:$hexkey)
hex512sign="${hex512sign:9}"
full512sign=$(python -c "exec(\"import base64, binascii\nprint base64.urlsafe_b64encode(binascii.a2b_hex('$hex512sign')).replace('=','')\")")

printf "\n\033[0;33m$uri public key is:\033[0m\n$pubkey\n"

printf "\n\033[0;33mYour JWT HS256 signature is: $full256sign"
printf "\nFull JWT is: $token.$full256sign\n"

printf "\nYour JWT HS512 signature is: $full512sign"
printf "\nFull JWT is: $token.$full512sign\n"