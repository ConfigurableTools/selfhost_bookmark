from lib.bottle import route, run, template, view, post,request
import sqlite3  


conn = sqlite3.connect('bookmark.db')  
cursor = conn.cursor()  
cursor.execute("CREATE TABLE IF NOT EXISTS bookmarks" +
                "(id INTEGER PRIMARY KEY, title TEXT, visit_times INTEGER DEFAULT 0, url TEXT, is_deleted DEFAULT 0, create_time TIMESTAMP NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')))")     
conn.commit()  



@route('/')
@route("/index")
@view("index")
def get_bookmark():
    cursor.execute("SELECT id, title, visit_times, url FROM bookmarks WHERE is_deleted != 1 ")
    results = cursor.fetchall()
    bookmarks = [dict(zip(['id', 'title', 'visit_times', 'url'], row)) for row in results]  
    return dict(bookmarks=bookmarks)

@post('/delete_bookmark')
def delete_bookmark():
    id = int(request.body.read())
    cursor.execute("UPDATE bookmarks SET is_deleted = 1 WHERE id=?", (id,))
    conn.commit()  
    return "success"

@post('/count_visit')
def count_visit():
    id = int(request.body.read())
    print(type(id))
    cursor.execute("SELECT visit_times FROM bookmarks WHERE id=?", (id,))
    new_visit_times = int(cursor.fetchone()[0]) + 1
    cursor.execute("UPDATE bookmarks SET visit_times = ? WHERE id=?", (new_visit_times, id))
    conn.commit()  
    return "success"

@post('/submit_item')
def submit_item():
    print(request.body.read())
    data = str(request.body.read(),'utf-8')
    print(data)
    title = data.split("](")[0][1:]
    url = data.split("](")[1][:-1]

    cursor.execute("INSERT INTO bookmarks(title, url) VALUES(?, ?)", (title, url))
    conn.commit()  
    
    return "success"

run(host='0.0.0.0', port=2025, reloader=True)