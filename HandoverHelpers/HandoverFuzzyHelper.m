% Function Handover_Fuzzy
% Description: calculate the number of Handovers based on dynamic fuzzy
% threhsold

function  handoverOut = HandoverFuzzyHelper( varargin )

RSRP_femto_macro = varargin{1}{1,1};
RSRQ_femto_macro = varargin{1}{1,2};
SINR_femto_macro = varargin{1}{1,3};
initial_cell = varargin{1}{1,4};
initial_cell_RSRQ = varargin{1}{1,5};
initial_cell_SINR = varargin{1}{1,6};
index_initial_cell = varargin{1}{1,7};
index_initial_cell_RSRQ = varargin{1}{1,8};
index_initial_cell_SINR = varargin{1}{1,9};
mobility = varargin{1}{1,10};
fuzzyModel = varargin{1}{1,11};

load(fuzzyModel);
hys =  2; %The hysteresis value for handover in (db)

         
  femto_macro = RSRP_femto_macro;

for i=1:length(RSRP_femto_macro) 
 test = cell2mat(femto_macro(i));   
   t = size(test); 
    for k = 1: t(1) %k counter
        for m=1:t(2) %m counter
    ind(k,m) = m; %gera indice referente a posicao
        end
    end
    indexes_femto_macro(i,1) = {ind}; %indexes only repeated values
    indexes_femto_macro_RSRQ(i,1) = {ind}; %fuzzy input- (Vel, RSRP, RSRQ)
    indexes_femto_macro_SINR(i,1)={ind}; %indexes sinr

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
hpp=0;
hand_counter =0;
ind_1 = 2;
    ind_2 = 3;
    ind_3 = 4;
    ind_4 = 5;
