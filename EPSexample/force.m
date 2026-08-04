%%
clc;
clear all;
close all;
setPlotParameters;
%% load time averaged data
nskip = 1;
cond = 0;
nvars = 3;
vfname = strcat('volumemean.dat')
vfile = loaddata(vfname, nskip, nvars);
nvars = 4;
sfname = strcat('surfacemean.dat');
sfile = loaddata(sfname, nskip, nvars);
dissp = vfile.data(:,3);
kflux = sfile.data(:,2);
pp = sfile.data(:,3);
tp = sfile.data(:,4);
x = sfile.data(:,1);
Drag = 0.657870442554336;
sum = dissp+kflux+pp+tp;
res = Drag - sum;
max(abs(res))/Drag*100
%% load instanteneous data
nskip = 1;
cond = 0;
dt = 6.111505023281428 / 256;
N0f = 2731;
time = 65.197344604243526;
%force 65.1973     0.49188886     0.16882651     0.66071537      0.1394657    0.01920194       9     0.15866765 -1.9351476e-12  -0.0013693481  -0.0013693481
for nn=1:1:3
    nvars = 3;
    vfname = strcat('volume',num2str(nn+N0f-2),'.dat');
    vfilet{nn} = loaddata(vfname, nskip, nvars);
    nvars = 4;
    sfname = strcat('surface',num2str(nn+N0f-2),'.dat');
    sfilet{nn} = loaddata(sfname, nskip, nvars);
end
Dragt = 0.66071537;
k0t = vfilet{1}.data(:,2);
k2t = vfilet{3}.data(:,2);
dkt = (k2t-k0t)/(dt*2);
disspt = vfilet{2}.data(:,3);
kfluxt = sfilet{2}.data(:,2);
ppt = sfilet{2}.data(:,3);
tpt = sfilet{2}.data(:,4);
xt = sfilet{2}.data(:,1);
sumt = dkt+disspt+kfluxt+ppt+tpt;
rest = Dragt - sumt;
max(abs(rest))/Dragt*100
%% plot
position1=[0.08 0.15 0.4 0.8];
position2=[0.58 0.15 0.4 0.8];
handle = figure;
hidden off; grid off;
set(handle,'Position',[0 0 1120 420]);
set(gcf,'color','w');
hold on
axis off
fontsize = 20;
plotsize=10;
ax1=axes;
set(ax1,'position',position1);
hidden off; box on;grid off;  hold on;
index = genindex(0, 150, 20, xt);
h = plot(xt,dkt,'b^-','MarkerIndices', [300 400 480], 'MarkerFaceColor','blue');
h = [h plot(xt,disspt,'vk-','MarkerIndices', [180 300 400 480], 'MarkerFaceColor','black')];
h = [h plot(xt,kfluxt,'or-','MarkerIndices', [300 400 480])];
h = [h plot(xt,ppt,'g-')];
h = [h plot(xt,tpt,'c--','LineWidth',3)];
h = [h plot(xt,sumt,'k-.')];
h = [h plot(xt(index),0*xt(index)+Dragt,'*k')];
xlabel('$x_{\mbox{wake}}/d$', 'Interpreter', 'latex');
ylabel('$F_x/\rho U_\infty^2 d$', 'Interpreter', 'latex');
axis([0 150 -0.1 0.7])
set(gca, ... 
    'XTick', [0:30:150], ...
    'XTickLabels', [0:30:150], ...
    'YTick', [-0.1:0.1:0.7], ...
    'YTickLabels', [-0.1:0.1:0.7], ...
    'FontSize', 15, ...
    'box', 'on','TickDir', 'Out')
ax1.XMinorTick='on';
ax1.XAxis.MinorTickValues=0:10:150;
lgd=legend("Kinetic energy increase","Dissipation rate", "Kinetic energy flux",...
     "Pressure power", "Viscous stress power","Sum of RHS",...
    "Surface-stress integral",'Interpreter', 'latex','FontSize',15, 'Orientation', 'vertical');
lgd.Position = [0.2182,0.3865,0.2268,0.4167];
annotation('textbox',[0.000,0.94,0.2,0.05],'String','($a$)','interpreter','latex','FontSize', 20,'LineStyle','None','Margin',0);



ax2=axes;
set(ax2,'position',position2);
hidden off; box on;grid off;  hold on;
h = [h plot(xt,dissp,'vk-','MarkerIndices', [180 300 400 480], 'MarkerFaceColor','black')];
h = [h plot(xt,kflux,'or-','MarkerIndices', [180 300 400 480])];
h = [h plot(xt,pp,'g-')];
h = [h plot(xt,tp,'c--','LineWidth',3)];
h = [h plot(xt,sum,'k-.')];
h = [h plot(xt(index),0*xt(index)+Drag,'*k')];
xlabel('$x_{\mbox{wake}}/d$', 'Interpreter', 'latex');
ylabel('$\overline{F_x}/\rho U_\infty^2 d$', 'Interpreter', 'latex');
axis([0 150 -0.1 0.7])
set(gca, ... 
    'XTick', [0:30:150], ...
    'XTickLabels', [0:30:150], ...
    'YTick', [-0.1:0.1:0.7], ...
    'YTickLabels', [-0.1:0.1:0.7], ...
    'FontSize', 15, ...
    'box', 'on','TickDir', 'Out')
ax2.XMinorTick='on';
ax2.XAxis.MinorTickValues=0:10:150;
annotation('textbox',[.500 0.94 0.2 0.05],'String','($b$)','interpreter','latex','FontSize', 20,'LineStyle','None','Margin',0);
exportgraphics(gcf,'KineticE.pdf','resolution',200) 