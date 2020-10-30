clear 

%% Extraemos las formas de onda para las soluciones S_1, S_2, S_3, S_4
for j=1:4
    name_folder = ['/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/angles/S_',num2str(j)];
    name_file = '/2lshe5A_1_Format2L.h';
    %
    [data,IdxMod,nangles]  = format2mat(fullfile(name_folder,name_file));

    Nt = 199;
    tspan = linspace(0,pi/2,Nt);
    %
    fvalues{j} = zeros(length(IdxMod),Nt);
    for i = 1:length(IdxMod)
    alphas = data(i,:);

    fvalues{j}(i,:) = angles2fspan(alphas,tspan);
    end

end

%% b1 values 
bvalues = IdxMod/sqrt(3);

save('data/EX01/bvalues','bvalues')