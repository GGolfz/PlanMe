from flask import Response
from service.database_connector import getConntection 
from .auth import extractJWT
import psycopg2
import jwt
import json
from datetime import date,timedelta
from .achievement import checkTimerAchievement,checkTimerAccumulateAchievement,checkAchievementCollection

def saveTimer(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("INSERT INTO user_timer(uid,timer_date,cid,timer_time) VALUES('"+uid+"','"+data['timer_date']+"','"+data['cid']+"','"+data['timer_time']+"')")
        conn.commit()
        d1 = checkTimerAchievement(uid,cur,conn,int(data['timer_time']))
        d2 = checkTimerAccumulateAchievement(uid,cur,conn)
        d3 = checkAchievementCollection(uid,cur,conn)
        cur.close()
        conn.close()
        returned_data ={
                "success":"true",
                "achievements":d1+d2+d3
        }
        return Response(json.dumps(returned_data), mimetype="application/json", status=201)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)

def convertTime(hour,minute,second):
    return int(hour)*3600 + int(minute)*60 + int(second)

def revertTime(time):
    hour = int(time/3600)
    minute = int((time%3600)/60)
    second = int(time%60)
    return {"hour":hour,"minute":minute,"second":second}

def getTimeByDay(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("SELECT timer_date,sum(timer_time) FROM user_timer \
    WHERE uid = '"+uid+"' AND timer_date > current_date - 7 \
    GROUP BY timer_date ORDER BY timer_date")
        data = cur.fetchall()
        res = []
        sums = 0
        if(len(data) != 7):
            for i in range(7-len(data)):
                today = date.today()
                target = today - timedelta(days=6-i)
                res.append({"timer_date":str(target),"times":0})
        for i in data:
            mins = int(i[1]) // 60
            sums += mins
            res.append({"timer_date":str(i[0]),"times":mins})
        returned_data = {"sum_time": sums, "data": res}
        return Response(json.dumps(returned_data), mimetype="application/json", status=200)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)

def getTimeByCategory(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("SELECT c.cid,category_name,color_code,sum(timer_time) FROM user_timer JOIN category c on c.cid = user_timer.cid \
WHERE uid = '"+uid+"' AND timer_date > current_date - 7 \
GROUP BY c.cid,category_name,color_code")
        data = cur.fetchall()
        res = []
        sums = 0
        for i in data:
            mins = int(i[3]) // 60
            sums += mins
            res.append({"category_name":i[1],"color_code":i[2],"times":mins})
        returned_data = {"sum_time": sums, "data": res}
        if sums == 0 and len(res) == 0:
            returned_data = {"sum_time": 1, "data": [{
                "category_name": "No Data",
                "color_code": "A01",
                "times": 1
            }]}
        return Response(json.dumps(returned_data), mimetype="application/json", status=200)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)
