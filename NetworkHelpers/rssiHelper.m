% RSSI (Received Signal Strength Indicator) 
% Description: a parameter which provides information about total received wide-band power 
% (measure in all symbols) including all interference and thermal noise.
%
% RSSI = wideband power = noise + serving cell power + interference power
% 
% --- Input 
% noise =>
% RSRP_femto_w =>  RSRP_femtocells in (watts)
% RSRP_macro_w => RSRP_macrocells in (watts)
% 
% --- Output
% Prxtotal => Sum of total RSRP of each macro and femto + noise
% RSSI_femto => RSSI of femtocells in(watts)
% RSSI_macro => RSSI of macrocells in(watts)
%
% --- Example
%  [Prxtotal, RSSI_femto, RSSI_macro] = rssi(noise, RSRP_femto_w, RSRP_macro_w)


% %Matriz RSRP em watts concatenada

function [Prxtotal, RSSI_femto_macro_w] = rssiHelper(RSRP_femto_macro_w , config)
s_femto = size(RSRP_femto_macro_w);


     for i = 1:s_femto(1)
         fm = cell2mat(RSRP_femto_macro_w(i)); %RSRP das 2 macrocells
         s_fm = size(fm);
        
            for h = 1:s_fm(1) %(901 Femto1..200)   
            Prxtotal_temp(h,1) = sum(config.NOISE + fm(h,:));    %Matrix Prxtotal 50x1[901x202] em w)
            aux = fm(h,:);
            rssi_temp(h,1:s_fm(2)) = 2.*aux + 10* Prxtotal_temp(h,1);          
            end
            
      RSSI_femto_macro_w(i,1) = {rssi_temp};
      Prxtotal(i,1) = {Prxtotal_temp};
     end         
end

