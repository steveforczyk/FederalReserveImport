function [output1,output2]=CreateHomeCorrelationPlot(FRObj,HomeCorrTable,titlestr)
% This function will create a 2 D table of Home Price Correlations
% Based on FRED Data

% Intended to work with the Home Correlation Table output from an earlier
% run of ImportFredData
% The data to be used is called "HomeCorrTable"
% 
% Written By: Stephen Forczyk
% Created: Sept1,2026
% Revised: Sept4,2026 followed the model from the CreateFoodCorrelation
% plot but modified using the HomeCorrTable which is a 10 x 10 matrix
% Set Up some initial Data

excelpath='K:\Investing2\ExcelFiles\';
TableFileName='ImportedFredData152.mat';
tablepath='K:\Investing2\Tables\';
jpegpath='D:\Investing2\FRED_Data\Jpeg_Files\';
fredjpegpath='K:\Investing2\FRED_Data\FredJpeg\';
tiffpath='D:\Investing2\FRED_Data\Tiff_Files\';
pdfpath='K:\Investing2\PDF_Files]';
output1=1;
output2=2;
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
% Set up a correlation table for plotting based on the HomeCoorTable
% Import The Data
% eval(['cd ' tablepath(1:length(tablepath)-1)]);
% load(TableFileName);
% dispstr=strcat('Loaded Save Imported Fred Data From File-',TableFileName);
% disp(dispstr)

% Now Create a 2 D Data array for plotting Correlations this will be a 10 x
% 10 array
DataCorr=zeros(10,10);
% This demands 10 x 10 correlation coefficients but self  correlation is 1 
% and the order of correlations is immaterial so fewer runs are needed

