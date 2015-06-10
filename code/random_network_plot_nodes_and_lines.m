function [node_pos, st_p, en_p] = random_network_plot_nodes_and_lines(A)

[row, col] = size(A);
if row ~= col
    disp('A should be a square matrix');
    return
end

node = 1:row;
% node_pos = rand(row, 2) * 100;
node_pos = rand(row, 2);

% figure;
% hold on;
% plot(node_pos(:, 1), node_pos(:, 2), 'o');

% for i=1:row
%     A(i, i) = 0;
% end

idx = find(A >= 1);
new_idx = idx - 1;
st_idx = fix(new_idx / col) + 1;
en_idx = rem(new_idx, col) + 1;

st_p = node_pos(st_idx, :);
en_p = node_pos(en_idx, :);

%line([st_p(:, 1)', en_p(:, 1)'], [st_p(:, 2)', en_p(:, 2)']);

