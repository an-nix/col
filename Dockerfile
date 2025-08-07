# Base image
FROM codercom/code-server:latest

# Switch to root to install packages
USER root

# Install Node.js 20 and Git
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs git \
    && node -v && npm -v

# Clone the freesewing repository
RUN git clone https://codeberg.org/an-nix/freesewing.git /freesewing \
    && chown -R coder:coder /freesewing

# Set working directory
WORKDIR /freesewing

# Switch back to code-server user
USER coder

# Install dependencies and run kickstart
RUN npm install

# Expose default port
EXPOSE 8080

# Start code-server with /freesewing as the default folder
CMD ["code-server", "/freesewing"]
