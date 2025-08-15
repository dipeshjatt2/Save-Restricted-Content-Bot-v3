FROM python:3.10-slim

# Update package lists and install basic dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    git \
    wget \
    curl \
    bash \
    ffmpeg \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install additional packages (neofetch is in the unstable repo)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository non-free \
    && apt-get update \
    && apt-get install -y neofetch \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .

RUN pip3 install wheel && \
    pip3 install --no-cache-dir -U -r requirements.txt

COPY . .

EXPOSE 5000

CMD flask run -h 0.0.0.0 -p 5000 & python3 main.py
