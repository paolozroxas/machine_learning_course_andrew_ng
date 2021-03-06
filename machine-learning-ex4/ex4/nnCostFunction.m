function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% USEFUL VARIABLES
Theta1ExBias = Theta1(:, 2:end);
Theta2ExBias = Theta2(:, 2:end);

% FEED FORWARD

% Converts ineger labels to arrays of size 10, where there is a single 1 whose position
% denotes the integer, and the rest of the array is zeros
Labels = eye(num_labels)(y, :);

% Add ones to input to form the biases
Inputs = [ones(m, 1), X];

% This is a (numberOfExamples x numberOfNeuronsInLayer2) matrix, representing activations of layer 2
Z2 = Inputs * Theta1';
A2 = [ones(m, 1), sigmoid(Z2)];

% This is a (numberOfExamples x numberOfNeuronsInOutputLayer) matrix
Outputs = sigmoid(A2 * Theta2');


% COST CALCULATION

% Applies the cost function using the labels and outputs.
% Note the double sum. One of the sums is over neurons, another is over examples
% The order of which sum dimension is applied first doesn't matter.
cost = (1/m) * sum(sum(-Labels .* log(Outputs) - (1 - Labels) .* log(1 - Outputs)));

% REGULARIZED COST

% Here we sum over all the theta values squared
regularizationTerm = (lambda/(2*m)) * (sum(sum(Theta1ExBias .^ 2)) + sum(sum(Theta2ExBias .^ 2)));

J = cost + regularizationTerm;


% GRADIENT
% Link to tutorial: https://www.coursera.org/learn/machine-learning/discussions/all/threads/a8Kce_WxEeS16yIACyoj1Q
delta3 = Outputs - Labels;
delta2 = (delta3 * Theta2ExBias) .* sigmoidGradient(Z2);

Delta2 = delta3' * A2;
Delta1 = delta2' * Inputs;

Theta1GradWithoutRegularization = (1/m) * Delta1;
Theta2GradWithoutRegularization = (1/m) * Delta2;

% REGULARIZED GRADIENT

Theta1_grad = Theta1GradWithoutRegularization + (lambda/m) * [zeros(hidden_layer_size, 1), Theta1ExBias];
Theta2_grad = Theta2GradWithoutRegularization + (lambda/m) * [zeros(num_labels, 1), Theta2ExBias];

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