while(i<=length(initial_cell))
  user = cell2mat(femto_macro(i)); %RSRP
  user_rsrq = cell2mat(RSRQ_femto_macro(i)); %RSRQ
  user_sinr= cell2mat(SINR_femto_macro(i)); %SINR
  
  velocity = mobility(i).v_velocity; %get the velocity from the mobility map
  velocity = repmat(velocity,[1 202]); %only to manage the matrixes with different sizes (repmat)
  
  ind_user = cell2mat(indexes_femto_macro(i)); %RSRP
  ind_user_RSRQ = cell2mat(indexes_femto_macro_RSRQ(i)); %RSRQ
  ind_user_SINR = cell2mat (indexes_femto_macro_SINR(i)); %SINR
  
  s_usuario = size(user); 
  initial = initial_cell(i); %the serving_cell values for each user RSRP
  initial_rsrq = initial_cell_RSRQ(i); %the serving_cell values for each user RSRQ
  initial_sinr= initial_cell_SINR(i); %the serving_cell values for each user SINR
  
  ind_initial =      index_initial_cell(i); %only the initial index for each RSRP
  ind_initial_rsrq = index_initial_cell_RSRQ(i); %RSRQ
  ind_initial_sinr = index_initial_cell_SINR(i); %SINR
  
  current = initial; %only one value
  current_rsrq = initial_rsrq; %RSRQ
  current_sinr= initial_sinr; %SINR
  
  ind_current = ind_initial; %only one index RSRP
  ind_current_rsrq = ind_initial_rsrq; %RSRQ
  ind_current_sinr = ind_initial_sinr; %SINR
  
  output = evalfis([velocity(1,1);initial;initial_rsrq],FuzzyController2); 
  
  for j=1:s_usuario(1)
        for k = 1:s_usuario(2)
        neighbor = user(j,k); %RSRP
        neighbor_rsrq = user_rsrq(j,k); %RSRQ
        neighbor_sinr = user_sinr(j,k); %SINR
        
        ind_neighbor = k; %RSRP
        ind_neighbor_rsrq = k; %RSRQ
        ind_neighbor_sinr =k; %SINR
        
        aux = current + hys;
        if(neighbor > aux && aux < output) %FuzzyInitial_cell
            current = neighbor; %RSRP
            current_rsrq = neighbor_rsrq; %RSRQ
            current_sinr= neighbor_sinr; %SINR
            output = evalfis([velocity(j,k);current;current_rsrq],FuzzyController2); % calculate fuzzy 
            
            if(ind_current ~= ind_neighbor) %only for indexes
            hand_counter = hand_counter + 1; %handover counter
            end
            
            ind_current = ind_neighbor; %RSRP
            ind_current_rsrq = ind_neighbor_rsrq; %RSRQ
            ind_current_sinr= ind_neighbor_sinr; %SINR
        end
        out_rsrp(j,k) = current; %Valores do RSRP das servingcell
        out_rsrq(j,k)= current_rsrq; %Valores do RSRQ das servingcell
        out_sinr(j,k)= current_sinr; %Valores do SINR das servingcell
        out_fuzzy(j,k) = output; %Fuzzy
        
        n_ind(j,k) = ind_current; %RSRP
        n_ind_rsrq(j,k) = ind_current_rsrq;%RSRQ
        n_ind_sinr(j,k) = ind_current_sinr; %SINR
    end
    
        if(p < s_usuario(1))            
            current = user(p+1,ind_current); %RSRP
            current_rsrq = user_rsrq(p+1,ind_current_rsrq); %RSRQ
            current_sinr= user_sinr(p+1,ind_current_sinr); %SINR
            p=p+1; 
        end
  end
  
  %HANDOVER PING PONG
  %TOS=2000ms; TimeOfStay
  %After HO, calcula N de HPP(ping pong handovers) and nHPP (nao ping pong)
    s_ind_handover = size(n_ind);
     
    for g=1:s_ind_handover(1)
     ind_c = n_ind(g,1);
    
     if(ind_c ~= n_ind(ind_1,1) ) 
         if( ind_c == n_ind(ind_2 , 1))
             hpp = hpp+1;
         end
         if(ind_c == n_ind(ind_3,1) && n_ind(ind_1 , 1) == n_ind(ind_2 , 1))
                hpp = hpp+1;
         end
     end
     if(ind_1 <= s_ind_handover(1)-1)
      ind_1 = ind_1+1; 
     end
     if(ind_2 <= s_ind_handover(1)-1)
      ind_2 = ind_1+1; 
     end
     if(ind_3 <= s_ind_handover(1)-1)
      ind_3 = ind_2+1; 
     end
              
    end
    
  %TODAS AS SAIDAS  
  total_hpp(i,1) = hpp;  %Total Number of ping pong HO
  threshold_fuzzy(i,1) = {out_fuzzy}; %all OptThrehsold for each user in each second
  
  out_handover_rsrp(i,1) = {out_rsrp}; % allservingRSRP
  out_handover_rsrq(i,1)= {out_rsrq}; % allservingRSRQ
  out_handover_sinr(i,1)={out_sinr}; % allservingSINR
  
  n_handover_fuzzy(i,1) = hand_counter; %Number of handover with fuzzy algorithm per user
  ind_handover_fuzzy(i,1) = {n_ind}; %indice de handover RSRP
  ind_handover_rsrq(i,1) = {n_ind_rsrq}; %indice de handover RSRQ
    ind_1 = 2;
    ind_2 = 3;
    ind_3 = 4;
  hand_counter = 0;
  p=1;
  hpp=0;
  i=i+1;
  if(i>length(initial_cell))
    break;
  end
end
handoverOut = struct('TOTAL_HPP',total_hpp , 'THRESHOLD_FUZZY',threshold_fuzzy,...
    'OUT_HANDOVER_RSRP',out_handover_rsrp,'OUT_HANDOVER_SINR',out_handover_sinr, ...
    'OUT_HANDOVER_RSRQ',out_handover_rsrq,'INDEX_HANDOVER_FUZZY',ind_handover_fuzzy,'INDEX_HANDOVER_RSRQ', ind_handover_rsrq, ...
    'NUMBER_HANDOVER_FUZZY', n_handover_fuzzy);
toc
end
