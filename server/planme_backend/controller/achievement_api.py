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
    cur.execute("SELECT achievement.achievement_id,achievement_name,level_id,level_name,level_description,level_img,true FROM achievement JOIN ach_level al on achievement.achievement_id = al.achievement_id JOIN user_achievement ua on achievement.achievement_id = ua.achievement_id AND ua.achievement_level >= al.level_id\
 UNION\
 SELECT achievement.achievement_id,achievement_name,level_id,level_name,level_description,level_img,false FROM achievement JOIN ach_level al on achievement.achievement_id = al.achievement_id JOIN user_achievement ua on achievement.achievement_id = ua.achievement_id AND ua.achievement_level < al.level_id\
 WHERE uid = '"+uid+"'\
 ORDER BY achievement_id,level_id")
    res = []
    data = cur.fetchall()
    for i in data:
        if int(i[0]) <= len(res):
            res[int(i[0])-1]["achievement_list"].append({"level_id":i[2],"level_name":i[3],"level_description":i[4],"level_img":i[5],"finish":i[6]})
        else:
            res.append({"achievement_id":i[0],"achievement_name": i[1],"achievement_list":[{"level_id":i[2],"level_name":i[3],"level_description":i[4],"level_img":i[5],"finish":i[6]}]})
    returned_data = {
        "success": "true",
        "data": res
    }
    return Response(json.dumps(returned_data), mimetype="application/json", status=200)
