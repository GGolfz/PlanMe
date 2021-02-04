import psycopg2

def getConntection():
    return psycopg2.connect(host="planme_postgres",database="planme_db",user="planme_user",password="PI3A8gLDftt5GKi7")
