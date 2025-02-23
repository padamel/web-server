from flask import Flask
app=Flask(__name__)

@app.route("/")
def web_root():
    return{"Message":"Welcome to my page!!!"}


if __name__=="__main__":
    app.run(debug=True,host='0.0.0.0',port=5000)



