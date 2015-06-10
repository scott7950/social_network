function first_and_second_contact = one_new_vertice_network_grow(vertices_conn, no_of_first_con, ms_prob_matrix)
    [row, col] = size(vertices_conn);
    
    if row ~= col
        errordlg('row No. does not match col No.');
    end

    % get first contact
    first_contact = new_one_vertice_first_contact(vertices_conn, no_of_first_con);

    % get second contact
    no_of_second_con_vs_first_contact = zeros(2, no_of_first_con);
    no_of_second_con_vs_first_contact(1, :) = first_contact;
    for i=1:no_of_first_con
        no_of_second_con_vs_first_contact(2, i) = sum(rand() > cumsum(ms_prob_matrix(:, 2)));
    end
    second_contact = new_one_vertice_second_contact(vertices_conn, no_of_second_con_vs_first_contact);

    first_and_second_contact = sort([first_contact, second_contact]);
