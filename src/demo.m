% Demonstartion of bezier2d function

% Case 1  - simple cases
b1 = [0, 0; 1, 1; 0, 1; 1, 0];
runTest(b1, 1);

% Case 2 - simple cases
b2 = [0, 0; 1, 0.5; 0, 1; 0, 0.5];
runTest(b2, 2);

% Case 3 - bigger numbers
b3 = rand(10, 2) * 1000;
runTest(b3, 3);

% Case 4 - more numbers
b4 = rand(100, 2) * 100;
runTest(b4, 4);

% Case 5 - big numbers - integers
b5 = randi([10000 100000], [10 2]);
runTest(b5, 5);


function runTest(b, testNum)
% runTest - auxiliary function
% Computes points for all t = [0, 0.01, ..., 1] and plots the difference
ts = [] * 100;
diffsInfy = [] * 100;
diffsSquare = [] * 100;
diffsMax = [] * 100;
t = 0.0;
for i = 1 : 100
    [v1, v2] = bezier2d(b, t);
    diffsMax(i) = max(abs(v1 - v2));
    diffsInfy(i) = sum(abs(v1 - v2));
    diffsSquare(i) = sqrt(sum(v1 - v2)^2);
    ts(i) = t;
    t = t + 0.01;
end

figure(testNum)
clf
hold on
plot(ts, diffsInfy, 'b', 'DisplayName', 'infy')
plot(ts, diffsMax, 'g', 'DisplayName', 'max')
plot(ts, diffsSquare, 'r', 'DisplayName', 'square')
xlabel("Value of t");
ylabel("Difference");
title("Comparison of algorithms for test " + testNum);
legend;
end