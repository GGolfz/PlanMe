from flask import Response, request
from flask_restful import Resource,reqparse
from controller.timer import saveTimer
class Timer(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('timer_date',type=str)
        parser.add_argument('cid',type=str)
        parser.add_argument('timer_time',type=str)
        data=parser.parse_args()
        return saveTimer(data)
