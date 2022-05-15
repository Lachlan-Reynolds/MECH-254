%%Name: Lachlan Reynolds
%%Date: February 6, 2021
%%Student Number: 14511638
%% Function: gradient_ascent
% Inputs: 
%...f, vectorized function handle (of 2 variables)
%...R, rectangle in xy plane (vector of length 4)
%...start, x and y coord of starting point (vector of length 2)
%...h, derivative approximator value
%...alpha, step size
%...tol, tolerance (ie stops if grad(f) w/in tolerance)
%...max_iter, maximum number of iterations before algorithm forced to stop

% Outputs
%...xmax, ymax, zmax: x,y,z coordinates of local max found by algorithm
%...total_time, time taken by the algorithm to final local max
%...n_iter, number of iterations performed by algorithm

% Purpose
%Plots surface z=f(x,y)
%Plots contour of z=f(x,y)
%Finds the local maximum and outputs it

function [xmax,ymax,zmax,total_time,n_iter]=gradient_ascent(f,R,start,h,alpha,tol,max_iter)

%Start Count 
tic;
tstart=tic;


colormap parula;

%Initiate x_0 and y_0 
X_guess=start(1);
Y_guess=start(2);

for n_iter=0:1:max_iter

    %Compute grad(f)
    f_x=(f(X_guess+h,Y_guess)-f(X_guess-h,Y_guess))/(2*h);
    f_y=(f(X_guess,Y_guess+h)-f(X_guess,Y_guess-h))/(2*h);
    
    %Tolerance Condition
    tolCond=sqrt(f_x^2+f_y^2);
    
    %3D plot
    subplot(1,2,1)
    x=R(1):alpha:R(2);
    y=R(3):alpha:R(4);
    [X,Y]=meshgrid(x,y);
    Z=f(X,Y);
    
    surf(X,Y,Z)
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal;
    grid ON;
    hold ON;
    Z_guess=f(X_guess,Y_guess);
    
    plot3(X_guess,Y_guess,Z_guess, 'r.');
    
    %2D Contour Plot
    subplot(1,2,2)
    hold ON;
    axis equal;
    contour(X,Y,Z);
    xlabel('x');
    ylabel('y');
    c=colorbar;
    plot(X_guess,Y_guess,'r.');
    
    if tolCond<tol
        break;
    end
    
    %Interate x and y guess
    X_guess=X_guess +alpha*f_x;
    Y_guess=Y_guess +alpha*f_y;
end

%Calculate D
f_xx=(f(X_guess+h,Y_guess)-2*f(X_guess,Y_guess)+f(X_guess-h,Y_guess))/(h^2);
f_yy=(f(X_guess,Y_guess+h)-2*f(X_guess,Y_guess)+f(X_guess,Y_guess-h))/(h^2);
f_xy=(f(X_guess+h,Y_guess+h)-f(X_guess-h,Y_guess+h)-f(X_guess+h,Y_guess-h)+f(X_guess-h,Y_guess+h))/(4*h^2);
D=f_xx*f_yy-f_xy^2;

%Test for max and saddle point
if tolCond<tol
    
    %Max Found
    if D>0
        xmax=X_guess; ymax=Y_guess; zmax=Z_guess;
        total_time=toc(tstart);
        disp(['Found local maximum in ', num2str(total_time), ' seconds and  ', num2str(n_iter), ' iterations ']);
        ans=[xmax ymax zmax];
    end
    
    %Saddlepoint Found
    if D<0
        xmax=NaN; ymax=NaN; zmax=NaN;
        total_time=toc(tstart);
        disp(['Found saddlepoint in ', num2str(total_time), ' seconds and  ', num2str(n_iter), ' iterations ']);
        ans=[xmax ymax zmax];        total_time=toc(tstart);

    end
    
%Max Iterations reached
else
    xmax=NaN; ymax=NaN; zmax=NaN;
    disp('No local max or saddlepoint found within maximum iterations');
    ans=[xmax ymax zmax];
      
end


end
