# DAY 2: BUILD THE FLASK APP (LOCAL ONLY)

STEP 1: Create the app folder structure
Inside your project folder (aws-devops-end-to-end):

```
mkdir app
cd app
```
Create these files:

```
touch app.py
touch requirements.txt
```

Your structure should now look like:
aws-devops-end-to-end/
```
│
├── app/
│   ├── app.py
│   └── requirements.txt
│
└── README.md
```
STEP 2: Write the Flask application 
Open app/app.py and paste this exactly:

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from AWS DevOps Project"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```
Save the file.

STEP 3: Add dependencies
Open app/requirements.txt and add:
```
flask
```
