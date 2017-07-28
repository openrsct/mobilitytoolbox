classdef MobilityUser
    % MOBILITYUSER - User class definition 
    % 
    % MobilityToolbox v 0.0.1 
    % A project of Open Research Tools  
    %
    % Reference: https://openrsct.github.io/home
    %
    % Description: Defines a single user on a network
    % Author: Igor Amorim Silva
    % Created at: 2017-07-22
    %
    %
    % ~~~~~~~~~~~~~~~~~~ HELP US MAINTAIN THIS PROJECT ~~~~~~~~~~~~~~~~~~~~~
    %
    %  PLEASE DONATE AT => https://openrsct.github.io/mobilitytoolbox             
    %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    properties
    USER_NETWORK_HEADER = 'USER' % Header of user definition for overall use in simulation. Default: 'USER'
    USER_NETWORK_ID % User identification on network.
    USER_AVAILABLE_CONECTIONS % List available HENB or ENB for connection. Cell Array of available connections for each user position 
    USER_CONNECTION_RANGE = 100 % Max allowed range in (meters) for user connection. Default 100 meters.
    USER_SPEED_GROUP % Defines speed group this user belongs
    USER_CURRENT_POSITION % Current position [POSITION_X POSITION_Y] of user
    USER_PATH % User path. Contains cell array {POSITION_X, POSITION_Y, SPEED_X, SPEED_Y}
    end
    
    methods
    
        function available = getAvailableConnections( obj , reference)
            % GETAVAILABLECONNECTIONS - Returns available connections and sets list of connections to matrix os connections  
            % INPUT Params: 
            % * reference - position of ENB or HENB
            %
            % OUTPUT Params:
            % * available - Cell Array of ENB or HENB available for
            % connection
            %% TODO - CREATE HELPER
            % Note1: use function pdist    
        end
    end
    
end

