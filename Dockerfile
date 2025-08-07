# Base image
FROM codercom/code-server:latest

# Switch to root to install packages
USER root

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && node -v && npm -v

# Switch back to code-server user
USER coder

# Expose default port
EXPOSE 8080
