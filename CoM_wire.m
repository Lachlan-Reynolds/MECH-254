%% Name: Lachlan Reynolds
%% Date: January 25, 2020
%% Student Number: 14511638
%% CM_Points: 
% Parameters: x, y, z, which are the x,y,z coordinates of a wire

% Returns: x_cm, y_cm, z_cm, m_tot, which are x,y,z coordinates of COM
% point wire and total mass

% Purpose: Compute COM and total mass, plot figure and the COM 
function [x_cm,y_cm,z_cm,m_tot] = cm_wire(x,y,z,rho,plot_figure)

x1 = x(1:length(x)-1);
x2 = x(2:length(x));
y1 = y(1:length(y)-1);
y2 = y(2:length(y));
z1 = z(1:length(z)-1);
z2 = z(2:length(z));

Li = sqrt(diff(x).^2+diff(y).^2+diff(z).^2);

p1 = rho(1:length(rho)-1);
p2 = rho(2:length(rho));
m = Li.*(pi+p2)/2;

ri_cm = [x1 y1 z1]+1/3*(p1+2*p2)./(p1+p2).*[(x2 - x1) (y2 - y1) (z2 - z1)];
[x_cm,y_cm,z_cm,m_tot] = cm_points(ri_cm(:,1), ri_cm(:,2),ri_cm(:,3),m, "n");

if plot_figure == 'y'
    plot3(x,y,z,'b.', 'MarkerSize', 2);
    axis equal;
    hold on;
    plot3(x_cm,y_cm,z_cm,'r.','MarkerSize', 20);
    title('Centre of Mass of a Wire Figure');
end
end
