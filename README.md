# TensorBoard S3 Docker Image

This Docker image provides a convenient way to run TensorBoard to visualize data stored in Amzaon S3/Compatible S3 Services. It comes pre-configured with support for S3 data storage and provides an easy way to specify the necessary environment variables for connecting to your S3 bucket.

## Environment Variables
Before using this Docker image, make sure you have the following variables:

| Environment Variable  | Description                                      | Required | Default Value |
|-----------------------|--------------------------------------------------|----------|---------------|
| S3_BUCKET_NAME        | The name of the Amazon S3 bucket                  | Yes      | N/A           |
| LOGDIR                | The directory path inside the S3 bucket           | Yes      | N/A           |
| AWS_ACCESS_KEY_ID     | The AWS access key ID for S3 authentication      | Yes      | N/A           |
| AWS_SECRET_ACCESS_KEY | The AWS secret access key for S3 authentication  | Yes      | N/A           |
| PORT                  | The port number on which TensorBoard will listen  | No       | 6006          |
| S3_ENDPOINT           | The endpoint URL for custom S3 endpoint          | No       | N/A           |
| S3_VERIFY_SSL         | Enable SSL verification for S3 endpoint          | No       | 0             |
| S3_USE_HTTPS          | Use HTTPS for S3 endpoint                        | No       | 0             |


## Usage

To use this Docker image, follow the steps below:

1. Pull the Docker image from Docker Hub:
  ```sh
  docker pull kaenova/tensorboard-s3
  ```  

2. Pull the Docker image from Docker Hub:
  ```sh
  docker run -p 6006:6006 \
  -e S3_BUCKET_NAME=<your_s3_bucket_name> \
  -e LOGDIR=<your_logdir_path> \
  -e AWS_ACCESS_KEY_ID=<your_aws_access_key_id> \
  -e AWS_SECRET_ACCESS_KEY=<your_aws_secret_access_key> \
  -e PORT=<optional_port_number> \
  -e S3_ENDPOINT=<optional_s3_endpoint> \
  -e S3_VERIFY_SSL=<optional_s3_verify_ssl> \
  -e S3_USE_HTTPS=<optional_s3_use_https> \
  kaenova/tensorboard-s3
  ```  

3. Access TensorBoard  
Once the container is running, you can access TensorBoard by navigating to http://localhost:6006 in your web browser, or to the custom port number you specified in the PORT environment variable.  

That's it! You can now use TensorBoard to visualize your TensorFlow logs stored in S3 Service using this Docker image with the specified environment variables.

_This markdown was created with the help of ChatGPT_