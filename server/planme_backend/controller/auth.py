from flask import Response
import bcrypt
from service.database_connector import getConntection 
import psycopg2
import jwt
import json
from datetime import date
secret = 'jwtsecret'
def register(data):
    try:
        email = data['email']
        password = data['password'].encode('utf-8')
        hashed = bcrypt.hashpw(password,bcrypt.gensalt())
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("SELECT * FROM users WHERE email = '"+email+"'")
        row = cur.fetchall()
        if len(row) == 0:
            cur.execute(cur.mogrify('INSERT INTO users(email,password) VALUES(%s,%s);',(email,hashed.decode('utf-8'))))  
            conn.commit()  
            cur.execute("SELECT uid FROM users WHERE email = '"+email+"'")
            row =cur.fetchone()
            token = jwt.encode({'uid': row[0]},secret, algorithm='HS256')
            checkDailyLogin(row[0],cur,conn)
            createDefaultCategory(row[0],cur,conn)
        else:
            return Response("{\"error\":{\"email\":\"Email is already used\",\"password\":\"\"}}", mimetype="application/json", status=400)
        cur.close()
        conn.close()
        returned_data = {
        "success":"true",
        "token":token
        }
        return Response(json.dumps(returned_data), mimetype="application/json", status=201)
    except:
        return Response("{\"error\":\"true\"}", mimetype="application/json", status=400)

def login(data):
    try:
        email = data['email']
        password = data['password'].encode('utf-8')
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("SELECT password FROM users WHERE email='"+email+"'")
        row = cur.fetchall()
        if len(row) == 0:
            return Response("{\"error\":{\"email\":\"\",\"password\":\"Invalid email or password\"}}", mimetype="application/json", status=404)
        try:
            if bcrypt.checkpw(password,row[0][0].encode('utf-8')):
                cur.execute("SELECT uid FROM users WHERE email = '"+email+"'")
                row1 =cur.fetchone()
                token = jwt.encode({'uid': row1[0]},secret, algorithm='HS256')
                returned_data ={
                    "success":"true",
                    "token":token
                }
                checkDailyLogin(row1[0],cur,conn)
                
                cur.close()
                conn.close()
                return Response(json.dumps(returned_data), mimetype="application/json", status=201)
            return Response("{\"error\":{\"email\":\"\",\"password\":\"Invalid email or password\"}}", mimetype="application/json", status=404)
        except:
            return Response("{\"error\":{\"email\":\"\",\"password\":\"Invalid email or password\"}}", mimetype="application/json", status=404)
    except:
        return Response("{\"error\":\"true\"}", mimetype="application/json", status=400)

def isauth(data):
    try:
        token = data['token']
        decoded = jwt.decode(token, secret, algorithms=["HS256"])
        uid = decoded['uid']
        conn = getConntection()
        cur = conn.cursor()
        cur.execute("SELECT uid FROM users WHERE uid='"+uid+"'")       
        row = cur.fetchall()
        checkDailyLogin(uid,cur,conn)
        if len(row) == 0:
            return Response("{\"error\":\"true\"}", mimetype="application/json", status=404)
        return Response(json.dumps(decoded), mimetype="application/json", status=200)
    except:
        return Response("{\"error\":\"true\"}", mimetype="application/json", status=400)

def extractJWT(token):
    try:
        decoded = jwt.decode(token,secret,algorithms=["HS256"])
        uid = decoded['uid']
        return uid
    except:
        raise Exception("Unauthorize")
        return ''

def checkDailyLogin(uid,cur,conn):
    today = date.today()
    cur.execute("SELECT date FROM login_log WHERE uid = '"+uid+"' AND date = '"+str(today)+"'")
    data = cur.fetchall()
    if len(data) == 0:
        cur.execute("INSERT INTO login_log(uid,date) VALUES('"+uid+"','"+str(today)+"')")
        conn.commit()

def createDefaultCategory(uid,cur,conn):
    cur.execute("INSERT INTO category(category_name, color_code) VALUES('Work','A01'),('Study','A02'),('Relax','A03') RETURNING cid;")
    conn.commit()
    row = cur.fetchall()
    for i in row:
        cur.execute("INSERT INTO user_category(uid,cid) VALUES ('"+uid+"','"+i[0]+"')")
        conn.commit()