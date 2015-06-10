function [sim_format, theory_format] = get_plot_format_of_sim_and_theory(number)
    switch number
        case 1
            sim_format = 'or';
            theory_format = '-ob';
        case 2
            sim_format = 'xr';
            theory_format = '-xb';
        case 3
            sim_format = 'sr';
            theory_format = '-sb';
        case 4
            sim_format = '+r';
            theory_format = '-+b';
        otherwise
            sim_format = 'or';
            theory_format = '-ob';
    end
    