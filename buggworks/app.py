""" Sample falcon app """
import json
import falcon

class QuoteResource(object):
    """Sample class for API"""
    req = None
    quote = {
        'quote': 'I\'ve always been more interested in the future than in the past.',
        'author': 'Grace Hopper'
    }

    def on_get(self, req, resp):
        """Handles GET requests"""
        self.req = req
        resp.body = json.dumps(self.quote)

    def on_post(self, req, resp):
        """ Set the quote. """
        self.quote = {'quote': 'New quote!', 'author': 'Tom Schultz'}
        self.req = req
        resp.status = '200 OK'

API = falcon.API()
API.add_route('/quote', QuoteResource())# sample.py
