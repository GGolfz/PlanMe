from .test import TestAPI
from .auth import Register,Login,isAuth
from .category import Category
from .event import Event
from .timer import Timer,ReportByCategory,ReportByDay
from .achievement import Achievement
def initialize_routes(api):
    api.add_resource(TestAPI, '/api/test')
    api.add_resource(Register,'/api/auth/register')
    api.add_resource(Login,'/api/auth/login')
    api.add_resource(isAuth,'/api/auth/isAuth')
    api.add_resource(Category,'/api/category')
    api.add_resource(Event,'/api/event')
    api.add_resource(Timer,'/api/timer')
    api.add_resource(Achievement,'/api/achievement')
    api.add_resource(ReportByCategory,'/api/report/category')
    api.add_resource(ReportByDay,'/api/report/day')