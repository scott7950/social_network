function [begin_row_of_new_vertices, vertices_conn] = network_grow(vertices_conn, increased_node_no, mr_prob_matrix, ms_prob_matrix)
    % generate random number of how many first contact
    no_of_first_con = zeros(1, increased_node_no);
    for i=1:increased_node_no
        mr_prob_matrix_index = 1 + sum(rand() > cumsum(mr_prob_matrix(:, 2)));
        no_of_first_con(1, i) = mr_prob_matrix(mr_prob_matrix_index, 1);
    end
    
    % no_of_first_con
    
    [row, col] = size(vertices_conn);
    if row ~= col
        errordlg('row No. does not match col No.');
    end
    
%     new_vertices_conn = zeros(increased_node_no, col + increased_node_no);

    for i=1:increased_node_no
        first_and_second_contact = one_new_vertice_network_grow(vertices_conn, no_of_first_con(1, i), ms_prob_matrix);
        one_new_vertice_conn  = zeros(1, col + i - 1);
        one_new_vertice_conn(1, first_and_second_contact) = 1;
    
        % append connection
        vertices_conn = [vertices_conn; one_new_vertice_conn];
        vertices_conn = [vertices_conn, [one_new_vertice_conn'; 0]];
        
%         new_vertices_conn(i, 1:(col + i - 1)) =  one_new_vertice_conn;
   
    end
    
    begin_row_of_new_vertices = row + 1;
    