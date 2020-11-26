clear 
figure(1)
clf
ylabelstring = '$b_1^T$';
ts = '';

figure(1)
clf
load('/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/pics/S0003/data/1-5-7-11-13|OCP-plus-OCP-plus.mat')
plotRes_4SYM_several(harmonics{:},bmatrix,bvalues,fopts,ylabelstring,ts)

figure(2)
clf
load('/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/pics/S0003/data/1-5-7-11-13|OCP-minus-OCP-minus.mat')
plotRes_4SYM_several(harmonics{:},bmatrix,bvalues,fopts,ylabelstring,ts)



figure(3)
clf
load('/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/pics/S0003/data/1-5-7-11-13|OCP-sq-OCP-sq.mat')
plotRes_4SYM_several(harmonics{:},bmatrix,bvalues,fopts,ylabelstring,ts)