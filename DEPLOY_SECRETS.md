## GitHub Secrets required for auto-deploy

Create these repository secrets:

- DEPLOY_HOST: server IP/hostname
- DEPLOY_USER: ssh username
- DEPLOY_SSH_KEY: private key (ed25519 recommended)
- DEPLOY_PATH: directory containing docker-compose.yml on the server (e.g. /opt/falcata)

Runtime secrets (recommended as server env vars, not GitHub):
- JWT_SECRET
- PG_CONNINFO (optional override)
