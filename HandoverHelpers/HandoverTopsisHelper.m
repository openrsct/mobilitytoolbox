% Function Handover TOPSIS
% 
%

function output =  HandoverTopsisHelper( obj , varargin )
input = varargin;
RSRP_femto_macro =                    input{1}{1,1};
RSRQ_femto_macro =                    input{1}{1,2};
SINR_femto_macro =                    input{1}{1,3};
ChannelCapacity_femto_macro =         input{1}{1,4};
initial_cell =                        input{1}{1,5};
initial_cell_RSRQ =                   input{1}{1,6};
initial_cell_SINR =                   input{1}{1,7};
initial_cell_ChannelCapacity =        input{1}{1,8};  
index_initial_cell =                  input{1}{1,9};
index_initial_cell_RSRQ =             input{1}{1,10};
index_initial_cell_SINR =             input{1}{1,11};
index_initial_cell_ChannelCapacity =  input{1}{1,12};



hys = obj.HYSTERESIS; %The hysteresis value for handover in (db)
% Qin=-8; %Threshold Qin
% T310=1000ms;

         
  femto_macro = RSRP_femto_macro;
  
for i=1:length(RSRP_femto_macro) 
 test = cell2mat(femto_macro(i));   
   t = size(test); 
    for k = 1: t(1) %k counter
        for m=1:t(2) %m counter
    t(k,m) = m; %gera indice referente a posicao
        end
    end
    indexes_femto_macro(i,1) = {t}; %indexes only repeated values
    indexes_femto_macro_RSRQ(i,1) = {t};
    indexes_femto_macro_SINR(i,1) = {t};
    indexes_femto_macro_ChannelCapacity (i,1) = {t};
end

clear ind;
% 1 - atribuir a serving_cell       1-Do the cell_selection
% 2 - para cada usu�rio             2-For each user
% 3 - come�ar a percorrer a matriz  3-scroll all the matrix
% 3.0 se prox > atual + hys         3.0-If neighbor>current+hys
% 3.1 faz handover                  3.1-handover occurs
% 3.2 cria nova matriz de indice    3.2-generate matrix with new indexes
% 3.3 conectado = atual             3.3-neighbour=current
tic
i=1;
p =1;
hand_counter =0;
HF=0;%Contador de Handover_failure

%Variaveis para o ping pong
tos=2; %Time of stay- Tempo em segundos para analise do ping pong
hpp=0; %Contador de handover ping pong
ind_1 = 2;
ind_2 = 3;
ind_3 = 4;
ind_4 = 5;
ind_5 = 6;
ind_6 = 7;
ind_7= 8;
ind_8= 9;
ind_9= 10;
ind_10= 11;
ind_11= 12;

while(i<=length(initial_cell))
  user = cell2mat(femto_macro(i)); %RSRP
  user_rsrq = cell2mat(RSRQ_femto_macro(i)); %RSRQ
  user_sinr = cell2mat(SINR_femto_macro(i)); %SINR
  user_channel_capacity = cell2mat(ChannelCapacity_femto_macro(i));
  
  ind_user = cell2mat(indexes_femto_macro(i)); %ind_user RSRP
  ind_user_RSRQ = cell2mat(indexes_femto_macro_RSRQ(i)); %ind_user RSRQ
  ind_user_SINR = cell2mat(indexes_femto_macro_SINR(i)); %ind_user SINR
  ind_user_channel_capacity = cell2mat(indexes_femto_macro_ChannelCapacity(i));
  
  s_usuario = size(user);
  initial = initial_cell(i); %RSRP- the serving_cell values for each user
  initial_rsrq = initial_cell_RSRQ(i); % RSRQ -the serving_cell values for each user
  initial_sinr = initial_cell_SINR(i);%SINR -the serving_cell values for each user
  initial_channel = initial_cell_ChannelCapacity(i);
 
  ind_initial = index_initial_cell(i); %only the initial index for each
  ind_initial_rsrq = index_initial_cell_RSRQ(i);
  ind_initial_sinr = index_initial_cell_SINR(i);
  ind_initial_channel = index_initial_cell_ChannelCapacity(i);
  
  current = initial; %only one value
  current_rsrq = initial_rsrq;
  current_sinr = initial_sinr;
  current_channel = initial_channel;
  
  ind_current = ind_initial; %only one index
  ind_current_rsrq = ind_initial_rsrq;
  ind_current_sinr = ind_initial_sinr;
  ind_current_channel = ind_initial_channel;
  
