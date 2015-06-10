function node_knn_and_degree = analyze_knn_distribution(vertices_conn)
    [row, col] = size(vertices_conn);
    
    node_degree = zeros(1, row);
    for i=1:row
%         for j=1:col
%             if vertices_conn(i, j) == 1
%                 node_degree(1, i) = node_degree(1, i) + 1;
%             end
%         end
        node_degree(1, i) = size(find(vertices_conn(i, :) == 1), 2);
    end
    
    % remove node with 0 degree and get the unique degree number array
    uniq_degree = sort(unique(node_degree(find(node_degree ~= 0))));
    
    node_knn_and_degree = [];
    for i=1:size(uniq_degree, 2)
        one_k_idx = find(node_degree == uniq_degree(i));
        node_knn_and_degree = [node_knn_and_degree, [uniq_degree(i), 0]'];
%         for j=1:size(one_k_idx, 2)
%             k_apostrophe = [];
%             one_vertice_conn = vertices_conn(one_k_idx(1, j), :);
%             for k=1:size(one_vertice_conn, 2)
%                 if one_vertice_conn(1, k) == 1
%                     k_apostrophe = [k_apostrophe, node_degree(1, k)];
%                 end
%             end
%             
%             uniq_k_apostrophe = unique(k_apostrophe);
%             total_k_apostrophe = size(k_apostrophe, 2);
%                 
%             if size(uniq_k_apostrophe, 2) ~= 0
%                 for k=1:size(uniq_k_apostrophe, 2)
%                     node_knn_and_degree(2, i) = node_knn_and_degree(2, i) + (size(find(k_apostrophe == uniq_k_apostrophe(1, k)), 2) / total_k_apostrophe) * uniq_k_apostrophe(1, k);
%                 end
%             end
%      
%         end
        
        k_apostrophe = [];
        for j=1:size(one_k_idx, 2)
            one_vertice_conn = vertices_conn(one_k_idx(1, j), :);
            for k=1:size(one_vertice_conn, 2)
                if one_vertice_conn(1, k) == 1
                    k_apostrophe = [k_apostrophe, node_degree(1, k)];
                end
            end
            

        end
        
        uniq_k_apostrophe = unique(k_apostrophe);
        total_k_apostrophe = size(k_apostrophe, 2);
                
        if size(uniq_k_apostrophe, 2) ~= 0
            for k=1:size(uniq_k_apostrophe, 2)
                node_knn_and_degree(2, i) = node_knn_and_degree(2, i) + (size(find(k_apostrophe == uniq_k_apostrophe(1, k)), 2) / total_k_apostrophe) * uniq_k_apostrophe(1, k);
            end
        end
     
    end
    
    node_knn_and_degree = log10(node_knn_and_degree);
    