# Commit and pull from git 

Ignore files you do not want commited e.g. terrfaormstate 
```
nano .gitignore
```

Update gitignore with below, click ctrl+x and 'Y' enter
```
terraform-aws-devops/.terraform/
terraform-aws-devops/*.tfstate
terraform-aws-devops/*.tfstate.backup
terraform-aws-devops/.terraform.lock.hcl
```
Commit and push gitignore 
```
git add .gitignore
git commit -m "removed sensitive terraform files from tracking"
git push origin main
```

Commit after a project
- Always pull to download updates from git to pc
- Git add, it can be '.' to add all changes or 'terraform-aws-devops/*.tf *.py .gitignore' to commit specific files. Include foldername/ if files are stored in a folder 
```
git pull origin main 
git add . 
git commit -m " "
git push origin main
```
```
git pull origin main 
git add terraform-aws-devops/*.tf *.py .gitignore 
git commit -m " "
git push origin main
```
Clone a git repo. 
Get the URL from GitHub by clicking the green "Code" button on your repo then copying the HTTPS link.
This will create a folder in your current directory with all the repo files inside. Then navigate into it:
```
git clone https://github.com/username/repo-name.git
```

Git branching
```
git pull origin main
```

Create your own branch for your changes
```
git checkout -b feature/updated-terraform-config
```

Make your changes, then stage and commit
```
git add .
git commit -m "updated terraform security group rules"
```

Push your branch to GitHub
```
git push origin feature/updated-terraform-config
```





