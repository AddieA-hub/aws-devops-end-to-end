## Issues Encoutered

# Day 1 
- Issue 1
    - I ran into an issue. I installed pip in the app folder then ran python app.py in the same folder and got this error 
'(venv) adinduaghanya@Adindus-Air app % python app.py Traceback (most recent call last): File 
"/Users/adinduaghanya/aws-devops-end-to-end/app/app.py", line 1, in <module> from flask import Flask ModuleNotFoundError:  No module named 'flask'
- Solution
    - Flask was never installed. I got a prompt to update pip. When I got the prompt to update pip, I was supposed to rerun the code pip install -r requirements.txt and rerun python app.py. I did this and it fixed the error. 


- Issue 2
    - I RAN THE python app.py but got this  * Serving Flask app 'app' * Debug mode: off Address already in use Port 5000 is in use by another program. Either identify and stop that program, or start the server with a different port. On macOS, try searching for and disabling 'AirPlay Receiver' in System Settings.'

- Solution
    - Port 5000 is already in use by my pc. So I updated the line below in my app.py file from 5000 to 5001
```
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
```

# Day 2
- Issue 1
    - I got this when I ran docker 'aws-devops-end-to-end % docker run -p 5001:5001 flask-devops-app Unable to find image 'flask-devops-app:latest' locally docker: Error response from daemon: pull access denied for flask-devops-app, repository does not exist or may require 'docker login' Run 'docker run --help' for more information'.
      
- Solution
```
docker images
```

This should list the images. If nothing is listed then the image was never built. The issue was, the fullstop at the end of the code below was omitted.

```
docker build -t flask-devops-app .
```
