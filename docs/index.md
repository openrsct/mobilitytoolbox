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
    POWER_TX_ENB_DBM = 43;%27/46; dBm Transmitting Power of eNB
    GAIN_TX = 12; %16dBi Antenna Gain
    CABLELOSS = 3; %dB Cable Loss
    NOISE = 0; %w noise
    
    %Parameters of HenB
    POWER_TX_FEMTO =20; %15/23;dBm Transmitting Power of HeNB
    GAIN_TX_FEMTO=2; %2%dBi Antenna Gain
    BW = 25; % Bandwidth, number of RBs => 5 MHz = 25 PRBs  %20Mhz-100RBs
    NOISE_FEMTO = 0; %w Noise

```


#### Class Getters

```matlab

  net = MobilityNetwork; % Constructor of class


  net.getPowerHenbFemtoWatts(); % Returns Power of HENB in Watts

  net.getPowerHenbFemtoDbm(); % Returns Power of HENB in Dbm

  net.getPowerEnbWatts(); % Returns Power of ENB in Watts

  net.getPowerEnbDbm(); % Returns Power of ENB in Dbm

  net.getNumberSubcarriers() % Returns number of subcarriers

  net.getPowerTxWattsFemto() % Returns Power Tx of HENB  in Watts

  net.getPowerTxWatts() % Returns Power Tx of ENB in Watts

  
```

#### Class Setters

```matlab

  net = MobilityNetwork; % Constructor of class


  net.setPowerHenbFemtoWatts(POWER_TX_WATTS , NUMBER_SUBCARRIERS); % Set Power of Henb in Watts

  net.setPowerHenbFemtoDbm(POWER_HENB_FEMTO_WATTS); % Set Power of HENB in Dbm

  net.setPowerEnbWatts(NUMBER_SUBCARRIERS, POWER_TX_WATTS); % Set Power of ENB in Watts

  net.setPowerEnbDbm(POWER_ENB_WATTS); % Set Power of ENB in Dbm

  net.setNumberSubcarriers(BANDWIDTH) % Set number of subcarriers

  net.setPowerTxWattsFemto(POWER_TX_FEMTO) % Set Power Tx of HENB  in Watts

  net.setPowerTxWatts(POWER_TX_ENB_DBM) % Set Power Tx of ENB in Watts

  
```


#### Class Methods

#### Calculate RSRP for HENB

 Returns RSRP of given mobility data for HENB

 **Input:** 

 **data** => Mobility data generated with class MobilityGenerator<br>
 **femtos** => Matrix with "x" and "y" of femtocells (HENB)

 **Output:** 

 **RSRP_femto** => RSRP of femtocells (HENB) in Dbm<br>
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

 **RSRP_macro** => RSRP of macrocells (ENB) in Dbm<br>
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
 **RSRQ_femto_macro** => RSSQ calculated in Dbm


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
 **SINR_femto_macro** => SINR calculated in Dbm


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

(Coming Soon...)