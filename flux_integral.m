%%Name: Lachlan Reynolds
%%Date: February 26, 2021
%%Student Number: 14511638
%% Function: tri_surface_area
% Inputs: 
%...T: matrix of vertex indicies of triangulation
%...X: vector of x-coords of vertices
%...Y: vector of y-coords of vertices
%...Z: vector of z-coords of vertices
%...F: Function handle defining vector fielt

% Outputs
%...total_flux: flux integral of the vector field F over the surface
% with triangluation points T

% Purpose
% Compute the flux integral

function total_flux= flux_integral(T,X,Y,Z,F)

%Flux Calculation

%Initialize as 0
total_flux=0;
for i=1:length(T)
    
    %Triangle Vectors
    A= [X(T(i,1)) Y(T(i,1)) Z(T(i,1))];
    B= [X(T(i,2)) Y(T(i,2)) Z(T(i,2))];
    C= [X(T(i,3)) Y(T(i,3)) Z(T(i,3))];
    
    %Determine Centroid vector
    P(i,:)=(A+B+C)./3;
   
    %Area and Normal Vector (pre-normalizing)
    n(i,:)=cross((B-A),(C-A));
    A_i=.5*norm(cross((B-A),(C-A)));

    %Iterate total_flux and normalize if normal vector is non-zero
    if norm(n(i,:))~=0
        n(i,:)=cross((B-A),(C-A))/norm(n(i,:));
        
        %Upward Normal
        if n(i,3)<0
            n(i,:)=-1*n(i,:); 
        end
        
        %Iterate
        total_flux=total_flux+((dot(F(P(i,1),P(i,2),P(i,3)),n(i,:)))*A_i);

    end
end

%Vector Fields at each Centroid
V=F(P(:,1),P(:,2),P(:,3));

%Plot Surface and Vector Field
trimesh(T,X,Y,Z);
hold on;

%Vector Field Vectors
quiver3(P(:,1),P(:,2),P(:,3),V(:,1),V(:,2),V(:,3));

%Normal Vectors
quiver3(P(:,1),P(:,2),P(:,3),n(:,1),n(:,2),n(:,3));
axis image;
grid on;

end
