function [channel_capacity_femto_macro] = channelCapacityHelper(out_handover_sinr)
B=5000000; %bandwidth 5 Mhz
s_out = size(out_handover_sinr); 
for k=1:s_out(1)
 sinr= cell2mat(out_handover_sinr(k));
 sinrw= 10.^(sinr)./10/1000; %transformo para watts
 c = B*10.*log2(1+sinrw);
 %Megabits = bits ÷ 1000000
%  c=c/1000000;
  channel_capacity_femto_macro(k,1) = {c};
 end

end
