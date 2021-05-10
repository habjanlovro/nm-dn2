function [v1, v2] = bezier2d(b, t)
% bezier2d - Compute the value of Bezier point
%   Computes the value of bezier point directly (v1) and using De
%   Casteljans algorithm
%   input:
%       b - 2 * (n + 1) vector containing control points in the columns
%       t - value of parameter
%   output:
%       v1 - point b(t) computed directly
%       v2 - point b(t) computed using De Casteljans algorithm

v1 = computeDirectly(b, t);
v1 = v1';

v2 = deCastiljas(b, t);
v2 = v2';
end

function v = computeDirectly(b, t)
    v = [0, 0];
    [nPlusOne, ~] = size(b);
    for i = 1 : nPlusOne
        v = v + nchoosek(nPlusOne-1, i-1) * t^(i-1) * (1 - t)^(nPlusOne - i) * b(i, :);
    end
end

function v = deCastiljas(b, t)
    [nPlusOne, ~] = size(b);
    for i = (nPlusOne - 1) : -1 : 1
        for j = 1 : i
            b(j, :) = (1 - t) * b(j, :) + t * b(j + 1, :);
        end
    end
    v = b(1, :);
end