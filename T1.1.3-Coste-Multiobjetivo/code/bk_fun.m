function result = bk_fun(n,fspan,tspan)
    T  = 2*tspan(end);
    wn = n*2*pi/T;
     %
    result = (2/T)*trapz(tspan,cos(wn*tspan).*fspan);
end