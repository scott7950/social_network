function [node_triang_and_degree] = analyze_triangle_distribution(vertices_conn, mr_prob_matrix, ms_prob_matrix)
    [row, col] = size(vertices_conn);
    all_node_triang_and_degree = zeros(3, row);
    for i=1:row
        conn_idx = find(vertices_conn(i, :) == 1);
        no_of_conn_idx = size(conn_idx, 2);
    
        total_possible_triang = no_of_conn_idx * (no_of_conn_idx - 1) / 2;
    
        % at least 2 edges are needed to created one triangle
        if no_of_conn_idx >= 2
            for j=1:(no_of_conn_idx - 1)
                for k=(j+1):no_of_conn_idx
                    if vertices_conn(conn_idx(j), conn_idx(k)) == 1
                        all_node_triang_and_degree(2, i) = all_node_triang_and_degree(2, i) + 1;
                    end
                end
            end
            all_node_triang_and_degree(2, i) = all_node_triang_and_degree(2, i) / total_possible_triang;
        else
            all_node_triang_and_degree(2, i) = 0;
        end
    end
    
    for i=1:row
%         for j=1:col
%             if vertices_conn(i, j) == 1
%                 all_node_triang_and_degree(1, i) = all_node_triang_and_degree(1, i) + 1;
%             end
%         end
        all_node_triang_and_degree(1, i) = size(find(vertices_conn(i, :) == 1), 2);
    end
    
    uniq_degree_arr = sort(unique(all_node_triang_and_degree(1, :)));
    node_triang_and_degree = zeros(3, size(uniq_degree_arr, 2));
    node_triang_and_degree(1, :) = uniq_degree_arr;
    for i=1:size(node_triang_and_degree(1, :), 2)
        idx = find(all_node_triang_and_degree(1, :) == node_triang_and_degree(1, i));
        total_triangle_degree = sum(all_node_triang_and_degree(2, idx));
        node_triang_and_degree(2, i) = total_triangle_degree / size(idx, 2);
    end

    % theory data
%     ck = est_triangle_distribution(all_node_triang_and_degree(1, :), mr_prob_matrix, ms_prob_matrix);
%     all_node_triang_and_degree(3, :) = ck;
    ck = est_triangle_distribution(node_triang_and_degree(1, :), mr_prob_matrix, ms_prob_matrix);
    node_triang_and_degree(3, :) = ck;
    
    node_triang_and_degree = real(log10(node_triang_and_degree));
    
%     [dummy, idx] = sort(all_node_triang_and_degree(1, :));
%     all_node_triang_and_degree = all_node_triang_and_degree(:, idx);
