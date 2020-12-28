from .test import TestAPI

def initialize_routes(api):
    api.add_resource(TestAPI, '/api/test')