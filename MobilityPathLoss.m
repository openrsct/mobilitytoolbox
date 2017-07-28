classdef MobilityPathLoss < MobilityNetwork
    % MOBILITYPATHLOSS
    %
    % Author: Igor Amorim Silva
    % Version: v0.0.2
    % Description - Class implementation of multiple PathLoss models
    
    properties (Access = public)
        MODEL_TYPE % Available PathLoss models [EMPIRICAL, SEMI-EMPIRICAL, DETERMINISTIC]
        
    end
    
    methods
      
        function [models] = chooseModel(obj, modelType, cellSize, cellLocation )
            switch( modelType )
                case 'EMPIRICAL'
                    
                case 'SEMI_EMPIRICAL'
                    
                case 'DETERMINISTIC'    
            end
        end
        
    end
    
end

