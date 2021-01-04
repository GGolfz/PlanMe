from flask import Response, request
from flask_restful import Resource,reqparse
from controller.event import getEvent,createEvent,toggleFinish,deleteEvent
class Event(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token', type=str)
        parser.add_argument('m',type=str)
        parser.add_argument('y',type=str)
        data=parser.parse_args()
        return getEvent(data)

    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('event_name',type=str)
        parser.add_argument('cid',type=str)
        parser.add_argument('event_date',type=str)
        data=parser.parse_args()
        return createEvent(data)

    def put(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('event_id',type=str)
        parser.add_argument('finish',type=str)
        data=parser.parse_args()
        return toggleFinish(data)

    def delete(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('event_id',type=str)
        data=parser.parse_args()
        return deleteEvent(data)
