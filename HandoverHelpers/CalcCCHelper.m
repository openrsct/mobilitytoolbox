%Funcao para calcular indice CC
%Algoritmo Fuzzy Topsis-FMCSS

%Step-1:Normalize the data usingfor the benefit criteria and cost criteria.
%(eq14):Rij=xij-(min{xij})/(max{xij}-min{xij})
%(eq15):Rij=(max{xij}-xij)/(max{xij}-min{xij}) 

function [cc_current, cc_neighbor] = CalcCCHelper(config , varargin)
inputs = varargin;
current = inputs{1}{1,1};
neighbor = inputs{1}{1,2};
current_sinr = inputs{1}{1,3};
neighbor_sinr = inputs{1}{1,4};
neighbor_channel = inputs{1}{1,5};
current_channel = inputs{1}{1,6};

%atribuir os min e max de cada criterio
tmin = config.RSRP_MIN;
tmax = config.RSRP_MAX;
%Channel
cmin = config.CHANNEL_CAPACITY_MIN;
cmax = config.CHANNEL_CAPACITY_MAX;
%SINR
smin = config.SINR_MIN;
smax = config.SINR_MAX;


%normaliza as matrizes com os criterios
norm_rsrp_current = abs( (current-tmin)/(tmax-tmin) ); %rsrp- beneficio atual
norm_rsrp_neighbor = abs( (neighbor-tmin)/(tmax-tmin) ); %rsrp- beneficio vizinha

norm_channel_current = abs( (current_channel-cmin)/(cmax-cmin) ); %channel beneficio atual
norm_channel_neighbor = abs( (neighbor_channel-cmin)/(cmax-cmin) ); %channel beneficio vizinha

norm_sinr_current = abs( (smax - current_sinr)/( smax-smin) ); %sinr custo atual
norm_sinr_neighbor = abs( (smax - neighbor_sinr)/( smax-smin) ); %sinr custo vizinha

%concantenacao da matriz com os 3 criterios e chamada da funcao mapCC para
%pegar a normalizada e transformar em valores linguisticos

[aux1_current,aux2_current,aux3_current] = config.mapChannelCapacity(norm_rsrp_current,norm_sinr_current,norm_channel_current);
[aux1_neighbor,aux2_neighbor,aux3_neighbor] = config.mapChannelCapacity(norm_rsrp_neighbor,norm_sinr_neighbor,norm_channel_neighbor);

%Step 5: Compute the Euclidean distance (separation measures) of each alternative from A+ and A?
% fuzzy negative ideal (FPIS A+)
dist_current_pos =  sqrt(0.333*sum((1-cell2mat(aux1_current)).^2))  + sqrt(0.333*sum((1-cell2mat(aux2_current)).^2))  +sqrt(0.333*sum((1-cell2mat(aux3_current)).^2));
dist_neighbor_pos = sqrt(0.333*sum((1-cell2mat(aux1_neighbor)).^2)) + sqrt(0.333*sum((1-cell2mat(aux2_neighbor)).^2)) +sqrt(0.333*sum((1-cell2mat(aux3_neighbor)).^2));

% fuzzy negative ideal (FPIS A-)
dist_current_neg =  sqrt(0.333*sum((0-cell2mat(aux1_current)).^2))  + sqrt(0.333*sum((0-cell2mat(aux2_current)).^2))  +sqrt(0.333*sum((0-cell2mat(aux3_current)).^2));
dist_neighbor_neg = sqrt(0.333*sum((0-cell2mat(aux1_neighbor)).^2)) + sqrt(0.333*sum((0-cell2mat(aux2_neighbor)).^2)) +sqrt(0.333*sum((0-cell2mat(aux3_neighbor)).^2));

%Step 6: Calculate the closeness coefficient or similarities to an ideal solution
%CC= dNeg/dPos+dNeg; %para cada alternativa (nosso caso cada antena)
 
cc_current = dist_current_neg/(dist_current_pos + dist_current_neg); %coef atual
cc_neighbor = dist_neighbor_neg/(dist_neighbor_pos + dist_neighbor_neg); %coef vizinha

end
