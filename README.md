# Inception 🐳

<p align="center">
  <strong>System Administration & Dockerization Project</strong>
</p>

<p align="center">
  <a href="#about-the-project">About</a> •
  <a href="#system-architecture">Architecture</a> •
  <a href="#prerequisites">Prerequisites</a> •
  <a href="#installation--usage">Installation</a> •
  <a href="#directory-structure">Structure</a>
</p>

---

## 📖 About the Project

**Inception** is a System Administration project from the 42 Network curriculum. The primary goal is to broaden usage and knowledge of **Docker** by building a small infrastructure of services using `docker-compose`.

Instead of pulling ready-made images, this project requires building custom Docker images for each service (Nginx, WordPress, MariaDB) based on Alpine Linux or Debian, ensuring a deep understanding of system configuration and service isolation.

---

## 🏗 System Architecture

The project consists of three distinct isolated containers orchestrated by **Docker Compose**, running on a dedicated network (`inception`).

| Service | Description | Details |
| :--- | :--- | :--- |
| **NGINX** | Web Server / Entry Point | • Acts as the only entry point (Port 443).<br>• Handles TSL/SSL security (HTTPS).<br>• Forwards PHP requests to the WordPress container. |
| **WordPress** | Content Management System | • A WordPress instance running PHP-FPM.<br>• Does not include NGINX internally; relies on the external NGINX container.<br>• Connects to MariaDB for data storage. |
| **MariaDB** | Database | • Relational database storing WordPress data.<br>• Isolated not accessible from the host directly, only via the internal network. |

### 💾 Data Persistence
Data is stored continuously using Docker Volumes mounted to the host machine:
- **WordPress Data**: Stored in `wp_data` volume.
- **Database Data**: Stored in `db_data` volume.

---

## 🛠 Prerequisites

Before running this project, ensure you have the following installed on your machine:

- **OS**: Linux (Virtual Machine recommended)
- **Docker Engine**: [Install Docker](https://docs.docker.com/engine/install/)
- **Docker Compose**: [Install Compose](https://docs.docker.com/compose/install/)
- **Make**: Standard build utility.

---

## 🚀 Installation & Usage

### 1. Clone the Repository
```bash
git clone git@github.com:1MhDjant23/doc-incep.git
cd doc-incep
```

### 2. Environment Setup
The project works with a `.env` file located in `srcs/.env`.
A default configuration is already included in the repository for ease of use.

#### Environment Variables
The following variables are configured in the `.env` file:
- **Database**: `SQL_DATABASE`, `SQL_HOST`, `WP_ADMIN_USER`, `WP_ADMIN_PASS`
- **WordPress Site**: `DOMAIN_NAME`, `WP_TITLE`, `WP_ADMIN_EMAIL`
- **WordPress Users**: `WP_USER`, `WP_USER_EMAIL`, `WP_USER_ROLE`, `WP_USER_PASS`

```bash
# Verify the .env file exists
ls srcs/.env
```

### 3. Build and Run
> [!IMPORTANT]
> If you encounter a `permission denied` error connecting to the Docker daemon sock, you can either:
> 1. Run commands with `sudo` (e.g., `sudo make up`).
> 2. Add your user to the docker group: `sudo usermod -aG docker $USER` (requires logout/login).

Use `make` to manage the lifecycle of the application.


| Command | Action |
| :--- | :--- |
| `make up` | Builds (if needed) and starts the containers in detached mode. |
| `make build` | Rebuilds the images without starting the containers. |
| `make start` | Starts existing containers. |
| `make stop` | Stops running containers. |
| `make down` | Stops and removes containers and networks. |
| `make logs` | Displays real-time logs from all containers. |
| `make ps` | Lists the status of the containers. |
| `make clean` | Stops containers and removes data volumes (Requires sudo). |
| `make fclean` | Deep clean: Removes containers, images, volumes, and networks. |

To access the site, add the domain to your `/etc/hosts` file (if required by subject, e.g., `login.42.fr`):
```bash
127.0.0.1   mait-taj.42.fr
```
Then open your browser and visit: `https://mait-taj.42.fr` (Accept the self-signed certificate warning).

---

## 📂 Directory Structure

```plaintext
doc-incep/
├── Makefile                # Control center for building and starting services
├── README.md               # Project documentation
└── srcs/                   # Source files
    ├── .env                # Environment variables (not committed)
    ├── docker-compose.yml  # Container orchestration config
    └── requirements/       # Service configurations
        ├── mariadb/        # Database Dockerfile & scripts
        ├── nginx/          # Web server Dockerfile & config
        └── wordpress/      # WordPress Dockerfile & scripts
```
