function [loss] = loss_function(intercept, slope, x, actual_y)
%LOSS_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
loss_s = actual_y - line_function(intercept, slope, x);
square_loss = loss_s.*loss_s;
loss = mean(square_loss);
end

