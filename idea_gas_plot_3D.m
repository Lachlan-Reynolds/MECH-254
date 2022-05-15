function idealGasLaw3DFigurePlot

% Setup the figure
h = 7; % Height in inches
w = 10; % Width in inches
figure('Units','Inches','Position',[ 0 0 w h ]);
set(gcf,'PaperSize', [ w h ],'PaperPositionMode', 'auto');
colormap(jet);



% Plot P-v-T
subplot(2,2,1)

R=287;

Volume=logspace(-3,0,20);
Temp=linspace(0,1000,20);
[X,Y]=meshgrid(Temp,Volume);
Z=1e-6*R*(X+273)./Y;
Pressure=1e-6*R*(Temp+273)./Volume;

surf(X,Y,Z);

xticks([0:200:1000]);
yticks([1e-3 1e-2 1e-1 1e0]);
zticks([0:10:50]);

set(gca,'YScale','log');
set(gca,'YDir','reverse');

xlim([0 1000]);
ylim([1e-3 1]);
zlim([0 50]);

xlabel('Temperature [Celsius]');
ylabel('Specific Volume [m^3/kg]');
zlabel('Pressure [MPa]');

% Plot T-P
subplot(2,2,2)

contourf(X,Z,Y,Volume);
xlabel('T [Celsius]');
ylabel('P [MPa]');
set(gca,'ZScale','linear');
xticks(0:200:1000);
yticks(0:10:50);

c=colorbar;
caxis([0 .1]);
c.Label.String='v [m^3/kg]';
set(c,'YTick',0:0.01:.1);

ylim([0 50]);
xlim([0 1000]);
grid on;

% Plot v-P
subplot(2,2,3)

contourf(Y,Z,X,Temp);
xlabel('v [m^3/kg]');
ylabel('P [MPa]');
set(gca,'ZScale','linear');
set(gca,'XScale','log');
xticks([1e-3 1e-2 1e-1 1e0]);
yticks(0:10:50);

c=colorbar;
caxis([0 1000]);
c.Label.String='T [Celsius]';
set(c,'YTick',0:200:1000);

ylim([0 50]);
xlim([1e-3 1]);
grid on;

% Plot v-T
subplot(2,2,4)

contourf(Y,X,Z,Pressure);
xlabel('v [m^3/kg]');
ylabel('T [Celsius]');
set(gca,'ZScale','linear');
set(gca,'XScale','log');
xticks([1e-3 1e-2 1e-1 1e0]);
yticks(0:200:1000);

c=colorbar;
caxis([0 100]);
c.Label.String='P [MPa]';
set(c,'YTick',0:10:100);

ylim([0 1000]);
xlim([1e-3 1]);
grid on;


% Print the figure
print('ideal_gas.png','-dpng','-r300');
end



