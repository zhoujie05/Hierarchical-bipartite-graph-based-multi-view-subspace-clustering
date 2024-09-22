function  [std_results ,var_results,std_var_result] = cal_std_var(results)
results(all(results == 0, 2), :) = [];

std_results = std(results);
var_results = var(results);

disp('std:');
disp(std_results);

% disp('var:');
% disp(var_results);
std_var_result=[std_results;var_results];
end