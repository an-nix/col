# Base image with code-server
FROM codercom/code-server:latest

# Install Node.js 20 using NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && node -v && npm -v

# Optional: install global npm packages
# RUN npm install -g yarn pnpm

# Expose default code-server port
EXPOSE 8080

# Entrypoint is already defined by base image
