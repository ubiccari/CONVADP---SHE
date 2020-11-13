function [bFun,Fvalues] = computeFourier(alpha,harmonics,tspan)

[lMa,n] = size(alpha);
bFun = zeros(lMa,n);
Fvalues = zeros(lMa,length(tspan));

for i = 1:lMa
    fvalues = angles2fspanNEW(alpha(i,:),tspan);
    Fvalues(i,:) = fvalues;
    [~,bn] = f2anbnNEW(fvalues,tspan,0,harmonics);
    bFun(i,:) = bn';
end


