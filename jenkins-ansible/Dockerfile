FROM jenkins/jenkins

USER root

RUN apt-get -y update && \
    apt-get -y install python3 && \
    apt-get -y install python3-pip && \
    apt-get install python-is-python3

# RUN curl -O https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
#    python get-pip.py && \

RUN pip install ansible

USER jenkins
