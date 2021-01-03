from flask import Response
from service.database_connector import getConntection 
from .auth import extractJWT
import psycopg2
import jwt
import json

def getEvent(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("SELECT event.event_id as event_id,event_date,event_name,finish,category_name FROM event JOIN category ON event.cid = category.cid JOIN user_event ON event.event_id = user_event.event_id WHERE user_event.uid = '"+uid+"' AND EXTRACT(year from event_date) = '"+data["y"]+"' AND EXTRACT(month from event_date) = '"+data["m"]+"'")
        row = cur.fetchall()
        arr = []
        for i in row:
            d = {
                "event_id" : i[0],
                "event_name" : i[2],
                "event_date" : i[1],
                "category": i[4],
                "finish": i[3]
            }
            arr.append(d)
        cur.close()
        conn.close()
        return Response(json.dumps(arr,default=str), mimetype="application/json", status=200)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)

def createEvent(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("INSERT INTO event(event_name, event_date,cid) VALUES ('"+data['event_name']+"','"+data['event_date']+"','"+data['cid']+"') RETURNING event_id")
        conn.commit()
        event_id = cur.fetchone()
        cur.execute("INSERT INTO user_event(uid,event_id) VALUES ('"+uid+"','"+event_id[0]+"')")
        conn.commit()
        cur.close()
        conn.close()
        return Response(json.dumps({"success":"true"}), mimetype="application/json", status=201)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)

def toggleFinish(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("UPDATE event SET finish = '"+data['finish']+"' WHERE event_id = '"+data['event_id']+"'")
        conn.commit()
        cur.close()
        conn.close()
        return Response(json.dumps({"success":"true"}), mimetype="application/json", status=200)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)

def deleteEvent(data):
    try:
        uid = extractJWT(data['token'])
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("DELETE FROM user_event WHERE uid = '"+uid+"' AND event_id = '"+data['event_id']+"'")
        conn.commit()
        cur.execute("DELETE FROM event WHERE event_id = '"+data['event_id']+"'")
        conn.commit()
        cur.close()
        conn.close()
        return Response(json.dumps({"success":"true"}), mimetype="application/json", status=200)
    except:
        return Response(json.dumps({"error":"true"}), mimetype="application/json", status=400)