from flask import Response, request
from flask_restful import Resource,reqparse
from controller.category import getCategory,createCategory,editCategory,deleteCategory
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
    def put(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('cid',type=str)
        parser.add_argument('category_name',type=str)
        parser.add_argument('color_code',type=str)
        data=parser.parse_args()
        return editCategory(data)
    def delete(self):
        parser = reqparse.RequestParser()
        parser.add_argument('token',type=str)
        parser.add_argument('cid',type=str)
        data=parser.parse_args()
        return deleteCategory(data)
