% RSRP- Reference Signal Received Power
% Description: the average received power of a single RS resource element
% Function to calculate the RSRP in dbm and watts for all enbs and femtocells. 
%
% Input--- 
% data => dados carregados de arquivo .mat
% femtos => matriz com a posição X,Y das femtos
%
% Output--- 
% RSRP_femto => RSRP das femtos em dBm 
% RSRP_femto_w => RSRP das femtos em Watts
% dists => distâncias calculadas do usuário até as femtos
% perdas => perdas calculadas para cada femto  dados os usuários
%
% Example: 
% data = load('data_mat/Mapa_mobilidade.mat');
% [RSRP_femto RSRP_femto_w dists perdas] = rsrp(data,femtos);
%
% Obs.: Para alterar os parametros de configuração utilizar o arquivo
% config.m
%
function [RSRP_femto, RSRP_femto_w, dists_femtos, loss_femtos] = rsrp_femtosHelper(data,femtos, config)

conf = config;
r=data;
n_users = length(r);
px = {r.v_x }'; % Posicoes X de todos os usuarios
py = {r.v_y }'; % Posicoes Y de todos os usuarios

i=1;
while(i <= n_users)
    % Todas as distâncias calculadas de todos os usuários em todas as suas
    % posições até as femtos
    %for j=1:length(femtos) %de 1 ate todas as femtos
    dists_femtos(i) = {dist_euclidiana([ cell2mat(px(i)) cell2mat(py(i))],femtos)};
    % Calculo das perdas do usuário até a femto   
    loss_femtos(i) = {PathLoss1238(conf.TYPE_OF_BUILDING,conf.OP_FREQUENCY,cell2mat(dists_femtos(1,i)), conf.NUMBER_OF_FLOORS_BUILDING)};
    %perdas_femtos(i) = {femto_pathloss(cell2mat(dists_femtos(1,i)))}; MODEL femto_pathloss
    i=i+1;
end
% Transposta das distâncias e perdas
dists_femtos = dists_femtos';
loss_femtos = loss_femtos';


for i = 1:n_users
     RSRP_femto(i) = { conf.getPowerHenbFemtoDbm() + conf.GAIN_TX_FEMTO - cell2mat(loss_femtos(i))}; %RSRP in dBm
     RSRP_femto_w(i) = {10.^(cell2mat(RSRP_femto(i))./10)/1000}; % RSRP in Watts   
end

RSRP_femto = RSRP_femto';
RSRP_femto_w = RSRP_femto_w';
end
    
