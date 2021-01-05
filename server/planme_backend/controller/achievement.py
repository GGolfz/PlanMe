LoginAchievement1 = "Login"
LoginAchievement2 = "Login Accumulate"

def createDefaultAchievement(uid,cur,conn):
    cur.execute("SELECT achievement_id FROM achievement")
    data = cur.fetchall()
    for i in data:
        cur.execute("INSERT INTO user_achievement(uid,achievement_id,achievement_level) VALUES('"+uid+"',"+str(i[0])+",0)")
        conn.commit()
    

def checkLoginAchievement(uid,cur,conn):
    cur.execute("SELECT COUNT(date) FROM login_log WHERE uid = '"+uid+"'")
    day = cur.fetchone()
    day = day[0]
    cur.execute("SELECT achievement.achievement_id,achievement_level FROM user_achievement JOIN achievement ON  achievement.achievement_id = user_achievement.achievement_id WHERE achievement_name = '"+LoginAchievement1+"' AND uid = '"+uid+"'")
    ac = cur.fetchone()
    aid = ac[0]
    lv = ac[1]
    curlv = 0
    if day >= 360:
        curlv = 7
    elif day >= 180:
        curlv = 6
    elif day >= 30:
        curlv = 5
    elif day >= 7:
        curlv = 4
    elif day >= 5:
        curlv = 3
    elif day >= 3:
        curlv = 2
    elif day >= 1:
        curlv = 1
    ach = []
    if curlv > lv:
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"'")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach

def checkLoginAccumulateAchievement(uid,cur,conn):
    cur.execute("SELECT times FROM login_accumulate WHERE uid = '"+uid+"'")
    time = cur.fetchone()
    time = time[0]
    cur.execute("SELECT achievement.achievement_id,achievement_level FROM user_achievement JOIN achievement ON user_achievement.achievement_id = achievement.achievement_id AND achievement_name = '"+LoginAchievement2+"' AND uid ='"+uid+"'")
    ac = cur.fetchone()
    aid = ac[0]
    lv = ac[1]
    curlv = 0
    if time >=28:
        curlv = 5
    elif time >= 14:
        curlv = 4
    elif time >= 7:
        curlv = 3
    elif time >= 3:
        curlv = 2
    elif time >= 1:
        curlv = 1
    ach = []
    if curlv > lv:
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"'")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach

