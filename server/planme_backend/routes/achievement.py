from flask import Response, request
from flask_restful import Resource,reqparse
from controller.achievement_api import getAchievement
class Achievement(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token', type=str)
        data=parser.parse_args()
        return getAchievement(data)
        