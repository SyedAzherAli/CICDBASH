#!/bin/bash

# CI and CD using bash script
# Paths
REPO_URL="https://github.com/SyedAzherAli/DemoGit.git"
CLONE_DIR="/home/ubuntu/project01"
APACHE_DIR="/var/www/html"

# Continuous Integration
ci() {
    if [ -d "$CLONE_DIR" ]; then
        rm -rf "$CLONE_DIR"
        sleep 2
        echo "OLD VERSION DELETED"
    fi
    # Clone the repo from GitHub
    git clone "$REPO_URL" "$CLONE_DIR"
    sleep 2
    echo "CLONE SUCCESSFUL"
    echo "---------------INTIGRATED-SUCESSFUL------------------------"
}

# Continuous Deployment
deploy() {
    # Copy HTML code to Apache web server directory, copy css, javascript files similerly replacing .html 
    sudo cp -r "$CLONE_DIR"/*.html "$APACHE_DIR"
    #sudo cp -r "$CLONE_DIR"/*.css "$APACHE_DIR"
    #sudo cp -r "$CLONE_DIR"/*.js "$APACHE_DIR"
    sleep 2
    echo "FILES COPIED TO $APACHE_DIR"
    echo "--------------WEB-SITE-DEPLOYED-SUCESSFUL------------------"
}

# Setup function
setup() {
    git clone "$REPO_URL" "$CLONE_DIR"
    echo "SETUP CLONE SUCCESSFUL"
    sudo cp -r "$CLONE_DIR"/*.html "$APACHE_DIR"
    echo "SETUP FILES COPIED TO $APACHE_DIR"
}

# Initial setup
for i in 1; do 
    setup
    echo "SETUP SUCCESSFUL"
done

# Watch for the changes in git remote repository
while true; do 
    # Pull latest changes
    cd "$CLONE_DIR" 
    git fetch 

    # Check if there are new changes
    LOCAL=$(git rev-parse @) 
    REMOTE=$(git rev-parse @{u})

    cd /home/ubuntu

    if [ "$LOCAL" != "$REMOTE" ]; then 
        echo "----------CHANGES DETECTED, UPDATING FILES-------------"
        ci 
        sleep 5
        deploy
        sleep 5
    fi
    sleep 60
done
