import boto3
import time
import json
import logging

def lambda_handler(event, context):
    # No need to assume_role since Lambda already has a role attached

    client = boto3.client('cloudfront')

    response = client.create_invalidation(
        DistributionId='CFDistributionId',
        InvalidationBatch={
            'Paths': {
                'Quantity': 1,
                'Items': [
                    '/*',
                ]
            },
            'CallerReference': str(time.time()).replace(".", "")
        }
    )
    invalidation_id = response['Invalidation']['Id']

    print("Invalidation created successfully with Id: " + invalidation_id)

    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    logger.debug(json.dumps(event))

    codepipeline = boto3.client('codepipeline')
    job_id = event['CodePipeline.job']['id']

    try:
        #raise ValueError('This message will appear in the CodePipeline UI.')
        logger.info('Success!')
        response = codepipeline.put_job_success_result(jobId=job_id)
        logger.debug(response)
    except Exception as error:
        logger.exception(error)
        response = codepipeline.put_job_failure_result(
            jobId=job_id,
            failureDetails={
              'type': 'JobFailed',
              'message': f'{error.__class__.__name__}: {str(error)}'
            }
        )
        logger.debug(response)
