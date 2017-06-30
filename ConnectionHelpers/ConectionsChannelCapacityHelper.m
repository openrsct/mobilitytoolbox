% Function Conection
% Description: Function that returns for each second the best
% ChannelCapacity
% sorting the matrix with all macro and femtocells


function [indexes_femto_macro_ChannelCapacity, conected_femto_macro_ChannelCapacity] = ConectionsChannelCapacityHelper(ChannelCapacity_femto_macro)

conf = config;
for i=1:length(ChannelCapacity_femto_macro)
   
  femto_macro_cc = cell2mat(ChannelCapacity_femto_macro(i));
       
    
    [aux_femto_macro_cc, ind_femto_macro_cc] = sort(femto_macro_cc,2,'descend');
    con_femto_macro_cc = aux_femto_macro_cc(:,1:conf.Limiter);
       
   
    indexes_femto_macro_ChannelCapacity(i,1) = {ind_femto_macro_cc(:,1:conf.Limiter)};
    conected_femto_macro_ChannelCapacity(i,1) = {con_femto_macro_cc};

end

end