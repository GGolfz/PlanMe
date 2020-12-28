from flask import Response, request
from flask_restful import Resource,reqparse
from controller.test import handleGetTest
class TestAPI(Resource):
    def get(self):
        ## Use this to get req.query
        parser = reqparse.RequestParser()
        parser.add_argument('q', type=str)
        data=parser.parse_args()
        return handleGetTest(data)
    def post(self):
        ## Use this to get req.body
        parser = reqparse.RequestParser()
        parser.add_argument('name', type=str)
        parser.add_argument('time', type=str)
        return parser.parse_args()
        # return request.get_json()
        # return Response({"status":"post success"}, mimetype="application/json", status=201)