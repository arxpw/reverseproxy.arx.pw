#/bin/sh
NAME=cert
DOMAIN=yourwebsite.com
PASSFILE=ca-pass.txt
EXTFILE=ssl/$NAME.ext

# Generate private key
echo '1. genrsa'
openssl genrsa -passout file:$PASSFILE -des3 -out ssl/ca.key 2048 

echo '2. req'
openssl req -passin file:$PASSFILE -x509 -new -nodes -key ssl/ca.key -sha256 -days 825 -out ssl/ca.pem

echo '3. genrsa, out'
openssl genrsa -out ssl/$NAME.key 2048

echo '4. req key'
openssl req -passin file:$PASSFILE -new -key ssl/$NAME.key -out ssl/$NAME.csr
# Create a config file for the extensions
>ssl/$NAME.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = backend.$DOMAIN # we'll be hitting this domain.
DNS.3 = frontend.$DOMAIN # frontend if required..
#IP.1 = 0.0.0.0 # Optionally, add an IP address
EOF

echo '5. create and sign cert'
# Create the signed certificate
openssl x509 -passin file:$PASSFILE -req -in ssl/$NAME.csr -CA ssl/ca.pem -CAkey ssl/ca.key -CAcreateserial \
-out ssl/$NAME.crt -days 825 -sha256 -extfile $EXTFILE
