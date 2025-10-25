# Step 1: Choose a base image with Python
FROM public.ecr.aws/docker/library/python:3.9-alpine

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 4: Copy the application code
COPY app/ ./app/
COPY templates/ ./templates/

# Step 5: Expose the port the Flask app will run on
EXPOSE 5000

# Step 6: Define the command to run the Flask application
CMD ["python", "app/app.py"]
