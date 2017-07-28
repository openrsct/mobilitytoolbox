% RSRP: Reference Signal Received Power
% Description: Function to calculate the average received power of a single RS resource element
% EIRP (Equivalent Isotropically Radiated Power)is the actual amount of signal leaving the antenna 
% and is a value measured in db and is based on 3 values:
%a) Transmit Power (dBm)
%b) Cable Loss (dB)
%c) Antenna Gain (dBi)
% RSRP = EIRP (dBm) - Loss

% <Transmit Power> - Cable Loss + Antenna Gain = EIRP
% 
% Input---
% data => dados carregados de arquivo .mat
% macro => matriz com a posição X,Y das macro
%
% Output---
% RSRP_macro_w => RSRP of macrocell in (watts)
% RSRP_macro => RSRP of macrocells in (dBm)
% dists => the calculated distance of UE to macrocell
% perdas => the calculated loss for each macrocell
%
% Example: 
% data = load('data_mat/Mapa_mobilidade.mat');
% [RSRP_femto RSRP_macro_w dists perdas] = rsrp_macro(data,macro);
%
% Obs.: To modify the parameters of configuration use the function
% 'config.m'
%
% 
function [RSRP_macro_w, RSRP_macro, dists_macro, loss_macro] = rsrp_macroHelper(data,macro, config)
conf = config;

r = data;
n_users = length(r);
px = {r.v_x }'; % Posicoes X de todos os usuarios
py = {r.v_y }'; % Posicoes Y de todos os usuarios


i=1;
while(i <= n_users)
    % Todas as distâncias calculadas de todos os usuários em todas as suas
    % posições até as femtos
    
    dists_macro(i) = {dist_euclidiana([ cell2mat(px(i)) cell2mat(py(i))],macro)};
    
    % Calculo das perdas do usuário até a macro
    loss_macro(i) = {PathLossOH(conf.TYPE, conf.CITY_SIZE, conf.OP_FREQUENCY,cell2mat(dists_macro(1,i)), conf.HEIGHT_BS, conf.HEIGHT_MS, conf.WALL_WINDOW_LOSS)};
    % perdas_macro(i) = {SUI_path_loss(cell2mat(dists_macro(1,i)))};
    i=i+1;
end

dists_macro = dists_macro';
loss_macro = loss_macro';

for i = 1:n_users
     RSRP_macro(i) = { conf.getPowerEnbDbm() + conf.GAIN_TX - cell2mat(loss_macro(i))}; %RSRP in dBm
     RSRP_macro_w(i) = {10.^(cell2mat(RSRP_macro(i))./10)/1000}; % RSRP in Watts   
end
RSRP_macro = RSRP_macro';
RSRP_macro_w = RSRP_macro_w';
end
    
