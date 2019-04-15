# README

## Product Summary
This is a Rails web app (Ruby 2.3.5, Rails 5.2.3) that uses machine learning to predict the NHL Playoff series outcome when given two teams. 

A simple neural network was developed in Python to take in team stats as inputs and output the chance of a given team winning the series. 

The app displays each individual team's stats on the Team page with graphs depicting the progression of the team throughout the years. The stats can be compared across teams on the 'Compare' page. 

The app also displays upcoming games and past games with their final score.

The app is deployed on: http://www.faceoff.fun/

## Getting Started
If you fork this project, to get the code running you will need to:

1) Install the dependencies:
```
bundle install
```
You will also need to install Python3 for the machine algorithm to run.


2) Start the web server:
```
bin/rails s -b 0.0.0.0
```

## Dependencies
* Python3
* pg
* Puma
* sass-rails
* uglifier
* rest-client
* indico
* responders
* bootstrap
* jquery-rails
* chartkick
* chartable
* highcharts-rails
* coffee-rails
* turbolinks
* jbuilder
* bootsnap

