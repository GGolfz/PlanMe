from flask import Response
from service.database_connector import getConntection 
from .auth import extractJWT
import psycopg2
import jwt
import json
from .achievement import checkCategoryAchievement,checkAchievementCollection
def getAchievement(data):
    uid = extractJWT(data['token'])
    conn = getConntection()
    cur = conn.cursor()
    
    return Response(json.dumps({"success":"true"}), mimetype="application/json", status=200)
