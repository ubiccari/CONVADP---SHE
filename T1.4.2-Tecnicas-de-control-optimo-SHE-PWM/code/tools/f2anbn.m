function [an,bn] = f2anbn(fvalues,tspan,Na,bharmonics)

    
    anfcn = @(f,n) (2/pi)*trapz(tspan,cos(n*tspan).*f);
    bnfcn = @(f,n) (2/pi)*trapz(tspan,sin(n*tspan).*f);


    an = zeros(Na,1);
    for n = 1:Na
       an(n) = anfcn(fvalues,n);
    end
  
    Nb = length(bharmonics);
    bn = zeros(Nb,1);
    for n = 1:Nb
       bn(n) = bnfcn(fvalues,bharmonics(n));
    end
    
end

