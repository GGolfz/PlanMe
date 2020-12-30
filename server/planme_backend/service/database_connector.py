import psycopg2

def getConntection():
    return psycopg2.connect(host="35.240.179.218",database="planme_db",user="planme_user",password="PI3A8gLDftt5GKi7")