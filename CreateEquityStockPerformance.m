% This script will read a large Excel file that contains
% The pricing data for stocks owned in the IRA File for a 1 year period
% This is for the year 2024
% Written By: Stephen Forczyk
% Created: Jan 27,2025
% Revised: Jan 28,2025 added ability to loop over stocks and store stats
% Revised: Feb 2,2025 added ability to calculate correlation coefficients
%          between individual stocks in IRA account
% Revised: Feb 4,2025 added ability to calculate The Relative Strength
% Index (RSI) metric for each stock
% Revised: Feb 6,2025 working on created data to allow for the creation of
% a heatmap display of the RSI data for each stock by month


fclose('all');
clear('all');
clc

global ActivityFile1 ActivityFile2 ActivityFile3;

global total_comissions divsum dataYear;
global RCoeff RCoeffNames;
global IRAStockList2024 TableList TableFileName BollingerList;
global EquityAAPL EquityABBV EquityALB EquityAMD EquityAMZN EquityCAT;
global EquityCCL EquityCDNS EquityCMI EquityDBX EquityDELL EquityDOCU;
global EquityENB EquityET EquityGE EquityGOOG EquityGSL EquityHII;
global EquityHWM EquityLMT EquityMSFT EquityNVDA EquityNVO EquityOC;
global EquityPAGP EquityPFE EquityPHM EquityPLTR EquityRCL EquityRIO;
global EquitySMCI EquityTHC EquityTOL EquityVZ EquityXOM EquityYOU;
global EquityAAPLTT EquityABBVTT EquityALBTT EquityAMDTT EquityAMZNTT EquityCATTT;
global EquityCCLTT EquityCDNSTT EquityCMITT EquityDBXTT EquityDELLTT EquityDOCUTT;
global EquityENBTT EquityETTT EquityGETT EquityGOOGTT EquityGSLTT EquityHIITT;
global EquityHWMTT EquityLMTTT EquityMSFTTT EquityNVDATT EquityNVOTT EquityOCTT;
global EquityPAGPTT EquityPFETT EquityPHMTT EquityPLTRTT EquityRCLTT EquityRIOTT;
global EquitySMCITT EquityTHCTT EquityTOLTT EquityVZTT EquityXOMTT EquityYOUTT;
global WorkBollTT BollAAPLTT BollABBVTT BollALBTT BollAMDTT BollAMZNTT;
global BollCATTT BollCCLTT BollCDNSTT BollCMITT BollDBXTT BollDELLTT BollDOCUTT;
global BollENBTT BollETTT BollGETT BollGOOGTT BollGSLTT BollHIITT BollNVOTT;
global BollHWMTT BollLMTTT BollMSFTTT BollNVDATT BollOCTT BollPAGPTT;
global BollPFETT BollPHMTT BollPLTRTT BollRCLTT BollRIOTT BollSMCITT;
global BollTHCTT BollTOLTT BollVZTT BollXOMTT BollYOUTT;
global RSIStats RSILowLimit RSIHighLimit meanRSI RSIJpegs iRISCounter RSIStatsHdr;
global RSIAAPLTT RSIABBVTT RSIALBTT RSIAMDTT RSIAMZNTT RSICATTT RSICCLTT;
global RSICDNSTT RSICMITT RSIDBXTT RSIDELLTT RSIDOCUTT RSIENBTT RSIETTT;
global RSIGETT RSIGOOGTT RSIGSLTT RSIHIITT RSIHWMTT RSILMTTT ;
global RSIMSFTTT RSINVDATT RSINVOTT RSIOCTT RSIPAGPTT RSIPFETT;
global RSIPHMTT RSIPLTRTT RSIRCLTT RSIRIOTT RSISMCITT RSITHCTT;
global RSITOLTT RSIVZTT RSIXOMTT RSIYOUTT;
global RMonthAAPL RMonthABBV RMonthALB RMonthAMD RMonthAMZN RMonthCAT;
global RMonthCCL RMonthCDNS RMonthCMI RMonthDBX RMonthDELL RMonthDOCU;
global RMonthENB RMonthET RMonthGE RMonthGOOG RMonthGSL RMonthHII RMonthHWM;
global RMonthLMT RMonthMSFT RMonthNVDA RMonthNVO RMonthOC  RMonthPAGP;
global RMonthPFE RMonthPHM RMonthPLTR RMonthRCL RMonthRIO RMonthSMCI;
global RMonthTHC RMonthTOL RMonthVZ RMonthXOM RMonthYOU;
global TSMomStats TSMonStatsHdrs TSMonJpegs itsmonsCounter TSMomStatsHdr;
global StockStats StockHdrs SheetRecords sheets StockList StockSymbols StockIndexHistory;
global StockTable MeasurementDate StockNames RCoeff1D StockCorrTable SortedStockTable;
global Months HeatMapTable XCenters YCenters;

global iLabels istocknum;
global EquityStockDataFile;
global iCreatePDFReport RptGenPresent pdffilename rpt chapter tocc;

global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global MSFileName ExcelFileName;
global fid;

global MSpath excelpath tablepath logfilepath jpegpath pdfpath;
global govjpegpath matpath;
MSFileName='MorganStanleyActivity2024Rev1.txt';
ActivityFile1='FullActivityIRA2024Rev2.xlsx';
MSpath='D:\Investing\';
excelpath='D:\Investing\ExcelFiles\';
ExcelFileName='MSActivity2024Rev2.xlsx';
TableFileName='IRA2024ConsolidatedTable.mat';
EquityStockDataFile='HistoricalStocks2024.xlsx';
tablepath='D:\Investing\Tables\';
logfilepath='D:\Investing\Log_Files\';
jpegpath='D:\Investing\Jpeg_Files\';
pdfpath='D:\Investing\PDF_Files\';
pdffilename='IvestmentReport-2024.pdf';
govjpegpath='D:\Investing\gov_jpeg\';
matpath='D:\Investing\MAT_Files\';
StockIndexHistory='HistoricalStockMarketIndices.mat';
dataYear=2024;
iLabels=1;
RSILowLimit=30;
RSIHighLimit=70;
Months=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
Months=Months';
iCreatePDFReport=1;
ab=1;


%% Call some routines that will create nice plot window sizes and locations
% Establish selected run parameters
imachine=2;
if(imachine==1)
    widd=720;
    lend=580;
    widd2=1000;
    lend2=700;
elseif(imachine==2)
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
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datestr(now);
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Reading MS Transaction File at-',startruntime);
logfilename=startruntime;
logfiledbl=double(logfilename);
% find the blank space in the date and replace it with a '-' to make a
% legalfilename
[iblank]=find(logfiledbl==32);
numblank=length(iblank);
for n=1:numblank
    is=iblank(n);
    ie=is;
    logfilename(is:ie)='-';
end
[icolon]=strfind(logfilename,':');
numcolon=length(icolon);
for n=1:numcolon
    is=icolon(n);
    ie=is;
    logfilename(is:ie)='-';
end

eval(['cd ' logfilepath(1:length(logfilepath)-1)]);
logfilename=strcat('StockEquityData-',logfilename,'.txt');
fid=fopen(logfilename,'w');
dispstr=strcat('Opened Log file-',logfilename,'-for writing');
disp(dispstr);
fprintf(fid,'%50s\n',startrunstr);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
% Find out the sheetnames of the target stock data file
sheets = sheetnames(EquityStockDataFile);
numsheets=length(sheets);
StockList=sheets';
IRAStockList2024=sheets;
SheetRecords=zeros(numsheets,1);
StockSymbols=cell(numsheets,1);
RSIStats=zeros(numsheets,10);
for mm=1:numsheets
    StockSymbols{mm,1}=sheets(mm,1);
