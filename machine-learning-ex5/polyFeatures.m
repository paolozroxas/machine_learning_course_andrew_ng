function [X_poly] = polyFeatures(X, p)
%POLYFEATURES Maps X (1D vector) into the p-th power
%   [X_poly] = POLYFEATURES(X, p) takes a data matrix X (size m x 1) and
%   maps each example into its polynomial features where
%   X_poly(i, :) = [X(i) X(i).^2 X(i).^3 ...  X(i).^p];
%


% You need to return the following variables correctly.
X_poly = zeros(numel(X), p);

% ====================== YOUR CODE HERE ======================
% Instructions: Given a vector X, return a matrix X_poly where the p-th 
%               column of X contains the values of X to the p-th power.
%
% 

% Create a matrix that looks like:
%  1   2   3   4   5
%  1   2   3   4   5
%  1   2   3   4   5
% Where rows are the number of elements in X
% and columns are the polynomial degree.
powers = repmat(1:p, numel(X), 1);

X_poly = X .^ powers;


% =========================================================================

end
