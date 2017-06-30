 % SINR: Signal-to-Interference-plus-Noise Ratio
 % SINR = RSRP/I+N,  servingPower / (average interference power+ noise) where
 % interferencePower = Prxtotal= Totalpower- TpowerX
 % Description: Function to calculate the SINR of given data
 %
 
 function [SINR_femto_macro_w,SINR_femto_macro] = sinrHelper(RSRP_femto_macro_w, Prxtotal, config)
 s_femto_macro = size(RSRP_femto_macro_w);
 
 for k=1:s_femto_macro(1)
 rsrp = cell2mat(RSRP_femto_macro_w(k));
 prxtotal = cell2mat(Prxtotal(k));
 s_rsrp = size(rsrp); 
 prxtotal = repmat(prxtotal,[1 s_rsrp(2)]);
    
    sinr_temp_w = rsrp./(config.NOISE + config.NOISE_FEMTO + prxtotal- rsrp);
    sinr_temp = real(10.*log10(sinr_temp_w));  %dB
    
 SINR_femto_macro_w(k,1) = {sinr_temp_w};
 SINR_femto_macro(k,1) = {sinr_temp};
 end

 end
 
