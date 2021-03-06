function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

positiveExampleIndices = find(y == 1);
negativeExampleIndices = find(y == 0);

plot(X(positiveExampleIndices, 1), X(positiveExampleIndices, 2), '+g', 'markersize', 7, 'linewidth', 2);
plot(X(negativeExampleIndices, 1), X(negativeExampleIndices, 2), 'or', 'markersize', 7, 'linewidth', 2);

% =========================================================================



hold off;

end
