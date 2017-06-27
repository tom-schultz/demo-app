""" """
import json
import falcon

class QuoteResource(object):
    """Sample class for API"""

    quote = {
        'quote': 'I\'ve always been less interested in the future than in the past.',
        'author': 'Grace Hopper'
    }

    def on_get(self, req, resp):
        """Handles GET requests"""
        resp.body = json.dumps(self.quote)

    def on_post(self, req, resp):
        """ Set the quote. """
        self.quote = {'quote': 'New quote!', 'author': 'Tom Schultz'}

class HealthCheck(object):
    """ Class for health check. """

    def on_get(self, req, resp):
        """ Health check """
        resp.status = '200 OK'

API = falcon.API()
API.add_route('/quote', QuoteResource())
API.add_route('/health', HealthCheck())
