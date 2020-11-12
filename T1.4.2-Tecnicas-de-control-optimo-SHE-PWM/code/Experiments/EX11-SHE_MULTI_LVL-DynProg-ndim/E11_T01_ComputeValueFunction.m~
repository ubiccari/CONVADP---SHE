
clear all;
%% Take a values of modulation index 

%% Create Solver

harmonics = [1 3]';
Dim = length(harmonics);
%% Digital Control
Nfs = 2;
fspan = linspace(-1,1,Nfs);
%% time discretization
Nt = 10;
tspan = linspace(0,pi/2,Nt);
%% NN

layer = [    imageInputLayer([Dim 1 1])
             
             fullyConnectedLayer(10)
             reluLayer
             
             fullyConnectedLayer(2)
             softmaxLayer
             classificationLayer ];
%
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'Verbose',true, ...
    'Plots','none');

%%
er = 1e-3;

Ndata = 200;

b_data = rand(Ndata,Dim);

VT_data = 0.5*sum(b_data.^2,2);
VT_data = (VT_data < er);

plot(b_data(:,1),b_data(:,2),'.')
