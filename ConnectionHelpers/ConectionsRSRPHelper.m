% Function Conection
% Description: Function that returns for each second the best RSRP
% sorting the matrix with all macro and femtocells
%
% Input: 
% RSRP_femto => 
% RSRP_macro =>
%

function [indexes_femto_macro, conected_femto_macro, indexes_femto_macro_w, conected_femto_macro_w ] = ConectionsRSRPHelper(obj,RSRP_femto , RSRP_macro,RSRP_femto_w , RSRP_macro_w)

conf = obj;
for i=1:length(RSRP_femto)
   
  femto_rsrp = cell2mat(RSRP_femto(i));
  macro_rsrp = cell2mat(RSRP_macro(i));
  femto_rsrp_w = cell2mat(RSRP_femto_w(i));
  macro_rsrp_w = cell2mat(RSRP_macro_w(i)); 
       
    femto_macro = [femto_rsrp macro_rsrp];
       [aux_femto_macro, ind_femto_macro] = sort(femto_macro,2,'descend');
       con_femto_macro = aux_femto_macro(:,1:conf.LIMITER);
       
   femto_macro_w = [femto_rsrp_w macro_rsrp_w];
       [aux_femto_macro_w, ind_femto_macro_w] = sort(femto_macro_w,2,'descend');
       con_femto_macro_w = aux_femto_macro_w(:,1:conf.LIMITER);
   
    indexes_femto_macro(i,1) = {ind_femto_macro(:,1:conf.LIMITER)};
    conected_femto_macro(i,1) = {con_femto_macro};
    
    indexes_femto_macro_w(i,1) = {ind_femto_macro_w(:,1:conf.LIMITER)};
    conected_femto_macro_w(i,1) = {con_femto_macro_w};
    
end

end