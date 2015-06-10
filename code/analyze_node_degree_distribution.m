function [node_degree_distribution] = analyze_node_degree_distribution(vertices_conn, mr_prob_matrix, ms_prob_matrix)
    [row, col] = size(vertices_conn);
    node_conn = zeros(1, row);
    for i=1:row
%         for j=1:col
%             if vertices_conn(i, j) == 1
%                 node_conn(1, i) = node_conn(1, i) + 1;
%             end
%         end
        node_conn(1, i) = size(find(vertices_conn(i, :) == 1), 2);
    end

    conn_arr = unique(node_conn);
    conn_arr_size = size(conn_arr, 2);
    total_conn = sum(node_conn);
    
    node_degree_distribution = zeros(3, conn_arr_size);
    
    node_degree_distribution(1, :) = sort(conn_arr);
    
    for i=1:conn_arr_size
        node_degree_distribution(2, i) = size(find(node_conn == conn_arr(i)), 2) / total_conn;
    end
    
    pk = est_degree_distribution(node_degree_distribution(1, :), mr_prob_matrix, ms_prob_matrix);
    node_degree_distribution(3, :) = pk;
    
    node_degree_distribution = log10(node_degree_distribution);
