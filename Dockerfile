 # Import the latest Python docker image
FROM python:latest

SHELL ["/bin/bash", "-c"]

# === User Creation ================================================================================
RUN useradd -ms /bin/bash aama
USER aama
WORKDIR /home/amma/

# === Copy Lab Code ================================================================================
# Lab components
COPY Lab02/run.sh .
COPY Lab02/MalConv ./MalConv
COPY Lab02/data ./data
# Grading scripts
COPY Lab02/model-grade.sh .
COPY Lab02/Grading ./Grading

# === Setup Python =================================================================================
# Copy requirements.txt
COPY requirements.txt .
# Setup virutal environment
RUN python3 -m venv venv
RUN source venv/bin/activate && pip3 install -r requirements.txt

# === Finishing Up =================================================================================
# Default to bash as the shell called when running
CMD ["/bin/bash"]
