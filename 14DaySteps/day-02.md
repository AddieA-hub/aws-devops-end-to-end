# DAY 2: BUILD THE FLASK APP (LOCAL ONLY)

- STEP 1:
    - Create the app folder structure
    - Inside your project folder (aws-devops-end-to-end):

```
mkdir app
cd app
```
    - Create these files:

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
- STEP 2: Write the Flask application 
    - Open app/app.py and paste this exactly:
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

- STEP 3: Add dependencies
    - Open app/requirements.txt and add:
```
flask
```

- STEP 4: Create a virtual environment (optional but recommended) 
    - From inside the app folder:

```python
python3 -m venv venv
```
Activate it:
Mac/Linux
```
source venv/bin/activate
```
Windows
```
venv\Scripts\activate
```
You should see (venv) in your terminal.

- STEP 5: Install Flask
    - Flask is used to build web apps, small websites and backend 

```
pip install -r requirements.txt
```

- STEP 6: Run the app locally
```python
python app.py
```

You should see something like:

Running on http://127.0.0.1:5000

- STEP 7: Open the browser
    - Go to:
```
http://localhost:5000
```

Expected result:
Hello from AWS DevOps Project

- STEP 8: Commit your work 
From the project root:
```
git status
git add .
git commit -m "Add basic Flask application"
git push
```

- STEP 8: Stop app from running
```
Control + C
```
