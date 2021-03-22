function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

% COST
cost = sum((X * theta - y) .^ 2) / (2*m);
regularizationCost = (lambda / (2*m)) * sum(theta(2:end) .^2);
J = cost + regularizationCost;

% GRADIENT
% This is a column vector with size = number of examples
errors = X * theta - y;

% Applies the data of each feature to the errors and sums over all examples
gradientWithoutReg = (1/m) * (X' * errors);

% Here we pad the start with 0 since we didn't penalize theta(1)
regularizationTermOfGradient = [0; (lambda / m) * theta(2:end) ];

grad = gradientWithoutReg + regularizationTermOfGradient;
% =========================================================================

grad = grad(:);

end
