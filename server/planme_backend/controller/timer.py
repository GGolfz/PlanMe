from flask import Response
from service.database_connector import getConntection 
from .auth import extractJWT
import psycopg2
import jwt
import json

def saveTimer(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("INSERT INTO user_timer(uid,timer_date,cid,timer_time) VALUES('"+uid+"','"+data['timer_date']+"','"+data['cid']+"','"+data['timer_time']+"')")
        conn.commit()
        cur.close()
        conn.close()
        return Response(json.dumps({"success":"true"}), mimetype="application/json", status=201)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)

def convertTime(hour,minute,second):
    return int(hour)*3600 + int(minute)*60 + int(second)

def revertTime(time):
    hour = int(time/3600)
    minute = int((time%3600)/60)
    second = int(time%60)
    return {"hour":hour,"minute":minute,"second":second}