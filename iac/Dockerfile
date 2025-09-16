FROM jenkins/inbound-agent:latest-jdk21
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip jq && \
    rm -rf /var/lib/apt/lists/*
USER jenkins
