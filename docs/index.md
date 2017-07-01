---
layout: default
---

# Mobility Toolbox V 0.0.1

---

### **Description**

This toolbox is a set of classes for generation and analysis of mobility data on Matlab. The aim o the toolbox is to provide easy generation and analysis of mobility data. 

### **Current operations supported**

Here is a list of current operations supported by the tool:

* Generation:
 1. Random Waypoint Mobility Model

---

* Analysis:
 1. RSRP (Reference Signal Received Power)
 2. RSSI (Received Signal Strength Indicator)
 3. SINR (Signal to Interference plus Noise Ratio )
 4. RSRQ (Reference Signal Received Quality)

---

* Compute:
 1. Handover A3 event
 2. Handover Opportunistic
 3. Handover Fuzzy (with Matlab Fuzzy toolbox)
 4. Handover TOPSIS 

---

## Usage
> Note: Each class or function has **doc** or **help** methods built-in. To use, just type **doc** or **help** and [name of class or function].
* Example 1: doc MobilityGenerator
* Example 2: help MobilityGenerator

## Author Notes:

1. For convention a **cell** refers to a HENB or ENB while **Cell** refers to the Matlab Cell data type.


###  Generate Mobility data
```matlab
% Generate data

generator = MobilityGenerator;  % constructor of class

config = struct( 'POSITION_X_INTERVAL', [0 1000] ,... % Interval x axis on meters
                 'POSITION_Y_INTERVAL', [0 1000],... % Interval y axis on meters
                 'SPEED_INTERVAL', [0 2.78],... % Speed interval for user in m/s
                 'PAUSE_INTERVAL', [0 0] ,... % After some distance user pauses on location
                 'WALK_INTERVAL', [30 90] ,... % Time interval user spends on place
                 'DIRECTION_INTERVAL', [0 360] ,... % Angle direction allowed for user
                 'SIMULATION_TIME', 900 ,...      % Time in seconds
                 'NUMBER_OF_USERS', 100); % Number of users

mobility_model = generator.randomWaypointMobility( config );
```

> Note: Case configuration struct not given, returns mobility data with default values.

### Configuring Mobility Network Class
The network class exposes a series of properties that can be configured and accessed in two ways.

1. Using Getters and Setters.
2. Setting directly the value to a property. (In this case some properties require the use of setters because they need to be evaluted)

#### Class Properties

Here is a list of the public properties of the MobilityNetwork class:
 
```matlab
    TYPE = 'OO'; % type of communication 
    CITY_SIZE = 'M'; %Size of city- Medium
    OPERATIONAL_FREQUENCY = 2000; %Operational frequency 2Ghz
    HEIGHT_BS = 30; %height of BS
    HEIGHT_MS = 1.5; %height of MS
    WALL_WINDOW_LOSS = 10; %Wall/Window loss
    %Pathloss- Parameters of femto
    TYPE_OF_BUILDING = 'R'; %type of building 
    OP_FREQUENCY = 2000; %Operational frequency 2000Mhz
    NUMBER_OF_FLOORS_BUILDING = 1;
    %Parameters of eNB
    RESOURCE_BLOCK = 25;%5mhz-25;resource block 
    POWER_TX_ENB_DBm = 43;%27/46; DBm Transmitting Power of eNB
    GAIN_TX = 12; %16dBi Antenna Gain
    CABLELOSS = 3; %dB Cable Loss
    NOISE = 0; %w noise
    
    %Parameters of HenB
    POWER_TX_FEMTO =20; %15/23;DBm Transmitting Power of HeNB
    GAIN_TX_FEMTO=2; %2%dBi Antenna Gain
    BW = 25; % Bandwidth, number of RBs => 5 MHz = 25 PRBs  %20Mhz-100RBs
    NOISE_FEMTO = 0; %w Noise

```


#### Class Getters

```matlab

  net = MobilityNetwork; % Constructor of class


  net.getPowerHenbFemtoWatts(); % Returns Power of HENB in Watts

  net.getPowerHenbFemtoDBm(); % Returns Power of HENB in DBm

  net.getPowerEnbWatts(); % Returns Power of ENB in Watts

  net.getPowerEnbDBm(); % Returns Power of ENB in DBm

  net.getNumberSubcarriers() % Returns number of subcarriers

  net.getPowerTxWattsFemto() % Returns Power Tx of HENB  in Watts

  net.getPowerTxWatts() % Returns Power Tx of ENB in Watts

  
```

#### Class Setters

