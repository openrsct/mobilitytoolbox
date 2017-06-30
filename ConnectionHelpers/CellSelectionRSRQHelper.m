%Function cell_selection
%Description: Function to select the most appropriate cell for a UE to camp
%Camp on servingcell- The cell with the highest RSRQ in the measurement set
%
%Input---
%=>user_conected_femto_macro
%
%Output---
%=>initial_cel: The serving cell selected for each user in the first second

function [initial_cell_RSRQ, index_initial_cell_RSRQ] = CellSelectionRSRQHelper(conected_femto_macro_RSRQ, indexes_femto_macro_RSRQ)
s_con = length(conected_femto_macro_RSRQ);
initial_cell_RSRQ = zeros(50,1);
index_initial_cell_RSRQ = zeros(50,1);
for i=1:s_con
 cons = cell2mat(conected_femto_macro_RSRQ(i));   
 inds = cell2mat(indexes_femto_macro_RSRQ(i));
initial_cell_RSRQ(i) = cons(1);
index_initial_cell_RSRQ(i)=inds(1);
end
%initial_cell = initial_cell';

end