end
RSIJpegs=cell(1,1);
RSIStatsHdr=cell(1,7);
RSIStatsHdr{1,1}='Mean RSI';
RSIStatsHdr{1,2}='Min RSI';
RSIStatsHdr{1,3}='Max RSI';
RSIStatsHdr{1,4}='Std RSI';
RSIStatsHdr{1,5}='Num OverSold';
RSIStatsHdr{1,6}='Num Neutral';
RSIStatsHdr{1,7}='Num OverBought';
iRISCounter=0;
TSMomStats=zeros(numsheets,10);
TSMomStatsHdr=cell(1,6);
TSMonStatsHdrs{1,1}='Stock Min Open';
TSMonStatsHdrs{1,2}='Stock Max Open';
TSMonStatsHdrs{1,3}='Stock Min Close';
TSMonStatsHdrs{1,4}='Stock Max Close';
TSMonStatsHdrs{1,5}='Max IntraDayRange';
TSMonStatsHdrs{1,6}='IntraDayMaxRangePct';

TSMonJpegs=cell(numsheets,1);
itsmonsCounter=0;
datastr1=strcat('Start Reading Data from file-',EquityStockDataFile);
disp(datastr1)
fprintf(fid,'%50s\n',datastr1);
%% Check to see if the Matlab Report Generator and Image Toolbox is present
toolbox='MATLAB Report Generator';
[RptGenPresent] = ToolboxChecker(toolbox);
toolbox='Image Processing Toolbox';
[ImageProcessPresent]=ToolboxChecker(toolbox);
%% Start a PDF report if requested by user and user has the Matlab Report
% Generator Package Installed
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*
    CreateInvestmentReportHeader
else
    fprintf(fid,'%s\n','No PDF report will be created for this run');
end

