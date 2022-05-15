%% Name: Lachlan Reynolds
%% Date: January 30, 2020
%% Student Number: 14511638
%% Ellipsoid Surface 
%%Parameters: Scaling Parameters for 3D ellipsoid , a,b,c

%%Returns: Approximate surface area

%%Purpose: plots ellipsoid and calculates surface area
function surface_Area=ellipsoid_surface(a,b,c)

% Plot Ellipsoid
N = 30;
theta = linspace(0,2*pi,N);
phi = linspace(0,pi,N);
[THETA,PHI] = meshgrid(theta,phi);
X = a*sin(PHI) .* cos(THETA);
Y = b*sin(PHI) .* sin(THETA);
Z = c*cos(PHI);
surf(X,Y,Z);
grid ON;
axis equal;

% Calculate surface area integral
f = @(x,y) sqrt((1-((1-(c^2/a^2)).*(x.^2/a^2)) -  ((1-(c^2/b^2))*(y.^2/b^2)))./(1-(x.^2/a^2)-(y.^2/b^2)));
ymax = @(x) b.*sqrt(1-(x.^2/a^2));
surface_Area=8*integral2(f,0,a,0,ymax);

end
