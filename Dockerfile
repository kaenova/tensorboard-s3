FROM ubuntu:jammy


RUN apt update
RUN apt install -y software-properties-common

ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC"
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt install -y python3.8
RUN apt install -y python3.8-distutils

RUN apt-get install -y wget
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.8 get-pip.py


WORKDIR /app

# Install gdown to get non avx version of tensorflow
RUN python3.8 -m pip install gdown
# Community wheel of Tensorflow w/o AVX
# https://github.com/yaroslavvb/tensorflow-community-wheels/issues/217
RUN gdown 1T3WrRsiKBBqZn-LRaBQL6ulAQM-Unh3G
RUN python3.8 --version
RUN python3.8 -m pip install ./tensorflow-2.12.0-cp38-cp38-linux_x86_64.whl

COPY requirements.txt requirements.txt

RUN python3.8 -m pip install -r requirements.txt

COPY main.py main.py

ENV AWS_REGION=default
ENV S3_VERIFY_SSL=0
ENV S3_USE_HTTPS=0
ENV PORT=6006

EXPOSE 6006

CMD ["python3.8", "main.py"]