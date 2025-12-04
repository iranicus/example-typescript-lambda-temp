#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LAMBDA_FUNCTION_NAME=typescript-lambda
LAMBDA_RUNTIME=nodejs22.x
LAMBDA_BUILD_DIR="$PROJECT_ROOT/dist"
LAMBDA_HANDLER_FUNCTION=src/index.handler

printf '\n## Creating Lambda function ##\n'

awslocal lambda create-function \
--function-name "${LAMBDA_FUNCTION_NAME}" \
--runtime "${LAMBDA_RUNTIME}" \
--timeout 150 \
--role "arn:aws:iam::000000000000:role/lambda-ex" \
--tags "{\"_custom_id_\":\"${LAMBDA_FUNCTION_NAME}\"}" \
--code S3Bucket="hot-reload",S3Key="${LAMBDA_BUILD_DIR}" \
--handler "${LAMBDA_HANDLER_FUNCTION}"

awslocal lambda create-function-url-config \
--function-name "${LAMBDA_FUNCTION_NAME}" \
--auth-type "NONE"

LAMBDA_INVOKE_URL=http://${LAMBDA_FUNCTION_NAME}.lambda-url.${REGION}.localhost.localstack.cloud:4566/

printf '\n## Lambda Invoke URL: %s\n' "$LAMBDA_INVOKE_URL"