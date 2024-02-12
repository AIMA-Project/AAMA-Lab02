 # Import the latest Python docker image
FROM python:latest

# Move lab code over to container during building
# Copy over setup files
COPY requirements.txt /home/
COPY Lab02/setup.sh /home/
# Copy over actual lab components
COPY Lab02/run.sh /home/
COPY Lab02/MalConv /home/MalConv
COPY Lab02/data /home/data
# Copy over grading
COPY Lab02/model-grade.sh /home/
COPY Lab02/Grading /home/Grading
