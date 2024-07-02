## CI/CD with a Single Bash Script for Static Website Hosting

This document demonstrates a streamlined CI/CD workflow using a single Bash script for managing your static website's deployment. It highlights key steps, configuration variables, and considerations for a smooth and automated deployment process.

**Key Functionalities:**

* Clones the website repository from the specified URL (replace `https://github.com/new`) using `git clone`.
* Creates a directory for the cloned repository content using `mkdir`.
* Deploys the website content to the designated hosting server location on Apache using `rsync`.

**Configuration Variables:**

* `REPO_URL`: The URL of your Git repository containing the website's code (replace with your actual URL).
* `CLONE_DIR`: The directory name where the repository will be cloned (e.g., `website`).
* `APACHE_DIR`: The deployment path on your hosting server (e.g., `/var/www/html`).

**Important Note:**

This script is intended to be executed on your web hosting server where Apache is installed. It assumes you have appropriate access and permissions to clone the repository and deploy files.

**Script (replace placeholders with your values):**

```bash
#!/bin/bash

# Replace with your Git repository URL
REPO_URL="[https://github.com/new](https://github.com/new)"

# Directory to clone the repository (adjust as needed)
CLONE_DIR="website"

# Apache document root (adjust for your server configuration)
APACHE_DIR="/var/www/html"

# Clone the repository
git clone $REPO_URL $CLONE_DIR

# Create the directory if it doesn't exist
mkdir -p $APACHE_DIR

# Deploy website content
rsync -avz $CLONE_DIR/ $APACHE_DIR

echo "Website deployment completed."
