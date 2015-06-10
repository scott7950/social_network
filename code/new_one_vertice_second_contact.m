 function second_contact = new_one_vertice_second_contact(vertices_conn, no_of_second_con_vs_first_contact)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % the second contact
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    no_of_first_con = size(no_of_second_con_vs_first_contact, 2);
    second_contact_tmp = [];
    
    for i=1:no_of_first_con
        one_second_contact = [];
        first_contact = no_of_second_con_vs_first_contact(1, i);
        no_of_second_con = no_of_second_con_vs_first_contact(2, i);

        if no_of_second_con >= 1
            second_con_of_first_con = vertices_conn(first_contact, :);
            idx = find(second_con_of_first_con >= 1);
        
            % remove the first contact from idx
            for j=1:no_of_first_con
                no_of_idx = size(idx, 2);
                for k =1:no_of_idx
                    if no_of_second_con_vs_first_contact(1, j) == idx(1, k)
                        idx(k) = [];
                        break;
                    end
                end
            end
            
            % remove the duplicate second contact from idx
            for j=1:size(second_contact_tmp, 2)
                no_of_idx = size(idx, 2);
                for k =1:no_of_idx
                    if second_contact_tmp(1, j) == idx(1, k)
                        idx(k) = [];
                        break;
                    end
                end
            end
            
            % get random second contact
            if size(idx, 2) ~= 0
                potential_second_contact = size(idx, 2);
                if potential_second_contact <= no_of_second_con
                    no_of_second_con = potential_second_contact;
                    one_second_contact = idx;
                else
                    for i=1:no_of_second_con
                        potential_second_contact = size(idx, 2);
                        selected_idx = randi([1, potential_second_contact], 1, 1);
                        one_second_contact = [one_second_contact, idx(selected_idx)];
                        idx(selected_idx) = [];
                    end
                end
            end
        end
        
        second_contact_tmp = [second_contact_tmp, one_second_contact];
        
    end
    
    second_contact = unique(second_contact_tmp);
    