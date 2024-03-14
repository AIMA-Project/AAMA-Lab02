 # Import the latest Python docker image
FROM python:latest

# Default to bash as shell used
CMD ["/bin/bash"]
SHELL ["/bin/bash", "-c"]

# === User Creation ================================================================================
RUN useradd -ms /bin/bash aama
WORKDIR /home/aama/

# === Setup Python Virtual Environment =============================================================
COPY requirements.txt .
# Setup virutal environment
RUN python3 -m venv venv
RUN source venv/bin/activate && pip3 install -r requirements.txt --no-cache-dir

# === Install Utilities ============================================================================
RUN apt update && apt install nano vim 7zip p7zip-full -y

# === Copy Lab Code ================================================================================
# Lab components
COPY Lab02/run.sh .
COPY Lab02/MalConv ./MalConv
COPY Lab02/data ./data
# Grading scripts
COPY Lab02/model-grade.sh .
COPY Lab02/Grading ./Grading

# === Enable User "aama" ===========================================================================
RUN chown -R aama:aama .
USER aama
RUN chmod +x run.sh model-grade.sh
