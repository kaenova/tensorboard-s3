# TensorBoard S3 Docker Image

This Docker image provides a convenient way to run TensorBoard to visualize data stored in Amzaon S3/Compatible S3 Services. It comes pre-configured with support for S3 data storage and provides an easy way to specify the necessary environment variables for connecting to your S3 bucket.

## Environment Variables
Before using this Docker image, make sure you have the following variables:

| Environment Variable  | Description                                      | Required | Default Value | Value Example                                               |
|-----------------------|--------------------------------------------------|----------|---------------|-------------------------------------------------------------|
| S3_ENDPOINT           | The endpoint URL for custom S3 endpoint          | Yes      | N/A           | https://your.s3.provider.url (or you can use http://)       |
| S3_BUCKET_NAME        | The name of the Amazon S3 bucket                 | Yes      | N/A           | s3-bucket                                                   |
| LOGDIR                | The directory path inside the S3 bucket          | Yes      | N/A           | logdir_folder                                               |
| AWS_ACCESS_KEY_ID     | The AWS access key ID for S3 authentication      | Yes      | N/A           | ********                                                    |
| AWS_SECRET_ACCESS_KEY | The AWS secret access key for S3 authentication  | Yes      | N/A           | *****************                                           |
| PORT                  | The port number on which TensorBoard will listen | No       | 6006          | 6006                                                        |
| S3_VERIFY_SSL         | Enable SSL verification for S3 endpoint          | No       | 0             | 0                                                           |
| S3_USE_HTTPS          | Use HTTPS for S3 endpoint                        | No       | 0             | 1 (If you're using https in the endpoint, this should be 1) |


## Usage

To use this Docker image, follow the steps below:

1. Pull the Docker image from Docker Hub:
  ```sh
  docker pull kaenova/tensorboard-s3
  ```  

2. Pull the Docker image from Docker Hub:
  ```sh
  docker run -p 6006:6006 \
  -e S3_USE_HTTPS=<your_s3_with_http_or_https> \
  -e S3_BUCKET_NAME=<your_s3_bucket_name> \
  -e LOGDIR=<your_logdir_path> \
  -e AWS_ACCESS_KEY_ID=<your_aws_access_key_id> \
  -e AWS_SECRET_ACCESS_KEY=<your_aws_secret_access_key> \
  -e PORT=<optional_port_number> \
  -e S3_ENDPOINT=<optional_s3_endpoint> \
  -e S3_VERIFY_SSL=<optional_s3_verify_ssl> \
  kaenova/tensorboard-s3
  ```  

3. Access TensorBoard  
Once the container is running, you can access TensorBoard by navigating to http://localhost:6006 in your web browser, or to the custom port number you specified in the PORT environment variable.  

## Docker Compose Example

Here is an example of local deployment using docker compose  S3 Tensorboard with MinIO for the S3 service.

```yaml
version: "3.8"

services:
  minio:
    image: quay.io/minio/minio:latest
    command: ["server", "/data", "--console-address", ":9001"]
    ports:
      - "9000:9000"
      - "9001:9001"
    environment:
      - "MINIO_ROOT_USER=ROOTNAME"
      - "MINIO_ROOT_PASSWORD=CHANGEME123"

  tensorboard:
    image: kaenova/tensorboard-s3
    ports:
      - "6006:6006"
    environment:
      - "S3_BUCKET_NAME=s3-test"
      - "S3_ENDPOINT=http://minio:9000"
      - "LOGDIR=tensorboard"
      - "AWS_ACCESS_KEY_ID=IUbvAf6LS4zYsvZLaNLR"
      - "AWS_SECRET_ACCESS_KEY=quZScW8nZaATzVbwkKLk7DmlQvwqeHmHu3Qm5N3F"
```

---

That's it! You can now use TensorBoard to visualize your TensorFlow logs stored in S3 Service using this Docker image with the specified environment variables.

_This markdown was created with the help of ChatGPT_