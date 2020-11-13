%%
% SHE via Chebyshev polynomials - quarter wave symmetry
% 
% modulates the 1st harmonic and set the 3rd, 5th and 7th to zero.
%
% REFERENCE: Janabi et al. - Generalized Chudnovsky algorithm for real-time
% PWM Selective Harmonic Elimination/Modulation: two-level VSI example

clear all

maMin = 0.01;
maMax = 1.05;
Ma = maMin:0.01:maMax;
harmonics = [1 3 5 7];
n = length(harmonics);

lMa = length(Ma);  
Vdc = 1;                            % DC-link voltage
b1 = Vdc*Ma;                        % first Fourier coefficient 
b = zeros(lMa,n);
for i = 1:lMa
    b(i,1:size(b1,1)) = b1(:,i)';
end

[alpha,val,Gdet,r] = AnglesSHE(b,Vdc);

tspan = linspace(0,0.5*pi,1000);

[bNum,Fvalues] = computeFourier(alpha,harmonics,tspan);

error = (bNum-b).^2;

%%
results.maMin = maMin;
results.maMax = maMax;
results.modulation = Ma;
results.harmonics = harmonics;
results.target = b;
results.targetNumerical = bNum;
results.error = error;
results.angles = alpha;
results.roots = r;
results.function = Fvalues;


