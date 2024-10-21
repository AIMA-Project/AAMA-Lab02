# Import the latest Python docker image
FROM python:latest

# Default to bash as shell used
CMD ["/bin/bash"]
SHELL ["/bin/bash", "-c"]

# === User Creation ================================================================================
RUN useradd -ms /bin/bash aama
WORKDIR /home/aama/

# === Setup Python Virtual Environment =============================================================
COPY resources/requirements.txt ./requirements.txt
# Setup virutal environment
RUN pip3 install -r requirements.txt --no-cache-dir

# === Install Utilities ============================================================================
RUN apt update && apt install nano vim 7zip p7zip-full -y

# === Copy Lab Code ================================================================================
# Lab components
COPY resources/run.sh ./run.sh
COPY resources/MalConv ./MalConv
COPY resources/data ./data
# Grading scripts
COPY resources/model-grade.sh ./model-grade.sh
COPY resources/Grading ./Grading

# === Enable User "aama" ===========================================================================
RUN chown -R aama:aama .
USER aama
RUN chmod +x run.sh model-grade.sh
