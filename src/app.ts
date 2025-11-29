import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import logger from './util/logger';

/**
 *
 * Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format
 * @param {Object} event - API Gateway Lambda Proxy Input Format
 *
 * Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
 * @returns {Object} object - API Gateway Lambda Proxy Output Format
 *
 */

export const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    const correlationId = event.headers?.['correlation-id'] ?? 'no-correlation-id';
    logger.info(`[${correlationId}] lambda invoked...`);
    console.log(`Lambda 1 Request: ${JSON.stringify(event)}`);

    try {
        return {
            statusCode: 200,
            body: JSON.stringify({
                message: 'Hello from lambda',
            }),
        };
    } catch (err) {
        console.log(err);
        return {
            statusCode: 500,
            body: JSON.stringify({
                message: 'some error happened',
            }),
        };
    }
};
