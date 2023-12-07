# Docker-VCSI

## Overview
Docker-VCSI is a Docker-based solution designed to automate the generation of video thumbnail sheets on Synology NAS systems or any Docker-compatible environment. It scans a designated directory for `.mov`, `.MOV`, `.mp4`, and `.MP4` files and generates thumbnail sheets using `vcsi`. This process is scheduled as a cron job within the Docker container.

## Features
- Automatically generates thumbnail sheets for video files.
- Supports `.mov`, `.MOV`, `.mp4`, and `.MP4` file formats.
- Scheduled execution as a cron job in an Alpine Linux Docker container.

## Prerequisites
- Docker installed on your Synology NAS or another system.
- Access to a directory containing `.mov`, `.MOV`, `.mp4`, and `.MP4` video files.

## Installation
1. Clone or download the Docker-VCSI repository to your local machine.
2. Navigate to the directory containing the Dockerfile.
3. Build the Docker image:
   ```bash
   docker build -t troyxmccall/vcsi .
   ```

## Usage
Run the Docker container by mounting the directory containing your video files:

```bash
docker run -v /path/to/video/files:/mnt docker-vcsi
```

Replace `/path/to/video/files` with the actual path to your video files.

## How It Works
- The container scans the `/mnt` directory for video files in `.mov`, `.MOV`, `.mp4`, and `.MP4` formats.
- For each video file, it checks if a corresponding thumbnail sheet already exists.
- If not, it generates a new thumbnail sheet using `vcsi`, saving it in the same directory as the video file.
