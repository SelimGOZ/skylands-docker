# Use the official Java Docker image as the base
FROM eclipse-temurin:17-jre-focal
# Install dependencies including screen, nano, wget, openssh-server, and expect
RUN apt-get update && \
    apt-get install -y screen nano wget openssh-server net-tools expect && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV MINECRAFT_HOME=/opt/minecraft

# Set up SSH
RUN mkdir /var/run/sshd && \
    echo 'root:SkylandsSMP2024' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Copy the SSH public key
COPY ssh_public_key.pub /root/.ssh/authorized_keys

# Ensure correct permissions on the authorized_keys file
RUN chmod 600 /root/.ssh/authorized_keys

# Expose SSH and Minecraft ports
EXPOSE 22 25565

# Copy all files from the Docker context into the container
COPY . $MINECRAFT_HOME/

# Set executable permissions for start.sh and mc.sh
COPY mc.sh /mc.sh
RUN chmod +x /mc.sh
RUN chmod +x $MINECRAFT_HOME/start.sh

# Use an entrypoint script to start SSH and then the Minecraft server
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
