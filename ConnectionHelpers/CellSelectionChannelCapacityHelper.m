%Function cell_selection
%Description: Function to select the most appropriate cell for a UE to camp
%Camp on servingcell- The cell with the highest Channel Capacity in the measurement set
%
%Input---
%=>conected_femto_macro_ChannelCapacity
%
%Output---
%=>initial_cel: The serving cell selected for each user in the first second

function [initial_cell_ChannelCapacity, index_initial_cell_ChannelCapacity] = CellSelectionChannelCapacityHelper(conected_femto_macro_ChannelCapacity, indexes_femto_macro_ChannelCapacity)
s_con = length(conected_femto_macro_ChannelCapacity);
initial_cell_ChannelCapacity = zeros(50,1);
index_initial_cell_ChannelCapacity = zeros(50,1);
for i=1:s_con
 cons = cell2mat(conected_femto_macro_ChannelCapacity(i));   
 inds = cell2mat(indexes_femto_macro_ChannelCapacity(i));
initial_cell_ChannelCapacity(i) = cons(1);
index_initial_cell_ChannelCapacity(i)=inds(1);
end
%initial_cell = initial_cell';

end