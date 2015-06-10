function [pk] = est_degree_distribution(k, mr_prob_matrix, ms_prob_matrix)
    % exp_mr = 0.95 * 1 + 0.05 * 2;
    exp_mr = 0;
    for i=1:size(mr_prob_matrix, 1)
        exp_mr = exp_mr + mr_prob_matrix(i, 1) * mr_prob_matrix(i, 2);
    end

    % exp_ms = 0 * 0.25 + 1 * 0.25 + 2 * 0.25 + 3 * 0.25;
    exp_ms = 0;
    for i=1:size(ms_prob_matrix, 1)
        exp_ms = exp_ms + ms_prob_matrix(i, 1) * ms_prob_matrix(i, 2);
    end
    
    A = 2 * (1 + exp_ms) / exp_ms;
    B = exp_mr * (A + 1 + exp_ms);
    C = A * exp_mr;
    
    k_no = size(k, 2);
    pk = zeros(1, k_no);
    for i=1:k_no
        pk(1, i) = A * (B ^ A)  * ((k(1, i) + C) ^ ( -2 / exp_ms -3));
        % pk(1, i) = log10(pk(1, i));
    end
    