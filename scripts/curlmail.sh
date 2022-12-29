#!/bin/sh
# an send mail by smtp server script
echo "example: ./mail.sh UAT/PROD/mailSender test@abc.com SMTPHOST(only not use UAT/PROD) "

cat context.json > bak.json
curlSendMail () {
  curl --location --request POST 'localhost:8000/mail' --header 'Content-Type:application/json' -d @context.json
}

sed -i "s/DEST/$2/" context.json

if [ $1 = "UAT" ]
then
  sed -i "s/HOSTADDR/172.24.81.231/" context.json
  sed -i "s/SENDER/srs_noreply_uat@moh.gov.sg/" context.json
  echo "in UAT"
  echo "current json as:"
  cat context.json
  echo "\n"
  curlSendMail
elif [ $1 = "PROD" ]
then
  sed -i "s/HOSTADDR/172.24.127.41/" context.json
  sed -i "s/SENDER/srs_noreply@moh.gov.sg/" context.json
  echo "in PROD"
  echo "current json as:"
  cat context.json
  echo "\n"
  curlSendMail
else
  echo "else"
  sed -i "s/HOSTADDR/$3/" context.json
  sed -i "s/SENDER/$1/" context.json
  echo "current json as:"
  cat context.json
  echo "\n"
  curlSendMail
fi
cat bak.json > context.json