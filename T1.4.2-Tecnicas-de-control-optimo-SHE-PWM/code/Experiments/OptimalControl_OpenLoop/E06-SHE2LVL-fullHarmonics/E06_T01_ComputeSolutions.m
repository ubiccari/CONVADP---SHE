import casadi.*

clear all;

%% Take bn for modulation index
bvalues = linspace(-1,+1,200);
%bmatrix = zeros(length(bvalues),length(harmonics));
%bmatrix(:,1) = bvalues;
%%
Nt = 300;
Lterms = {@(f) +f    , ...
          @(f) -f   };
Lnames = {'OCP-plus','OCP-minus'};
      %Lterms = {@(f) f.^2.*cos(7*pi*f)};

harmonics = {[1 3 5 7 9],
             [1 5 7 9 11],
             [1 7 9 11 13]
             [1 3 9 13 17]};

jter = 0;
for ih = harmonics'
    bmatrix = zeros(length(bvalues),length(ih{:}));
    bmatrix(:,1) = bvalues;

    jter = jter +1;
    iter = 0;
    fconstraints = [-1,1];
    for Lterm = Lterms
        iter = iter + 1;
        [S,ftraj] = SHE2OCP_4SYM(ih{:}',Lterm{:},Nt);
        fopts = SolveOCP_4SYM_range(bmatrix,S,ftraj,Nt,fconstraints);
        ylabelstring = '$\beta_1$';
        titlestring = "{ "+num2str(ih{:})+" } | "+Lnames{iter};
        figure
        plotRes_4SYM(ih{:},bmatrix,bvalues,fopts,Nt,ylabelstring,titlestring)
        path = replace(replace(replace(titlestring,'  ','-'),'}',''),'{','');
        path = replace(path,' ','')+"-"+Lnames{iter}+".png";
        path = "pics/S0002/"+path;
        saveas(gcf,path,'png')

    end
end
%%
%ylabelstring = '$\beta_1 = \beta_2$';
%plotRes_4SYM(harmonics,bmatrix,bvalues,fopts,Nt,ylabelstring)
%%
