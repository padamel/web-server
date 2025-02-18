from flask import Flask, jsonify

app=Flask(__name__)

@app.route("/home")
def web_root():
    return jsonify ({"Message":"Welcome to my page!!!"})


if __name__=="__main__":
    app.run (debug=True,host='40.121.201.10',port=5000)



