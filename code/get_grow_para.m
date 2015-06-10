function [startValue, endValue] = get_grow_para(growStr)
colon_pos = regexp(growStr, ':');
startValue_str = growStr(1:(colon_pos - 1));
endValue_str = growStr((colon_pos + 1):end);
startValue = str2num(startValue_str);
endValue = str2num(endValue_str);
