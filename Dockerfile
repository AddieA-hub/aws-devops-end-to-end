# Use a lightweight Python image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file first (better caching)
COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/app.py .

# Expose port used by Flask
EXPOSE 5001

# Run the application
CMD ["python", "app.py"]
