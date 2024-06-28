# Use the official Airflow image with Python 3.8
FROM apache/airflow:2.5.1-python3.8

# Set environment variables
ENV AIRFLOW_HOME=/opt/airflow

# Create necessary directories and set permissions
USER root
RUN mkdir -p /opt/airflow/logs /opt/airflow/dags &&     chown -R airflow: /opt/airflow

# Copy everything from the current directory to the working directory in the Docker image
COPY . /opt/airflow/

# Ensure entry_point.sh is executable
RUN chmod +x /opt/airflow/entry_point.sh

# Switch to the airflow user
USER airflow

# Install dependencies directly as the airflow user
RUN pip install --upgrade pip &&     pip install -r /opt/airflow/requirements.txt

# Set the working directory
WORKDIR /opt/airflow

# Set the entrypoint
ENTRYPOINT ["/opt/airflow/entry_point.sh"]
