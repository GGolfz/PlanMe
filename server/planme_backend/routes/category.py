from flask import Response, request
from flask_restful import Resource,reqparse
from controller.category import getCategory,createCategory,changeCategoryName,changeCategoryColor
class Category(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token', type=str)
        data=parser.parse_args()
        return getCategory(data)
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('category_name',type=str)
        parser.add_argument('color_code',type=str)
        data=parser.parse_args()
        return createCategory(data)

class CategoryName(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('cid',type=str)
        parser.add_argument('category_name',type=str)
        data=parser.parse_args()
        return changeCategoryName(data)

class CategoryColor(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('cid',type=str)
        parser.add_argument('color_code',type=str)
        data=parser.parse_args()
        return changeCategoryColor(data)
