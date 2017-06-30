classdef MobilityHandover < MobilityNetwork 
    % HANDOVER Class -  Exposes handover related methods
    %   Developed by: Igor Amorim Silva
    %   Version: 0.0.1
    %   License: MIT
    %   Date: 2017-06-23
    %
    % --------------------------- PLEASE DONATE ---------------------------- 
    %
    properties(Access = public)
    HYSTERESIS = 2; % Hysteresis
     % Parameters of Topsis
    RSRP_MIN = -135; % Max value of RSRP for use in Handover TOPSIS
    RSRP_MAX = -13; % Min value of RSRP for use in Handover TOPSIS
    %Channel
    CHANNEL_CAPACITY_MIN = -10*10^8; % Min value of Channel Capacity for use in Handover TOPSIS
    CHANNEL_CAPACITY_MAX = 13*10^8; % Max value of Channel Capacity for use in Handover TOPSIS
    %SINR
    SINR_MIN = -130; % Min value of SINR for use in Handover TOPSIS
    SINR_MAX = 75; % Max value of Channel Capacity for use in Handover TOPSIS
    
    % Literals Definition for Topsis
    LITERAL_VERY_LOW    =   [0   0.05   0.1625];          % Literal definition of very low rule 
    LITERAL_LOW         =   [0.0525   0.15   0.2925];     % Literal definition of  low rule
    LITERAL_MEDIUM      =   [0.1225    0.2500    0.4225]; % Literal definition of medium rule
    LITERAL_HIGH        =   [0.1925    0.3500    0.5525]; % Literal definition of high rule
    LITERAL_VERY_HIGH   =   [0.2625    0.4500    0.6500]; % Literal definition of very rule
    end
    
    methods
        function handoverOut = handoverA3(obj, varargin )
        % Function Handover A3 Event
        % Description: calculate the number of Handovers based on Event A3
        % A3 event: If RSRP_neighbour > RSRPcurrentcell + Hys
        % 
        %    
        inputs = varargin;
        handoverOut =  HandoverA3Helper(obj, inputs );
        end
        
        function handoverOut = handoverFuzzy(~,varargin)
        % Function Handover_Fuzzy
        % Description: calculate the number of Handovers based on dynamic fuzzy
        % threhsold    
            inputs = varargin;
            handoverOut = HandoverFuzzyHelper( inputs );
        end
        
        function handoverOut = handoverTopsis(obj , varargin)
        % Function Handover_Topsis
        % Description: calculate the number of Handovers based on Topsis
        % algorithm
        % Input: 
        % 
        % RSRP_femto_macro                    
        % RSRQ_femto_macro                    
        % SINR_femto_macro                   
        % ChannelCapacity_femto_macro         
        % initial_cell                        
        % initial_cell_RSRQ                   
        % initial_cell_SINR                  
        % initial_cell_ChannelCapacity          
        % index_initial_cell                  
        % index_initial_cell_RSRQ             
        % index_initial_cell_SINR             
        % index_initial_cell_ChannelCapacity   
        % 
           inputs = varargin;
           handoverOut = HandoverTopsisHelper(obj, inputs);
        end
        
        function handoverOut = handoverCellRangeExpansion(obj, varargin)


        end

        function [hpp] = autoPingPong(obj,n_ind , tos)
        % Function to calculate number of handover ping pong
            hpp = AutoPingPongHelper(n_ind, tos );
        end

        function [cc_current, cc_neighbor] = calculateChannelCapacityTopsis(obj, varargin)
        % Function to calculate index CC for TOPSIS Algorithm
        % Algorithm Fuzzy Topsis-FMCSS
        % Step-1:Normalize the data usingfor the benefit criteria and cost criteria.
        % (eq14):Rij=xij-(min{xij})/(max{xij}-min{xij})
        % (eq15):Rij=(max{xij}-xij)/(max{xij}-min{xij})
        % 
            inputs = varargin;
            [cc_current, cc_neighbor] = CalcCCHelper(obj, inputs);
        end
        
        function [out1,out2,out3] = mapChannelCapacity(obj,rsrp,sinr,channel)
        % Linguist Variables
        % Map Channel Capacity on Very Low, Low, Medium, High, Very High    
            [out1,out2,out3] = MapCCHelper(obj,rsrp,sinr,channel);
        end
        
        function output = getLiteral(~, intervals, weights)
        % Return calculted Literal    
            output = intervals .* weights;
        end
        
        
        
    end
    
end

