# Base image
FROM codercom/code-server:latest

# Switch to root to install packages
USER root

# Install Node.js 20 and Git
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs git \
    && node -v && npm -v

RUN mkdir -p /freesewing && chown coder:coder /freesewing
USER coder
WORKDIR /freesewing

# Expose default port
EXPOSE 8080

# Start code-server with /freesewing as the default folder
CMD ["code-server", "/freesewing"]
