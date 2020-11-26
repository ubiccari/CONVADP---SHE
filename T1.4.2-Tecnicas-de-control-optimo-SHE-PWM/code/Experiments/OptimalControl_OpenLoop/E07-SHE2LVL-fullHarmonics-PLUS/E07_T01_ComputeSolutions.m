import casadi.*

clear all;

%% Take bn for modulation index
bvalues = linspace(-1,+1,200);

%%
Nt =100;
Lterms = {@(f)    };
Lnames = {'OCP-sq'};

harmonics = {[1 5 7 11 13]};

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
        [fopts,x_opt] = SolveOCP_4SYM_range(bmatrix,S,ftraj,Nt,fconstraints);
        % plots
        ylabelstring = '$\beta_1$';
        titlestring = "{ "+num2str(ih{:})+" } | "+Lnames{iter};
        figure
        variation = (pi/4)*bvalues;
        plotRes_4SYM(ih{:},bmatrix,variation,fopts,ylabelstring,titlestring)
        path = replace(replace(replace(titlestring,'  ','-'),'}',''),'{','');
        path = replace(path,' ','')+"-"+Lnames{iter};
        % save
        pathdata = "pics/S0003/data/"+path;
        path = "pics/S0003/imgs/"+path+'.png';
        %saveas(gcf,path,'png')
        %save(pathdata,'fopts','fconstraints','harmonics','bvalues','bmatrix','x_opt')

    end
end
%%
%ylabelstring = '$\beta_1 = \beta_2$';
%plotRes_4SYM(harmonics,bmatrix,bvalues,fopts,Nt,ylabelstring)
%%
