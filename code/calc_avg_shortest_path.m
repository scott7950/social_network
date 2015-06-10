function [avg_short_path] = calc_avg_shortest_path(vertices_conn)
        vertices_conn_sparse = sparse(vertices_conn);
        sum_shortest_path = 0;
        for j=1:(size(vertices_conn_sparse, 1) - 1)
            for k=(j+1):size(vertices_conn_sparse, 1)
                shortest_path = graphshortestpath(vertices_conn_sparse, j, k);
                if ~isinf(shortest_path)
                    sum_shortest_path = sum_shortest_path + shortest_path;
                end
            end
        end
    
        no_of_vertices = size(vertices_conn, 1);
        avg_short_path = sum_shortest_path / (no_of_vertices * (no_of_vertices + 1) / 2);
        