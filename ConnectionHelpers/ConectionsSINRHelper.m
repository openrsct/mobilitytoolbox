% Function Conection
% Description: Function that returns for each second the best RSRP
% sorting the matrix with all macro and femtocells
%
% Input: 
% femto_macro_SINR
% Output:
% conections=>

function [indexes_femto_macro_SINR, conected_femto_macro_SINR] = ConectionsSINRHelper(obj ,SINR_femto_macro)

conf = obj;
for i=1:length(SINR_femto_macro)
   
  femto_macro_sinr = cell2mat(SINR_femto_macro(i));
       
    
    [aux_femto_macro_sinr, ind_femto_macro_sinr] = sort(femto_macro_sinr,2,'descend');
    con_femto_macro_sinr = aux_femto_macro_sinr(:,1:conf.LIMITER);
       
   
    indexes_femto_macro_SINR(i,1) = {ind_femto_macro_sinr(:,1:conf.LIMITER)};
    conected_femto_macro_SINR(i,1) = {con_femto_macro_sinr};

end

end