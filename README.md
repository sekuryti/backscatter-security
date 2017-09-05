# backscatter-security
## This file contains backscatter data read, data decode, data trace, data cut and define;
## data_read 
### Represents we plot the figures using matlab according to backscatter data from USRP;
## data_decode
### Represents backscatter data decoding at received end. Here, we sent data series "01010011", I have ploted the decoding figures using square wave;
## data_trace 
### Represents the data trace when we moving the attenna on body;
## data_cut 
### Represents we cut the backscatter data according to the data trace. Here, I used the slope of the trace to determine the states of the antenna. If the slopes have large changes, it means that we have moved the antenna. 
## define 
### Represents the function that can determine whether the received data is from on-body tag or not. Here I use the threshold as 4db which cite from the paper "Analytical Propagation Modeling of BAN Channels Based on the Creeping-Wave Theory".
## Attention
### In this file , when using define.m, I have to use the data type as "double", because these data files is from the oringinal data after cutting.
