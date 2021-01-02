from flask import Response
from service.database_connector import getConntection 
from .auth import extractJWT
import psycopg2
import jwt
import json


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