for j=1:s_usuario(1)
        for k = 1:s_usuario(2)
        neighbor = user(j,k);
        neighbor_rsrq = user_rsrq(j,k);
        neighbor_sinr = user_sinr(j,k);
        neighbor_channel = user_channel_capacity(j,k);
        
        ind_neighbor = k;
        ind_neighbor_rsrq = k;
        ind_neighbor_sinr = k;
        ind_neighbor_channel = k;
        
            aux = current + hys;            
            if(neighbor > aux ) %Event HO condition
            
                %calcula o algoritmo fuzzy topsis
                % calcula o cc pra atual e pra vizinha
                
                [cc_current,cc_neighbor] = obj.calculateChannelCapacityTopsis(current,...
                neighbor,...
                current_sinr,...
                neighbor_sinr,...
                current_channel,...
                neighbor_channel);
            
            %condicao do algoritmo topsis: Se cc viz> cc atual= faz HO)
            if( cc_neighbor > cc_current)
                
           
            current = neighbor;
            current_rsrq = neighbor_rsrq;
            current_sinr = neighbor_sinr;
            current_channel = neighbor_channel;
            
           
            if(ind_current ~= ind_neighbor) %only for indexes
            hand_counter = hand_counter + 1; %handover counter
            end
            
                    
            ind_current = ind_neighbor;
            ind_current_rsrq = ind_neighbor_rsrq;
            ind_current_sinr = ind_neighbor_sinr;
            ind_current_channel = ind_neighbor_channel;
            end
            
            end
            
        out_rsrp(j,k) = current; %Tabela atual_conectado RSRP
        out_rsrq(j,k)= current_rsrq; %Tabela atual_conectado RSRQ
        out_sinr(j,k)= current_sinr; %Tabela atual_conectado SINR
        out_channel(j,k)= current_channel;
              
        n_ind(j,k) = ind_current; %ind RSRP
        n_ind_rsrq(j,k) = ind_current_rsrq; %ind RSRQ
        n_ind_sinr(j,k) = ind_current_sinr; %ind SINR
        n_ind_channel(j,k) = ind_current_channel;
    end
    
        if(p < s_usuario(1))            
            current = user(p+1,ind_current);%RSRP
            current_rsrq = user_rsrq(p+1,ind_current_rsrq);%RSRQ
            current_sinr = user_sinr(p+1,ind_current_sinr);%SINR
            current_channel = user_channel_capacity(p+1,ind_current_channel);
            p=p+1; 
        end
         
end
%-------------------CALCULO HANDOVER PING PONG-----------------------------
%After HO, calculate the number of HPP(ping pong handovers) and nHPP
 hpp1 = obj.autoPingPong(n_ind,1);       
 hpp2 = obj.autoPingPong(n_ind,2);    
 hpp3 = obj.autoPingPong(n_ind,3);
 hpp4 = obj.autoPingPong(n_ind,4);
 hpp5 = obj.autoPingPong(n_ind,5);
 hpp6 = obj.autoPingPong(n_ind,6);
 hpp7 = obj.autoPingPong(n_ind,7);
 hpp8 = obj.autoPingPong(n_ind,8);
 hpp9 = obj.autoPingPong(n_ind,9);
 hpp10 = obj.autoPingPong(n_ind,10);

%---------------------FIM HO PING PONG-------------------------------
% % % %-------------------CALCULO HANDOVER PING PONG-----------------------------
% % % %After HO, calculate the number of HPP(ping pong handovers) and nHPP
% % %     s_ind_handover = size(n_ind);
% % %      
% % %     for g=1:s_ind_handover(1)
% % %      ind_c = n_ind(g,1);
% % %     
% % %      if(ind_c ~= n_ind(ind_1,1) ) 
% % %          if( ind_c == n_ind(ind_2 , 1))
% % %              hpp = hpp+1;
% % %          end
% % %          if(ind_c == n_ind(ind_3,1) && n_ind(ind_1 , 1) == n_ind(ind_2 , 1))
% % %                 hpp = hpp+1;
% % %          end
% % %      end
% % %      if(ind_1 <= s_ind_handover(1)-1)
% % %       ind_1 = ind_1+1; 
% % %      end
% % %      if(ind_2 <= s_ind_handover(1)-1)
% % %       ind_2 = ind_1+1; 
% % %      end
% % %      if(ind_3 <= s_ind_handover(1)-1)
% % %       ind_3 = ind_2+1; 
% % %      end
% % %               
% % %     end
% % % 
% % % 
% % % %---------------------FIM HO PING PONG-------------------------------

%-------------------SAIDAS-------------------------------------------
 out_handover_rsrp_TOPSIS(i,1) = {out_rsrp}; %AllServing_RSRP during simulation
 out_handover_rsrq_TOPSIS(i,1)= {out_rsrq}; %Allserving_RSRQ during simulation
 out_handover_sinr_TOPSIS(i,1)= {out_sinr}; %Allserving_SINR during simulation
 out_handover_channel_TOPSIS(i,1) = {out_channel};
 
 Total_HO_TOPSIS(i,1) = hand_counter; %TotalNumber of HO per user
 handover_failure_TOPSIS(i,1)=HF; %Total Number of HO failure per user
  
 ind_handover_TOPSIS(i,1)={n_ind}; %Out_all_indices_RSRP
 ind_handover_rsrq_TOPSIS(i,1) = {n_ind_rsrq}; %Out_all_indices_RSRQ
 ind_handover_sinr_TOPSIS(i,1) = {n_ind_sinr};%Out_all_indices_SINR

