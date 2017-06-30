% Function Conection
% Description: Function that returns for each second the best RSRP
% sorting the matrix with all macro and femtocells
%
% Input: 
% RSRQ_femto_macro => 
% %
% Output:
% conections=>
%
function [indexes_femto_macro_RSRQ, conected_femto_macro_RSRQ] = ConectionsRSRQHelper(RSRQ_femto_macro)

conf = obj;
for i=1:length(RSRQ_femto_macro)
   
  femto_macro_rsrq = cell2mat(RSRQ_femto_macro(i));
%  
%        
%     femto_macro = [femto_rsrp macro_rsrp];
    [aux_femto_macro_rsrq, ind_femto_macro_rsrq] = sort(femto_macro_rsrq,2,'descend');
    con_femto_macro_rsrq = aux_femto_macro_rsrq(:,1:conf.LIMITER);
       
  
    indexes_femto_macro_RSRQ(i,1) = {ind_femto_macro_rsrq(:,1:conf.LIMITER)};
    conected_femto_macro_RSRQ(i,1) = {con_femto_macro_rsrq};
    
   
    
end

end