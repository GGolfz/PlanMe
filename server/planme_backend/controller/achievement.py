LoginAchievement1 = "Login"
LoginAchievement2 = "Login Accumulate"
CategoryAchievement = "Category"
TimerAchievement1 = "Timer"
TimerAchievement2 = "Timer Accumulate"
AchievementCollection1 = "Achievement Collect"
AchievementCollection2 = "Achievement Level"
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
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"' ORDER BY level_id")
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
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"' ORDER BY level_id")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach

def checkCategoryAchievement(uid,cur,conn):
    cur.execute("SELECT COUNT(cid) FROM user_category WHERE uid = '"+uid+"'")
    cat = cur.fetchone()
    cat = cat[0]
    cur.execute("SELECT achievement.achievement_id,achievement_level FROM user_achievement JOIN achievement ON achievement.achievement_id = user_achievement.achievement_id WHERE achievement_name = '"+CategoryAchievement+"' AND uid = '"+uid+"'")
    ac = cur.fetchone()
    aid = ac[0]
    lv = ac[1]
    curlv = 0
    if cat >= 20:
        curlv = 5
    elif cat >= 15:
        curlv = 4
    elif cat >= 10:
        curlv = 3
    elif cat >= 7:
        curlv = 2
    elif cat >= 5:
        curlv = 1
    ach = []
    if curlv > lv:
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"' ORDER BY level_id")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach

def checkTimerAchievement(uid,cur,conn,mtime):
    cur.execute("SELECT achievement.achievement_id,achievement_level FROM user_achievement JOIN achievement ON achievement.achievement_id = user_achievement.achievement_id WHERE achievement_name = '"+TimerAchievement1+"' AND uid = '"+uid+"'")
    ac = cur.fetchone()
    aid = ac[0]
    lv = ac[1]
    curlv = 0
    mtime = mtime // 60
    if mtime >= 180:
        curlv = 5
    elif mtime >= 120:
        curlv = 4
    elif mtime >= 60:
        curlv = 3
    elif mtime >= 45:
        curlv = 2
    elif mtime >= 25:
        curlv = 1
    ach = []
    if curlv > lv:
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"' ORDER BY level_id")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach

def checkTimerAccumulateAchievement(uid,cur,conn):
    cur.execute("SELECT sum(timer_time) FROM user_timer WHERE uid = '"+uid+"'")
    time = cur.fetchone()
    time = time[0]
    cur.execute("SELECT achievement.achievement_id,achievement_level FROM user_achievement JOIN achievement ON achievement.achievement_id = user_achievement.achievement_id WHERE achievement_name = '"+TimerAchievement2+"' AND uid = '"+uid+"'")
    ac = cur.fetchone()
    aid = ac[0]
    lv = ac[1]
    curlv = 0
    time = time // 60
    if time >= 6000:
        curlv = 6
    elif time >= 3000:
        curlv = 5
    elif time >= 1200:
        curlv = 4
    elif time >= 600:
        curlv = 3
    elif time >= 300:
        curlv = 2
    elif time >= 100:
        curlv = 1
    ach = []
    if curlv > lv:
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"' ORDER BY level_id")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach

def checkAchievementCollection(uid,cur,conn):
    ach = []
    while(True):
        d1 = checkAchievementCollect(uid,cur,conn)
        d2 = checkAchievementLevel(uid,cur,conn)
        if len(d1) == 0 and len(d2) == 0:
            break
        ach = ach + d1 + d2
    return ach

def checkAchievementCollect(uid,cur,conn):
    cur.execute("SELECT sum(achievement_level) FROM user_achievement WHERE uid = '"+uid+"'")
    achsum = cur.fetchone()
    achsum = int(achsum[0])
    cur.execute("SELECT achievement.achievement_id,achievement_level FROM user_achievement JOIN achievement ON user_achievement.achievement_id = achievement.achievement_id AND achievement_name = '"+AchievementCollection1+"' AND uid ='"+uid+"'")
    ac = cur.fetchone()
    aid = ac[0]
    lv = ac[1]
    curlv = 0
    if achsum >= 25:
        curlv = 5
    elif achsum >= 20:
        curlv = 4
    elif achsum >= 15:
        curlv = 3
    elif achsum >= 10:
        curlv = 2
    elif achsum >= 5:
        curlv = 1
    ach = []
    if curlv > lv:
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"' ORDER BY level_id")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach

def checkAchievementLevel(uid,cur,conn):
    cur.execute("SELECT achievement_level FROM user_achievement WHERE uid = '"+uid+"'")
    achls= cur.fetchall()
    cur.execute("SELECT achievement.achievement_id,achievement_level FROM user_achievement JOIN achievement ON user_achievement.achievement_id = achievement.achievement_id AND achievement_name = '"+AchievementCollection2+"' AND uid ='"+uid+"'")
    ac = cur.fetchone()
    aid = ac[0]
    lv = ac[1]
    curlv = 0
    for i in range(5):
        c = 0
        for j in achls:
            if int(j[0]) >= 5-i:
                c+=1
        if c >= 5:
            curlv = 5-i
            break
    ach = []
    if curlv > lv:
        cur.execute("SELECT achievement.achievement_id,level_name,level_img FROM ach_level JOIN achievement ON achievement.achievement_id = ach_level.achievement_id WHERE level_id > "+str(lv)+" AND level_id <= "+str(curlv)+" AND achievement.achievement_id = '"+str(aid)+"' ORDER BY level_id")
        data = cur.fetchall()
        for i in data:
            ach.append({"achievement_id":i[0],"level_name":i[1],"level_img":i[2]})
        cur.execute("UPDATE user_achievement SET achievement_level = "+str(curlv)+" WHERE achievement_id = '"+str(aid)+"' AND uid ='"+uid+"'")
        conn.commit()
    return ach
