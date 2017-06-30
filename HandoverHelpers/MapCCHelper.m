% Linguist Variables
% Map Channel Capacity on Very Low, Low, Medium, High, Very High
function [aux1,aux2,aux3] = MapCCHelper(config,rsrp,sinr,channel)
VL = config.LITERAL_VERY_LOW  ; %VeryLow * weight
L = config.LITERAL_LOW        ; %Low * weight
M = config.LITERAL_MEDIUM     ; %Medium * weight
H = config.LITERAL_HIGH       ; %High * weight
VH = config.LITERAL_VERY_HIGH ; %VeryHigh * weight

        
if(rsrp >= 0 && rsrp <= 0.2)
                aux1 = {VL}; 
            end
           
            if(rsrp > 0.2 && rsrp <= 0.4)
                aux1 = {L}; 
            end
            
            if(rsrp > 0.4 && rsrp <= 0.6)
                aux1 = {M}; 
            end
            
            if(rsrp > 0.6 && rsrp <= 0.8)
                aux1 = {H}; 
            end
            
            if(rsrp > 0.8)
                aux1 = {VH}; 
            end
            
            % Criterio 2: RB
            if(channel >= 0 && channel <= 0.2) %VeryLow
                aux2 = {VL}; 
            end           
            
            if(channel >0.2 && channel <= 0.4)%Low
                aux2 = {L}; 
            end
            
            if(channel > 0.4 && channel <= 0.6)%Medium
                aux2 = {M}; 
            end
            
            if(channel > 0.6 && channel<=0.8) %High
                aux2 = {H}; 
            end
            
            if(channel > 0.8) %VeryHigh
                aux2 = {VH}; 
            end
            
            % Criterio 3:SINR
            if(sinr >= 0 && sinr <= 0.2)
                aux3 = {VH}; 
            end
            
            if(sinr > 0.2 && sinr <= 0.4)
                aux3 = {H}; 
            end
            
            if(sinr > 0.4 && sinr <= 0.6)
                aux3 = {M}; 
            end
            
            if(sinr > 0.6 && sinr <= 0.8)
                aux3 = {L}; 
            end
            
            if(sinr > 0.8)
                aux3 = {VL}; 
            end
end
