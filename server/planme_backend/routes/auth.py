from flask import Response, request
from flask_restful import Resource,reqparse
from controller.auth import register,login,isauth
class Register(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email', type=str)
        parser.add_argument('password', type=str)
        data=parser.parse_args()
        return register(data)
class Login(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email', type=str)
        parser.add_argument('password', type=str)
        data=parser.parse_args()
        return login(data)
class isAuth(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        data=parser.parse_args()
        return isauth(data)