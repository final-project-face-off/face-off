#!/usr/bin/env python3
import numpy as np
import psycopg2
from dotenv import load_dotenv
import os
import decimal
import sys
import json
load_dotenv()

EPOCHS = 1500
LEARNING_RATE = [decimal.Decimal('0.05')]
# TEAM_ID_1 = int(sys.argv[1])
# TEAM_ID_2 = int(sys.argv[2])
# SEASON = int(sys.argv[3])

# Calculate mean absolute error
def mae_metric(actual, predicted):
	sum_error = decimal.Decimal('0.0')
	for i in range(len(actual)):
		sum_error += abs(predicted[i] - actual[i])
	return sum_error / decimal.Decimal(len(actual))

# Helper function to get past team stats based on team id and season
def get_past_team_stats(id, season):
    try:
        connection = psycopg2.connect(user = os.getenv("DB_USER"),
                                  password = os.getenv("DB_PASS"),
                                  host = os.getenv("DB_HOST"),
                                  port = os.getenv("DB_PORT"),
                                  database = os.getenv("DB_NAME"))

        cursor = connection.cursor()
        # Print PostgreSQL Connection properties
        # print ( connection.get_dsn_parameters(),"\n")

        # Print PostgreSQL version
        cursor.execute('SELECT "goalsPerGame", "goalsAgainstPerGame", "evGGARatio", "powerPlayPercentage", "penaltyKillPercentage", "shootingPctg", "savePctg", "winLeadSecondPer", "winOutshootOpp" FROM past_teams WHERE team_id = %s AND season = %s' %(id, season))
        record = cursor.fetchone()
        # print("You are connected to - ", record,"\n")
        return record
    except (Exception, psycopg2.Error) as error :
        print ("Error while connecting to PostgreSQL", error)
    finally:
        #closing database connection.
            if(connection):
                cursor.close()
                connection.close()
                # print("PostgreSQL connection is closed")

def compare_two_teams(id_1, id_2, season):
    team_1 = get_past_team_stats(id_1, season)
    team_2 = get_past_team_stats(id_2, season)
    diff = [a - b for a, b in zip(team_1, team_2)]
    return diff


class NeuralNetwork():
    def __init__(self):
        # Seed the random number generator
        np.random.seed(1)

        # Set synaptic weights to a 9x1 matrix (since 9 is the number of variables taken into account)
        # Synaptic weights are set to values from -1 to 1 and mean 0
        self.result = 2* np.random.random((9, 1)) - 1
        self.synaptic_weights = [[decimal.Decimal(y) for y in x] for x in self.result]

    def sigmoid(self, x):
        # Takes in weighted sum of the inputs and normalizes them between 0 and 1 through sigmoid function
        return 1 / (1 + np.exp(-x))

    def sigmoid_derivative(self, x):
        # Takes the derivative of the sigmoid function to calculate necessary weight adjustments
        return x * (1 - x)

    def train(self, training_inputs, training_outputs, training_iterations):
        # Train the model through trial and error, adjusting synaptic weights each time
        for iteration in range(training_iterations):
            # print("iteration: ", iteration)

            # Pass training set through neural network
            output = self.think(training_inputs)

            # Calculate error rate
            error = training_outputs - output

            # Multiply error by input and gradient of sigmoid function
            # Less confident weights are adjusted more through the nature of the function
            p = LEARNING_RATE * error * self.sigmoid_derivative(output)
            adjustments = np.dot(training_inputs.T, p)

            #Adjust synaptic weights
            self.synaptic_weights += adjustments

    def think(self, inputs):
        # Pass inputs through the neural network to get output
        output = self.sigmoid(np.dot(inputs, self.synaptic_weights))
        return output

    def results(self, predicted, mae, loss):
        predictedFloat = float(predicted)
        maeFloat = float(mae)
        loss = float(loss)
        # Convert the results to JSON format
        predictedJSON = json.dumps({ "predicted": predictedFloat, "mae": maeFloat, "loss": loss })
        # The Faceoff Results Controlled receives the PRINTED results
        print(predictedJSON)
        # return {'predicted': predictedFloat, 'mae': maeFloat, 'loss': loss}


