function [A] = random_network_vertices_and_connection(n0, randThresh)

% generate a random network connection
A = rand(n0, n0);
A = A >= randThresh;

% for the connection with the point itself, remove the connection
for i=1:n0
    A(i, i) = 0;
end

% if point(i, j) is connected, point(j, i) should be connected too
for i=1:n0
    for j=1:n0
        if A(i, j) == 1
            A(j, i) = 1;
        end
    end
end

