import numpy as np
import psycopg2
from dotenv import load_dotenv
import os
load_dotenv()

try:
    connection = psycopg2.connect(user = os.getenv("DB_USER"),
                                  password = os.getenv("DB_PASS"),
                                  host = os.getenv("DB_HOST"),
                                  port = os.getenv("DB_PORT"),
                                  database = os.getenv("DB_NAME"))
                                  
    cursor = connection.cursor()
    # Print PostgreSQL Connection properties
    print ( connection.get_dsn_parameters(),"\n")

    # Print PostgreSQL version
    cursor.execute("SELECT * FROM past_teams WHERE team_id = 1 AND season = 20092010")
    record = cursor.fetchone()
    print("You are connected to - ", record,"\n")
except (Exception, psycopg2.Error) as error :
    print ("Error while connecting to PostgreSQL", error)
finally:
    #closing database connection.
        if(connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

class NeuralNetwork():
    def __init__(self):
        # Seed the random number generator
        np.random.seed(1)

        # Set synaptic weights to a 9x1 matrix (since 9 is the number of variables taken into account)
        # Synaptic weights are set to values from -1 to 1 and mean 0
        self.synaptic_weights = 2 * np.random.random((9, 2)) - 1

    def sigmoid(self, x):
        # Takes in weighted sum of the inputs and normalizes them between 0 and 1 through sigmoid function
        return 1 / (1 + np.exp(-x))

    def sigmoid_derivative(self, x):
        # Takes the derivative of the sigmoid function to calculate necessary weight adjustments
        return x * (1 - x)

    def train(self, training_inputs, training_outputs, training_iterations):
        # Train the model through trial and error, adjusting synaptic weights each time

        for iteration in range(training_iterations):
            # Pass training set through neural network
            output = self.think(training_inputs)

            # Calculate error rate
            error = training_outputs - output

            # Multiply error by input and gradient of sigmoid function
            # Less confident weights are adjusted more through the nature of the function
            adjustments = np.dot(training_inputs.T, error * self.sigmoid_derivative(output))

            #Adjust synaptic weights
            self.synaptic_weights += adjustments

    def think(self, inputs):
        # Pass inputs through the neural network to get output
        
        inputs = inputs.astype(float)
        output = self.sigmoid(np.dot(inputs, self.synaptic_weights))
        return output

if __name__ == "__main__":

    # Initialize the single neuron neural network
    neural_network = NeuralNetwork()

    print("Random starting synaptic weights: ")
    print(neural_network.synaptic_weights)

    # The training set, with 4 examples of 9 input values and 1 output value
    training_inputs = np.array([[-0.365,-0.219,0.1094,-0.6,1.3,-1.3,0.006,-0.004,0.178], 
                                [-0.317,0.012,-0.0086,-4.7,-6,-0.1,0.01,-0.065,-0.083],
                                [0.134,-0.695,0.5255,-0.7,1.3,0.9,0.01,0.197,0.288],
                                [0.378,0.439,-0.0299,3.2,-2.7,0.4,-0.008,0.057,0.124],
                                [0.025,-0.098,0.0761,-0.9,-3.2,0.3,0.007,0.073,0.064],
                                [0.366,-0.122,0.1403,-0.3,-1.8,0.4,0.009,-0.033,-0.066],
                                [-0.195,-0.207,0.1882,-2.8,-1.6,0.2,0.014,-0.129,0.071]])

    training_outputs = np.array([[0,1],[1,0],[1,0],[1,0],[0,1],[0,1],[0,1]])

    # Train the neural network
    neural_network.train(training_inputs, training_outputs, 100000)

    print("Synaptic weights after training: ")
    print(neural_network.synaptic_weights)

    A = [-0.146,-0.146,0.0903,-2.2,0.1,-0.4,0.006,-0.095,-0.083]
    print("Output data: ")
    print(neural_network.think(np.array([A])))