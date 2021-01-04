from flask import Response, request
from flask_restful import Resource,reqparse
from controller.event import createEvent
class Event(Resource):
    # def get(self):
    #     parser = reqparse.RequestParser()
    #     parser.add_argument('token', type=str)
    #     data=parser.parse_args()
    #     return getCategory(data)
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('event_name',type=str)
        parser.add_argument('cid',type=str)
        parser.add_argument('event_date',type=str)
        data=parser.parse_args()
        return createEvent(data)
    