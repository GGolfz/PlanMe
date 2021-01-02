from .test import TestAPI
from .auth import Register,Login,isAuth
from .category import Category
def initialize_routes(api):
    api.add_resource(TestAPI, '/api/test')
    api.add_resource(Register,'/api/auth/register')
    api.add_resource(Login,'/api/auth/login')
    api.add_resource(isAuth,'/api/auth/isAuth')
    api.add_resource(Category,'/api/category')