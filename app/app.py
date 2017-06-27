""" Demo app """
import json
import falcon
import boto3
from botocore.exceptions import ClientError

class TripResource(object):
    """ Handling the trip route """

    def on_get(self, req, resp, user_id, trip_id):
        """Handles GET requests"""
        try:
            ddb = boto3.resource('dynamodb', region_name='us-west-2')
            table = ddb.Table('octank-demo-user-trips')
            response = table.get_item(Key={'user_id': user_id})
        except ClientError as exception:
            resp.status_code = falcon.HTTP_404
            resp.body = exception.response['Error']['Message']
        else:
            item = response['Item']
            resp.body = json.dumps(item)

class TripsResource(object):
    """ Handling the trips route """
    def get_trips(self, req, resp, user_id):
        """Handles GET requests"""
        try:
            ddb = boto3.resource('dynamodb', region_name='us-west-2')
            table = ddb.Table('octank-demo-user-trips')
            response = table.scan()
        except ClientError as exception:
            resp.status_code = falcon.HTTP_404
            resp.body = exception.response['Error']['Message']
        else:
            resp.body = json.dumps(response['Items'])

class HealthCheck(object):
    """ Class for health check. """

    def on_get(self, req, resp):
        """ Health check """
        resp.status = '200 OK'

API = falcon.API()
API.add_route('/{user_id}/trip/{trip_id}', TripResource())
API.add_route('/{user_id}/trips', TripsResource())
API.add_route('/health', HealthCheck())
