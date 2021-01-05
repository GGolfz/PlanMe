from flask import Response
from service.database_connector import getConntection 
from .auth import extractJWT
import psycopg2
import jwt
import json
from .achievement import checkCategoryAchievement,checkAchievementCollection
def getCategory(data):
    uid = extractJWT(data['token'])
    conn = getConntection()
    cur = conn.cursor()
    cur.execute("SELECT c.cid as cid,category_name,color_code FROM user_category JOIN category c on c.cid = user_category.cid WHERE uid = '"+uid+"'")
    row = cur.fetchall()
    cur.close()
    conn.close()
    arr = []
    for i in row:
        arr.append({"cid":i[0],"category_name":i[1],"color_code":i[2]})
    return Response(json.dumps(arr), mimetype="application/json", status=200)
def createCategory(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("INSERT INTO category(category_name, color_code) VALUES ('"+data['category_name']+"','"+data['color_code']+"') RETURNING cid")
        conn.commit()
        cid = cur.fetchone()
        cur.execute("INSERT INTO user_category(uid,cid) VALUES ('"+uid+"','"+cid[0]+"')")
        conn.commit()
        d1 = checkCategoryAchievement(uid,cur,conn)
        d2 = checkAchievementCollection(uid,cur,conn)
        cur.close()
        conn.close()
        returned_data ={
            "success":"true",
            "achievements":d1+d2
        }
        return Response(json.dumps(returned_data), mimetype="application/json", status=201)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)
def editCategory(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("UPDATE category SET category_name = '"+data['category_name']+"',color_code = '"+data['color_code']+"' WHERE cid = '"+data["cid"]+"'")
        conn.commit()
        cur.close()
        conn.close()
        return Response(json.dumps({"success":"true"}), mimetype="application/json", status=200)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)
def deleteCategory(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("DELETE FROM user_category WHERE uid = '"+uid+"' AND cid = '"+data['cid']+"'")
        conn.commit()
        cur.execute("DELETE FROM category WHERE cid ='"+data['cid']+"'")
        conn.commit()
        cur.close()
        conn.close() 
        return Response(json.dumps({"success":"true"}), mimetype="application/json", status=200)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)