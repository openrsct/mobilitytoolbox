classdef MobilityConnection < MobilityNetwork
% CONNECTION Class -  Exposes connection related methods
%   Developed by: Igor Amorim Silva
%   Version: 0.0.1
%   License: MIT
%   Date: 2017-06-23
%   Last Review : 2017-06-29
%
% --------------------------- PLEASE DONATE ---------------------------- 
%
properties (Access = private)
    
end


properties (Access = public)
  LIMITER = 202;  
end

methods

    function [initial_cell, index_initial_cell] = cellSelectionRSRP(obj,conected_femto_macro, indexes_femto_macro)
    %   Function Cell Selection RSRP
    %   Description: Function to select the most appropriate cell for a UE to camp
    %   Camp on servingcell- The cell with the highest RSRP in the measurement set
    %  
    %   Input---
    %   =>user_conected_femto_macro
    %  
    %   Output---
    %   =>initial_cel: The serving cell selected for each user in the first second
        [initial_cell, index_initial_cell] = CellSeletionRSRPHelper(conected_femto_macro, indexes_femto_macro);
    end


    function [initial_cell, index_initial_cell] = cellSelectionRSRQ(obj,conected_femto_macro, indexes_femto_macro)
    %  Function Cell Selection RSRQ
    %  Description: Function to select the most appropriate cell for a UE to camp
    %  Camp on servingcell- The cell with the highest RSRQ in the measurement set
    %  
    %  Input---
    %  =>user_conected_femto_macro
    %  
    %  Output---
    %  =>initial_cel: The serving cell selected for each user in the first second

        [initial_cell, index_initial_cell] = CellSeletionRSRQHelper(conected_femto_macro, indexes_femto_macro);
    end

    
    function [initial_cell, index_initial_cell] = cellSelectionSINR(obj,conected_femto_macro, indexes_femto_macro)
    %  Function Cell Selection SINR
    %  Description: Function to select the most appropriate cell for a UE to camp
    %  Camp on servingcell- The cell with the highest SINR in the measurement set
    %  
    %  Input---
    %  =>conected_femto_macro_SINR
    %  
    %  Output---
    %  =>initial_cel: The serving cell selected for each user in the first second
        [initial_cell, index_initial_cell] = CellSeletionSINRHelper(conected_femto_macro, indexes_femto_macro);
    end


    function [initial_cell, index_initial_cell] = cellSelectionChannelCapacity(obj,conected_femto_macro, indexes_femto_macro)
    %  Function Cell Selection Channel Capacity
    %  Description: Function to select the most appropriate cell for a UE to camp
    %  Camp on servingcell- The cell with the highest Channel Capacity in the measurement set
    %  
    %  Input---
    %  =>conected_femto_macro_ChannelCapacity
    %  
    %  Output---
    %  =>initial_cel: The serving cell selected for each user in the first second
        [initial_cell, index_initial_cell] = CellSeletionChannelCapacityHelper(conected_femto_macro, indexes_femto_macro);
    end

    function [indexes_femto_macro_ChannelCapacity, conected_femto_macro_ChannelCapacity] = conectionsChannelCapacity(obj, ChannelCapacity_femto_macro)
    %   Function Conection Channel Capacity
    %   Description: Function that returns for each second the best
    %   ChannelCapacity
    %   sorting the matrix with all macro and femtocells
    [indexes_femto_macro_ChannelCapacity, conected_femto_macro_ChannelCapacity] = ConectionsChannelCapacityHelper(obj,ChannelCapacity_femto_macro);

    end

    function [indexes_femto_macro_SINR, conected_femto_macro_SINR] = conectionsSINR(obj ,SINR_femto_macro)
    %   Function Conection SINR
    %   Description: Function that returns for each second the best RSRP
    %   sorting the matrix with all macro and femtocells
    %  
    %   Input: 
    %   femto_macro_SINR
    %   Output:
    %   conections=>
    
    [indexes_femto_macro_SINR, conected_femto_macro_SINR] = ConectionsSINRHelper(obj ,SINR_femto_macro);

    end

    function [indexes_femto_macro, conected_femto_macro, indexes_femto_macro_w, conected_femto_macro_w ] = conectionsRSRP(obj,RSRP_femto , RSRP_macro,RSRP_femto_w , RSRP_macro_w)
    %   Function Conection SINR
    %   Description: Function that returns for each second the best RSRP
    %   sorting the matrix with all macro and femtocells
    %  
    %   Input: 
    %   RSRP_femto => 
    %   RSRP_macro =>
    %  
     [indexes_femto_macro, conected_femto_macro, indexes_femto_macro_w, conected_femto_macro_w ] = ConectionsRSRPHelper(obj,RSRP_femto , RSRP_macro,RSRP_femto_w , RSRP_macro_w);

    end
end

end