```matlab

  net = MobilityNetwork; % Constructor of class


  net.setPowerHenbFemtoWatts(POWER_TX_WATTS , NUMBER_SUBCARRIERS); % Set Power of Henb in Watts

  net.setPowerHenbFemtoDBm(POWER_HENB_FEMTO_WATTS); % Set Power of HENB in DBm

  net.setPowerEnbWatts(NUMBER_SUBCARRIERS, POWER_TX_WATTS); % Set Power of ENB in Watts

  net.setPowerEnbDBm(POWER_ENB_WATTS); % Set Power of ENB in DBm

  net.setNumberSubcarriers(BANDWIDTH) % Set number of subcarriers

  net.setPowerTxWattsFemto(POWER_TX_FEMTO) % Set Power Tx of HENB  in Watts

  net.setPowerTxWatts(POWER_TX_ENB_DBm) % Set Power Tx of ENB in Watts

  
```


#### Class Methods

#### Calculate RSRP for HENB

 Returns RSRP of given mobility data for HENB

 **Input:** 

 **data** => Mobility data generated with class MobilityGenerator<br>
 **femtos** => Matrix with "x" and "y" of femtocells (HENB)

 **Output:** 

 **RSRP_femto** => RSRP of femtocells (HENB) in DBm<br>
 **RSRP_femtos_w** => RSRP of femtocells (HENB) in Watts<br>
 **dists_femtos** => Calculated euclidean distance of user to HENB in each second<br>
 **loss_femtos** => Pathloss of cells to user


```matlab

net = MobilityNetwork; % Constructor of class

[RSRP_femto, RSRP_femto_w, dists_femtos, loss_femtos] = net.rsrpFemtos( data , femtos );  

```

#### Calculate RSRP for ENB

 Returns RSRP of given mobility data for ENB

 **Input:** 

 **data** => Mobility data generated with class MobilityGenerator<br>
 **macros** => Matrix with "x" and "y" of macrocells (ENB)

 **Output:** 

 **RSRP_macro** => RSRP of macrocells (ENB) in DBm<br>
 **RSRP_macro_w** => RSRP of macrocells (ENB) in Watts<br>
 **dists_macro** => Calculated euclidean distance of user to ENB in each second<br>
 **loss_macro** => Pathloss of cells to user


```matlab

net = MobilityNetwork; % Constructor of class

[RSRP_macro_w, RSRP_macro, dists_macro, loss_macro] = net.rsrpMacros(data,macro); 

```

#### Calculate RSSI 

 Returns RSSI of given RSRP

 **Input:** 

 **RSRP_femto_macro_w** => Concatented RSRP matrix of ENB and HENB  in Watts

 **Output:** 

 **Prxtotal** => Total Power Rx<br>
 **RSSI_femto_macro_w** => RSSI of data


```matlab

net = MobilityNetwork; % Constructor of class

[Prxtotal, RSSI_femto_macro_w] = net.rssi( RSRP_femto_macro_w); 

```

#### Calculate RSRQ 

 Returns RSRQ of given RSRP and RSSI in Watts

 **Input:** 

 **RSRP_femto_macro_w** => Concatented RSRP matrix of ENB and HENB<br>
 **RSSI_femto_macro_w** => Concatented RSSI matrix of ENB and HENB    

 **Output:** 

 **RSRQ_femto_macro_w** => RSRQ calculated in Watts<br>
 **RSRQ_femto_macro** => RSSQ calculated in DBm


```matlab

net = MobilityNetwork; % Constructor of class

[RSRQ_femto_macro_w,RSRQ_femto_macro] = net.rsrq( RSRP_femto_macro_w , RSSI_femto_macro_w); 

```

#### Calculate SINR 

 Returns SINR of given RSRP and RSSI in Watts

 **Input:** 

 **RSRP_femto_macro_w** => Concatented RSRP matrix of ENB and HENB<br>
 **Prxtotal** => Total Power Rx    

 **Output:** 

 **SINR_femto_macro_w** => SINR calculated in Watts<br>
 **SINR_femto_macro** => SINR calculated in DBm


```matlab

net = MobilityNetwork; % Constructor of class

[SINR_femto_macro_w,SINR_femto_macro] = net.sinr( RSRP_femto_macro_w , Prxtotal)

```


#### Calculate Channel Capacity

 Calculate the throughput in the Shannon-Hartley theorem for channel capacity
 **Input:** 

 **SINR_femto_macro_w** => Concatented SINR matrix of ENB and HENB<br>
 **out_handover_sinr_op** => SINR of Handover Opportunistic result   

 **Output:** 

 **channel_capacity** => Throughput calculated (per user)<br>
 

```matlab

net = MobilityNetwork; % Constructor of class

channel_capacity = net.channelCapacity( SINR_femto_macro_w , out_handover_sinr_OP)

```
### Class Connection

This class inherites from MobilityNetwork.

#### Class Properties

```matlab

  LIMITER => limit the number of HENB visible per user

```

#### Class Methods