%% Now start assigning this to tables
warning('off')
TableList=cell(1,1);
BollingerList=cell(1,1);
%% Load in some historical stock index data
eval(['cd ' matpath(1:length(matpath)-1)]);
fprintf(fid,'\n');
load(StockIndexHistory);
stockstr1=strcat('Importing Stock Index data from file-',StockIndexHistory);
fprintf(fid,'%20s\n',stockstr1);
disp(stockstr1);
fprintf(fid,'\n');
ab=2;
%% Start with AAPL
istocknum=1;
nowSheet=sheets(1);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
EquityAAPL = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityAAPL.Close,10,'omitnan');
Meandays50=movmean(EquityAAPL.Close,50,'omitnan');
RCoeff=zeros(numsheets,numsheets);
RCoeffNames=cell(numsheets,numsheets);
numprices=length(EquityAAPL.Close);
StockPrices=zeros(numprices,numsheets);
AAPLStockPrices(:,1)=EquityAAPL.Close;
Dates=char(EquityAAPL.Date);
MeasurementDate=datetime(EquityAAPL.Date);
ST = timetable(MeasurementDate,StockPrices);
%SP500DateNums=zeros(numprices,1);
[EquityAAPLTT] = CalculateEquityTableDateNum(EquityAAPL,Meandays10,Meandays50,numprices);
% nowDate=zeros(numprices,1);
% for n=1:numprices
%     temp=char(EquityAAPL.Date(n));
%     nowDate(n,1)=datenum(temp);
% end
%SP500TT = addvars(SP500TT,nowDate);
% T2 = addvars(EquityAAPL,Meandays10,Meandays50,nowDate);
% EquityAAPLTT = table2timetable(T2,'RowTimes','Date');
% startDate=char(EquityAAPLTT.Date(2));
% endDate=char(EquityAAPLTT.Date(end));
% startDateNum=datenum(startDate);
% endDateNum=datenum(endDate);
ab=1;
numrec=height(EquityAAPLTT);
SheetRecords(1,1)=numrec;
filestr1=strcat('Importing DataSet 1 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr1);
disp(filestr1);
TableList{1,1}='EquityAAPLTT';
TMWTable=EquityAAPL;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollAAPLTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{1,1}='BollAAPLTT';
WorkBollTT=BollAAPLTT;
% Calulate the Relative Strength Index Metric
RSIAAPLTT = rsindex(BollAAPLTT);
RSIWhole=RSIAAPLTT.RelativeStrengthIndex;
numvals=height(RSIAAPLTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIAAPLTT = addvars(RSIAAPLTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);

[StartIndex,StopIndex] = FindTableDates(RSIAAPLTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthAAPL=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthAAPL(ii,1)=meanRSI;
    end
end
ab=3;
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-AAPL');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIAAPLTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityAAPLTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','AAPL');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with ABBV
istocknum=2;
nowSheet=sheets(2);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
EquityABBV = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityABBV.Close,10,'omitnan');
Meandays50=movmean(EquityABBV.Close,50,'omitnan');
nowCol=2;
SelectStockHistory{1,nowCol}=nowSheet;
SelectStockHistory{2,nowCol}=EquityABBV.Close;
ABBVStockPrices(:,1)=EquityABBV.Close;
ST = timetable(MeasurementDate,AAPLStockPrices,ABBVStockPrices);
T2 = addvars(EquityABBV,Meandays10,Meandays50);
EquityABBVTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityABBVTT);
SheetRecords(2,1)=numrec;
filestr2=strcat('Importing DataSet 2 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr2);
disp(filestr2);
TableList{2,1}='EquityABBVTT';
TMWTable=EquityABBV;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollABBVTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{2,1}='BollABBVTT';
WorkBollTT=BollABBVTT;
% Calulate the Relative Strength Index Metric
RSIABBVTT = rsindex(BollABBVTT);
RSIWhole=RSIABBVTT.RelativeStrengthIndex;
numvals=height(RSIABBVTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIABBVTT = addvars(RSIABBVTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIABBVTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthABBV=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthABBV(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-ABBV');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIABBVTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM-
TMOM=EquityABBVTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','ABBV');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityABBVTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','ABBV');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)

%% Continue with ALB
istocknum=3;
nowSheet=sheets(3);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
EquityALB = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityALB.Close,10,'omitnan');
Meandays50=movmean(EquityALB.Close,50,'omitnan');
ALBStockPrices(:,1)=EquityALB.Close;
ST = addvars(ST,ALBStockPrices);
T2 = addvars(EquityALB,Meandays10,Meandays50);
EquityALBTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityALBTT);
SheetRecords(3,1)=numrec;
filestr3=strcat('Importing DataSet 3 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr3);
disp(filestr3);
TableList{3,1}='EquityALBTT';
TMWTable=EquityALB;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollALBTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{3,1}='BollALBTT';
WorkBollTT=BollALBTT;
% Calulate the Relative Strength Index Metric
RSIALBTT = rsindex(BollALBTT);
RSIWhole=RSIALBTT.RelativeStrengthIndex;
numvals=height(RSIALBTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIALBTT = addvars(RSIALBTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIALBTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthALB=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthALB(ii,1)=meanRSI;
    end
end
ab=3;
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-ALB');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIABBVTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityALBTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','ALB');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with AMD
istocknum=4;
nowSheet=sheets(4);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
EquityAMD = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityAMD.Close,10,'omitnan');
Meandays50=movmean(EquityAMD.Close,50,'omitnan');
AMDStockPrices(:,1)=EquityAMD.Close;
ST = addvars(ST,AMDStockPrices);
T2 = addvars(EquityAMD,Meandays10,Meandays50);
EquityAMDTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityALBTT);
SheetRecords(4,1)=numrec;
filestr4=strcat('Importing DataSet 4 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr4);
disp(filestr4);
TableList{4,1}='EquityAMDTT';
TMWTable=EquityAMD;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollAMDTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{4,1}='BollAMDTT';
WorkBollTT=BollAMDTT;
% Calulate the Relative Strength Index Metric
RSIAMDTT = rsindex(BollAMDTT);
RSIWhole=RSIAMDTT.RelativeStrengthIndex;
numvals=height(RSIAMDTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIAMDTT = addvars(RSIAMDTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIAMDTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthAMD=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthAMD(ii,1)=meanRSI;
    end
end
ab=4;
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-AMD');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIAMDTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityAMDTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','AMD');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with AMZN
istocknum=5;
nowSheet=sheets(5);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
EquityAMZN = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityAMZN.Close,10,'omitnan');
Meandays50=movmean(EquityAMZN.Close,50,'omitnan');
AMZNStockPrices(:,1)=EquityAMZN.Close;
ST = addvars(ST,AMZNStockPrices);
T2 = addvars(EquityAMZN,Meandays10,Meandays50);
EquityAMZNTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityAMZNTT);
SheetRecords(5,1)=numrec;
filestr5=strcat('Importing DataSet 5 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr5);
disp(filestr5);
TableList{5,1}='EquityAMZNTT';
TMWTable=EquityAMZN;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollAMZNTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{5,1}='BollAMZNTT';
WorkBollTT=BollAMZNTT;
% Calulate the Relative Strength Index Metric
RSIAMZNTT = rsindex(BollAMZNTT);
RSIWhole=RSIAMZNTT.RelativeStrengthIndex;
numvals=height(RSIAMZNTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIAMZNTT = addvars(RSIAMZNTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIAMZNTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthAMZN=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthAMZN(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-AMZN');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIAMZNTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityAMZNTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','AMZN');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with CAT
istocknum=6;
nowSheet=sheets(6);
EquityCAT = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityCAT.Close,10,'omitnan');
Meandays50=movmean(EquityCAT.Close,50,'omitnan');
CATStockPrices(:,1)=EquityCAT.Close;
ST = addvars(ST,CATStockPrices);
T2 = addvars(EquityCAT,Meandays10,Meandays50);
EquityCATTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityCATTT);
SheetRecords(6,1)=numrec;
filestr6=strcat('Importing DataSet 6 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr6);
disp(filestr6);
TableList{6,1}='EquityCATTT';
TMWTable=EquityCAT;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollCATTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{6,1}='BollCATTT';
WorkBollTT=BollCATTT;
% Calulate the Relative Strength Index Metric
RSICATTT = rsindex(BollCATTT);
RSIWhole=RSICATTT.RelativeStrengthIndex;
numvals=height(RSICATTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSICATTT = addvars(RSICATTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSICATTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthCAT=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthCAT(ii,1)=meanRSI;
    end
end
ab=6;
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-CAT');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSICATTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityCATTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','CAT');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with CCL
istocknum=7;
nowSheet=sheets(7);
EquityCCL = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityCCL.Close,10,'omitnan');
Meandays50=movmean(EquityCCL.Close,50,'omitnan');
CCLStockPrices(:,1)=EquityCCL.Close;
ST = addvars(ST,CCLStockPrices);
T2 = addvars(EquityCCL,Meandays10,Meandays50);
EquityCCLTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityCCLTT);
SheetRecords(7,1)=numrec;
filestr7=strcat('Importing DataSet 7 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr7);
disp(filestr7);
TableList{7,1}='EquityCCLTT';
TMWTable=EquityCCL;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollCCLTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{7,1}='BollCCLTT';
WorkBollTT=BollCCLTT;
% Calulate the Relative Strength Index Metric
RSICCLTT = rsindex(BollCCLTT);
RSIWhole=RSICCLTT.RelativeStrengthIndex;
numvals=height(RSICCLTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSICCLTT = addvars(RSICCLTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSICCLTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthCCL=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthCCL(ii,1)=meanRSI;
    end
end
ab=7;
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-CCL');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSICCLTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityCCLTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','CCL');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with CDNS
istocknum=8;
nowSheet=sheets(8);
EquityCDNS = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityCDNS.Close,10,'omitnan');
Meandays50=movmean(EquityCDNS.Close,50,'omitnan');
CDNSStockPrices(:,1)=EquityCDNS.Close;
ST = addvars(ST,CDNSStockPrices);
T2 = addvars(EquityCDNS,Meandays10,Meandays50);
EquityCDNSTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityCDNSTT);
SheetRecords(8,1)=numrec;
filestr8=strcat('Importing DataSet 8 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr8);
disp(filestr8);
TableList{8,1}='EquityCDNSTT';
TMWTable=EquityCDNS;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollCDNSTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{8,1}='BollCDNSTT';
WorkBollTT=BollCDNSTT;
% Calulate the Relative Strength Index Metric
RSICDNSTT = rsindex(BollCDNSTT);
RSIWhole=RSICDNSTT.RelativeStrengthIndex;
numvals=height(RSICDNSTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSICDNSTT = addvars(RSICDNSTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSICDNSTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthCDNS=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthCDNS(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-CDNS');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSICDNSTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityCDNSTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','CDNS');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%& Continue with CMI
istocknum=9;
nowSheet=sheets(9);
EquityCMI = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityCMI.Close,10,'omitnan');
Meandays50=movmean(EquityCMI.Close,50,'omitnan');
CMIStockPrices(:,1)=EquityCMI.Close;
ST = addvars(ST,CMIStockPrices);
T2 = addvars(EquityCMI,Meandays10,Meandays50);
EquityCMITT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityCDNSTT);
SheetRecords(9,1)=numrec;
filestr9=strcat('Importing DataSet 9 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr9);
disp(filestr9);
TableList{9,1}='EquityCMITT';
TMWTable=EquityCMI;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollCMITT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{9,1}='BollCMITT';
WorkBollTT=BollCMITT;
% Calulate the Relative Strength Index Metric
RSICMITT = rsindex(BollCMITT);
RSIWhole=RSICMITT.RelativeStrengthIndex;
numvals=height(RSICMITT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSICMITT = addvars(RSICMITT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSICMITT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthCMI=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthCMI(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-CMI');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSICMITT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityCMITT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','CMI');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with DBX
istocknum=10;
nowSheet=sheets(10);
EquityDBX = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityDBX.Close,10,'omitnan');
Meandays50=movmean(EquityDBX.Close,50,'omitnan');
DBXStockPrices(:,1)=EquityDBX.Close;
ST = addvars(ST,DBXStockPrices);
T2 = addvars(EquityDBX,Meandays10,Meandays50);
EquityDBXTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityDBXTT);
SheetRecords(10,1)=numrec;
filestr10=strcat('Importing DataSet 10 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr10);
disp(filestr10);
TableList{10,1}='EquityDBXTT';
TMWTable=EquityDBX;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollDBXTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{10,1}='BollDBXTT';
WorkBollTT=BollDBXTT;
% Calulate the Relative Strength Index Metric
RSIDBXTT = rsindex(BollDBXTT);
RSIWhole=RSIDBXTT.RelativeStrengthIndex;
numvals=height(RSIDBXTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIDBXTT = addvars(RSIDBXTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIDBXTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthDBX=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthDBX(ii,1)=meanRSI;
    end
end

% Plot The RSI Metric over time
titlestr=strcat('RSI-For-DBX');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIDBXTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityDBXTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','DBX');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with DELL
istocknum=11;
nowSheet=sheets(11);
EquityDELL = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityDELL.Close,10,'omitnan');
Meandays50=movmean(EquityDELL.Close,50,'omitnan');
DELLStockPrices(:,1)=EquityDELL.Close;
ST = addvars(ST,DELLStockPrices);
T2 = addvars(EquityDELL,Meandays10,Meandays50);
EquityDELLTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityDELLTT);
SheetRecords(11,1)=numrec;
filestr11=strcat('Importing DataSet 11 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr11);
disp(filestr11);
TableList{11,1}='EquityDELLTT';
TMWTable=EquityDELL;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollDELLTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{11,1}='BollDELLTT';
WorkBollTT=BollDELLTT;
% Calulate the Relative Strength Index Metric
RSIDELLTT = rsindex(BollDELLTT);
RSIWhole=RSIDELLTT.RelativeStrengthIndex;
numvals=height(RSIDELLTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIDELLTT = addvars(RSIDELLTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIDELLTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthDELL=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthDELL(ii,1)=meanRSI;
    end
end
ab=11;
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-DELL');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIDELLTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityDELLTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','DELL');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with DOCU
istocknum=12;
nowSheet=sheets(12);
EquityDOCU = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityDOCU.Close,10,'omitnan');
Meandays50=movmean(EquityDOCU.Close,50,'omitnan');
DOCUStockPrices(:,1)=EquityDOCU.Close;
ST = addvars(ST,DOCUStockPrices);
T2 = addvars(EquityDOCU,Meandays10,Meandays50);
EquityDOCUTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityDOCUTT);
SheetRecords(12,1)=numrec;
filestr12=strcat('Importing DataSet 12 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr12);
disp(filestr12);
TableList{12,1}='EquityDOCUTT';
TMWTable=EquityDOCU;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollDOCUTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{12,1}='BollDOCUTT';
WorkBollTT=BollDOCUTT;
% Calulate the Relative Strength Index Metric
RSIDOCUTT = rsindex(BollDOCUTT);
RSIWhole=RSIDOCUTT.RelativeStrengthIndex;
numvals=height(RSIDOCUTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIDOCUTT = addvars(RSIDOCUTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIDOCUTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthDOCU=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthDOCU(ii,1)=meanRSI;
    end
end

% Plot The RSI Metric over time
titlestr=strcat('RSI-For-DOCU');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIDOCUTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityDOCUTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','DOCU');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with ENB
istocknum=13;
nowSheet=sheets(13);
EquityENB = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityENB.Close,10,'omitnan');
Meandays50=movmean(EquityENB.Close,50,'omitnan');
ENBStockPrices(:,1)=EquityENB.Close;
ST = addvars(ST,ENBStockPrices);
T2 = addvars(EquityENB,Meandays10,Meandays50);
EquityENBTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityENBTT);
SheetRecords(13,1)=numrec;
filestr13=strcat('Importing DataSet 13 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr13);
disp(filestr13);
TableList{13,1}='EquityENBTT';
TMWTable=EquityENB;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollENBTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{13,1}='BollENBTT';
WorkBollTT=BollENBTT;
% Calulate the Relative Strength Index Metric
RSIENBTT = rsindex(BollENBTT);
RSIWhole=RSIENBTT.RelativeStrengthIndex;
numvals=height(RSIENBTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIENBTT = addvars(RSIENBTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIENBTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthENB=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthENB(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-ENB');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIENBTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityENBTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','ENB');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%& Continue with ET
istocknum=14;
nowSheet=sheets(14);
EquityET = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityET.Close,10,'omitnan');
Meandays50=movmean(EquityET.Close,50,'omitnan');
ETStockPrices(:,1)=EquityET.Close;
ST = addvars(ST,ETStockPrices);
T2 = addvars(EquityET,Meandays10,Meandays50);
EquityETTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityETTT);
SheetRecords(14,1)=numrec;
filestr14=strcat('Importing DataSet 14 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr14);
disp(filestr14);
TableList{14,1}='EquityETTT';
TMWTable=EquityET;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollETTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{14,1}='BollETTT';
WorkBollTT=BollETTT;
% Calulate the Relative Strength Index Metric
RSIETTT = rsindex(BollETTT);
RSIWhole=RSIETTT.RelativeStrengthIndex;
numvals=height(RSIETTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIETTT = addvars(RSIETTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIETTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthET=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthET(ii,1)=meanRSI;
    end
end

% Plot The RSI Metric over time
titlestr=strcat('RSI-For-ET');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIETTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityETTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','ET');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with GE
istocknum=15;
nowSheet=sheets(15);
EquityGE = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityGE.Close,10,'omitnan');
Meandays50=movmean(EquityGE.Close,50,'omitnan');
GEStockPrices(:,1)=EquityGE.Close;
ST = addvars(ST,GEStockPrices);
T2 = addvars(EquityGE,Meandays10,Meandays50);
EquityGETT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityGETT);
SheetRecords(15,1)=numrec;
filestr15=strcat('Importing DataSet 15 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr15);
disp(filestr15);
TableList{15,1}='EquityGETT';
TMWTable=EquityGE;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollGETT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{15,1}='BollGETT';
WorkBollTT=BollGETT;
% Calulate the Relative Strength Index Metric
RSIGETT = rsindex(BollGETT);
RSIWhole=RSIGETT.RelativeStrengthIndex;
numvals=height(RSIGETT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIGETT = addvars(RSIGETT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIGETT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthGE=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthGE(ii,1)=meanRSI;
        ab=1;
    end
end

% Plot The RSI Metric over time
titlestr=strcat('RSI-For-GE');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIGETT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityGETT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','GE');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with GOOGL
istocknum=16;
nowSheet=sheets(16);
EquityGOOG = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityGOOG.Close,10,'omitnan');
Meandays50=movmean(EquityGOOG.Close,50,'omitnan');
GOOGStockPrices(:,1)=EquityGOOG.Close;
ST = addvars(ST,GOOGStockPrices);
T2 = addvars(EquityGOOG,Meandays10,Meandays50);
EquityGOOGTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityGOOGTT);
SheetRecords(16,1)=numrec;
filestr16=strcat('Importing DataSet 16 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr16);
disp(filestr16);
TableList{16,1}='EquityGOOGTT';
TMWTable=EquityGOOG;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollGOOGTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{16,1}='BollGOOGTT';
WorkBollTT=BollGETT;
% Calulate the Relative Strength Index Metric
RSIGOOGTT = rsindex(BollGOOGTT);
RSIWhole=RSIGOOGTT.RelativeStrengthIndex;
numvals=height(RSIGOOGTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIGOOGTT = addvars(RSIGOOGTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIGOOGTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthGOOG=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthGOOG(ii,1)=meanRSI;
    end
end

% Plot The RSI Metric over time
titlestr=strcat('RSI-For-GOOG');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIGOOGTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityGOOGTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','GPPG');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)

%% Continue with GSL
istocknum=17;
nowSheet=sheets(17);
EquityGSL = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityGSL.Close,10,'omitnan');
Meandays50=movmean(EquityGSL.Close,50,'omitnan');
GSLStockPrices(:,1)=EquityGSL.Close;
ST = addvars(ST,GSLStockPrices);
T2 = addvars(EquityGSL,Meandays10,Meandays50);
EquityGSLTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityGSLTT);
SheetRecords(17,1)=numrec;
filestr17=strcat('Importing DataSet 17 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr17);
disp(filestr17);
TableList{17,1}='EquityGSLTT';
TMWTable=EquityGSL;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollGSLTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{17,1}='BollGSLTT';
WorkBollTT=BollGSLTT;
% Calulate the Relative Strength Index Metric
RSIGSLTT = rsindex(BollGSLTT);
RSIWhole=RSIGSLTT.RelativeStrengthIndex;
numvals=height(RSIGSLTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIGSLTT = addvars(RSIGSLTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIGSLTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthGSL=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthGSL(ii,1)=meanRSI;
    end
end
ab=17;
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-GSL');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIGSLTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityGSLTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','GSL');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with HII
istocknum=18;
nowSheet=sheets(18);
EquityHII = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityHII.Close,10,'omitnan');
Meandays50=movmean(EquityHII.Close,50,'omitnan');
HIIStockPrices(:,1)=EquityHII.Close;
ST = addvars(ST,HIIStockPrices);
T2 = addvars(EquityHII,Meandays10,Meandays50);
EquityHIITT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityHIITT);
SheetRecords(18,1)=numrec;
filestr18=strcat('Importing DataSet 18 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr18);
disp(filestr18);
TableList{18,1}='EquityHIITT';
TMWTable=EquityHII;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollHIITT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{18,1}='BollHIITT';
WorkBollTT=BollHIITT;
% Calulate the Relative Strength Index Metric
RSIHIITT = rsindex(BollHIITT);
RSIWhole=RSIHIITT.RelativeStrengthIndex;
numvals=height(RSIHIITT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIHIITT = addvars(RSIHIITT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIHIITT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthHII=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthHII(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-HII');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIHIITT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityHIITT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','HII');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with HWM
istocknum=19;
nowSheet=sheets(19);
EquityHWM = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityHWM.Close,10,'omitnan');
Meandays50=movmean(EquityHWM.Close,50,'omitnan');
HWMStockPrices(:,1)=EquityHWM.Close;
ST = addvars(ST,HWMStockPrices);
T2 = addvars(EquityHWM,Meandays10,Meandays50);
EquityHWMTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityHWMTT);
SheetRecords(19,1)=numrec;
filestr19=strcat('Importing DataSet 19 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr19);
disp(filestr19);
TableList{19,1}='EquityHWMTT';
TMWTable=EquityHWM;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollHWMTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{19,1}='BollHWMTT';
WorkBollTT=BollHWMTT;
% Calulate the Relative Strength Index Metric
RSIHWMTT = rsindex(BollHWMTT);
RSIWhole=RSIHWMTT.RelativeStrengthIndex;
numvals=height(RSIHWMTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIHWMTT = addvars(RSIHWMTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIHWMTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthHWM=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthHWM(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-HWM');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIHWMTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityHWMTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','HWM');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with LMT
istocknum=20;
nowSheet=sheets(20);
EquityLMT = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityLMT.Close,10,'omitnan');
Meandays50=movmean(EquityLMT.Close,50,'omitnan');
LMTStockPrices(:,1)=EquityLMT.Close;
ST = addvars(ST,LMTStockPrices);
T2 = addvars(EquityLMT,Meandays10,Meandays50);
EquityLMTTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityLMTTT);
SheetRecords(20,1)=numrec;
filestr20=strcat('Importing DataSet 20 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr20);
disp(filestr20);
TableList{20,1}='EquityLMTTT';
TMWTable=EquityLMT;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollLMTTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{20,1}='BollLMTTT';
WorkBollTT=BollLMTTT;
% Calulate the Relative Strength Index Metric
RSILMTTT = rsindex(BollLMTTT);
RSIWhole=RSILMTTT.RelativeStrengthIndex;
numvals=height(RSILMTTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSILMTTT = addvars(RSILMTTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSILMTTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthLMT=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthLMT(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-LMT');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSILMTTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityLMTTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','LMT');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with MSFT
istocknum=21;
nowSheet=sheets(21);
EquityMSFT = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityMSFT.Close,10,'omitnan');
Meandays50=movmean(EquityMSFT.Close,50,'omitnan');
MSFTStockPrices(:,1)=EquityMSFT.Close;
ST = addvars(ST,MSFTStockPrices);
T2 = addvars(EquityMSFT,Meandays10,Meandays50);
EquityMSFTTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityMSFTTT);
SheetRecords(21,1)=numrec;
filestr21=strcat('Importing DataSet 21 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr21);
disp(filestr21);
TableList{21,1}='EquityMSFTTT';
TMWTable=EquityMSFT;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollMSFTTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{21,1}='BollMSFTTT';
WorkBollTT=BollMSFTTT;
% Calulate the Relative Strength Index Metric
RSIMSFTTT = rsindex(BollMSFTTT);
RSIWhole=RSIMSFTTT.RelativeStrengthIndex;
numvals=height(RSIMSFTTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIMSFTTT = addvars(RSIMSFTTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIMSFTTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthMSFT=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthMSFT(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-MSFT');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIMSFTTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityMSFTTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','MSFT');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)

%% Continue with NVDA
istocknum=22;
nowSheet=sheets(22);
EquityNVDA = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityNVDA.Close,10,'omitnan');
Meandays50=movmean(EquityNVDA.Close,50,'omitnan');
NVDAStockPrices(:,1)=EquityNVDA.Close;
ST = addvars(ST,NVDAStockPrices);
T2 = addvars(EquityNVDA,Meandays10,Meandays50);
EquityNVDATT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityNVDATT);
SheetRecords(22,1)=numrec;
filestr22=strcat('Importing DataSet 22 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr22);
disp(filestr22);
TableList{22,1}='EquityNVDATT';
TMWTable=EquityNVDA;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollNVDATT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{22,1}='BollNVDATT';
WorkBollTT=BollNVDATT;
% Calulate the Relative Strength Index Metric
RSINVDATT = rsindex(BollNVDATT);
RSIWhole=RSINVDATT.RelativeStrengthIndex;
numvals=height(RSINVDATT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSINVDATT = addvars(RSINVDATT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSINVDATT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthNVDA=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthNVDA(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-NVDA');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSINVDATT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityNVDATT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','NVDA');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with NVO
istocknum=23;
nowSheet=sheets(23);
EquityNVO = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityNVO.Close,10,'omitnan');
Meandays50=movmean(EquityNVO.Close,50,'omitnan');
NVOStockPrices(:,1)=EquityNVO.Close;
ST = addvars(ST,NVOStockPrices);
T2 = addvars(EquityNVO,Meandays10,Meandays50);
EquityNVOTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityNVOTT);
SheetRecords(23,1)=numrec;
filestr23=strcat('Importing DataSet 23 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr23);
disp(filestr23);
TableList{23,1}='EquityNVOTT';
TMWTable=EquityNVO;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollNVOTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{23,1}='BollNVOTT';
WorkBollTT=BollNVOTT;
% Calulate the Relative Strength Index Metric
RSINVOTT = rsindex(BollNVOTT);
RSIWhole=RSINVOTT.RelativeStrengthIndex;
numvals=height(RSINVOTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSINVOTT = addvars(RSINVOTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSINVOTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthNVO=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthNVO(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-NVO');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSINVOTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityNVOTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','NVO');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with OC
istocknum=24;
nowSheet=sheets(24);
EquityOC = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityOC.Close,10,'omitnan');
Meandays50=movmean(EquityOC.Close,50,'omitnan');
OCStockPrices(:,1)=EquityOC.Close;
ST = addvars(ST,OCStockPrices);
T2 = addvars(EquityOC,Meandays10,Meandays50);
EquityOCTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityOCTT);
SheetRecords(24,1)=numrec;
filestr24=strcat('Importing DataSet 24 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr24);
disp(filestr24);
TableList{24,1}='EquityOCTT';
TMWTable=EquityOC;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollOCTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{24,1}='BollOCTT';
WorkBollTT=BollOCTT;
% Calulate the Relative Strength Index Metric
RSIOCTT = rsindex(BollOCTT);
RSIWhole=RSIOCTT.RelativeStrengthIndex;
numvals=height(RSIOCTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIOCTT = addvars(RSIOCTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIOCTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthOC=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthOC(ii,1)=meanRSI;
    end
end
%% Test plot of pseudo heatmap
StockList2=StockList';
XCenters=zeros(12,1);
YCenters=zeros(24,1);
XCenters=1:1:12;
XCenters=XCenters';
YCenters=1:1:24;
YCenters=YCenters';
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-OC');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIOCTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityOCTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','OC');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with PAGP
istocknum=25;
nowSheet=sheets(25);
EquityPAGP = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityPAGP.Close,10,'omitnan');
Meandays50=movmean(EquityPAGP.Close,50,'omitnan');
PAGPStockPrices(:,1)=EquityPAGP.Close;
ST = addvars(ST,PAGPStockPrices);
T2 = addvars(EquityPAGP,Meandays10,Meandays50);
EquityPAGPTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityPAGPTT);
SheetRecords(25,1)=numrec;
filestr25=strcat('Importing DataSet 25 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr25);
disp(filestr25);
TableList{25,1}='EquityPAGPTT';
TMWTable=EquityPAGP;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollPAGPTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{25,1}='BollPAGPTT';
WorkBollTT=BollPAGPTT;
% Calulate the Relative Strength Index Metric
RSIPAGPTT = rsindex(BollPAGPTT);
RSIWhole=RSIPAGPTT.RelativeStrengthIndex;
numvals=height(RSIPAGPTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIPAGPTT = addvars(RSIPAGPTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIPAGPTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthPAGP=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthPAGP(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-PAGP');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIPAGPTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityPAGPTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','PAGP');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with PFE
istocknum=26;
nowSheet=sheets(26);
EquityPFE = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityPFE.Close,10,'omitnan');
Meandays50=movmean(EquityPFE.Close,50,'omitnan');
PFEStockPrices(:,1)=EquityPFE.Close;
ST = addvars(ST,PFEStockPrices);
T2 = addvars(EquityPFE,Meandays10,Meandays50);
EquityPFETT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityPFETT);
SheetRecords(26,1)=numrec;
filestr26=strcat('Importing DataSet 26 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr26);
disp(filestr26);
TableList{26,1}='EquityPFETT';
TMWTable=EquityPFE;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollPFETT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{26,1}='BollPFETT';
WorkBollTT=BollPFETT;
% Calulate the Relative Strength Index Metric
RSIPFETT = rsindex(BollPFETT);
RSIWhole=RSIPFETT.RelativeStrengthIndex;
numvals=height(RSIPFETT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIPFETT = addvars(RSIPFETT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIPFETT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthPFE=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthPFE(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-PFE');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIPFETT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityPFETT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','PFE');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with PHM
istocknum=27;
nowSheet=sheets(27);
EquityPHM = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityPHM.Close,10,'omitnan');
Meandays50=movmean(EquityPHM.Close,50,'omitnan');
PHMStockPrices(:,1)=EquityPHM.Close;
ST = addvars(ST,PHMStockPrices);
T2 = addvars(EquityPHM,Meandays10,Meandays50);
EquityPHMTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityPHMTT);
SheetRecords(27,1)=numrec;
filestr27=strcat('Importing DataSet 27 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr27);
disp(filestr27);
TableList{27,1}='EquityPHMTT';
TMWTable=EquityPHM;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollPHMTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{27,1}='BollPHMTT';
WorkBollTT=BollPHMTT;
% Calulate the Relative Strength Index Metric
RSIPHMTT = rsindex(BollPHMTT);
RSIWhole=RSIPHMTT.RelativeStrengthIndex;
numvals=height(RSIPHMTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIPHMTT = addvars(RSIPHMTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIPHMTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthPHM=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthPHM(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-PHM');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIPHMTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityPHMTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','PHM');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with PLTR
istocknum=28;
nowSheet=sheets(28);
EquityPLTR = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityPLTR.Close,10,'omitnan');
Meandays50=movmean(EquityPLTR.Close,50,'omitnan');
PLTRStockPrices(:,1)=EquityPLTR.Close;
ST = addvars(ST,PLTRStockPrices);
T2 = addvars(EquityPLTR,Meandays10,Meandays50);
EquityPLTRTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityPLTRTT);
SheetRecords(28,1)=numrec;
filestr28=strcat('Importing DataSet 28 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr28);
disp(filestr28);
TableList{28,1}='EquityPLTRTT';
TMWTable=EquityPLTR;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollPLTRTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{28,1}='BollPLTRTT';
WorkBollTT=BollPLTRTT;
% Calulate the Relative Strength Index Metric
RSIPLTRTT = rsindex(BollPLTRTT);
RSIWhole=RSIPLTRTT.RelativeStrengthIndex;
numvals=height(RSIPLTRTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIPLTRTT = addvars(RSIPLTRTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIPLTRTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthPLTR=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthPLTR(ii,1)=meanRSI;
    end
end

% Plot The RSI Metric over time
titlestr=strcat('RSI-For-PLTR');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIPLTRTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityPLTRTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','PLTR');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with RCL
istocknum=29;
nowSheet=sheets(29);
EquityRCL = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityRCL.Close,10,'omitnan');
Meandays50=movmean(EquityRCL.Close,50,'omitnan');
RCLStockPrices(:,1)=EquityRCL.Close;
ST = addvars(ST,RCLStockPrices);
T2 = addvars(EquityRCL,Meandays10,Meandays50);
EquityRCLTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityRCLTT);
SheetRecords(29,1)=numrec;
filestr29=strcat('Importing DataSet 29 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr29);
disp(filestr29);
TableList{29,1}='EquityRCLTT';
TMWTable=EquityRCL;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollRCLTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{29,1}='BollRCLTT';
WorkBollTT=BollRCLTT;
% Calulate the Relative Strength Index Metric
RSIRCLTT = rsindex(BollRCLTT);
RSIWhole=RSIRCLTT.RelativeStrengthIndex;
numvals=height(RSIRCLTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIRCLTT = addvars(RSIRCLTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIRCLTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthRCL=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthRCL(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-RCL');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIRCLTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityRCLTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','RCL');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with RIO
istocknum=30;
nowSheet=sheets(30);
EquityRIO = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityRIO.Close,10,'omitnan');
Meandays50=movmean(EquityRIO.Close,50,'omitnan');
RIOStockPrices(:,1)=EquityRIO.Close;
ST = addvars(ST,RIOStockPrices);
T2 = addvars(EquityRIO,Meandays10,Meandays50);
EquityRIOTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityRIOTT);
SheetRecords(30,1)=numrec;
filestr30=strcat('Importing DataSet 30 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr30);
disp(filestr30);
TableList{30,1}='EquityRIOTT';
TMWTable=EquityRIO;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollRIOTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{30,1}='BollRIOTT';
WorkBollTT=BollRIOTT;
% Calulate the Relative Strength Index Metric
RSIRIOTT = rsindex(BollRIOTT);
RSIWhole=RSIRIOTT.RelativeStrengthIndex;
numvals=height(RSIRIOTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIRIOTT = addvars(RSIRIOTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIRIOTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthRIO=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthRIO(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-RIO');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIRIOTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityRIOTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','RIO');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with SMCI
istocknum=31;
nowSheet=sheets(31);
EquitySMCI = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquitySMCI.Close,10,'omitnan');
Meandays50=movmean(EquitySMCI.Close,50,'omitnan');
SMCIStockPrices(:,1)=EquitySMCI.Close;
ST = addvars(ST,SMCIStockPrices);
T2 = addvars(EquitySMCI,Meandays10,Meandays50);
EquitySMCITT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquitySMCITT);
SheetRecords(31,1)=numrec;
filestr31=strcat('Importing DataSet 31 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr31);
disp(filestr31);
TableList{31,1}='EquitySMCITT';
TMWTable=EquitySMCI;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollSMCITT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{31,1}='BollSMCITT';
WorkBollTT=BollSMCITT;
% Calulate the Relative Strength Index Metric
RSISMCITT = rsindex(BollSMCITT);
RSIWhole=RSISMCITT.RelativeStrengthIndex;
numvals=height(RSISMCITT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSISMCITT = addvars(RSISMCITT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSISMCITT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthSMCI=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthSMCI(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-SMCI');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSISMCITT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquitySMCITT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','SMCI');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)

%& Continue with THC
istocknum=32;
nowSheet=sheets(32);
EquityTHC = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityTHC.Close,10,'omitnan');
Meandays50=movmean(EquityTHC.Close,50,'omitnan');
THCStockPrices(:,1)=EquityTHC.Close;
ST = addvars(ST,THCStockPrices);
T2 = addvars(EquityTHC,Meandays10,Meandays50);
EquityTHCTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityTHCTT);
SheetRecords(32,1)=numrec;
filestr32=strcat('Importing DataSet 32 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr32);
disp(filestr32);
TableList{32,1}='EquityTHCTT';
TMWTable=EquityTHC;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollTHCTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{32,1}='BollTHCTT';
WorkBollTT=BollTHCTT;
% Calulate the Relative Strength Index Metric
RSITHCTT = rsindex(BollTHCTT);
RSIWhole=RSITHCTT.RelativeStrengthIndex;
numvals=height(RSITHCTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSITHCTT = addvars(RSITHCTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSITHCTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthTHC=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthTHC(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-THC');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSITHCTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityTHCTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','PAGP');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with TOL
istocknum=33;
nowSheet=sheets(33);
EquityTOL = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityTOL.Close,10,'omitnan');
Meandays50=movmean(EquityTOL.Close,50,'omitnan');
TOLStockPrices(:,1)=EquityTOL.Close;
ST = addvars(ST,TOLStockPrices);
T2 = addvars(EquityTOL,Meandays10,Meandays50);
EquityTOLTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityTOLTT);
SheetRecords(33,1)=numrec;
filestr33=strcat('Importing DataSet 33 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr33);
disp(filestr33);
TableList{33,1}='EquityTHCTT';
TMWTable=EquityTOL;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollTOLTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{33,1}='BollTOLTT';
WorkBollTT=BollTOLTT;
% Calulate the Relative Strength Index Metric
RSITOLTT = rsindex(BollTOLTT);
RSIWhole=RSITOLTT.RelativeStrengthIndex;
numvals=height(RSITOLTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSITOLTT = addvars(RSITOLTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSITOLTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthTOL=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthTOL(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-TOL');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSITOLTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityTOLTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','TOL');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with VZ
istocknum=34;
nowSheet=sheets(34);
EquityVZ = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityVZ.Close,10,'omitnan');
Meandays50=movmean(EquityVZ.Close,50,'omitnan');
VZStockPrices(:,1)=EquityVZ.Close;
ST = addvars(ST,VZStockPrices);
T2 = addvars(EquityVZ,Meandays10,Meandays50);
EquityVZTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityVZTT);
SheetRecords(34,1)=numrec;
filestr34=strcat('Importing DataSet 34 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr34);
disp(filestr34);
TableList{34,1}='EquityVZTT';
TMWTable=EquityVZ;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollVZTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{34,1}='BollVZTT';
WorkBollTT=BollVZTT;
% Calulate the Relative Strength Index Metric
RSIVZTT = rsindex(BollVZTT);
RSIWhole=RSIVZTT.RelativeStrengthIndex;
numvals=height(RSIVZTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIVZTT = addvars(RSIVZTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIVZTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthVZ=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthVZ(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-VZ');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIVZTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityVZTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','VZ');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with XOM
istocknum=35;
nowSheet=sheets(35);
EquityXOM = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityXOM.Close,10,'omitnan');
Meandays50=movmean(EquityXOM.Close,50,'omitnan');
XOMStockPrices(:,1)=EquityXOM.Close;
ST = addvars(ST,XOMStockPrices);
T2 = addvars(EquityXOM,Meandays10,Meandays50);
EquityXOMTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityXOMTT);
SheetRecords(35,1)=numrec;
filestr35=strcat('Importing DataSet 35 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr35);
disp(filestr35);
TableList{35,1}='EquityXOMTT';
TMWTable=EquityXOM;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollXOMTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{35,1}='BollXOMTT';
WorkBollTT=BollXOMTT;
% Calulate the Relative Strength Index Metric
RSIXOMTT = rsindex(BollXOMTT);
RSIWhole=RSIXOMTT.RelativeStrengthIndex;
numvals=height(RSIXOMTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIXOMTT = addvars(RSIXOMTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIXOMTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthXOM=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthXOM(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-XOM');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIXOMTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityXOMTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','XOM');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Continue with YOU
istocknum=36;
nowSheet=sheets(36);
EquityYOU = readtable(EquityStockDataFile,'Sheet',nowSheet);
Meandays10=movmean(EquityYOU.Close,10,'omitnan');
Meandays50=movmean(EquityYOU.Close,50,'omitnan');
YOUStockPrices(:,1)=EquityYOU.Close;
ST = addvars(ST,YOUStockPrices);
T2 = addvars(EquityYOU,Meandays10,Meandays50);
EquityYOUTT = table2timetable(T2,'RowTimes','Date');
numrec=height(EquityYOUTT);
SheetRecords(36,1)=numrec;
filestr36=strcat('Importing DataSet 36 from sheet-',nowSheet);
fprintf(fid,'%20s\n',filestr36);
disp(filestr36);
TableList{36,1}='EquityYOUTT';
TMWTable=EquityYOU;
TMW2Table = renamevars(TMWTable,["Date"],["Time"]);
TMW3Table = removevars(TMW2Table,["AdjClose"]);
BollYOUTT = table2timetable(TMW3Table,'RowTimes','Time');
BollingerList{36,1}='BollYOUTT';
WorkBollTT=BollYOUTT;
% Calulate the Relative Strength Index Metric
RSIYOUTT = rsindex(BollYOUTT);
RSIWhole=RSIYOUTT.RelativeStrengthIndex;
numvals=height(RSIYOUTT);
Oversold=30*ones(numvals,1);
Overbought=70*ones(numvals,1);
RSIYOUTT = addvars(RSIYOUTT,Oversold,Overbought);
CalculateRSIStats(RSIWhole);
CountRSIReadings(RSIWhole);
[StartIndex,StopIndex] = FindTableDates(RSIYOUTT,numvals);
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonthYOU=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonthYOU(ii,1)=meanRSI;
    end
end
% Plot The RSI Metric over time
titlestr=strcat('RSI-For-YOU');
ikind=1;
PlotStockTableTechnicalIndicators(titlestr,RSIYOUTT,ikind,istocknum)
% Compute the Momentum Metric TSMOM
TMOM=EquityYOUTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
momentum = tsmom(TMOM); 
titlestr=strcat('TSMOMValueForStock-','YOU');
ikind=2;
PlotStockTableTechnicalIndicators(titlestr,momentum,ikind,istocknum)
%% Create a HeatMap Table and Plot it
StockList2=StockList';
XCenters=1:1:12;
XCenters=XCenters';
YCenters=1:1:36;
YCenters=YCenters';
HeatMapTable=  table(Months,RMonthAAPL,RMonthABBV,RMonthALB,RMonthAMD);%4
HeatMapTable=  addvars(HeatMapTable,RMonthAMZN,RMonthCAT,RMonthCCL,RMonthCDNS);%8
HeatMapTable = addvars(HeatMapTable,RMonthCMI,RMonthDBX,RMonthDELL,RMonthDOCU);%12
HeatMapTable = addvars(HeatMapTable,RMonthENB,RMonthET,RMonthGE,RMonthGOOG);%16
HeatMapTable = addvars(HeatMapTable,RMonthGSL,RMonthHII,RMonthHWM,RMonthLMT);%20
HeatMapTable = addvars(HeatMapTable,RMonthMSFT,RMonthNVDA,RMonthNVO,RMonthOC);%24
HeatMapTable = addvars(HeatMapTable,RMonthPAGP,RMonthPFE,RMonthPHM,RMonthPLTR);%28
HeatMapTable = addvars(HeatMapTable,RMonthRCL,RMonthRIO,RMonthSMCI,RMonthTHC);%32
HeatMapTable = addvars(HeatMapTable,RMonthTOL,RMonthVZ,RMonthXOM,RMonthYOU);%36
titlestr='HeatMapByStockAndMonth';
PlotRSIHeatMap(titlestr)
ab=1;
%% Calculate the correlation coefficients of each stock against the others
SArray = table2array(ST) ;
for i=1:numsheets
    for j=1:numsheets
        A=SArray(:,i);
        B=SArray(:,j);
        R= corrcoef(A,B);
        RCoeff(i,j)=R(1,2);
        nowSheet1=char(sheets(i));
        nowSheet2=char(sheets(j));
        combName=strcat(nowSheet1,'-',nowSheet2);
        RCoeffNames{i,j}=combName;
    end
end
% Now plot this data as an image
titlestr=strcat('Year=',num2str(dataYear),'-Price-Correlation');
PlotStockPriceCorrelation(titlestr)
% Now create a table of these stock Correlations
StockNames=char(RCoeffNames);
RCoeff1D=reshape(RCoeff,numsheets*numsheets,1);
StockCorrTable = table(StockNames, RCoeff1D);
SortedStockTable=sortrows(StockCorrTable,2,'descend');
toDelete = SortedStockTable.RCoeff1D > .99;
SortedStockTable(toDelete,:) = [];
finalSize=size(SortedStockTable);
ab=2;
warning('on')
%% Now start saving these tables

%% Now start making some plots
% Do just the first 36 stocks on this list
% Loop thru the first 36 stocks
StockHdrs=cell(1,1);
StockHdrs{1,1}='Close Price Jan 1';
StockHdrs{2,1}='Close Price Dec 31';
for n=1:36
    WorkingTT=eval(char(TableList{n,1}));
    nowStock=char(IRAStockList2024(n));
    titlestr=strcat('Closing-Stock-prices-for-',nowStock);
    ikind=1;
    istocknum=n;
    PlotIRAYearlyStockTableRev1(titlestr,WorkingTT,ikind,istocknum)
    fprintf(fid,'%s\n',titlestr);
    disp(titlestr);
    titlestr=strcat('Closing-Stock-prices-for-',nowStock,'-with-bounds');
    ikind=2;
    PlotIRAYearlyStockTableRev1(titlestr,WorkingTT,ikind,istocknum)
    fprintf(fid,'%s\n',titlestr);
    disp(titlestr);
    titlestr=strcat('Daily-Trade-Volume-',nowStock);
    ikind=3;
    PlotIRAYearlyStockTableRev1(titlestr,WorkingTT,ikind,istocknum)
    fprintf(fid,'%s\n',titlestr);
    disp(titlestr);
    titlestr=char(strcat('BollingerLimits-',nowStock));
    ikind=4;
    % if(n==23)
    %     ab=4;
    % end
    WorkingTT=eval(char(BollingerList{n,1}));
    PlotIRAYearlyStockTableRev1(titlestr,WorkingTT,ikind,istocknum)
    fprintf(fid,'%s\n',titlestr);
    disp(titlestr);
end
%% Save the TimeTables Created
commandwindow
eval(['cd ' tablepath(1:length(tablepath)-1)]);
% Save the Equity Tables
actionstr='save';
varstr1='EquityAAPLTT EquityABBVTT EquityALBTT EquityAMDTT EquityAMZNTT EquityCATTT';
varstr2=' EquityCCLTT EquityCDNSTT EquityCMITT EquityDBXTT EquityDELLTT EquityDOCUTT';
varstr3=' EquityENBTT EquityETTT EquityGETT EquityGOOGTT EquityGSLTT EquityHIITT';
varstr4=' EquityHWMTT EquityLMTTT EquityMSFTTT EquityNVDATT EquityNVOTT EquityOCTT';
varstr5=' EquityPAGPTT EquityPFETT EquityPHMTT EquityPLTRTT EquityRCLTT EquityRIOTT';
varstr6=' EquitySMCITT EquityTHCTT EquityTOLTT EquityVZTT EquityXOMTT EquityYOUTT';
varstr7=' IRAStockList2024 TableList TableFileName BollingerList RCoeff RCoeffNames';
%varstr8=' StockStats StockHdrs SheetRecords sheets StockList StockSymbols';
varstr=strcat(varstr1,varstr2,varstr3,varstr4,varstr5,varstr6,varstr7);
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,TableFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Consolidated Table FileName-',TableFileName);
disp(dispstr);
fprintf(fid,'%s\n',dispstr);
disp('');
fprintf(fid,'\n');
fclose('all');
ab=2;
% Close a PDF report if one is created
a1=exist('rpt','var');
if((iCreatePDFReport==1) && (RptGenPresent==1))
    % if(iReport(62,1)==1)
    %     CreateAerosolDataAlgoDesc
    % end
    close(rpt);
    rptview(rpt)
    dispstr=strcat('Closed PDF Report-',pdffilename);
    disp(dispstr)
else
    disp('No pdf report generated by this run');
end
disp('Run Complete')
