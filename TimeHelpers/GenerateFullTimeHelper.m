function mobility =  GenerateFullTimeHelper(obj,data)


    v_t = 0:conf.SIMULATION_TIME; %tempo de simulacao v_t = 0:600;
    
    for i = 1:data.s_mobility.NB_NODES
        % Simple interpolation (linear) to get the position, anytime.
        % Remember that "interp1" is the matlab function to use in order to
        % get nodes' position at any continuous time.

        vs_node(i).v_x = interp1(data.s_mobility.VS_NODE(i).V_TIME,data.s_mobility.VS_NODE(i).V_POSITION_X,v_t,'ppval')';
        vs_node(i).v_y = interp1(data.s_mobility.VS_NODE(i).V_TIME,data.s_mobility.VS_NODE(i).V_POSITION_Y,v_t,'ppval')';
        vs_node(i).v_velocity = interp1(data.s_mobility.VS_NODE(i).V_TIME,data.s_mobility.VS_NODE(i).V_SPEED_X,v_t,'ppval')';
       
        fprintf('calculating %d\n',i);
        
    end
    mobility = vs_node;
end