% % %  Total_HPP_TOPSIS(i,1) = hpp;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_1(i,1) = hpp1;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_2(i,1) =  hpp2;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_3(i,1) =  hpp3;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_4(i,1) =  hpp4;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_5(i,1) =  hpp5;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_6(i,1) =  hpp6;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_7(i,1) =  hpp7;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_8(i,1) =  hpp8;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_9(i,1) =  hpp9;  %Total Number of HO ping pong
 Total_HPP_TOPSIS_10(i,1) = hpp10;  %Total Number of HO ping pong

 hand_counter = 0;
 HF=0;
 p=1;
 
%---------------------Calculo Falha de Handover----------------------------  
%Etapa que quantifica as Falhas de Handover 

ser = cell2mat(out_handover_sinr_TOPSIS(i));
t = cell2mat(ind_handover_TOPSIS(i));
h=1;
hp=0;
s = length(ser);
while(h<s)
   
    if(t(h,1) ~= t(h+1,1))
    if(ser(h+1,1) <= -8)
    hp = hp+1;
    end
    end
    
h=h+1;    
end
Total_HF_TOPSIS(i,1) = hp; %Numero de falha para cada user
hp=0;

%---------------------FIM Falha de Handover----------------------------  
%---------------------Contadores de HO ping pong---------------------------
 hpp=0;
ind_1 = 2;
ind_2 = 3;
ind_3 = 4;
ind_4 = 5;
ind_5 = 6;
ind_6 = 7;
ind_7= 8;
ind_8= 9;
ind_9= 10;
ind_10= 11;
ind_11= 12;

i=i+1;
  if(i>length(initial_cell))
    break;
  end
  
end
% % % %---------------------Calculate the number of No Ping-Pong HO--------------
% % % Total_HnPP_TOPSIS = Total_HO_TOPSIS - Total_HPP_TOPSIS; %Numero de Nao PIng pong para cada User
% % % 
% % % toc

%---------------------Calculate the number of No Ping-Pong HO--------------
Total_HnPP_TOPSIS_1 = Total_HO_TOPSIS - Total_HPP_TOPSIS_1; %Numero de Nao PIng pong para cada User
Total_HnPP_TOPSIS_2 = Total_HO_TOPSIS - Total_HPP_TOPSIS_2;
Total_HnPP_TOPSIS_3 = Total_HO_TOPSIS - Total_HPP_TOPSIS_3;
Total_HnPP_TOPSIS_4 = Total_HO_TOPSIS - Total_HPP_TOPSIS_4;
Total_HnPP_TOPSIS_5 = Total_HO_TOPSIS - Total_HPP_TOPSIS_5;
Total_HnPP_TOPSIS_6 = Total_HO_TOPSIS - Total_HPP_TOPSIS_6;
Total_HnPP_TOPSIS_7 = Total_HO_TOPSIS - Total_HPP_TOPSIS_7;
Total_HnPP_TOPSIS_8 = Total_HO_TOPSIS - Total_HPP_TOPSIS_8;
Total_HnPP_TOPSIS_9 = Total_HO_TOPSIS - Total_HPP_TOPSIS_9;
Total_HnPP_TOPSIS_10 = Total_HO_TOPSIS - Total_HPP_TOPSIS_10;


Total_HPP_TOPSIS =[Total_HPP_TOPSIS_1,Total_HPP_TOPSIS_2,Total_HPP_TOPSIS_3,Total_HPP_TOPSIS_4,...
    Total_HPP_TOPSIS_5,Total_HPP_TOPSIS_6,Total_HPP_TOPSIS_7,Total_HPP_TOPSIS_8,...
    Total_HPP_TOPSIS_9,Total_HPP_TOPSIS_10];
Total_HnPP_TOPSIS = [Total_HnPP_TOPSIS_1,Total_HnPP_TOPSIS_2,Total_HnPP_TOPSIS_3,Total_HnPP_TOPSIS_4,...
    Total_HnPP_TOPSIS_5,Total_HnPP_TOPSIS_6,Total_HnPP_TOPSIS_7,Total_HnPP_TOPSIS_8,...
    Total_HnPP_TOPSIS_9,Total_HnPP_TOPSIS_10];


output = struct('OUT_HANDOVER_RSRP',out_handover_rsrp_TOPSIS, ...
                'OUT_HANDOVER_SINR',out_handover_sinr_TOPSIS, ...
                'OUT_HANDOVER_RSRQ', out_handover_rsrq_TOPSIS, ...
                'INDEX_HANDOVER_RSRP', ind_handover_TOPSIS,  ...
                'INDEX_HANDOVER_SINR', ind_handover_sinr_TOPSIS, ...
                'INDEX_HANDOVER_RSRQ', ind_handover_rsrq_TOPSIS, ...
                'TOTAL_HANDOVER_COUNT', Total_HO_TOPSIS, ...
                'TOTAL_HANDOVER_FAILURE', Total_HF_TOPSIS, ...
                'TOTAL_HANDOVER_PING_PONG_TOPSIS', Total_HPP_TOPSIS, ...
                'TOTAL_NOT_HANDOVER_PING_PONG_TOPSIS', Total_HnPP_TOPSIS);
toc
end
