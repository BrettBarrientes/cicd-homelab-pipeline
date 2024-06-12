# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Upgrade pip & install flask
RUN pip install --upgrade pip
RUN pip install flask

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r /python-app/requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME Cloudcity

# Run app.py when the container launches
CMD ["python", "app.py"]
