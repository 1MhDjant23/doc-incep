# Inception

## What is this project?

Inception is a project from the 42 Network curriculum.
The goal is to learn how to use Docker to set up and manage multiple services inside isolated containers.
This project helped me understand how to configure, connect, and secure different components of a web infrastructure.

## Main ideas

- **Docker**: A platform that lets you package and run applications in containers. Containers make your applications portable and consistent across different environments.

- **Containers**: Lightweight, isolated environments that keep each service separate so they don’t interfere with one another.

- **Docker Compose**: A tool that allows you to define and manage multiple containers easily using a single configuration file (docker-compose.yml).

- **Services**: The different applications that work together (web server, PHP processor, database, etc.).

- **Networks and Volumes**: Used to let containers communicate and to persist data even after containers are restarted.

## What i build?

I built and connected the following services — each running in its own container:

- **Nginx**: A web server that acts as a reverse proxy.
  - Handles HTTPS connections using a self-signed TLS certificate for secure communication.
  - Forwards PHP requests to the PHP-FPM container.
- **WordPress** (with PHP-FPM):
  - A WordPress site running with PHP-FPM (FastCGI Process Manager) to handle PHP execution.
  - Communicates with the database through the internal Docker network.
- **MariaDB**:
  - A relational database used to store all WordPress data (posts, users, settings, etc.).
  - Data is stored in a persistent Docker volume to ensure it is not lost when containers are rebuilt.
