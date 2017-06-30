% Function cell_selection
% Description: Function to select the most appropriate cell for a UE to camp
% Camp on servingcell- The cell with the highest RSRP in the measurement set
%
% Input---
% =>user_conected_femto_macro
%
% Output---
% =>initial_cel: The serving cell selected for each user in the first second

function [initial_cell, index_initial_cell] = CellSeletionRSRPHelper(conected_femto_macro, indexes_femto_macro)
s_con = length(conected_femto_macro);
initial_cell = zeros(50,1);
index_initial_cell = zeros(50,1);
for i=1:s_con
 cons = cell2mat(conected_femto_macro(i));   
 inds = cell2mat(indexes_femto_macro(i));
initial_cell(i) = cons(1);
index_initial_cell(i)=inds(1);
end
%initial_cell = initial_cell';

end