function [V] = E10_ComputeValueFunction()


harmonics = [1 3 5]';
Ns = {10 ,20 ,30};
dim = length(Ns);

Reshapes = diag([Ns{:}]); 
Reshapes(Reshapes == 0) = 1;

for idim = 1:dim
    bT_span{idim} = linspace(-1,1,Ns{idim});
    Linspaces{idim} = 1:Ns{idim};
end

%
Nf = 2;
f_span = linspace(-1,1,Nf);

Nt = 4;
T = pi/2;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);
%%

%%
V = zeros(Ns{:},Nt);
%
for idim = 1:dim 
    term = reshape(bT_span{idim},Reshapes(idim,:));
    V(Linspaces{:},Nt) = V(Linspaces{:},Nt) + 0.5*term.^2;
end
%V(V<1e-4) = 0;
for it = (Nt-1):-1:1
    
    for idim = 1:3
        bTn_ms{idim} = bT_span{idim} - dt*sin(f_span'*harmonics(idim)*tspan(it));
        [~,ind_ms{idim}] = min(abs(bTn_ms{idim} - bT_span{idim}));
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for ifs = 1:Nf
        ind1_ms_fs = reshape(ind1_ms(:,:,ifs),N2,1);
        ind2_ms_fs = reshape(ind2_ms(:,:,ifs),N1,1);
    
        Vf{ifs}  = V(ind1_ms_fs,ind2_ms_fs,it+1);
     
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    V(:,:,it) = min(cat(3,Vf{:}),[],3);

end


end

