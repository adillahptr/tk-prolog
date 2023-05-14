# base image  
FROM ubuntu:22.04
# setup environment variable  
ENV DockerHOME=/home/app/webapp  

# set work directory  
RUN mkdir -p $DockerHOME  

# where your code lives  
WORKDIR $DockerHOME

# set environment variables  
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies  

# copy whole project to your docker home directory. 
COPY . $DockerHOME  
# run this command to install all dependencies
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-add-repository ppa:swi-prolog/stable
RUN apt-get update
RUN apt-get install swi-prolog -y
RUN set -xe \
    && apt-get update \
    && apt-get install python3-pip -y
RUN pip install --upgrade pip
RUN apt-get install git -y
RUN pip install -r requirements.txt  
# port where the Django app runs  
EXPOSE 8000  
# start server  
ENTRYPOINT ["python3", "manage.py"]
CMD ["runserver", "0.0.0.0:8080"]