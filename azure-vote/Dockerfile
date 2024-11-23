# Use a lightweight Python image with Flask support
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PORT=80
ENV PATH=${PATH}:/home/site/wwwroot
ENV REDIS_HOST=azure-vote-back

# Install system dependencies and Python libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server vim curl wget supervisor redis-tools && \
    pip install --no-cache-dir flask redis && \
    rm -rf /var/lib/apt/lists/*

# Create application directory
WORKDIR /app

# Copy application code to the container
COPY azure-vote /app

# Ensure logs directory exists
RUN mkdir -p /var/log/supervisor/

# Copy Supervisor configuration
COPY app_init.supervisord.conf /etc/supervisor/conf.d/

# Configure SSH (set up root password and default SSH settings)
RUN echo "root:Docker!" | chpasswd && \
    mkdir -p /var/run/sshd && \
    sed -i 's/^#Port 22/Port 2222/' /etc/ssh/sshd_config && \
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose ports (SSH and Flask app)
EXPOSE 2222 80

# Run Supervisor as the main process
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
