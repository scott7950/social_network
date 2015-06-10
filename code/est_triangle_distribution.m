function [ck] = est_triangle_distribution(k, mr_prob_matrix, ms_prob_matrix)
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
    D = C *(exp_ms - 1);
    F = D * log(B) + exp_mr;
    
    k_no = size(k, 2);
    ck = zeros(1, k_no);
    for i=1:k_no
        if k(1, i) < 2
             ck(1, i) = 0;
        else
            ck(1, i) = 2 * (k(1, i) + D * log(k(1, i) + C) - F) / (k(1, i) * (k(1, i) - 1));
            % ck(1, i) = real(log(ck(1, i)));
        end
    end
    