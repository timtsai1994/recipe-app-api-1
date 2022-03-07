FROM python:3.7-alpine 
#alpine image is a lightweight minimal image that runs python
#can put any name here to basically keep track of to show that someone maintain this docker image
LABEL MAINTAINER JUITING
# set an environment variable in a docker buildfile. 
# what this does is it tells python to run in unbuffered mode which is recommended when running python within docker containers. avoids some complications.
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt   

# create an empty folder on docker image called app
RUN mkdir /app
#switch to that folder as the default directory, means any application we run using docker container will run starting from this location unless we specify otherwise.
WORKDIR /app
# copies from our local machine (the app folder) to the app folder created on our image
# allow us to take the code that we created on our product here and copy to our docker image
COPY ./app /app

# -D created an user that is going to be used for running application only
RUN adduser -D username
#switch user to the user which just created
# if we don't do this. the image will run the application using the root account which is not recommended.Because that mean if somebody compromises our application .they can have the root access to the image.
# create a seperate user just for this application limit the scope that an attacker would have in this documentation
USER username 