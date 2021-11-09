#!/bin/bash
export AWS_DEFAULT_REGION='eu-west-1'
if [ "$3" != 'none' ]; then
    export AWS_ACCESS_KEY_ID="$3"
    export AWS_SECRET_ACCESS_KEY="$4"
    echo "{ \"url\": \"$(aws s3 presign s3://$1/$2 --expires-in 1800)\" }"
else
    echo "{ \"url\": \"$(aws s3 presign s3://$1/$2 --expires-in 1800)\" }"
fi
