% Given a model (V,T,F,b,load)
%       Do computation and save the result
%
function compute_and_save(outputdir, pathtomodel)
    status = mkdir(outputdir);
    [meshname,V,T,F,bnds,load] = model_load(pathtomodel);
    
    % compute for different solvers

    max_iters = 1000;
    tol = 1e-30;
    saveon = (1:1:max_iters)';

    % % SOR
    % solvername = 'sor';
    % for omega = 1:0.2:2
    %     linearsolver = @(A,b) sor(A,b,zeros(size(b)),max_iters,tol, ...
    %         'Omega',omega, 'SaveOn',saveon);
    %     [U,K,f,strain,stress,VM,Bs,C,data] = linelas3d_tetrahedron(V,T,bnds,load, ...
    %         'LinearSolver', linearsolver);

    %     outputmat = strcat(outputdir,meshname,'_',solvername,num2str(omega),'.mat');
    %     save(outputmat, ...
    %         'pathtomodel', ...
    %         'solvername', ...
    %         'omega', ...
    %         'max_iters', ...
    %         'tol', ...
    %         'saveon', ...
    %         'U','K','f','strain','stress','VM','Bs','C','data');
    %     fprintf('Saving outputs to %s\n', outputmat);
    % end
    
    % % w-jacobi
    % solvername = 'jacobi';
    % for omega = [0:0.08:0.4 0.6 0.8 1]
    %     linearsolver = @(A,b) jacobi(A,b,zeros(size(b)),max_iters,tol, ...
    %         'Omega',omega, 'SaveOn',saveon);
    %     [U,K,f,strain,stress,VM,Bs,C,data] = linelas3d_tetrahedron(V,T,bnds,load, ...
    %         'LinearSolver', linearsolver);

    %     outputmat = strcat(outputdir,meshname,'_',solvername,num2str(omega),'.mat');
    %     save(outputmat, ...
    %         'pathtomodel', ...
    %         'solvername', ...
    %         'omega', ...
    %         'max_iters', ...
    %         'tol', ...
    %         'saveon', ...
    %         'U','K','f','strain','stress','VM','Bs','C','data');
    %     fprintf('Saving outputs to %s\n', outputmat);
    % end
    
    % backslash 
    omega = -Inf;       % placeholder ...
    solvername = 'backslash';
    [U,K,f,strain,stress,VM,Bs,C,data] = linelas3d_tetrahedron(V,T,bnds,load);

    outputmat = strcat(outputdir,meshname,'_',solvername,'.mat');
    save(outputmat, ...
        'pathtomodel', ...
        'solvername', ...
        'omega', ...
        'max_iters', ...
        'tol', ...
        'saveon', ...
        'U','K','f','strain','stress','VM','Bs','C','data');
    fprintf('Saving outputs to %s\n', outputmat);
end