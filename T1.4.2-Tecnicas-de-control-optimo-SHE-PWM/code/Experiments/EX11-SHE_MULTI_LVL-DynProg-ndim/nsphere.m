function [W] = nsphere(dim,ntheta,nphi)


    %%% Create the matrix of weigths by choosing points in the unit ball
    dphi = 2*pi/nphi;
    phi = linspace(0, 2*pi-dphi, nphi);
    phi_ms = [];
    dtheta = pi/ntheta;
    for idim = 1:dim-2
        theta{idim} = linspace(dtheta,pi-dtheta,ntheta);
        theta_ms{idim} = [];
    end

    [theta_ms{:},phi_ms] = ndgrid(theta{:},phi);

    senos = 0*phi_ms + 1;

    for i = 1: dim-2
        x{i} = senos.*cos(theta_ms{i});
        senos = senos.*sin(theta_ms{i});
    end

    x{dim-1} = senos.*cos(phi_ms);
    x{dim} = senos.*sin(phi_ms);


    W = reshape(cat(dim,x{:}),ntheta^(dim-2)*nphi,dim);

end

