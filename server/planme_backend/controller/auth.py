from flask import Response
import bcrypt
from service.database_connector import getConntection 
import psycopg2
import jwt
import json
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
                return Response(json.dumps(returned_data), mimetype="application/json", status=201)
            return Response("{\"error\":{\"email\":\"\",\"password\":\"Invalid email or password\"}}", mimetype="application/json", status=404)
        except:
            return Response("{\"error\":{\"email\":\"\",\"password\":\"Invalid email or password\"}}", mimetype="application/json", status=404)
    except:
        return Response("{\"error\":\"true\"}", mimetype="application/json", status=400)