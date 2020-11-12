%%
% SHE via Chebyshev polynomials - quarter wave symmetry
% 
% modulates the 1st harmonic and set the 3rd, 5th and 7th to zero.
%
% REFERENCE: Janabi et al. - Generalized Chudnovsky algorithm for real-time
% PWM Selective Harmonic Elimination/Modulation: two-level VSI example

clear all

[data,Ma,n] = format2mat_revised('./SHE_2L_4A_TercerHarmEliminado/angles/S_1/2lshe4A_1_Format2L.h');

% data: data from the table of Tecnalia
% Ma: modulation indices
% n: number of switching angles

lMa = length(Ma);  
Vdc = 1;                            % DC-link voltage
b1 = Vdc*Ma;                        % first Fourier coefficient 
b = zeros(lMa,n);
for i = 1:lMa
    b(i,1:size(b1,1)) = b1(:,i)';
end

bTarget = zeros(n,lMa);             % Target
for i = 1:lMa
    bTarget(1,i) = b1(i);
end

alpha = AnglesSHE(b,Vdc);

ErrorAnglesMatr = alpha - data;
ErrorAngles = norm(ErrorAnglesMatr,Inf);

tspan = linspace(0,0.5*pi,1000);
harmonics = [1 3 5 7];
bFun = zeros(lMa,n);

for i = 1:lMa
    fvalues = angles2fspanNEW(alpha(i,:),tspan);
    [~,bn] = f2anbnNEW(fvalues,tspan,0,harmonics);
    bFun(i,:) = bn';
end
bFun = bFun';

bAngles = zeros(lMa,n);
for i = 1:lMa
    for k = 1:n
        bAngles(i,k) = (-4*Vdc/(k*pi))*(1+2*sum(((-1).^(1:n)).*cos(k*alpha(i,:))));
    end
end
bAngles = bAngles';

bData = zeros(lMa,n);
for i = 1:lMa
    for k = 1:n
        bData(i,k) = (-4*Vdc/(k*pi))*(1+2*sum(((-1).^(1:n)).*cos(k*data(i,:))));
    end
end
bData = bData';

close all

figure(1)

subplot(2,2,1)
surf(ErrorAnglesMatr)
title('Angles difference')

subplot(2,2,2)
for i = 1:lMa
    plot(ErrorAnglesMatr(i,:))
    hold on
end
title('Angles difference')

subplot(2,2,3)
surf(bFun-bTarget)
title('Fourier coefficients difference')

subplot(2,2,4)
for i = 1:lMa
    plot(bFun(:,i)-bTarget(:,i))
    hold on
end
title('Fourier coefficients difference')

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.9, 0.9])





