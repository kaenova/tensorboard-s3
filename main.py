import os
import subprocess
import warnings

from tensorboard import program
import tensorflow_io as tfio
from dotenv import load_dotenv

class EnvVariables:
    def __init__(self):
        self.port = os.environ.get("PORT")
        self.s3_bucket_name = os.environ.get("S3_BUCKET_NAME")
        self.logdir = os.environ.get("LOGDIR")
        self.s3_endpoint = os.environ.get("S3_ENDPOINT")
        self.s3_verify_ssl = os.environ.get("S3_VERIFY_SSL")
        self.s3_use_https = os.environ.get("S3_USE_HTTPS")
        self.aws_region = os.environ.get("AWS_REGION")
        self.aws_access_key_id = os.environ.get("AWS_ACCESS_KEY_ID")
        self.aws_secret_access_key = os.environ.get("AWS_SECRET_ACCESS_KEY")
        self.check_missing_vars()

    def check_missing_vars(self):
        missing_vars = [var for var in vars(self) if getattr(self, var) is None]
        if missing_vars:
            warnings(
                f"WARNING: The following environment variables are missing: {', '.join(missing_vars)}"
            )


if __name__ == "__main__":
    load_dotenv()
    
    vars = EnvVariables()
    s3_path = f"s3://{vars.s3_bucket_name}/{vars.logdir}"
    cmd = [
        "tensorboard",
        "--logdir",
        s3_path,
        "--port",
        vars.port,
        "--bind_all",
        "--reload_multifile",
        "true",
        "--reload_multifile_inactive_secs",
        "3",
        "--purge_orphaned_data",
        "true",
        "--detect_file_replacement",
        "true",
        "serve",
    ]

    # Launch TensorBoard using subprocess
    process = subprocess.Popen(cmd)

    # Wait for TensorBoard to finish
    process.wait()
