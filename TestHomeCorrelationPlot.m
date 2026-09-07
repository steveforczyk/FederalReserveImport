% This script will test the CreateHomeCorrelationPlot function

titlestr='TestHomeCorrelationPlot.png';
% Set Up some initial Data

excelpath='K:\Investing2\ExcelFiles\';
TableFileName='ImportedFredData159.mat';
tablepath='K:\Investing2\Tables\';
jpegpath='D:\Investing2\FRED_Data\Jpeg_Files\';
fredjpegpath='K:\Investing2\FRED_Data\FredJpeg\';
tiffpath='D:\Investing2\FRED_Data\Tiff_Files\';
pdfpath='K:\Investing2\PDF_Files]';
output1=1;
output2=2;
% Set up a correlation table for plotting based on the HomeCorrTable
% Import The Data
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load(TableFileName);
dispstr=strcat('Loaded Save Imported Fred Data From File-',TableFileName);
disp(dispstr)
[output1,output2]=CreateHomeCorrelationPlot(FRObj,HomeCorrTable,titlestr);
