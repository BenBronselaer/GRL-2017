# GRL-2017
Code for Bronselaer et. al. 2017 (GRL)


This repository contains the data and MATLAB routine for calculating ocean, atmospheric and land anthropogenic carbon storage 
for a given atmospheric pCO2 history. The methods utilizes impulse response functions to:
1. Calculate the carbon emissions needed to produce the observed atmospheric pCO2 history
2. Convolve the emissions history with the impulse response function for oceanic and land carbon to give the respective
carbon storage in these reservoirs.

The parameters for the impulse response functions are taken from climate model and EMIC carbon pulse experiments from Joos et. al. 2013

In Bronselaer et. al. 2017 (GRL), this technique is used to calculate the oceanic antropogenic carbon inventory in 2011 that
is due to a rise in atmospheric pCO2 prior to 1850. To calculate the oceanic carbon storage in 2011 due to a rise in CO2 from 1765 to 1850, the appropriate atmospheric pCO2 inout profile has the observed atmospheric pCO2 rise from 1765 to 1850, after which time the pCO2 is held constant from 1850 until 2011.

