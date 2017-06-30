classdef MobilityTimer < MobilityUtil

properties 
SIMULATION_TIME = 900;
end

methods 
   function mobility =  generateFullTime(obj,data)

   mobility =  GenerateFullTimeHelper(obj,data); 
   end
end

end