#### Get user connections with RSRP

**Input:** 

 **RSRP_femto** => RSRP of HENB in DBm. Calculated with MobilityNetwork lass <br>
 **RSRP_macro** => RSRP of ENB in DBm. Calculated  with MobilityNetwork class  <br>
 **RSRP_femto_w** => RSRP of HENB in Watts.   <br>
 **RSRP_macro_w** => RSRP of ENB in DBm. Calculated  with MobilityNetwork class <br>

 **Output:** 

**indexes_femto_macro** => Cell Matrix of original positions of values for each user<br>
**conected_femto_macro** => Cell Matrix RSRP in DBm values sorted<br>
**indexes_femto_macro_w** => Cell Matrix of original positions of values for each user<br>
**conected_femto_macro_w** => Cell Matrix RSRP in Watts values sorted for each user<br>


```matlab

  conn = MobilityConnection; % Class constructor
  
  % Function that returns for each second the best RSRP sorting the matrix with all macro and femtocells

  [indexes_femto_macro, conected_femto_macro, indexes_femto_macro_w, conected_femto_macro_w ] = conectionsRSRP(RSRP_femto , RSRP_macro,RSRP_femto_w , RSRP_macro_w)

```


#### Select initial connected cell of user given RSRP

**Input:** 

 **connected_femto_macro** => Cell Matrix RSRP in DBm values sorted <br>

 **indexes_femto_macro** => RSRP of HENB in DBm. Calculated with MobilityNetwork lass <br>

 **Output:** 

**initia_cell** => Cell Matrix of original positions of values for each user<br>
**index_initial_cell** => Cell Matrix RSRP in DBm values sorted<br>



```matlab
  %   Select the most appropriate cell for a UE to camp
  %   Camp on servingcell- The cell with the highest RSRP in the measurement set
  [initial_cell, index_initial_cell] = conn.cellSelectionRSRP(conected_femto_macro, indexes_femto_macro)  
```


#### Get user connections with SINR

**Input:** 

 **SINR_femto_macro** => SINR of ENB and HENB in DBm. Calculated with MobilityNetwork lass <br>


 **Output:** 

**indexes_femto_macro_SINR** => Cell Matrix of original positions of values for each user<br>
**conected_femto_macro_SINR** => Cell Matrix SINR in DBm values sorted for each user<br>


```matlab

  conn = MobilityConnection; % Class constructor
  
  % Function that returns for each second the best SINR sorting the matrix with all macro and femtocells
[indexes_femto_macro_SINR, conected_femto_macro_SINR] = conn.conectionsSINR(SINR_femto_macro)
  

```


#### Select initial connected cell of user given SINR

**Input:** 

 **connected_femto_macro** => Cell Matrix SINR in DBm values sorted <br>

 **indexes_femto_macro** => SINR of HENB in DBm. Calculated with MobilityNetwork lass <br>

 **Output:** 

**initia_cell** => Cell Matrix of original positions of values for each user<br>
**index_initial_cell** => Cell Matrix SINR in DBm values sorted<br>



```matlab
  %   Select the most appropriate cell for a UE to camp
  %   Camp on servingcell- The cell with the highest SINR in the measurement set
  [initial_cell, index_initial_cell] = conn.cellSelectionSINR(conected_femto_macro, indexes_femto_macro)  
``` 

#### Get user connections with RSRQ

**Input:** 

 **RSRQ_femto_macro** => RSRQ of ENB and HENB in DBm. Calculated with MobilityNetwork lass <br>


 **Output:** 

**indexes_femto_macro_RSRQ** => Cell Matrix of original positions of values for each user<br>
**conected_femto_macro_RSRQ** => Cell Matrix RSRQ in DBm values sorted for each user<br>


```matlab

  conn = MobilityConnection; % Class constructor
  
  % Function that returns for each second the best RSRQ sorting the matrix with all macro and femtocells
[indexes_femto_macro_RSRQ, conected_femto_macro_RSRQ] = conn.conectionsRSRQ(RSRQ_femto_macro)
```


#### Select initial connected cell of user given RSRQ

**Input:** 

 **connected_femto_macro_RSRQ** => Cell Matrix RSRQ in DBm values sorted <br>

 **indexes_femto_macro_RSRQ** => RSRQ of HENB in DBm. Calculated with MobilityNetwork lass <br>

 **Output:** 

**initia_cell** => Cell Matrix of original positions of values for each user<br>
**index_initial_cell** => Cell Matrix RSRQ in DBm values sorted<br>



```matlab
  %   Select the most appropriate cell for a UE to camp
  %   Camp on servingcell- The cell with the highest RSRQ in the measurement set
  [initial_cell, index_initial_cell] = conn.cellSelectionRSRQ(conected_femto_macro_RSRQ, indexes_femto_macro_RSRQ); 
```   

