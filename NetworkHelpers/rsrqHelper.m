% RSRQ:Reference Signal Received Quality|
% Description: Function to calculate the RSRQ
% RSRQ= (N*RSRP)/RSSI where N= Number of RBs
%
% 
% --- Input 
% RSRP_macro_w => RSRP of macrocells (watts)
% RSSI_macro=> RSSI of macrocells (watts)
% RSRP_femto_w => RSRP of femtocells (dbm)
% RSSI_femto => RSSI of femtocells (watts)
% N => number of resource blocks (Defined in config.m)
%
% --- Output
% RSRQ_femto_w => RSRQ of femtocells in (watts)
% RSRQ_femto => RSRQ of femtocells in (dB)
% RSRQ_macro_w => RSRQ of macrocells in (watts)
% RSRQ_macro => RSRQ of macrocells in (dB)
% 
% Example:
% [RSRQ_femto_w, RSRQ_femto, RSRQ_macro_w,RSRQ_macro] = rsrq(RSRP_macro_w,RSRP_femto_w,RSSI_femto,RSSI_macro, N)

function [RSRQ_femto_macro_w,RSRQ_femto_macro] = rsrqHelper(RSRP_femto_macro_w , RSSI_femto_macro_w, config)
    s_rsrp = size(RSRP_femto_macro_w);
    
    for k = 1:s_rsrp(1)
    
    rsrp_user = cell2mat(RSRP_femto_macro_w(k));
    rssi_user = cell2mat(RSSI_femto_macro_w(k));
     
    RSRQ_femto_macro_w(k,1) = {config.RESOURCE_BLOCK .*rsrp_user./rssi_user};  %w 
    RSRQ_femto_macro(k,1) = {10.*log10(cell2mat(RSRQ_femto_macro_w(k,1)))};  %dB Only apply the conversion (10*log10 Value(w))       
    end
end
