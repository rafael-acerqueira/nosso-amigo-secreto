![ruby](https://img.shields.io/badge/Ruby-2.4.1-red.svg)
![rails](https://img.shields.io/badge/Rails-5.0.1-red.svg)
![rails](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

# Nosso Amigo Secreto (Kriss Kringle / Secret Santa Play)

----
## About this project
This project makes possible create a secret santa / kriss kringle play. You can create a different secret santa like in your work or neighboorhood.

![Nosso Amigo Secreto](https://raw.githubusercontent.com/rafael-acerqueira/nosso-amigo-secreto/master/app/assets/images/home.png)

----
## How it works?
After you create, you add participats, raffle them and everyone receive a email. In this email each person knows who they have to give a gift.

![Nosso Amigo Secreto](https://raw.githubusercontent.com/rafael-acerqueira/nosso-amigo-secreto/master/app/assets/images/campaign.png)

----
## Getting Started
    1. docker-compose build
    2. docker-compose run --rm website rake db:create db:migrate
    3. docker-compose up


----
## Test
    docker-compose run --rm website rspec
