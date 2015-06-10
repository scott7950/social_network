function new_conn_matrix = conn_calc_for_new_vertice(orig_conn_matrix)
[row, col] = size(orig_conn_matrix)
new_row = row + 1;
new_col = col + 1;

% new_one_row = zeros(1, col);
new_one_row = rand(1, col);
new_one_row = new_one_row >= 0.5;
new_conn_matrix = [orig_conn_matrix; new_one_row];

% new_one_col = zeros(new_col, 1);
new_one_col = new_one_row';
new_one_col = [new_one_col; 0];
new_conn_matrix = [new_conn_matrix, new_one_col];
