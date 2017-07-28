classdef MobilityGenerator
    % MOBILITYGENERATOR - Class for data mobility generation based on model
    %   
    % **MobilityToolbox v 0.0.1** 
    % A project of Open Research Tools  
    %
    % Reference: https://openrsct.github.io/home
    %   Developed by: Igor Amorim Silva
    %   Version: 0.0.1
    %   License: MIT
    %   Date: 2017-06-23   
    %   This class exposes a collection of methods for user mobility given set of params
    %
    % List of available methods:
    %
    % 1 - Random Waypoint Mobility Model
    % 2 - Manhattan Mobility Model          (ON FUTURE RELEASES)
    % 3 - Gauss Markov Mobility Model       (ON FUTURE RELEASES)    
    % 4 - Waypoint Mobility                 (ON FUTURE RELEASES)
    % 5 - Random Walk                       (ON FUTURE RELEASES)
    % 6 - Pathway Mobility                  (ON FUTURE RELEASES)
    % 7 - Freeway Mobility                  (ON FUTURE RELEASES)
    %
    % 
    % ~~~~~~~~~~~~~~~~~~ HELP US MAINTAIN THIS PROJECT ~~~~~~~~~~~~~~~~~~~~
    %
    %  PLEASE DONATE AT => https://openrsct.github.io/mobilitytoolbox             
    %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    properties
        POSITION_X_INTERVAL = [0 1000];
        POSITION_Y_INTERVAL = [0 1000];
        SPEED_INTERVAL = [0 2.78];
        PAUSE_INTERVAL = [0 0];
        WALK_INTERVAL = [30 80];
        DIRECTION_INTERVAL = [0 360];
        SIMULATION_TIME = 900;
        NUMBER_OF_USERS = 20;
    end
    
        
    methods
        
        function [mobility_model] = randomWaypointMobility( obj , config )
        % randomWaypointMobility - Function to generate mobility data base on random
        %                          waypoint mobility model 
        %
        %   Input : 
        %   * config => Struct with model configuration data. See documentation for more info
        %
        %   Ouptut :
        %   * mobility_model => generated data
        %
        %   **Example** : 
        %
        %   [mobility_model] = [class constructor].randomWaypointMobility(config);
        %
        %   Note: Case not config data is given, the function uses default
        %         values
        %
    if (nargin > 1) 
              settings = struct('V_POSITION_X_INTERVAL', config.POSITION_X_INTERVAL,...
                 'V_POSITION_Y_INTERVAL', config.POSITION_Y_INTERVAL,...
                 'V_SPEED_INTERVAL', config.SPEED_INTERVAL,...
                 'V_PAUSE_INTERVAL', config.PAUSE_INTERVAL ,...
                 'V_WALK_INTERVAL', config.WALK_INTERVAL,...
                 'V_DIRECTION_INTERVAL', config.DIRECTION_INTERVAL,...
                 'SIMULATION_TIME', config.SIMULATION_TIME,...
                 'NB_NODES', config.NUMBER_OF_USERS);   
             else
              settings = struct('V_POSITION_X_INTERVAL', obj.POSITION_X_INTERVAL,...
                 'V_POSITION_Y_INTERVAL', obj.POSITION_Y_INTERVAL,...
                 'V_SPEED_INTERVAL', obj.SPEED_INTERVAL,...
                 'V_PAUSE_INTERVAL', obj.PAUSE_INTERVAL ,...
                 'V_WALK_INTERVAL', obj.WALK_INTERVAL,...
                 'V_DIRECTION_INTERVAL', obj.DIRECTION_INTERVAL,...
                 'SIMULATION_TIME', obj.SIMULATION_TIME,...
                 'NB_NODES', obj.NUMBER_OF_USERS);        
    end
        mobility_model = randomWaypointHelper(settings);
    end
        
        
    end
end

