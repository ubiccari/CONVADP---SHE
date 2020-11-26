import casadi.*

clear all;

%% Take bn for modulation index
bvalues = linspace(0,+1,200);

%%
Nt =100;
Lterms = {@(f) +f   };
Lnames = {'OCP-plus'};

harmonics = {[1 5 17 19 21],
             [1 3],
             [1 5],
             [1 7],
             [1 9],
             [1 3 7],
             [1 3 9],
             [1 5 9],
             [1 5 7]
             [1 3 5 7 9],
             [1 5 7 9 11],
             [1 7 9 11 13]
             [1 3 9 13 17],
             [1 5 7 13 15],
             [1 7 11 15 17]};

 harmonics = {   [1 3],
                 [1 5],
                 [1 7],
                 [1 9] };

jter = 0;
for ih = harmonics'
    bmatrix = zeros(length(bvalues),length(ih{:}));
    bmatrix(:,1) = bvalues;

    jter = jter +1;
    iter = 0;
    fconstraints = [0,1];
    for Lterm = Lterms
        iter = iter + 1;
        [S,ftraj] = SHE2OCP_4SYM(ih{:}',Lterm{:},Nt);
        [fopts,x_opt] = SolveOCP_4SYM_range(bmatrix,S,ftraj,Nt,fconstraints);
        ylabelstring = '$\beta_1$';
        titlestring = "{ "+num2str(ih{:})+" } | "+Lnames{iter};
        figure
        plotRes_4SYM(ih{:},bmatrix,bvalues,fopts,Nt,ylabelstring,titlestring)
        path = replace(replace(replace(titlestring,'  ','-'),'}',''),'{','');
        path = replace(path,' ','')+"-"+Lnames{iter};
        pathdata = "pics/S0004/data/"+path;
        path = "pics/S0004/imgs/"+path+'.png';
        saveas(gcf,path,'png')
        save(pathdata,'fopts','fconstraints','harmonics','bvalues','bmatrix','x_opt')

    end
end
%%
%ylabelstring = '$\beta_1 = \beta_2$';
%plotRes_4SYM(harmonics,bmatrix,bvalues,fopts,Nt,ylabelstring)
%%
