% Demonstartion of bezier2d function

% Case 1  - simple cases
b1 = [0, 0; 1, 1; 0, 1; 1, 0];
runTest(b1, 1);

% Case 2 - simple cases
b2 = [0, 0; 1, 0.5; 0, 1; 0, 0.5];
runTest(b2, 2);

% Case 3 - more numbers
b4 = rand(100, 2) * 100;
runTest(b4, 3);

% Case 4 - big numbers - integers
b5 = randi([10000 100000], [10 2]);
runTest(b5, 4);


function runTest(b, testNum)
% runTest - auxiliary function
% Computes points for all t = [0, 0.01, ..., 1] and plots the difference
    n = 101;
    ts = [] * n;
    diffsInfy = [] * n;
    diffsSquare = [] * n;
    diffsMax = [] * n;
    vs1 = zeros(n, 2);
    vs2 = zeros(n, 2);
    t = 0.0;
    for i = 1 : n
        [v1, v2] = bezier2d(b, t);
        diffsMax(i) = max(abs(v1 - v2));
        diffsInfy(i) = sum(abs(v1 - v2));
        diffsSquare(i) = sqrt(sum(v1 - v2)^2);
        vs1(i, :) = v1;
        vs2(i, :) = v2;
        ts(i) = t;
        t = t + 0.01;
    end

    diffName = num2str(testNum) + " - differences";
    figure('Name', diffName)
    clf
    hold on
    plot(ts, diffsInfy, 'b', 'DisplayName', 'infy')
    plot(ts, diffsMax, 'g', 'DisplayName', 'max')
    plot(ts, diffsSquare, 'r', 'DisplayName', 'square')
    xlabel("Value of t");
    ylabel("Difference");
    title("Comparison of algorithms for test " + testNum);
    legend;
    
    curveName = num2str(testNum) + " - curves";
    figure('Name', curveName)
    clf
    hold on
    plot(b(:, 1), b(:, 2), 'ro');
    plot(vs1(:, 1), vs1(:, 2), 'b');
    plot(vs2(:, 1), vs2(:, 2), 'g');
end
