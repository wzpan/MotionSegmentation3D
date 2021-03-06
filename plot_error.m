function handle = plot_error(result, data, epsilon)

% plot_error
%
%       Plot the misclassification rate as a functon of epsilon.
%
% Inputs:
%   result      - a struct array containing the result of the experiment
%                   on a particular motion result
%   data        - an array where each column is a processed feature vectors
%                   of a tracked feature correspondence in the motion result
%
%   epsilon      - a list of epsilons used in this experiment
%
% Outputs:
%   handle             - the number of the figure generated by this
%                           function.
% Dependencies:
%   none
% Sep. '07  Shankar Rao -- srrao@uiuc.edu

% Copyright 2007, University of Illinois. All rights reserved.


outlierCount = 4;
handle = figure;
subplot(211)
errorPlot = semilogx(epsilon, result.error);
set(errorPlot, 'LineWidth', 2);
errorWindow = get(errorPlot, 'Parent');
set(errorWindow, 'FontSize', 16, 'FontWeight', 'bold', 'LineWidth', 2);
hold on
title(strrep(result.name, '_', '\_'), 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Error', 'FontSize', 16, 'FontWeight', 'bold');

l2 = line([epsilon(:) epsilon(:)], [zeros(length(epsilon),1) result.error(:)])


axis([min(epsilon) max(epsilon) 0 1]);

subplot(212)
stem1 = semilogx(epsilon, result.groupCounts, 'bo');
hold on
l3 = line([epsilon ; epsilon ], [zeros(1, length(epsilon)) ; result.groupCounts(:)'], 'Color' , 'k');

axis([min(epsilon) max(epsilon) 0 6]);

set(stem1, 'LineWidth', 2);

modifiedGroupCount = zeros(size(result.groupCounts));
 
for i=1:length(modifiedGroupCount)
    modifiedGroupCount(i) = sum(histc(result.labels(:, i), 1:result.groupCounts(i)) > outlierCount);
end
stem2 = semilogx(gca, epsilon(find(modifiedGroupCount ~= result.groupCounts)), modifiedGroupCount(modifiedGroupCount ~= result.groupCounts), 'go');
set(stem2, 'LineWidth', 2);
stemWindow = get(stem1, 'Parent');
set(stemWindow, 'FontSize', 16, 'FontWeight', 'bold', 'LineWidth', 2);
ylabel('Computed Group Count', 'FontSize', 16, 'FontWeight', 'bold');
