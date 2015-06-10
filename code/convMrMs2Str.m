function [mr_str, ms_str] = convMrMs2Str(mr_prob_matrix, ms_prob_matrix)
    mr_str = 'Mr: ';
    for j=1:size(mr_prob_matrix, 1)
        one_mr_para_str = sprintf('%d: %0.2f; ', mr_prob_matrix(j, 1), mr_prob_matrix(j, 2));
        mr_str = [mr_str, one_mr_para_str];
    end
        
    ms_str = 'Ms: ';
    for j=1:size(ms_prob_matrix, 1)
        one_ms_para_str = sprintf('%d: %0.2f; ', ms_prob_matrix(j, 1), ms_prob_matrix(j, 2));
        ms_str = [ms_str, one_ms_para_str];
    end
    