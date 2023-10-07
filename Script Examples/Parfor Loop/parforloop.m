% Sequential (non-parallel) for loop
tic1 = tic;
N = 100;
result = zeros(1, N);
for i = 1:N
    A = randn(1000, 1000);
    B = randn(1000, 1000);
    result(i) = sum(sum(A * B));
end
toc1 = toc(tic1); % Measure elapsed time correctly
fprintf('time elapsed for simulation normal for loop is: %f\n', toc1);

% Parallel for loop using parfor
tic2 = tic;
N = 100;
result = zeros(1, N);
parfor i = 1:N
    A = randn(1000, 1000);
    B = randn(1000, 1000);
    result(i) = sum(sum(A * B)); % Perform the same computation in parallel
end
toc2 = toc(tic2); % Measure elapsed time correctly
fprintf('time elapsed for simulation parfor loop is: %f\n', toc2);