#### Get user connections with Channel Capacity

**Input:** 

 **ChannelCapacity_femto_macro** => Channel Capacity of ENB and HENB. Calculated with MobilityNetwork lass <br>


 **Output:** 

**indexes_femto_macro_ChannelCapacity** => Cell Matrix of original positions of values for each user<br>
**conected_femto_macro_ChannelCapacity** => Cell Matrix of Channel Capacity values sorted for each user<br>


```matlab

  conn = MobilityConnection; % Class constructor
  
  % Function that returns for each second the best Channel Capacity sorting the matrix with all macro and femtocells
[indexes_femto_macro_ChannelCapacity, conected_femto_macro_ChannelCapacity] = conn.conectionsChannelCapacity(ChannelCapacity_femto_macro);
```


#### Select initial connected cell of user given Channel Capacity

**Input:** 

 **conected_femto_macro_ChannelCapacity** => Cell Matrix Channel Capacity values sorted <br>

 **indexes_femto_macro** => Channel Capacity of HENB in DBm. Calculated with MobilityNetwork lass <br>

 **Output:** 

**initia_cell** => Cell Matrix of original positions of values for each user<br>
**index_initial_cell** => Cell Matrix Channel Capacity values sorted<br>



```matlab
  %   Select the most appropriate cell for a UE to camp
  %   Camp on servingcell- The cell with the highest Channel Capacity in the measurement set
  [initial_cell, index_initial_cell] = cellSelectionChannelCapacity(obj,conected_femto_macro_ChannelCapacity, indexes_femto_macro);  
```   



### Class Handover

This class inherites from MobilityNetwork.

#### Class Properties

```matlab
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

```

#### Class Methods

#### Calculate Handover A3 Event

**Input**

**RSRP_femto_macro**  => Calculated RSRP in DBm. <br><br>
**RSRQ_femto_macro**  => Calculated RSRQ in DBm.<br><br>
**SINR_femto_macro**  => Calculated SINR in DBm.<br><br>
**initial_cell_RSRP**  => Values of RSRP user initially connected.  <br><br>
**initial_cell_RSRQ**  => Values of RSRQ user initially connected. <br><br>
**initial_cell_SINR**  => Values of SINR user initially connected. <br><br>
**index_initial_cell_RSRP**  => Original positions connected RSRP <br><br>
**index_initial_cell_RSRQ**  => Original positions connected RSRQ <br><br>
**index_initial_cell_SINR**  => Original positions connected SINR <br><br>

**Output**

**handoverOut** => Struct with evaluated data

> Data description of handoverOut:

OUT_HANDOVER_RSRP  => RSRP values where a handover was counted <br><br>
OUT_HANDOVER_RSRQ  => RSRQ values where a handover was counted <br><br>
OUT_HANDOVER_SINR  => SINR values where a handover was counted <br><br>
INDEX_HANDOVER_RSRP => Index of HENB or ENB on RSRP atrix where user made handover <br><br>
INDEX_HANDOVER_SINR => Index of HENB or ENB on SINR atrix where user made handover <br><br>
INDEX_HANDOVER_RSRQ => Index of HENB or ENB on RSRQ atrix where user made handover  <br><br>
TOTAL_HANDOVER_COUNT => Total number of handovers for each users <br><br>
TOTAL_HANDOVER_FAILURE => Total number of handover failure for each user   <br><br>
TOTAL_HANDOVER_PING_PONG => Total number of handover ping pong <br><br>
TOTAL_NOT_HANDOVER_PING_PONG => Total number of handover not ping pong  <br><br>


| OUT_HANDOVER_RSRP | OUT_HANDOVER_RSRQ| OUT_HANDOVER_SINR | INDEX_HANDOVER_RSRP | INDEX_HANDOVER_SINR |  INDEX_HANDOVER_RSRQ | TOTAL_HANDOVER_COUNT | TOTAL_HANDOVER_FAILURE | TOTAL_HANDOVER_PING_PONG | TOTAL_NOT_HANDOVER_PING_PONG | 
|-------------------|---------------------|---------------------|---------------------|---------------------|-------------------|---------------------|--------------------|--------------------------|------------------------------|
| Cell Array| Cell Array| Cell Array| Cell Array| Cell Array| Cell Array| Cell Array| Cell Array| Cell Array| Cell Array|

```matlab
hand = MobilityHandover; % Class constructor;

handoverOut = hand.handoverA3(Input); % Cited variables in input

```

#### Calculate handover with Fuzzy 

Documentation Soon.


#### Calculate handover with TOPSIS 

Documentation Soon.


#### Calculate handover with CRE 

Documentation Soon.