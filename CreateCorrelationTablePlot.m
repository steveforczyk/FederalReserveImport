% This script will create some test plots of correlation files
% Intended to work with the Food Correlation Table output from an earlier
% run of ImportFredData
% The data to be used is called "FoodCorrTable"
% 
% Written By: Stephen Forczyk
% Created: Aug 12,2026
% Revised:----
% Set Up some initial Data

excelpath='K:\Investing2\ExcelFiles\';
TableFileName='ImportedFredData152.mat';
tablepath='K:\Investing2\Tables\';

%% Call some routines that will create nice plot window sizes and locations
% Establish selected run parameters
imachine=2;
if(imachine==1)
    widd=720;
    lend=580;
    widd2=1000;
    lend2=700;
elseif(imachine==2)% This will be the default
    widd=1080;
    lend=812;
    widd2=1000;
    lend2=700;
elseif(imachine==3)
    widd=1296;
    lend=974;
    widd2=1200;
    lend2=840;
end
% Set a specific color order
set(0,'DefaultAxesColorOrder',[1 0 0;
    1 1 0;0 1 0;0 0 1;0.75 0.50 0.25;
    0.5 0.75 0.25; 0.25 1 0.25;0 .50 .75]);
% Set up some defaults for a PowerPoint presentationwhos
scaling='true';
stretching='false';
padding=[75 75 75 75];
igrid=1;
% Set up paramters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,~,~,~]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datetime("now");
% Import The Data
eval(['cd ' tablepath(1:length(tablepath)-1)]);
%load(TableFileName,'FoodCorrTable','FoodRho');
load(TableFileName);
disp('Loaded Food Correlation ')

% Now Create a Data array for plotting
% Take the 1 D FoodRow Array and create a 2 array of correlation
% coefficients
[nrows,ncols]=size(FoodRho);
Data=zeros(nrows,nrows);
[nrows2,ncols2]=size(Data);
nc=1;
nr=0;
% for i=1:nrows
%     nc=nc+1;
%     nr=nr+1;
%     if(nr>nrows)
%         nr=1;
%     end
% Create the first column
for i=1:nrows
    Data(i,1)=FoodRho(i,1);
end
% Create all other columns
iter=0;
while iter<=nrows2
    nc=nc+1;
    ncc=1;
    nc2=nc;
    iter=iter+1;
   
 for i=nc:nrows
    ncc=ncc+1;
    val=FoodRho(i,1);
    Data(nc2-1,ncc)=FoodRho(i,1);
    ab=1;
 end
    ab=2;
end
ab=1;
figure()
Data = rand(12, 12);
SHM7 = SHeatmap(FoodRho, 'Format','sq');
SHM7.ColName = {'X-1','X-2','X-3','X-4','X-5','X-6','X-7','X-8','X-9','X-10','X-11','X-12'};
SHM7.RowName = {'Y-1','Y-2','Y-3','Y-4','Y-5','Y-6','Y-7','Y-8','Y-9','Y-10','Y-11','Y-12'};
SHM7.draw(); 
SHM7.setFrame()