if __name__ == "__main__":

    # Initialize the single neuron neural network
    neural_network = NeuralNetwork()

    # print("Random starting synaptic weights: ")
    # print(neural_network.synaptic_weights)

    # The training set, with 4 examples of 9 input values and 1 output value
    training_inputs = np.array([
        # NHL Playoff games for season 2009-2010
        compare_two_teams(15, 8, 20092010),
        compare_two_teams(1, 4, 20092010),
        compare_two_teams(7, 6, 20092010),
        compare_two_teams(5, 9, 20092010),
        compare_two_teams(28, 21, 20092010),
        compare_two_teams(16, 18, 20092010),
        compare_two_teams(23, 26, 20092010),
        compare_two_teams(27, 17, 20092010),
        compare_two_teams(5, 8, 20092010),
        compare_two_teams(6, 4, 20092010),
        compare_two_teams(28, 17, 20092010),
        compare_two_teams(16, 23, 20092010),
        compare_two_teams(8, 4, 20092010),
        compare_two_teams(28, 16, 20092010),
        compare_two_teams(4, 16, 20092010),
        # NHL Playoff games for season 2010-2011
        compare_two_teams(15, 3, 20102011),
        compare_two_teams(4, 7, 20102011),
        compare_two_teams(6, 8, 20102011),
        compare_two_teams(5, 14, 20102011),
        compare_two_teams(23, 16, 20102011),
        compare_two_teams(28, 26, 20102011),
        compare_two_teams(17, 27, 20102011),
        compare_two_teams(24, 18, 20102011),
        compare_two_teams(15, 14, 20102011),
        compare_two_teams(4, 6, 20102011),
        compare_two_teams(23, 18, 20102011),
        compare_two_teams(28, 17, 20102011),
        compare_two_teams(14, 6, 20102011),
        compare_two_teams(23, 28, 20102011),
        compare_two_teams(6, 23, 20102011),
        # NHL Playoff games for season 2011-2012
        compare_two_teams(3, 9, 20112012),
        compare_two_teams(6, 15, 20112012),
        compare_two_teams(13, 1, 20112012),
        compare_two_teams(5, 4, 20112012),
        compare_two_teams(23, 26, 20112012),
        compare_two_teams(19, 28, 20112012),
        compare_two_teams(27, 16, 20112012),
        compare_two_teams(18, 17, 20112012),
        compare_two_teams(3, 15, 20112012),
        compare_two_teams(4, 1, 20112012),
        compare_two_teams(19, 26, 20112012),
        compare_two_teams(27, 18, 20112012),
        compare_two_teams(3, 1, 20112012),
        compare_two_teams(26, 27, 20112012),
        compare_two_teams(1, 26, 20112012),
        # NHL Playoff games for season 2012-2013
        compare_two_teams(5, 2, 20122013),
        compare_two_teams(8, 9, 20122013),
        compare_two_teams(15, 3, 20122013),
        compare_two_teams(6, 10, 20122013),
        compare_two_teams(16, 30, 20122013),
        compare_two_teams(24, 17, 20122013),
        compare_two_teams(23, 28, 20122013),
        compare_two_teams(19, 26, 20122013),
        compare_two_teams(5, 9, 20122013),
        compare_two_teams(6, 3, 20122013),
        compare_two_teams(16, 17, 20122013),
        compare_two_teams(26, 28, 20122013),
        compare_two_teams(5, 6, 20122013),
        compare_two_teams(16, 26, 20122013),
        compare_two_teams(6, 16, 20122013),
        # NHL Playoff games for season 2013-2014
        compare_two_teams(6, 17, 20132014),
        compare_two_teams(14, 8, 20132014),
        compare_two_teams(5, 29, 20132014),
        compare_two_teams(3, 4, 20132014),
        compare_two_teams(21, 30, 20132014),
        compare_two_teams(19, 16, 20132014),
        compare_two_teams(24, 25, 20132014),
        compare_two_teams(28, 26, 20132014),
        compare_two_teams(6, 8, 20132014),
        compare_two_teams(5, 3, 20132014),
        compare_two_teams(30, 16, 20132014),
        compare_two_teams(24, 26, 20132014),
        compare_two_teams(8, 3, 20132014),
        compare_two_teams(16, 26, 20132014),
        compare_two_teams(3, 26, 20132014),
        # NHL Playoff games for season 2014-2015
        compare_two_teams(8, 9, 20142015),
        compare_two_teams(14, 17, 20142015),
        compare_two_teams(3, 5, 20142015),
        compare_two_teams(15, 2, 20142015),
        compare_two_teams(19, 30, 20142015),
        compare_two_teams(18, 16, 20142015),
        compare_two_teams(24, 52, 20142015),
        compare_two_teams(23, 20, 20142015),
        compare_two_teams(8, 14, 20142015),
        compare_two_teams(3, 15, 20142015),
        compare_two_teams(30, 16, 20142015),
        compare_two_teams(24, 20, 20142015),
        compare_two_teams(14, 3, 20142015),
        compare_two_teams(16, 24, 20142015),
        compare_two_teams(14, 16, 20142015),
        # NHL Playoff games for season 2015-2016
        compare_two_teams(13, 2, 20152016),
        compare_two_teams(14, 17, 20152016),
        compare_two_teams(15, 4, 20152016),
        compare_two_teams(5, 3, 20152016),
        compare_two_teams(25, 30, 20152016),
        compare_two_teams(19, 16, 20152016),
        compare_two_teams(24, 18, 20152016),
        compare_two_teams(26, 28, 20152016),
        compare_two_teams(2, 14, 20152016),
        compare_two_teams(15, 5, 20152016),
        compare_two_teams(25, 19, 20152016),
        compare_two_teams(18, 28, 20152016),
        compare_two_teams(14, 5, 20152016),
        compare_two_teams(19, 28, 20152016),
        compare_two_teams(5, 28, 20152016),
        # NHL Playoff games for season 2016-2017
        compare_two_teams(8, 3, 20162017),
        compare_two_teams(9, 6, 20162017),
        compare_two_teams(15, 10, 20162017),
        compare_two_teams(5, 29, 20162017),
        compare_two_teams(16, 18, 20162017),
        compare_two_teams(30, 19, 20162017),
        compare_two_teams(24, 20, 20162017),
        compare_two_teams(22, 28, 20162017),
        compare_two_teams(3, 9, 20162017),
        compare_two_teams(15, 5, 20162017),
        compare_two_teams(18, 19, 20162017),
        compare_two_teams(24, 22, 20162017),
        compare_two_teams(9, 5, 20162017),
        compare_two_teams(18, 24, 20162017),
        compare_two_teams(5, 18, 20162017),
        # 2010-03-25 (11 games)
        compare_two_teams(14, 6, 20092010),
        compare_two_teams(3, 1, 20092010),
        compare_two_teams(20, 2, 20092010),
        compare_two_teams(30, 4, 20092010),
        compare_two_teams(15, 12, 20092010),
        compare_two_teams(10, 11, 20092010),
        compare_two_teams(16, 29, 20092010),
        compare_two_teams(13, 8, 20092010),
        compare_two_teams(26, 19, 20092010),
        compare_two_teams(27, 18, 20092010),
        compare_two_teams(25, 28, 20092010),
        # 2011-03-26 (12 games)
        compare_two_teams(3, 6, 20102011),
        compare_two_teams(21, 26, 20102011),
        compare_two_teams(1, 7, 20102011),
        compare_two_teams(15, 8, 20102011),
        compare_two_teams(4, 2, 20102011),
        compare_two_teams(14, 12, 20102011),
        compare_two_teams(10, 17, 20102011),
        compare_two_teams(25, 18, 20102011),
        compare_two_teams(19, 30, 20102011),
        compare_two_teams(24, 16, 20102011),
        compare_two_teams(28, 27, 20102011),
        compare_two_teams(20, 22, 20102011),
        # 2012-03-24 (11 games)
        compare_two_teams(20, 25, 20112012),
        compare_two_teams(52, 18, 20112012),
        compare_two_teams(30, 7, 20112012),
        compare_two_teams(3, 10, 20112012),
        compare_two_teams(5, 9, 20112012),
        compare_two_teams(8, 4, 20112012),
        compare_two_teams(2, 14, 20112012),
        compare_two_teams(12, 17, 20112012),
        compare_two_teams(6, 26, 20112012),
        compare_two_teams(27, 28, 20112012),
        compare_two_teams(23, 21, 20112012),
        # 2013-03-28 (10 games)
        compare_two_teams(12, 10, 20122013),
        compare_two_teams(2, 4, 20122013),
        compare_two_teams(52, 5, 20122013),
        compare_two_teams(3, 9, 20122013),
        compare_two_teams(7, 13, 20122013),
        compare_two_teams(26, 19, 20122013),
        compare_two_teams(27, 18, 20122013),
        compare_two_teams(29, 22, 20122013),
        compare_two_teams(21, 23, 20122013),
        compare_two_teams(17, 28, 20122013),
        # 2014-03-25 (10 games)
        compare_two_teams(19, 10, 20132014),
        compare_two_teams(27, 5, 20132014),
        compare_two_teams(26, 15, 20132014),
        compare_two_teams(2, 12, 20132014),
        compare_two_teams(7, 8, 20132014),
        compare_two_teams(9, 13, 20132014),
        compare_two_teams(17, 29, 20132014),
        compare_two_teams(25, 16, 20132014),
        compare_two_teams(21, 18, 20132014),
        compare_two_teams(28, 22, 20132014),
        # 2015-03-26 (11 games)
        compare_two_teams(24, 6, 20142015),
        compare_two_teams(53, 7, 20142015),
        compare_two_teams(26, 2, 20142015),
        compare_two_teams(1, 15, 20142015),
        compare_two_teams(5, 12, 20142015),
        compare_two_teams(13, 10, 20142015),
        compare_two_teams(3, 9, 20142015),
        compare_two_teams(28, 17, 20142015),
        compare_two_teams(18, 14, 20142015),
        compare_two_teams(8, 52, 20142015),
        compare_two_teams(21, 23, 20142015),
        # 2016-03-26 (14 games)
        compare_two_teams(52, 7, 20152016),
        compare_two_teams(5, 17, 20152016),
        compare_two_teams(30, 21, 20152016),
        compare_two_teams(25, 28, 20152016),
        compare_two_teams(6, 10, 20152016),
        compare_two_teams(3, 8, 20152016),
        compare_two_teams(24, 9, 20152016),
        compare_two_teams(13, 14, 20152016),
        compare_two_teams(19, 15, 20152016),
        compare_two_teams(2, 12, 20152016),
        compare_two_teams(29, 18, 20152016),
        compare_two_teams(4, 53, 20152016),
        compare_two_teams(22, 26, 20152016),
        compare_two_teams(16, 20, 20152016),
        # 2017-03-25 (12 games)
        compare_two_teams(23, 30, 20162017),
        compare_two_teams(4, 29, 20162017),
        compare_two_teams(20, 19, 20162017),
        compare_two_teams(10, 7, 20162017),
        compare_two_teams(9, 8, 20162017),
        compare_two_teams(16, 13, 20162017),
        compare_two_teams(12, 1, 20162017),
        compare_two_teams(6, 2, 20162017),
        compare_two_teams(53, 15, 20162017),
        compare_two_teams(28, 18, 20162017),
        compare_two_teams(21, 22, 20162017),
        compare_two_teams(3, 26, 20162017),
        # 2010-03-16 (11 games)
        compare_two_teams(6, 12, 20092010),
        compare_two_teams(7, 11, 20092010),
        compare_two_teams(8, 3, 20092010),
        compare_two_teams(10, 9, 20092010),
        compare_two_teams(27, 14, 20092010),
        compare_two_teams(15, 13, 20092010),
        compare_two_teams(21, 19, 20092010),
        compare_two_teams(4, 18, 20092010),
        compare_two_teams(22, 30, 20092010),
        compare_two_teams(28, 25, 20092010),
        compare_two_teams(2, 23, 20092010),
        # 2011-03-15 (10 games)
        compare_two_teams(11, 1, 20102011),
        compare_two_teams(2, 3, 20102011),
        compare_two_teams(6, 29, 20102011),
        compare_two_teams(15, 8, 20102011),
        compare_two_teams(12, 7, 20102011),
        compare_two_teams(5, 9, 20102011),
        compare_two_teams(4, 13, 20102011),
        compare_two_teams(26, 18, 20102011),
        compare_two_teams(28, 25, 20102011),
        compare_two_teams(27, 20, 20102011),
        # 2012-03-17 (11 games)
        compare_two_teams(4, 6, 20112012),
        compare_two_teams(5, 1, 20112012),
        compare_two_teams(12, 30, 20112012),
        compare_two_teams(2, 8, 20112012),
        compare_two_teams(10, 9, 20112012),
        compare_two_teams(21, 3, 20112012),
        compare_two_teams(19, 14, 20112012),
        compare_two_teams(7, 13, 20112012),
        compare_two_teams(29, 23, 20112012),
        compare_two_teams(18, 26, 20112012),
        compare_two_teams(17, 28, 20112012),
        # 2013-03-16 (13 games)
        compare_two_teams(15, 6, 20122013),
        compare_two_teams(3, 5, 20122013),
        compare_two_teams(30, 21, 20122013),
        compare_two_teams(9, 7, 20122013),
        compare_two_teams(52, 10, 20122013),
        compare_two_teams(8, 1, 20122013),
        compare_two_teams(12, 14, 20122013),
        compare_two_teams(27, 29, 20122013),
        compare_two_teams(2, 13, 20122013),
        compare_two_teams(24, 19, 20122013),
        compare_two_teams(16, 25, 20122013),
        compare_two_teams(17, 23, 20122013),
        compare_two_teams(28, 26, 20122013),
        # 2014-03-18 (12 games)
        compare_two_teams(6, 1, 20132014),
        compare_two_teams(30, 2, 20132014),
        compare_two_teams(25, 5, 20132014),
        compare_two_teams(12, 29, 20132014),
        compare_two_teams(21, 8, 20132014),
        compare_two_teams(3, 9, 20132014),
        compare_two_teams(10, 17, 20132014),
        compare_two_teams(16, 4, 20132014),
        compare_two_teams(7, 20, 20132014),
        compare_two_teams(18, 22, 20132014),
        compare_two_teams(15, 24, 20132014),
        compare_two_teams(13, 28, 20132014),
        # 2015-03-14 (12 games)
        compare_two_teams(17, 4, 20142015),
        compare_two_teams(6, 5, 20142015),
        compare_two_teams(16, 28, 20142015),
        compare_two_teams(10, 23, 20142015),
        compare_two_teams(3, 7, 20142015),
        compare_two_teams(52, 14, 20142015),
        compare_two_teams(8, 2, 20142015),
        compare_two_teams(13, 12, 20142015),
        compare_two_teams(30, 19, 20142015),
        compare_two_teams(1, 53, 20142015),
        compare_two_teams(18, 26, 20142015),
        compare_two_teams(20, 21, 20142015),
        # 2016-03-19 (11 games)
        compare_two_teams(5, 4, 20152016),
        compare_two_teams(12, 30, 20152016),
        compare_two_teams(3, 28, 20152016),
        compare_two_teams(7, 10, 20152016),
        compare_two_teams(8, 9, 20152016),
        compare_two_teams(17, 13, 20152016),
        compare_two_teams(1, 29, 20152016),
        compare_two_teams(2, 25, 20152016),
        compare_two_teams(19, 23, 20152016),
        compare_two_teams(14, 53, 20152016),
        compare_two_teams(6, 26, 20152016),
        # 2017-03-16 (12 games)
        compare_two_teams(4, 1, 20162017),
        compare_two_teams(52, 2, 20162017),
        compare_two_teams(18, 15, 20162017),
        compare_two_teams(30, 12, 20162017),
        compare_two_teams(13, 29, 20162017),
        compare_two_teams(16, 9, 20162017),
        compare_two_teams(10, 14, 20162017),
        compare_two_teams(6, 22, 20162017),
        compare_two_teams(25, 23, 20162017),
        compare_two_teams(17, 53, 20162017),
        compare_two_teams(7, 26, 20162017),
        compare_two_teams(19, 28, 20162017),
        # 2018-03-17 (10 games)
        compare_two_teams(16, 7, 20172018),
        compare_two_teams(22, 13, 20172018),
        compare_two_teams(1, 26, 20172018),
        compare_two_teams(8, 10, 20172018),
        compare_two_teams(6, 14, 20172018),
        compare_two_teams(4, 12, 20172018),
        compare_two_teams(9, 29, 20172018),
        compare_two_teams(3, 19, 20172018),
        compare_two_teams(30, 53, 20172018),
        compare_two_teams(28, 23, 20172018),
    ])

    training_outputs = np.array([[
        0,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        1,
        1,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        0,
        1,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        1,
        0,
        1,
        0,
        1,
        1,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        0,
        1,
        1,
        # 2010-03-25 (11 games)
        1,
        1,
        0,
        1,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        # 2011-03-26 (12 games)
        1,
        0,
        0,
        1,
        1,
        1,
        0,
        0,
        1,
        1, 
        1,
        1,
        # 2012-03-24 (11 games)
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        # 2013-03-28 (10 games)
        0,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        # 2014-03-25 (10 games)
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        # 2015-03-26 (11 games)
        1,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        1,
        # 2016-03-26 (14 games)
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        # 2017-03-25 (12 games)
        1,
        0,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        1,
        # 20092010
        1,
        0,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        # 20102011
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        # 20112012
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        # 20122013
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
        # 20132014
        1,
        1,
        0,
        1,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        # 20142015
        0,
        1,
        1,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        # 20152016
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        1,
        1,
        0,
        # 20162017
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        0,
        1,
        1,
        0,
        1,
        # 20172018
        0,
        1,
        1,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
    ]]).T

    # Train the neural network
    neural_network.train(training_inputs, training_outputs, EPOCHS)

    print("Synaptic weights after training: ")
    print(neural_network.synaptic_weights)

    # TEST ON SEASON 2017-2018 
    B = [
        # 2018-03-24 (12 games)
        compare_two_teams(54, 21, 20172018),
        compare_two_teams(20, 28, 20172018),
        compare_two_teams(17, 10, 20172018),
        compare_two_teams(15, 8, 20172018),
        compare_two_teams(12, 9, 20172018),
        compare_two_teams(53, 13, 20172018),
        compare_two_teams(14, 1, 20172018),
        compare_two_teams(16, 2, 20172018),
        compare_two_teams(7, 3, 20172018),
        compare_two_teams(19, 29, 20172018),
        compare_two_teams(18, 30, 20172018),
        compare_two_teams(26, 22, 20172018),
        # Playoffs 2018
        compare_two_teams(14, 1, 20172018),
        compare_two_teams(6, 10, 20172018),
        compare_two_teams(15, 29, 20172018),
        compare_two_teams(5, 4, 20172018),
        compare_two_teams(18, 21, 20172018),
        compare_two_teams(52, 30, 20172018),
        compare_two_teams(54, 26, 20172018),
        compare_two_teams(24, 28, 20172018),
        compare_two_teams(14, 6, 20172018),
        compare_two_teams(15, 5, 20172018),
        compare_two_teams(18, 52, 20172018),
        compare_two_teams(54, 28, 20172018),
        compare_two_teams(14, 15, 20172018),
        compare_two_teams(52, 54, 20172018),
        compare_two_teams(15, 54, 20172018),
        ]
    # print("Expected output: ")
    resultsArray = np.array([[0,0,0,1,1,0,0,1,0,1,0,0,1,1,1,1,1,1,1,0,1,1,0,1,0,0,1]]).T

    predicted = neural_network.think(np.array(B))
    print("B Output data: ", predicted)

    mae = mae_metric(resultsArray, predicted)
    print("B MAE: \n", mae)
    loss = str(np.mean(np.square(resultsArray - predicted)))
    print ("B Loss: \n", loss)
    neural_network.results(predicted, mae, loss)

    # A = [compare_two_teams(TEAM_ID_1, TEAM_ID_2, SEASON)]
    # resultsArray = np.array([[1]]).T

    # predicted = neural_network.think(np.array(A))
    # # print("Output data: ", predicted)

    # mae = mae_metric(resultsArray, predicted)
    # # print("MAE: \n", mae)
    # loss = str(np.mean(np.square(resultsArray - predicted)))
    # # print("Loss: \n", loss)
    # neural_network.results(predicted, mae, loss)


    # HARDCODED INPUT TEST TO COMPARE THAT DATA PASSED FROM CONTROLLER
    # RETURNS THE EXPECT DATA (IE OUTPUT FROM A AND B SHOULD MATCH)
    # B = [compare_two_teams(1, 2, 20182019)]
    # # print("Expected output: ")
    # resultsArray = np.array([[1]]).T

    # predicted = neural_network.think(np.array(B))
    # print("Output data: ", predicted)

    # mae = mae_metric(resultsArray, predicted)
    # print("MAE: \n", mae)
    # loss = str(np.mean(np.square(resultsArray - predicted)))
    # print ("Loss: \n", loss)
    # neural_network.results(predicted, mae, loss)



