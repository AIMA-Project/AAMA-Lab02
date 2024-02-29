 # Import the latest Python docker image
FROM python:latest

SHELL ["/bin/bash", "-c"]

# === Install Text Editors =========================================================================
RUN apt update
RUN apt install nano vim p7zip -y

# === User Creation ================================================================================
RUN useradd -ms /bin/bash aama
WORKDIR /home/aama/

# === Copy Lab Code ================================================================================
# Lab components
COPY Lab02/run.sh .
COPY Lab02/MalConv ./MalConv
COPY Lab02/data ./data
# Grading scripts
COPY Lab02/model-grade.sh .
COPY Lab02/Grading ./Grading
# Give ownership of copied files to aama user
RUN chown aama:aama -R ./
# Enter user for final portion of setup
USER aama

# === Setup Python =================================================================================
COPY requirements.txt .
# Setup virutal environment
RUN python3 -m venv venv
RUN source venv/bin/activate && pip3 install -r requirements.txt --no-cache-dir

# === Finishing Up =================================================================================
# Default to bash as the shell called when running
CMD ["/bin/bash"]
