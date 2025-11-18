# Simple WordPress CI/CD Project

![Build Status](https://img.shields.io/github/actions/workflow/status/unihost-com/wordpress-cicd/deploy.yml?branch=main&style=flat-square)
![WordPress Version](https://img.shields.io/badge/WordPress-6.x-blue?style=flat-square)
![PHP Version](https://img.shields.io/badge/PHP-8.0%2B-purple?style=flat-square)

This repository hosts the WordPress source code and the Continuous Integration/Continuous Deployment (CI/CD) configuration for the **Unihost Simple WordPress CICD** project.

The pipeline is automated using **GitHub Actions** to ensure smooth, safe, and consistent deployments to our development and production environments.

---

## 🚀 How It Works

This repository uses a **Git-based workflow**. Deployments are triggered automatically based on the branch you push to.


### The Pipeline Stages
1.  **Trigger**: A developer pushes code to GitHub.
2.  **Checkout**: GitHub Actions checks out the latest code.
3.  **Deploy**:
    * The code is securely transferred to the server via **SSH**.
    * Build Docker image
    * Upload custom WP content files to docker volume.

### Branching Strategy
* **`dev` Branch**: Pushes here trigger a deployment to the **Development/Staging** server. Used for testing new features.
* **`main` Branch**: Pull request here trigger a deployment to the **Production** server. This is the live site.

---

## 🔑 Repository Secret Variables

For the CI/CD pipeline to function, it requires secure access to the target server. These credentials are stored in **GitHub Repo Settings > Secrets and variables > Actions**.

The following secrets **must** be defined for the pipeline to work:

| Secret Name | Description | Example / Format |
| :--- | :--- | :--- |
| `DEV_SSH_PRIVATE_KEY` | **(Critical)** The SSH private key used to authenticate with the server. | `-----BEGIN OPENSSH PRIVATE KEY----- ...` |
| `DEV_SERVER_IP` | The IP address or domain name of the target server. | `123.45.67.89` or `dev.unihost.com` |
| `DEV_SSH_USER` | The system username to log in as. | `ubuntu`, `root`, or `unihost_user` |
| `DEV_TRAEFIK_EMAIL` | The absolute path on the server where WP files reside. | `/var/www/html/wp-content/` |
| `DEV_WP_DB_NAME` | WordPress database name. | `dev_wp_db` |
| `DEV_WP_DB_PASSWORD` | WordPress database password (recommend to use strong password). | `8QaEW7YMzpuuaMY` |
| `DEV_WP_DB_USER` | WordPress database user name. | `dev_wp_user` |
| `DEV_WP_DOMAIN` | The domain name for your WordPress dev site. | `dev.unitest.com` |
| `DEV_MYSQL_ROOT_PASSWORD` | MySQL root password(need to allow docker to create neccecary db and user). | `8QaEW7YMzpuuaMY` |

> **Note:** You need to set the same variables like `DEV_*` for your prodaction CI\CD. Production secrets looklike. `MAIN_*`, for example `MAIN_TRAEFIK_EMAIL`

> **Note:** If you have different servers for Dev and Prod, you may have set secrets like `DEV_SERVER_IP` and `MAIN_SERVER_IP`. Check the `.yml` workflow file to see which keys are being called.

---

## 🛠 Local Development Setup

To contribute to this project locally:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/unihost-com/wordpress-cicd.git](https://github.com/unihost-com/wordpress-cicd.git)
    cd wordpress-cicd
    git checkout dev
    ```
2.  **Make Changes:**
    * Edit your theme or plugin files.
    * **Do not** upload core WordPress files to reposotory.

3.  **Commit & Push:**
    ```bash
    git add .
    git commit -m "Fix: Updated header logo"
    git push origin dev
    ```
    *This will automatically trigger the deployment to the Dev server.*

---

## 📂 Repository Structure

```text
├── .github/
│   └── workflows/      # CI/CD Pipeline configurations (YAML files)
├── wp-content/
│   ├── themes/         # Custom themes
│   └── plugins/        # Custom plugins
├── .gitignore          # Files excluded from Git (e.g., node_modules, .env)
└── README.md           # This documentation
