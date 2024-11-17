#!/usr/bin/env bash

while ! curl -k $RANCHER_SERVER/ping; do sleep 3; done

# Login
LOGINRESPONSE=`curl -s $RANCHER_SERVER'/v3-public/localProviders/local?action=login' -H 'content-type: application/json' --data-binary '{"username":"admin","password":"'$RANCHER_ADMIN_PASSWORD'"}' --insecure`
LOGINTOKEN=`echo $LOGINRESPONSE | jq -r .token`

echo $LOGINTOKEN

# Create API key
APIRESPONSE=`curl -s $RANCHER_SERVER'/v3/token' -H 'content-type: application/json' -H "Authorization: Bearer $LOGINTOKEN" --data-binary '{"type":"token","description":"automation"}' --insecure`
# Extract and store token
APITOKEN=`echo $APIRESPONSE | jq -r .token`

echo $APITOKEN

# Get cluster
CLUSTERID=`curl -s $RANCHER_SERVER'/v3/clusters' -H 'content-type: application/json' -H "Authorization: Bearer $APITOKEN" --insecure | jq -r '.data[0].id'`

# Generate nodecommand
AGENTCMD=`curl -s $RANCHER_SERVER'/v3/clusterregistrationtoken?id="'$CLUSTERID'"' -H 'content-type: application/json' -H "Authorization: Bearer $APITOKEN" --insecure | jq -r '.data[].nodeCommand' | head -1`

# Concat commands
DOCKERRUNCMD="$AGENTCMD $NODE_ROLE"

# Echo and Execute command
echo $DOCKERRUNCMD
$DOCKERRUNCMD
