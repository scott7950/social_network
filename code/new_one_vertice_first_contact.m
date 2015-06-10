function first_contact = new_one_vertice_first_contact(vertices_conn, no_of_first_con)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % the first contact
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % new vertice connection node
    first_contact = zeros(1, no_of_first_con);
    [row, col] = size(vertices_conn);
        
    for i=1:no_of_first_con
        % check if the first contact already conttected
        same_node = 1;
        while same_node == 1
            % random the first contact
            first_contact(1, i) = randi([1, row], 1, 1);
            same_node = 0;
            for j=1:i
                 if j ~= i && first_contact(1, i) == first_contact(1, j)
                     same_node = 1;
                     break;
                 end
            end
        end
    end
    