function [output1,output2]=CreateHomeCorrelationPlot(FRObj,titlestr)
% This function will create a 2 D table of Home Price Correlations
% Based on FRED Data

% Intended to work with the Home Correlation Table output from an earlier
% run of ImportFredData
% The data to be used is called "HomeCorrTable"
% 
% Written By: Stephen Forczyk
% Created: Sept,2026
% Revised:----
% Set Up some initial Data

excelpath='K:\Investing2\ExcelFiles\';
TableFileName='ImportedFredData152.mat';
tablepath='K:\Investing2\Tables\';
jpegpath='D:\Investing2\FRED_Data\Jpeg_Files\';
fredjpegpath='K:\Investing2\FRED_Data\FredJpeg\';
tiffpath='D:\Investing2\FRED_Data\Tiff_Files\';
pdfpath='K:\Investing2\PDF_Files]';

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
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load(TableFileName);
dispstr=strcat('Loaded Save Imported Fred Data From File-',TableFileName);
disp(dispstr)

% Now Create a 2 D Data array for plotting Correlations this will be a 7 x
% 7 array
DataCorr=zeros(7,7);
% This demands 7 x 7 correlation coefficients but self  correlation is 1 
% and the order of correlations is immaterial so fewer runs are needed

datacol=1;
minCorrPts=100;
ikind=1;
% First set the values to 1 for the 7 self correlations
DataCorr(1,1)=1;
DataCorr(2,2)=1;
DataCorr(3,3)=1;
DataCorr(4,4)=1;
DataCorr(5,5)=1;
DataCorr(6,6)=1;
DataCorr(7,7)=1;
% Calc Corr #1
UrbanHFTT=FRObj.UrbanHFTT;
PPIDieselTT=FRObj.PPIDieselTT;
[DataCorr(1,2),~,~] = CalculateCorrelation(UrbanHFTT,PPIDieselTT,ikind,minCorrPts);
DataCorr(2,1)=DataCorr(1,2);
dispstr=strcat('Price Correlation Between Urban Home Food and Diesel Fuel Prices-',num2str(DataCorr(1,2)));
disp(dispstr)
% Calc Corr #2
ChuckRoastTT=FRObj.ChuckRoastTT;
ikind=2;
[DataCorr(1,3),~,~] = CalculateCorrelation(UrbanHFTT,ChuckRoastTT,ikind,minCorrPts);
DataCorr(3,1)=DataCorr(1,3);
dispstr=strcat('Price Correlation Between Urban Home Food and Chuck Roast Prices-',num2str(DataCorr(1,3)));
disp(dispstr)
% Calc Corr 3
BaconPriceTT=FRObj.BaconPriceTT;
[DataCorr(1,4),~,~] = CalculateCorrelation(UrbanHFTT,BaconPriceTT,ikind,minCorrPts);
DataCorr(4,1)=DataCorr(1,4);
dispstr=strcat('Price Correlation Between Urban Home Food and Bacon Prices-',num2str(DataCorr(1,4)));
disp(dispstr)
% Calc Corr 4
ElectricityPriceTT=FRObj.ElectricityPriceTT;
[DataCorr(1,5),~,~] = CalculateCorrelation(UrbanHFTT,ElectricityPriceTT,ikind,minCorrPts);
DataCorr(5,1)=DataCorr(1,5);
dispstr=strcat('Price Correlation Between Urban Home Food and Electricity Prices-',num2str(DataCorr(1,5)));
disp(dispstr)
% Calc Corr 5
WholeChickenTT=FRObj.WholeChickenTT;
[DataCorr(1,6),~,~] = CalculateCorrelation(UrbanHFTT,WholeChickenTT,ikind,minCorrPts);
DataCorr(6,1)=DataCorr(1,6);
dispstr=strcat('Price Correlation Between Urban Home Food and Whole Chicken Prices-',num2str(DataCorr(1,6)));
disp(dispstr)
% Calc Corr 6
FlourPriceTT=FRObj.FlourPriceTT;
[DataCorr(1,7),~,~] = CalculateCorrelation(UrbanHFTT,FlourPriceTT,ikind,minCorrPts);
DataCorr(7,1)=DataCorr(1,7);
dispstr=strcat('Price Correlation Between Urban Home Food and Flour Prices-',num2str(DataCorr(1,7)));
disp(dispstr)
% Calc Corr 7
[DataCorr(2,3),~,~] = CalculateCorrelation(PPIDieselTT,ChuckRoastTT,ikind,minCorrPts);
DataCorr(3,2)=DataCorr(2,3);
dispstr=strcat('Price Correlation Between Diesel Prices and ChuckRoast Prices-',num2str(DataCorr(2,3)));
disp(dispstr)
% Calc Corr 8
[DataCorr(2,4),~,~] = CalculateCorrelation(PPIDieselTT,BaconPriceTT,ikind,minCorrPts);
DataCorr(4,2)=DataCorr(2,4);
dispstr=strcat('Price Correlation Between Diesel Prices and Bacon  Prices-',num2str(DataCorr(2,4)));
disp(dispstr)
% Calc Corr 9
[DataCorr(2,5),~,~] = CalculateCorrelation(PPIDieselTT,ElectricityPriceTT,ikind,minCorrPts);
DataCorr(5,2)=DataCorr(2,5);
dispstr=strcat('Price Correlation Between Diesel Prices and Electricity Prices-',num2str(DataCorr(2,5)));
disp(dispstr)
% Calc Corr 10
[DataCorr(2,6),~,~] = CalculateCorrelation(PPIDieselTT,WholeChickenTT,ikind,minCorrPts);
DataCorr(6,2)=DataCorr(2,6);
dispstr=strcat('Price Correlation Between Diesel Prices and Whole Chicken Prices-',num2str(DataCorr(2,6)));
disp(dispstr)
% Calc Corr 11
[DataCorr(2,7),~,~] = CalculateCorrelation(PPIDieselTT,FlourPriceTT,ikind,minCorrPts);
DataCorr(7,2)=DataCorr(2,7);
dispstr=strcat('Price Correlation Between Diesel Prices and Flour Prices-',num2str(DataCorr(2,7)));
disp(dispstr)
% Calc Corr 12
ikind=4;
[DataCorr(3,4),~,~] = CalculateCorrelation(ChuckRoastTT,BaconPriceTT,ikind,minCorrPts);
DataCorr(4,3)=DataCorr(3,4);
dispstr=strcat('Price Correlation Between ChuckRoast Prices and Bacon  Prices-',num2str(DataCorr(3,4)));
disp(dispstr)
% Calc Corr 13
ikind=4;
[DataCorr(3,5),~,~] = CalculateCorrelation(ChuckRoastTT,ElectricityPriceTT,ikind,minCorrPts);
DataCorr(5,3)=DataCorr(3,5);
dispstr=strcat('Price Correlation Between ChuckRoast Prices and Electricity Prices-',num2str(DataCorr(3,5)));
disp(dispstr)
% Calc Corr 14
ikind=4;
[DataCorr(3,6),~,~] = CalculateCorrelation(ChuckRoastTT,WholeChickenTT,ikind,minCorrPts);
DataCorr(6,3)=DataCorr(3,6);
dispstr=strcat('Price Correlation Between ChuckRoast Prices and Whole Chicken Prices-',num2str(DataCorr(3,6)));
disp(dispstr)
% Calc Corr 15
ikind=4;
[DataCorr(3,7),~,~] = CalculateCorrelation(ChuckRoastTT,FlourPriceTT,ikind,minCorrPts);
DataCorr(7,3)=DataCorr(3,7);
dispstr=strcat('Price Correlation Between ChuckRoast Prices and Flour Prices-',num2str(DataCorr(3,7)));
disp(dispstr)
% Calc Corr 16
ikind=4;
[DataCorr(4,5),~,~] = CalculateCorrelation(BaconPriceTT,ElectricityPriceTT,ikind,minCorrPts);
DataCorr(5,4)=DataCorr(4,5);
dispstr=strcat('Price Correlation Between Bacon Prices and Electricity Prices-',num2str(DataCorr(4,5)));
disp(dispstr)
% Calc Corr 17
ikind=4;
[DataCorr(4,6),~,~] = CalculateCorrelation(BaconPriceTT,WholeChickenTT,ikind,minCorrPts);
DataCorr(6,4)=DataCorr(4,6);
dispstr=strcat('Price Correlation Between Bacon Prices and Whole Chicken Prices-',num2str(DataCorr(4,6)));
disp(dispstr)
% Calc Corr 18
ikind=4;
[DataCorr(4,7),~,~] = CalculateCorrelation(BaconPriceTT,FlourPriceTT,ikind,minCorrPts);
DataCorr(7,4)=DataCorr(4,7);
dispstr=strcat('Price Correlation Between Bacon Prices and Whole Chicken Prices-',num2str(DataCorr(4,7)));
disp(dispstr)
% Calc Corr 19
ikind=4;
[DataCorr(5,6),~,~] = CalculateCorrelation(ElectricityPriceTT,WholeChickenTT,ikind,minCorrPts);
DataCorr(6,5)=DataCorr(5,6);
dispstr=strcat('Price Correlation Between Electricity Prices and Whole ChickenPrices-',num2str(DataCorr(5,6)));
disp(dispstr)
% Calc Corr 20
ikind=4;
[DataCorr(5,7),~,~] = CalculateCorrelation(ElectricityPriceTT,FlourPriceTT,ikind,minCorrPts);
DataCorr(7,5)=DataCorr(5,7);
dispstr=strcat('Price Correlation Between Electricity Prices and Flour Prices-',num2str(DataCorr(5,7)));
disp(dispstr)
% Calc Corr 21
ikind=4;
[DataCorr(6,7),~,~] = CalculateCorrelation(WholeChickenTT,FlourPriceTT,ikind,minCorrPts);
DataCorr(7,6)=DataCorr(6,7);
dispstr=strcat('Price Correlation Between Whole Chicken Prices and Flour Prices-',num2str(DataCorr(6,7)));
disp(dispstr)
% Create the actual correlation plot
ab=1;
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
minval=min(min(DataCorr));
SHM7 = SHeatmap(DataCorr, 'Format','sq');
SHM7.ColName = {'UrbanHF','Diesel','ChuckRoast','Bacon','Electricity','Chicken','Flour'};
SHM7.RowName = {'UrbanHF','Diesel','ChuckRoast','Bacon','Electricity','Chicken','Flour'};;
SHM7.draw(); 
CB = colorbar;
CB.Location = 'eastoutside';
CB.Label.String = 'Correlation';
CB.Label.FontSize = 12;
CB.Label.FontWeight ='bold';
%colormap(slanCM('inferno')) 
%colormap(slanCM('magma'));
colormap(jet)
clim([0.6 1.1]);
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
end