datacol=1;
minCorrPts=100;
ikind=1;
% First set the values to 1 for the 10 self correlations
DataCorr(1,1)=1;
DataCorr(2,2)=1;
DataCorr(3,3)=1;
DataCorr(4,4)=1;
DataCorr(5,5)=1;
DataCorr(6,6)=1;
DataCorr(7,7)=1;
DataCorr(8,8)=1;
DataCorr(9,9)=1;
DataCorr(10,10)=1;
% Calc Corr #1
DataCorr(1,2)=table2array(HomeCorrTable(1,9));
DataCorr(2,1)=DataCorr(1,2);
% Calc Corr #2
DataCorr(1,3)=table2array(HomeCorrTable(2,9));
DataCorr(3,1)=DataCorr(1,3);
% Calc Corr 3
DataCorr(1,4)=table2array(HomeCorrTable(3,9));
DataCorr(4,1)=DataCorr(1,4);
% Calc Corr 4
DataCorr(1,5)=table2array(HomeCorrTable(4,9));
DataCorr(5,1)=DataCorr(1,5);
% Calc Corr 5
DataCorr(1,6)=table2array(HomeCorrTable(5,9));
DataCorr(6,1)=DataCorr(1,6);
% Calc Corr 6
DataCorr(1,7)=table2array(HomeCorrTable(6,9));
DataCorr(7,1)=DataCorr(1,7);
% Calc Corr 7
DataCorr(1,8)=table2array(HomeCorrTable(7,9));
DataCorr(8,1)=DataCorr(1,8);
% Calc Corr 8
DataCorr(1,9)=table2array(HomeCorrTable(8,9));
DataCorr(9,1)=DataCorr(1,9);
% Calc Corr 9
DataCorr(1,10)=table2array(HomeCorrTable(9,9));
DataCorr(10,1)=DataCorr(1,10);
% Calc Corr 10
DataCorr(2,3)=table2array(HomeCorrTable(10,9));
DataCorr(3,2)=DataCorr(2,3);
% Calc Corr 11
DataCorr(2,4)=table2array(HomeCorrTable(11,9));
DataCorr(4,2)=DataCorr(2,4);
% Calc Corr 12
DataCorr(2,5)=table2array(HomeCorrTable(12,9));
DataCorr(5,2)=DataCorr(2,5);
% Calc Corr 13
DataCorr(2,6)=table2array(HomeCorrTable(13,9));
DataCorr(6,2)=DataCorr(2,6);
% Calc Corr 14
DataCorr(2,7)=table2array(HomeCorrTable(14,9));
DataCorr(7,2)=DataCorr(2,7);
% Calc Corr 15
DataCorr(2,8)=table2array(HomeCorrTable(15,9));
DataCorr(8,2)=DataCorr(2,8);
% Calc Corr 16
DataCorr(2,9)=table2array(HomeCorrTable(16,9));
DataCorr(9,2)=DataCorr(2,9);
% Calc Corr 17
DataCorr(2,10)=table2array(HomeCorrTable(17,9));
DataCorr(10,2)=DataCorr(2,10);
% Calc Corr 18
DataCorr(3,4)=table2array(HomeCorrTable(18,9));
DataCorr(4,3)=DataCorr(3,4);
% Calc Corr 19
DataCorr(3,5)=table2array(HomeCorrTable(19,9));
DataCorr(5,3)=DataCorr(3,5);
% Calc Corr 20
DataCorr(3,6)=table2array(HomeCorrTable(20,9));
DataCorr(6,3)=DataCorr(3,6);
% Calc Corr 21
DataCorr(3,7)=table2array(HomeCorrTable(21,9));
DataCorr(7,3)=DataCorr(3,7);
% Calc Corr 22
DataCorr(3,8)=table2array(HomeCorrTable(22,9));
DataCorr(8,3)=DataCorr(3,8);
% Calc Corr 23
DataCorr(3,9)=table2array(HomeCorrTable(23,9));
DataCorr(9,3)=DataCorr(3,9);
% Calc Corr 24
DataCorr(3,10)=table2array(HomeCorrTable(24,9));
DataCorr(10,3)=DataCorr(3,10);
% Calc Corr 25
DataCorr(4,5)=table2array(HomeCorrTable(25,9));
DataCorr(5,4)=DataCorr(4,5);
% Calc Corr 26
DataCorr(4,6)=table2array(HomeCorrTable(26,9));
DataCorr(6,4)=DataCorr(4,6);
% Calc Corr 27
DataCorr(4,7)=table2array(HomeCorrTable(27,9));
DataCorr(7,4)=DataCorr(4,7);
% Calc Corr 28
DataCorr(4,8)=table2array(HomeCorrTable(28,9));
DataCorr(8,4)=DataCorr(4,8);
% Calc Corr 29
DataCorr(4,9)=table2array(HomeCorrTable(29,9));
DataCorr(9,4)=DataCorr(4,9);
% Calc Corr 30
DataCorr(4,10)=table2array(HomeCorrTable(30,9));
DataCorr(10,4)=DataCorr(4,10);
% Calc Corr 31
DataCorr(5,6)=table2array(HomeCorrTable(31,9));
DataCorr(6,5)=DataCorr(5,6);
% Calc Corr 32
DataCorr(5,7)=table2array(HomeCorrTable(32,9));
DataCorr(7,5)=DataCorr(5,7);
% Calc Corr 33
DataCorr(5,8)=table2array(HomeCorrTable(33,9));
DataCorr(8,5)=DataCorr(5,8);
% Calc Corr 34
DataCorr(5,9)=table2array(HomeCorrTable(34,9));
DataCorr(9,5)=DataCorr(5,9);
% Calc Corr 35
DataCorr(5,10)=table2array(HomeCorrTable(35,9));
DataCorr(10,5)=DataCorr(5,9);
% Calc Corr 36
DataCorr(6,7)=table2array(HomeCorrTable(36,9));
DataCorr(7,6)=DataCorr(6,7);
% Calc Corr 37
DataCorr(6,8)=table2array(HomeCorrTable(37,9));
DataCorr(8,6)=DataCorr(6,8);
% Calc Corr 38
DataCorr(6,9)=table2array(HomeCorrTable(38,9));
DataCorr(9,6)=DataCorr(6,9);
% Calc Corr 39
DataCorr(6,10)=table2array(HomeCorrTable(39,9));
DataCorr(10,6)=DataCorr(6,10);
% Calc Corr 40
DataCorr(7,8)=table2array(HomeCorrTable(40,9));
DataCorr(8,7)=DataCorr(7,8);
% Calc Corr 41
DataCorr(7,9)=table2array(HomeCorrTable(41,9));
DataCorr(9,7)=DataCorr(7,9);
% Calc Corr 42
DataCorr(7,10)=table2array(HomeCorrTable(42,9));
DataCorr(10,7)=DataCorr(7,10);
% Calc Corr 43
DataCorr(8,9)=table2array(HomeCorrTable(43,9));
DataCorr(9,8)=DataCorr(8,9);
% Calc Corr 44
DataCorr(8,10)=table2array(HomeCorrTable(44,9));
DataCorr(10,8)=DataCorr(8,10);
% Calc Corr 45
DataCorr(9,10)=table2array(HomeCorrTable(45,9));
DataCorr(10,9)=DataCorr(9,10);


% Create the actual correlation plot
ab=1;
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
minval=min(min(DataCorr));
SHM7 = SHeatmap(DataCorr, 'Format','sq');
SHM7.ColName = {'U2 Rate','SCIPTT','CaseShiller','Lumber','HardWood','SoftWood','HardwoodFloor','MillWork','TreatedWood','PlasticPipe'};
SHM7.RowName = {'U2 Rate','SCIPTT','CaseShiller','Lumber','HardWood','SoftWood','HardwoodFloor','MillWork','TreatedWood','PlasticPipe'};
SHM7.draw(); 
CB = colorbar;
CB.Location = 'eastoutside';
CB.Label.String = 'Correlation';
CB.Label.FontSize = 12;
CB.Label.FontWeight ='bold';
%colormap(slanCM('inferno')) 
%colormap(slanCM('magma'));
colormap(jet)
clim([-.4 1.1]);
SHM7.setText();
SHM7.setFrame()
title(titlestr)
drawnow
titlestr=char(titlestr);
actionstr='print';
typestr='-djpeg';
figstr=strcat(titlestr,'.jpg');
figstr2=strcat(titlestr,'.png');
figstr=char(figstr);
figstr2=char(figstr2);
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
pause(5)
eval(['cd ' tiffpath(1:length(tiffpath)-1)]);
screencapture(gcf,[],figstr2);
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
close('all')
ab=2;


end
