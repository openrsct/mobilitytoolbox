%Function cell_selection
%Description: Function to select the most appropriate cell for a UE to camp
%Camp on servingcell- The cell with the highest SINR in the measurement set
%
%Input---
%=>conected_femto_macro_SINR
%
%Output---
%=>initial_cel: The serving cell selected for each user in the first second

function [initial_cell_SINR, index_initial_cell_SINR] =CellSelectionSINRHelper(conected_femto_macro_SINR, indexes_femto_macro_SINR)
s_con = length(conected_femto_macro_SINR);
initial_cell_SINR = zeros(50,1);
index_initial_cell_SINR = zeros(50,1);
for i=1:s_con
 cons = cell2mat(conected_femto_macro_SINR(i));   
 inds = cell2mat(indexes_femto_macro_SINR(i));
initial_cell_SINR(i) = cons(1);
index_initial_cell_SINR(i)=inds(1);
end
%initial_cell = initial_cell';

end