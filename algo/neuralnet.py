#!/usr/bin/env python3
import numpy as np
import psycopg2
from dotenv import load_dotenv
import os
import decimal 
from sklearn.metrics import mean_absolute_error
load_dotenv()

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
        self.result = 2 * np.random.random((9, 1)) - 1
        self.synaptic_weights = [[decimal.Decimal(y) for y in x] for x in self.result]

    def sigmoid(self, x):
        # Takes in weighted sum of the inputs and normalizes them between 0 and 1 through sigmoid function
        return 1 / (1 + np.exp(-x))

    def sigmoid_derivative(self, x):
        # Takes the derivative of the sigmoid function to calculate necessary weight adjustments
        # print(x * (1 - x))
        return x * (1 - x)

    def train(self, training_inputs, training_outputs, training_iterations):
        # Train the model through trial and error, adjusting synaptic weights each time

        for iteration in range(training_iterations):
            # Pass training set through neural network
            output = self.think(training_inputs)

            # Calculate error rate
            error = training_outputs - output
            # print("Error rate: ")
            # print(error)

            # Multiply error by input and gradient of sigmoid function
            # Less confident weights are adjusted more through the nature of the function
            # print(training_inputs.T)
            # print(self.sigmoid_derivative(output))
            # print([decimal.Decimal(x,y) for (x,y) in self.sigmoid_derivative(output)])
            # print('error:', error)
            # print('sigmoid', self.sigmoid_derivative(output))
            p = error * self.sigmoid_derivative(output)
            adjustments = np.dot(training_inputs.T, p)

            #Adjust synaptic weights
            self.synaptic_weights += adjustments

    def think(self, inputs):
        # Pass inputs through the neural network to get output
        # inputs = [decimal.Decimal(x) for x in inputs]
        # print('inputs:')
        # print(inputs)
        output = self.sigmoid(np.dot(inputs, self.synaptic_weights))
        # print("outputs: ")
        # print(output)
        return output

    def results(self, predicted, mae, loss):
        print("returned!")
        return {'predicted': predicted, 'mae': mae, 'loss': loss}


if __name__ == "__main__":
    # compare_two_teams(8, 3, 20162017)

    # Initialize the single neuron neural network
    neural_network = NeuralNetwork()

    # print("Random starting synaptic weights: ")
    # print(neural_network.synaptic_weights)

    # The training set, with 4 examples of 9 input values and 1 output value
    training_inputs = np.array([
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
    ])

    # print('training_inputs variable:', training_inputs)

    training_outputs = np.array([
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (0,1),
        (1,0),
        (0,1),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (1,0),
        (0,1),
        (1,0),
        (0,1),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (0,1),
        (1,0),
        (0,1),
        (1,0),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (0,1),
        (0,1),
        (1,0),
        (1,0),
        (0,1),
        (1,0),
        (1,0),
        ])

    # Train the neural network
    neural_network.train(training_inputs, training_outputs, 1000)

    print("Synaptic weights after training: ")
    print(neural_network.synaptic_weights)

    # A = [-0.146,-0.146,0.0903,-2.2,0.1,-0.4,0.006,-0.095,-0.083]
    A = [
        compare_two_teams(14, 1, 20172018),
        compare_two_teams(6, 10, 20172018),
        compare_two_teams(15, 29, 20172018),
        compare_two_teams(5, 4, 20172018),
        compare_two_teams(18, 21, 20172018),
        compare_two_teams(52, 30, 20172018),
        compare_two_teams(54, 26, 20172018),
        compare_two_teams(24, 28, 20172018)
    ]
    print("Expected output: ")
    resultsArray = [[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[0,1]]
    expected = [[[decimal.Decimal(y) for y in x] for x in resultsArray]]
    print(expected)
    print("Output data: ")
    predicted = neural_network.think(np.array([A]))
    print(neural_network.think(np.array([A])))
    # Test RMSE
    # actual = expected
    mae = mae_metric(expected, predicted)
    print("MAE: \n", mae)
    loss = str(np.mean(np.square(expected - predicted)))
    print ("Loss: \n", loss)
    neural_network.results(predicted, mae, loss) 
    
   

