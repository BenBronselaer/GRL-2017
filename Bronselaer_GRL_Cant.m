% script to plot ocean anthropogenic carbon given a given history of
% anthropogenic Co2
% from Bronselaer et. al. 2017
clear



% The steps to calculate ocean anthropogenic carbon from an atmospheric CO2
% history are as follows:
% 1. Calculate the emissions needed to produce the given atmopsheric CO2
% history by adjusting emission profile 
% 2. Calculate ocean, atmospheric and land carbon by convolving the
% emission profile with the respective impulse response functions






% Start date
tstart = 1765;
% End date;
tend = 2011;
% Date to fix atmospheric pCO2
tfix = 1860;






%%

% prepare impulse response functions and data
t0 = 1:4000;

% load mean atmospheric carbon impulse response function parameters from climate models, from Joos et. al. 2003
load PI100fit_atm
% Pre-industrial parameters (where the pulse of carbon is introduced in
% 1850 conditions)
I=x(1)+x(2)*exp(-t0/x(3))+x(4)*exp(-t0/x(5))+x(6)*exp(-t0/x(7))+x(8)*exp(-t0/x(9))+x(10)*exp(-t0/x(11));
% Contemporary parameters (where the pulse of carbon is introduced in the
% year 2015 in a historical simulation) - not used here
I2 = 0.2173+0.2240*exp(-t0/394.4)+0.2824*exp(-t0/36.54)+0.2763*exp(-t0/4.304);

clear x
% load mean oceanic carbon impulse response function parameters from climate models, from Joos et. al. 2003
load PI100fit
% Pre-industrial parameters (where the pulse of carbon is introduced in
% 1850 conditions)
Io=x(1)+x(2)*exp(-t0/x(3))+x(4)*exp(-t0/x(5))+x(6)*exp(-t0/x(7))+x(8)*exp(-t0/x(9))+x(10)*exp(-t0/x(11));
% Contemporary parameters (where the pulse of carbon is introduced in the
% year 2015 in a historical simulation) - not used here
Io2 = 60.29-26.48*exp(-t0/390.5)-17.45*exp(-t0/100.5)-16.35*exp(-t0/4.551);
% load mean land carbon impulse response function parameters from climate
% models, from Joos et. al. 2003 for pre-industrial carbon pulse
Il=17.07+332.1*exp(-t0/74.76)-334.1*exp(-t0/70.31)-15.09*exp(-t0/6.139);

% convert units
I=I/100;
Io=Io/100;
Io2=Io2/100;
Il=Il/100;



% read in atmospheric CO2 history 
M = csvread('spline_merged_ice_core_yearly.csv',28,0);
atm0 = zeros(1,(tend-tstart));
atm0(1:(tfix-tstart)) = M(tstart:tfix-1,2)-M(tstart-1,2);

atm0((tfix-tstart):end) = atm0((tfix-tstart));

% in Ptg of C
atm_c = 2.13.*atm0;

%%

% Step 1
% make initial guess for emission history
atm_e = 2.13.*([diff(atm0) (atm0(end)-atm0(end-1))]);
for t1 = 1:(tend-tstart)
    
   F = conv(I,atm_e,'full'); 
    atm = F;
    
    
     while atm(t1) >= (atm0(t1)+0.01)
     
     atm_e(t1) = atm_e(t1)-0.01;
     F = conv(I,atm_e,'full'); 
    atm = F;
     end
     

     while atm(t1) <= (atm0(t1)-0.01)
    atm_e(t1) = atm_e(t1)+0.01;
    F = conv(I,atm_e,'full'); 
    atm = F;
     end
 
    
end
E1860 = atm_e;
%%

% Step 2
% convolve emissions with impulse response functions
Fo1860 = conv(Io,E1860,'full');
Fl1860 = conv(Il,E1860,'full');
Fa1860 = conv(I,E1860,'full');




%%



T0 = tstart:tend;


h=figure(1);

hold on
plot(T0,Fo1860(1:max(size(T0))),'color',[0.5 	0.7 1],'linewidth',4)
plot(T0,2.13*Fa1860(1:max(size(T0))),'color',[1 0.5 0.8],'linewidth',4)
plot(T0,Fl1860(1:max(size(T0))),'color',[0.3 1 0.6],'linewidth',4)
legend('Ocean','Atmosphere','Land');
xlim([tstart tend])
set(gca,'fontsize',22,'linewidth',2)
title('Anthropogenic carbon')
ylabel('Pg C')
xlabel('Year')
%set(h,'position',[ 216    80   884   618])



return
%%
