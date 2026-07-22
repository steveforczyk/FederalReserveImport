% This script is designed to import FRED economic data into Matlab Format
%
% Written By: Stephen Forczyk
% Created: Jun 13,2025
% Revised: June 14-15,2025 added more tables such as
% Labor Force Participation Rate and Single Home Loans BudgetDebt
% Delinquancy Rate
% Revised: June 16-19,2025 added more tables and created an
% Object class called Fred to store results
% Revised: June 20-July 1 continued to add more items to list
% and added a Catalog Table
% Revised: Jul 17,2025 Continued to add new items
% Revised: Jul 19,2025 added routine CreateFredDetailsReport
% to allow details of each data set to be added to PDF report
% Revised: July 20-27,2025 added more data to PDF report and
% also imported the Flexible CPI Data
% Revised: Jul28-Nov15,2025 added more data to PDF Report
% Revised: Nov 16,2025 thru present-fixing numerous charts and eliminated
% unneeded statements
% Revised: Feb 19,2026 added new section on exchange rates
% Revised: March 2026: Added captions to numerous charts and Items 101-110
% Revised: April 2026 added Items 111-thru 125
% Revised: May 18-19 2026 start removing all global variable from code
% Revised: June 8,2026 Add commodity label to Catalog Table
% Revised: June 9-22 added addtional items focussed on food costs


% Set Up some initial Data
MSFileName='MorganStanleyActivity2024Rev1.txt';
ActivityFile1='FullActivityIRA2024Rev2.xlsx';
MSpath='D:\Investing\';
excelpath='K:\Investing2\ExcelFiles\';
ExcelFileName='MSActivity2024Rev2.xlsx';
TableFileName='IRA2024ConsolidatedTable.mat';
tablepath='K:\Investing2\Tables\';
logfilepath='K:\Investing2\Log_Files\';
jpegpath='D:\Investing2\FRED_Data\Jpeg_Files\';
fredjpegpath='K:\Investing2\FRED_Data\FredJpeg\';
tiffpath='D:\Investing2\FRED_Data\Tiff_Files\';
pdfpath='K:\Investing2\PDF_Files]';
govjpegpath='K:\Investing2\gov_jpeg\';
matpath='K:\Investing2\MAT_Files\';
% Populate list of Fred Data files to be imported
fredpath='K:\Investing2\FRED_Data\';
fredfile1='UNRATE-1948-2024.xlsx';
fredfile2='CORESTICKM159SFRBATL.xlsx';
fredfile3='CIVPART-1948-2025.xlsx';
fredfile4='DelinquencyRateSingleHomes-1991-2025.xlsx';
fredfile5='HomeOwnership-1965-2025.xlsx';
fredfile6='IPMAN-1972-2025.xlsx';
fredfile7='RealMedianHouseholdIncome.xlsx';
fredfile8='CBOE-VIX.xlsx';
fredfile9='ConsumerConfidence-1978-2025.xlsx';
fredfile10='HouseInventory.xlsx';
fredfile11='Fed10YearBondYields.xlsx';
fredfile12='U2Rate-1967-2025.xlsx';
fredfile13='RealGDP-1947-2025.xlsx';
fredfile14='RealGDPPerCap-1947-2025.xlsx';
fredfile15='Fed2YearBondYields.xlsx';
fredfile16='InitialUnemploymentClaims.xlsx';
fredfile17='ContinuedUnemploymentClaims.xlsx';
fredfile18='TotalNonFarmJobOpen-2000-2025.xlsx';
fredfile19='ConstructionJobOpenings-2000-2025.xlsx';
fredfile20='ManufacturingJobOpenings-2000-2025.xlsx';
fredfile21='ProfJobOpen.xlsx';
fredfile22='HealthCareJobOpenings.xlsx';
fredfile23='GovJobOpenings.xlsx';
fredfile24='RealMedianPersonalIncome.xlsx';
fredfile25='T10Y2Y-1976-2025.xlsx';
fredfile26='VISASMIDNSA-2014-2025.xlsx';
fredfile27='CaseShillerHousePriceIndex.xlsx';
fredfile28='MedianWeeklyWage.xlsx';
fredfile29='FYGDP-1930-2023.xlsx';
fredfile30='PublicDebtvsGDP-1966-2025.xlsx';
fredfile31='BudgetSurplus.xlsx';
fredfile32='NetFedOutlays.xlsx';
fredfile33='FederalReceipts.xlsx';
fredfile34='FederalPublicDebt.xlsx';
fredfile35='FedInterestPctGDP.xlsx';
fredfile36='TreasuryDebt.xlsx';
fredfile37='DomesticAutoInventories.xlsx';
fredfile38='ForeignAutoSales.xlsx';
fredfile39='TotalVehicleSales.xlsx';
fredfile40='DomesticAutoProduction.xlsx';
fredfile41='AutoExports.xlsx';
fredfile42='VehicleMilesTravelled.xlsx';
fredfile43='FreightTransportIndex.xlsx';
fredfile44='RailCarloads.xlsx';
fredfile45='AirlineLoadfactor.xlsx';
fredfile46='ASM.xlsx';
fredfile47='PipelinePetrol.xlsx';
fredfile48='HouseStarts.xlsx';
fredfile49='MDSP.xlsx';
fredfile50='VacantHousingUnits.xlsx';
fredfile51='USPatents.xlsx';
fredfile52='TCU.xlsx';
fredfile53='IPSemiconductors.xlsx';
fredfile54='IPDefense.xlsx';
fredfile55='TotalRevenueAllHospitals.xlsx';
fredfile56='PharmaceuticalPriceIndex.xlsx';
fredfile57='ProducerPriceIndex.xlsx';
fredfile58='FlexCPIIndex.xlsx';
fredfile59='COMPU1USA.xlsx';
fredfile60='AdvanceRetailSales.xlsx';
fredfile61='ECommerceRSales.xlsx';
fredfile62='InventoryToSales.xlsx';
fredfile63='RetailInventories.xlsx';
fredfile64='UsedCarSales.xlsx';
fredfile65='RestaurantSales.xlsx';
fredfile66='FurnitureSales.xlsx';
fredfile67='ManufacturingSales.xlsx';
fredfile68='NewCarSales.xlsx';
fredfile69='FullServeRestaurants.xlsx';
fredfile70='RetailGasSales.xlsx';
fredfile71='RetailAutoParts.xlsx';
fredfile72='LeadingIndex.xlsx';
fredfile73='InferredRecessionDates.xlsx';
fredfile74='CoincidentEconomicActivity.xlsx';
fredfile75='BalanceSheets.xlsx';
fredfile76='CreditCardDebt.xlsx';
fredfile77='LoanPerformance.xlsx';
fredfile78='Population.xlsx';
fredfile79='TotalHouseHolds.xlsx';
fredfile80='POP55.xlsx';
fredfile81='POP-25-54.xlsx';
fredfile82='FamiliesWithChildren.xlsx';
fredfile83='BlackPop.xlsx';
fredfile84='WhitePop.xlsx';
fredfile85='HispanicPop.xlsx';
fredfile86='FemaleEmploymentRatio.xlsx';
fredfile87='CBOENasdaqVolatility.xlsx';
fredfile88='LeadingIndexUSA.xlsx';
fredfile89='Fed3MonthBondYields.xlsx';
fredfile90='TDSP.xlsx';
fredfile91='CDSP.xlsx';
fredfile92='RealDisposableIncome.xlsx';
fredfile93='PCE.xlsx';
fredfile94='DAUTOSAAR.xlsx';
fredfile95='USSTHPI.xlsx';
fredfile96='RCCCBBALTOT.xlsx';
fredfile97='RCMFLOORIG.xlsx';
fredfile98='PastDueMortgages.xlsx';
fredfile99='CreditScore50.xlsx';
fredfile100='HomeEquityLines.xlsx';
fredfile101='USDToPoundSterling.xlsx';
fredfile102='NominalBroadUSDollarIndex.xlsx';
fredfile103='JapaneseYenToUSD.xlsx';
fredfile104='StockMarketCapitalization.xlsx';
fredfile105='CPI_All.xlsx';
fredfile106='GrossNationalIncome.xlsx';
fredfile107='GASREGW.xlsx';
fredfile108='DCOILBRENTEU.xlsx';
fredfile109='EggPrices.xlsx';
fredfile110='GroundBeefPrices.xlsx';
fredfile111='ElectricityPrices.xlsx';
fredfile112='WestTexasIntermediateCrude.xlsx';
fredfile113='HenryHubNaturalGasPrices.xlsx';
fredfile114='GlobalCopperPrice.xlsx';
fredfile115='DieselPrices.xlsx';
fredfile116='JetFuelPrices.xlsx';
fredfile117='GlobalAluminumPrice.xlsx';
fredfile118='CocoaPrice.xlsx';
fredfile119='GlobalEnergyPrice.xlsx';
fredfile120='BreadPrice.xlsx';
fredfile121='WheatPrices.xlsx';
fredfile122='UraniumPrices.xlsx';
fredfile123='NickelPrices.xlsx';
fredfile124='RubberPrices.xlsx';
fredfile125='SugarPrices.xlsx';
fredfile126='CPIUrbanFoodAtHome.xlsx';
fredfile127='PPIFoodManufacturing.xlsx';
fredfile128='PPIDiesel.xlsx';
fredfile129='BolognaPrices.xlsx';
fredfile130='BonelessHamPrices.xlsx';
fredfile131='ChuckRoastPrices.xlsx';
fredfile132='BaconPrices.xlsx';
fredfile133='SoybeanIndex.xlsx';
fredfile134='FlourPrice.xlsx';
fredfile135='CookingOilPriceIndex.xlsx';
fredfile136='WholeChickenPrices.xlsx';
fredfile137='PPIFarmProducts.xlsx';
fredfile138='PPICattle.xlsx';
fredfile139='PPITomatoes.xlsx';
fredfile140='PPICorn.xlsx';
fredfile141='PPIRawMilk.xlsx';
fredfile142='PPIFruits.xlsx';
fredfile143='PPICabbage.xlsx';
fredfile144='PPIRice.xlsx';
fredfile145='PPICitrusFruits.xlsx';
fredfile146='RecessProb.xlsx';
iCreatePDFReport=1;
iTechCounter=0;
icapture=1;
pdffilename='FredDataImport146A.pdf';
dataYear=2025;
tic;
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
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datetime("now");
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Note that this file is different in purpose and content from the optional
% PDF formatted report file. This was included for the users have dont have
% access to the Matlab Report Generator toolbox
%
% Start writing a log file and Also look at the current stored image paths
%
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Processing Stock Data-',startruntime);
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
logfilename=strcat('Import Fred Data-',logfilename,'.txt');
fid=fopen(logfilename,'w');
dispstr=strcat('Opened Log file-',logfilename,'-for writing');
disp(dispstr);
catfilename=strcat('FredCatalogData-',logfilename,'.xlsx');
fprintf(fid,'%50s\n',startrunstr);
%% Check to see if the Matlab Report Generator and Image Toolbox is present
% If the user does not gave this toolbox this functality will not be
% activated
toolbox='MATLAB Report Generator';
[RptGenPresent] = ToolboxChecker(toolbox);
toolbox='Image Processing Toolbox';
[ImageProcessPresent]=ToolboxChecker(toolbox);
%% Create an Instance of the Class Program Info
PStatsObj=ProgramInfo();
CodeFileName='ImportFredData.m';% This is the entry point of this code
PStatsObj.fid=fid;
[PStatsObj]=SpecifyMatlabConfigurationRev3(PStatsObj,CodeFileName);
PStatsObj.fid=fid;
PStatsObj.iCreatePDFReport=iCreatePDFReport;
PStatsObj.startruntime=startruntime;
PStatsObj.logfilename=logfilename;
PStatsObj.RptGenPresent=RptGenPresent;
PStatsObj.pdffilename=pdffilename;
PStatsObj.hor1=hor1;
PStatsObj.hor2=hor2;
PStatsObj.vert1=vert1;
PStatsObj.vert2=vert2;
PStatsObj.Fz1=Fz1;
PStatsObj.Fz2=Fz2;
PStatsObj.lend=lend;
PStatsObj.lend2=lend2;
PStatsObj.fredpath=fredpath;
PStatsObj.jpegpath=jpegpath;
PStatsObj.logfilepath=logfilepath;
PStatsObj.tiffpath=tiffpath;
PStatsObj.govjpegpath=govjpegpath;
PStatsObj.tablepath=tablepath;
PStatsObj.pdfpath=pdfpath;
PStatsObj.excelpath=excelpath;
PStatsObj.matpath=matpath;
PStatsObj.dataYear=dataYear;
PStatsObj.MSpath= MSpath;
PStatsObj.excelpath= excelpath;
PStatsObj.pdfpath= pdfpath;
PStatsObj.logfilepath=logfilepath;
eval(['cd ' excelpath(1:length(excelpath)-1)]);

%% Start a PDF report if requested by user and user has the Matlab Report
% Generator Package Installed
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*;
% This kicks off writing this report and creates Chapters 1 and 2
    [PStatsObj,TSeries1Hdrs,TSeries1Table]=CreateFREDReportHeader(PStatsObj);
    rpt=PStatsObj.rpt;
else
    fprintf(fid,'%s\n','No PDF report will be created for this run');
end

%% Create an Object to hold the FRED Data
FRObj=Fred();
FRObj.fid=PStatsObj.fid;
FRObj.hor1=PStatsObj.hor1;
FRObj.hor2=PStatsObj.hor2;
FRObj.vert1=PStatsObj.vert1;
FRObj.vert2=PStatsObj.vert2;
FRObj.Fz1=PStatsObj.Fz1;
FRObj.Fz2=PStatsObj.Fz2;
FRObj.lend=PStatsObj.lend;
FRObj.lend2=PStatsObj.lend2;
FRObj.widd=PStatsObj.widd;
FRObj.chart_time=5;
FRObj.machine=machine;
FRObj.icapture=icapture;
FRObj.jpegpath=jpegpath;
FRObj.tiffpath=tiffpath;
FRObj.fid=fid;
FRObj.igrid=igrid;
FRObj.MSpath=MSpath;
FRObj.excelpath=excelpath;
FRObj.iCreatePDFReport=iCreatePDFReport;
FRObj.RptGenPresent=RptGenPresent;
ishowrecession=1;
FRObj.ishowrecession=1;
Chap=-1*ones(146,1);
Section=-1*ones(146,1);
Commodity=zeros(146,1);
FredPngList=cell(146,1);
rho=zeros(25,1);
numoverlap=zeros(25,1);
RecessionInfo=zeros(150,1);
% Start with loading some items that need to be available immediately
% For this reason they are done "Out of order"
%% Get the Inferred Recession Dates(JHDUSRGDPBR)-could be useful immediately
eval(['cd ' fredpath(1:length(fredpath)-1)]);
InferRecessionDatesTable = readtable(fredfile73,'Sheet','Quarterly');
[nrows73,~]=size(InferRecessionDatesTable);
clear DateNumbers dateArray
dateArray=strings(nrows73,1);
for n=1:nrows73
    nowstr=string(InferRecessionDatesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows73)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
InferRecessionDatesTT=table2timetable(InferRecessionDatesTable,'RowTimes','Date');
InferRecessionDatesTT = addvars(InferRecessionDatesTT,DateNumbers);
meanFlagVal=mean(InferRecessionDatesTT.Rflag,'omitnan');
medianFlagVal=median(InferRecessionDatesTT.Rflag,'omitnan');
maxFlagVal=max(InferRecessionDatesTT.Rflag,[],'omitnan');
meanRflag=zeros(nrows73,1);
medianRflag=zeros(nrows73,1);
maxRflag=zeros(nrows73,1);
for n=1:nrows73
    meanRflag(n,1)=meanFlagVal;
    medianRflag(n,1)=medianFlagVal;
    maxRflag(n,1)=maxFlagVal;
end
InferRecessionDatesTT= addvars(InferRecessionDatesTT,meanRflag,medianRflag,maxRflag);
RecessionDatesRTT=InferRecessionDatesTT;
RecessionDatesRTT(RecessionDatesRTT.Rflag<1,:)=[];
numAllQtrs=height(InferRecessionDatesTT);
numRecessionQtrs=height(RecessionDatesRTT);
GDPRecessionFrac=numRecessionQtrs/numAllQtrs;
SourceFile(73,1)="InferredRecssionDates.xlsx";
Code(73,1)="JHDUSRGDPBR";
Desc(73,1)="GDP InferredRecessionDates";
Freq(73,1)="Quarterly";
StartYear(73,1)=1967;
EndYear(73,1)=2025;
SeasonalAdj(73,1)="No";
BaseYear(73,1)=1967;
NumObs(73,1)=230;
loopstr5='Process InferredRecessionDates';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows73,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Rflag=',num2str(meanFlagVal,4),...
    '-Median Rflag =',num2str(medianFlagVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.InferRecessionDatesTT=InferRecessionDatesTT;
FRObj.RecessionDatesRTT=RecessionDatesRTT;
FRObj.GDPRecessionFrac=GDPRecessionFrac;
Chap(73,1)=8;
Section(73,1)=2;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=73;
titlestr='ReferredRecessionDates';
PlotFredData(FRObj,InferRecessionDatesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{73,1}=figstr2;

%% Get the Smoothed Recession Probabilities(RECPROUSM156N)-could be useful immediately
eval(['cd ' fredpath(1:length(fredpath)-1)]);
RecessProbTable = readtable(fredfile146,'Sheet','Monthly');
[nrows146,~]=size(RecessProbTable);
clear DateNumbers dateArray
dateArray=strings(nrows146,1);
for n=1:nrows146
    nowstr=string(RecessProbTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows146)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RecessProbTT=table2timetable(RecessProbTable,'RowTimes','Date');
RecessProbTT = addvars(RecessProbTT,DateNumbers);
loopstr5='Process Smoothed Recession Dates';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
% now add a column that will serve as the recession flag
% This will be set to one if the probability >=50 and zero otherwise
% A probability of 1 implies a recession period and 0 is not recession
RFlag=zeros(nrows146,1);
recession_months=0;
%RecessProbTT= addvars(RecessProbTT,RFlag);
for n=1:nrows146
    nowProb=RecessProbTT(n,1).Prob;
    if(nowProb>=50)
        RFlag(n,1)=1;
        recession_months=recession_months+1;
    end
end
RecessProbTT= addvars(RecessProbTT,RFlag);
meanFlagVal=mean(RecessProbTT.RFlag,'omitnan');
medianFlagVal=median(RecessProbTT.RFlag,'omitnan');
maxFlagVal=max(RecessProbTT.RFlag,[],'omitnan');
meanRFlag=zeros(nrows146,1);
medianRFlag=zeros(nrows146,1);
maxRFlag=zeros(nrows146,1);
for n=1:nrows146
    meanRFlag(n,1)=meanFlagVal;
    medianRFlag(n,1)=medianFlagVal;
    maxRFlag(n,1)=maxFlagVal;
end
RecessProbTT= addvars(RecessProbTT,meanRFlag,medianRFlag,maxRFlag);
% RecessionDatesRTT=InferRecessionDatesTT;
% RecessionDatesRTT(RecessionDatesRTT.Rflag<1,:)=[];
% numAllQtrs=height(InferRecessionDatesTT);
% numRecessionQtrs=height(RecessionDatesRTT);
% GDPRecessionFrac=numRecessionQtrs/numAllQtrs;
SourceFile(146,1)="RecessProb.xlsx";
Code(146,1)="RECPROUSM156N";
Desc(146,1)="Smoothed Recession Dates";
Freq(146,1)="Monthly";
StartYear(146,1)=1967;
EndYear(146,1)=2025;
SeasonalAdj(146,1)="No";
BaseYear(146,1)=1967;
NumObs(146,1)=707;

FRObj.RecessProbTT=RecessProbTT;
SmoothedRessProb=1;
FRObj.SmoothedRessProb=SmoothedRessProb;
Chap(146,1)=8;
Section(146,1)=8;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=146;
titlestr='SmoothedRecessionDates';
PlotFredData(FRObj,RecessProbTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{146,1}=figstr2;

%% CPI for Urban Consumers -Food Price Index Home Meals (CUSR0000SAF11)(Monthly)
% This dataset is loaded here so it is available the commodity data is
% imported
% itype=126
eval(['cd ' fredpath(1:length(fredpath)-1)]);
UrbanHomeFoodTable = readtable(fredfile126,'Sheet','Monthly');
[nrows126,ncols126]=size(UrbanHomeFoodTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows126,1);
for n=1:nrows126
    nowstr=string(UrbanHomeFoodTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows126)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the CPI Urban Dweller Home Food Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows126,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
UrbanHFTT=table2timetable(UrbanHomeFoodTable,'RowTimes','Date');
UrbanHFTT = addvars(UrbanHFTT,DateNumbers);
UrbanHFmeanVal=mean(UrbanHFTT.Index);
UrbanHFmedianVal=median(UrbanHFTT.Index);
meanHF=zeros(nrows126,1);
medianHF=zeros(nrows126,1);
for n=1:nrows126
    meanHF(n,1)=UrbanHFmeanVal;
    medianHF(n,1)=UrbanHFmedianVal;
end
UrbanHFTT = addvars(UrbanHFTT,meanHF,medianHF);
SourceFile(126,1)="CPIUrbanFoodAtHome.xlsx";
Code(126,1)="CUSR0000SAF11";
Desc(126,1)="UrbanHomeFoodPriceIndex";
Freq(126,1)="Monthly";
StartYear(126,1)=1952;
EndYear(126,1)=2025;
SeasonalAdj(126,1)="Yes";
BaseYear(126,1)=1982;
NumObs(126,1)=892;
Chap(126,1)=19;
Section(126,1)=1;
itype=126;
StartYear1=1952;
EndYear1=2025;
% Calculate the Simple Stats
Data=UrbanHFTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
urbanhfsmooth = smoothdata(Data);
P0=urbanhfsmooth(1);
PF=urbanhfsmooth(892);
UrbanHFTT= addvars(UrbanHFTT,urbanhfsmooth);
NYears=EndYear(126,1)-StartYear(126,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG126=100*GrowthRateAll(itype,1);
FRObj.SG126=SG126;
% Now plot this data
titlestr='Urban-HomeFood-PriceIndex';
PlotFredData(FRObj,UrbanHFTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.UrbanHFTT=UrbanHFTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{126,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='UrbanHomeFoodIndex-Cumil-Distribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Next work on importing most of the tables (>100 tables)
%% Start with The Unemployment Data (UNRATE) (Monthly)  Chap 3-1
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Unemployment Rate Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
UnrateTable = readtable(fredfile1,'Sheet','Monthly');
[nrows,ncols]=size(UnrateTable);
dateArray=strings(nrows,1);
for n=1:nrows
    nowstr=string(UnrateTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
UnrateTT=table2timetable(UnrateTable,'RowTimes','Date');
UnrateTT = addvars(UnrateTT,DateNumbers);
meanUnrateVal=mean(UnrateTT.UNRATE);
medianUnrateVal=mean(UnrateTT.UNRATE);
meanUnrate=zeros(nrows,1);
medianUnrate=zeros(nrows,1);
for n=1:nrows
    meanUnrate(n,1)=meanUnrateVal;
    medianUnrate(n,1)=medianUnrateVal;
end
UnrateTT = addvars(UnrateTT,meanUnrate,medianUnrate);
SourceFile(1,1)="UNRATE-1948-2024.xlsx";
Code(1,1)="UNRATE";
Desc(1,1)="UnemploymentRate";
Freq(1,1)="Monthly";
StartYear(1,1)=1948;
EndYear(1,1)=2024;
SeasonalAdj(1,1)="Yes";
BaseYear(1,1)=1948;
NumObs(1,1)=924;
FRObj.Desc=Desc;
Chap(1,1)=3;
Section(1,1)=1;
% Calculate the Simple Stats
itype=1;
Data=UnrateTT.UNRATE;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
unratesmooth = smoothdata(Data);
P0=unratesmooth(1);
PF=unratesmooth(924);
UnrateTT= addvars(UnrateTT,unratesmooth);
% Now plot this data
titlestr='UnemploymentRate-1948-2025';
PlotFredData(FRObj,UnrateTT,itype,titlestr)
% Add this table to the FredObj
FRObj.UnrateTT=UnrateTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{1,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='U2Rate-CumilDist.png';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

% Pre Allocate a table to store Food price data that will be used later
sz = [25 11];
varTypes = ["double","string","double","double","double","string","double","double","double","double","double"];
varNames = ["BaseiType","BaseTableName","StartYear1","EndYear1","CompiType","CompTableName","StartYear2","EndYear2",...
    "rho","GR","numovrlp"];
FoodCorrTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

%% PPI for Food Manufacturing (PCU311311)(Monthly)
% itype=127
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PPIFoodTable = readtable(fredfile127,'Sheet','Monthly');
[nrows127,ncols127]=size(PPIFoodTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows127,1);
for n=1:nrows127
    nowstr=string(PPIFoodTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the PPI Food Production Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows127,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
PPIFoodTT=table2timetable(PPIFoodTable,'RowTimes','Date');
PPIFoodTT = addvars(PPIFoodTT,DateNumbers);
PPIFoodmeanVal=mean(PPIFoodTT.Index);
PPIFoodmedianVal=median(PPIFoodTT.Index);
meanPPIFood=zeros(nrows127,1);
medianPPIFood=zeros(nrows127,1);
for n=1:nrows127
    meanPPIFood(n,1)=PPIFoodmeanVal;
    medianPPIFood(n,1)=PPIFoodmedianVal;
end
PPIFoodTT = addvars(PPIFoodTT,meanPPIFood,medianPPIFood);
SourceFile(127,1)="PPIFoodManufacturing.xlsx";
Code(127,1)="PCU311311";
Desc(127,1)="PCIFoodPriceIndex";
Freq(127,1)="Monthly";
StartYear(127,1)=1984;
EndYear(127,1)=2025;
SeasonalAdj(127,1)="No";
BaseYear(127,1)=1984;
NumObs(127,1)=497;
Chap(127,1)=19;
Section(127,1)=2;
itype=127;
% Calculate the Simple Stats
Data=PPIFoodTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
ppifoodsmooth = smoothdata(Data);
P0=ppifoodsmooth(1);
PF=ppifoodsmooth(497);
PPIFoodTT= addvars(PPIFoodTT,ppifoodsmooth);
NYears=EndYear(127,1)-StartYear(127,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG127=100*GrowthRateAll(itype,1);
FRObj.SG127=SG127;
% Now plot this data
titlestr='PPI-Food-Production';
PlotFredData(FRObj,PPIFoodTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.PPIFoodTT=PPIFoodTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{127,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='PPI-FoodIndex-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between 
datacol=1;
minCorrPts=100;
ikind=1;
[rho(1),~,numoverlap(1)] = CalculateCorrelation(UrbanHFTT,PPIFoodTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Food Production Costs-',num2str(rho(1)));
disp(dispstr)
FoodCorrTable(1,:) = {126,"UrbanHFTT",StartYear1,EndYear1,127,"PPIFoodTT",1984,2025,rho(1),SG127,numoverlap(1)};
%% PPI for Diesel #2 Fuel (WPU057303)(Monthly)
% itype=128
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PPIDieselTable = readtable(fredfile128,'Sheet','Monthly');
[nrows128,ncols128]=size(PPIDieselTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows128,1);
for n=1:nrows128
    nowstr=string(PPIDieselTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the PPI Diesel #2 Production Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows128,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
PPIDieselTT=table2timetable(PPIDieselTable,'RowTimes','Date');
PPIDieselTT = addvars(PPIDieselTT,DateNumbers);
PPIDieselmeanVal=mean(PPIDieselTT.Index);
PPIDieselmedianVal=median(PPIDieselTT.Index);
meanPPIDiesel=zeros(nrows128,1);
medianPPIDiesel=zeros(nrows128,1);
for n=1:nrows128
    meanPPIDiesel(n,1)=PPIDieselmeanVal;
    medianPPIDiesel(n,1)=PPIDieselmedianVal;
end
PPIDieselTT = addvars(PPIDieselTT,meanPPIDiesel,medianPPIDiesel);
SourceFile(128,1)="PPIDiesel.xlsx";
Code(128,1)="WPU057303";
Desc(128,1)="PCIDieselPriceIndex";
Freq(128,1)="Monthly";
StartYear(128,1)=1973;
EndYear(128,1)=2025;
SeasonalAdj(128,1)="No";
BaseYear(128,1)=1982;
NumObs(128,1)=640;
Chap(128,1)=19;
Section(128,1)=3;
itype=128;
% Calculate the Simple Stats
Data=PPIDieselTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
ppidieselsmooth = smoothdata(Data);
P0=ppidieselsmooth(1);
PF=ppidieselsmooth(640);
PPIDieselTT= addvars(PPIDieselTT,ppidieselsmooth);
NYears=EndYear(128,1)-StartYear(128,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG128=100*GrowthRateAll(itype,1);
FRObj.SG128=SG128;
% Now pull of the Recession Probability data that matches the available
% time poiunts in the PPIDieselTT
RecessProbTT=FRObj.RecessProbTT;
ab=1;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [PPIDieselTT,icase] = OverlapTimeLinesRev1(PPIDieselTT,RecessProbTT);
    FRObj.PPIDieselTT=PPIDieselTT;
    RecessionInfo(128,1)=icase;
end
% Now plot this data
FRObj.barval=100;
titlestr='PPI-Diesel-Production';
PlotFredData(FRObj,PPIDieselTT,itype,titlestr)
% Add this data to the Fred Obj
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{128,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='PPI-DieselIndex-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Food prices and Diesel Fuel
datacol=1;
minCorrPts=100;
ikind=1;
[rho(2),~,numoverlap(2)] = CalculateCorrelation(UrbanHFTT,PPIDieselTT,ikind,minCorrPts);
ab=1;
dispstr=strcat('Price Correlation Between Urban Home Food and Diesel Production Costs-',num2str(rho(2)));
disp(dispstr)
FoodCorrTable(2,:) = {126,"UrbanHFTT",StartYear1,EndYear1,128,"PPIDieselTT",1973,2025,rho(2),SG128,numoverlap(2)};

%% Avererage Price For Beef Bologna (APU0000705121)(Monthly)
% itype=129
eval(['cd ' fredpath(1:length(fredpath)-1)]);
BolognaTable = readtable(fredfile129,'Sheet','Monthly');
[nrows129,ncols129]=size(BolognaTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows129,1);
for n=1:nrows129
    nowstr=string(BolognaTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Average Beef Bologna Prices';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows129,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
BolognaTT=table2timetable(BolognaTable,'RowTimes','Date');
BolognaTT = addvars(BolognaTT,DateNumbers);
BolognameanVal=mean(BolognaTT.Price);
BolognamedianVal=median(BolognaTT.Price);
meanBologna=zeros(nrows129,1);
medianBologna=zeros(nrows129,1);
for n=1:nrows129
    meanBologna(n,1)=BolognameanVal;
    medianBologna(n,1)=BolognamedianVal;
end
BolognaTT = addvars(BolognaTT,meanBologna,medianBologna);
SourceFile(129,1)="BolognaPrices.xlsx";
Code(129,1)="APU0000705121";
Desc(129,1)="MeanBolognaPrices";
Freq(129,1)="Monthly";
StartYear(129,1)=1980;
EndYear(129,1)=2019;
SeasonalAdj(129,1)="No";
BaseYear(129,1)=1980;
NumObs(129,1)=477;
Chap(129,1)=19;
Section(129,1)=4;
itype=129;
% Calculate the Simple Stats
Data=BolognaTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
bolognasmooth = smoothdata(Data);
P0=bolognasmooth(1);
PF=bolognasmooth(477);
BolognaTT= addvars(BolognaTT,bolognasmooth);
NYears=EndYear(129,1)-StartYear(129,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG129=100*GrowthRateAll(itype,1);
FRObj.SG129=SG129;
% Now pull of the Recession Probability data that matches the available
% time points in the PPIDieselTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [BolognaTT,icase] = OverlapTimeLinesRev1(BolognaTT,RecessProbTT);
    FRObj.BolognaTT=BolognaTT;
    RecessionInfo(129,1)=icase;
end
FRObj.barval=3;
FRObj.BolognaTT=BolognaTT;
% Now plot this data
titlestr='BolognaPrices';
PlotFredData(FRObj,BolognaTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.BolognaTT=BolognaTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{129,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='BolognaPrices-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Food prices and Bologna
datacol=1;
minCorrPts=100;
ikind=2;
[rho(3),~,numoverlap(3)] = CalculateCorrelation(UrbanHFTT,BolognaTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Bologna-',num2str(rho(3)));
disp(dispstr)
FoodCorrTable(3,:) = {126,"UrbanHFTT",StartYear1,EndYear1,129,"BolognaTT",1980,2019,rho(3),SG129,numoverlap(3)};

%% Avererage Price For Boneless Ham (APU0000704312)(Monthly)
% itype=130
eval(['cd ' fredpath(1:length(fredpath)-1)]);
BonelessHamTable = readtable(fredfile130,'Sheet','Monthly');
[nrows130,ncols130]=size(BonelessHamTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows130,1);
for n=1:nrows130
    nowstr=string(BonelessHamTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Average BonelessHam Prices';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows130,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
BonelessHamTT=table2timetable(BonelessHamTable,'RowTimes','Date');
BonelessHamTT = addvars(BonelessHamTT,DateNumbers);
HammeanVal=mean(BonelessHamTT.Price);
HammedianVal=median(BonelessHamTT.Price);
meanHam=zeros(nrows130,1);
medianHam=zeros(nrows130,1);
for n=1:nrows130
    meanHam(n,1)=HammeanVal;
    medianHam(n,1)=HammedianVal;
end
BonelessHamTT = addvars(BonelessHamTT,meanHam,medianHam);
SourceFile(130,1)="BonelessHamPrices.xlsx";
Code(130,1)="APU0000704312";
Desc(130,1)="MeanBonelessHamPrices";
Freq(130,1)="Monthly";
StartYear(130,1)=1991;
EndYear(130,1)=2025;
SeasonalAdj(130,1)="No";
BaseYear(130,1)=1991;
NumObs(130,1)=425;
Chap(130,1)=19;
Section(130,1)=5;
itype=130;
% Calculate the Simple Stats
Data=BonelessHamTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
hamsmooth = smoothdata(Data);
P0=hamsmooth(1);
PF=hamsmooth(425);
BonelessHamTT= addvars(BonelessHamTT,hamsmooth);
NYears=EndYear(130,1)-StartYear(130,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG130=100*GrowthRateAll(itype,1);
FRObj.SG130=SG130;
% Now plot this data
% Now pull of the Recession Probability data that matches the available
% time points in the BonelessHamTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [BonelessHamTT,icase] = OverlapTimeLinesRev1(BonelessHamTT,RecessProbTT);
    FRObj.BonelessHamTT=BonelessHamTT;
    RecessionInfo(130,1)=icase;
end
FRObj.barval=4;
FRObj.BonelessHamTT=BonelessHamTT;
titlestr='BonelessHamPrices';
PlotFredData(FRObj,BonelessHamTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.BonelessHamTT=BonelessHamTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{130,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='BonelessHamPrices-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Food prices and BonelessHam
datacol=1;
minCorrPts=100;
ikind=2;
[rho(4),~,numoverlap(4)] = CalculateCorrelation(UrbanHFTT,BonelessHamTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Boneless Ham Prices-',num2str(rho(4)));
disp(dispstr)
FoodCorrTable(4,:) = {126,"UrbanHFTT",StartYear1,EndYear1,130,"BonelessHamTT",1991,2025,rho(4),SG130,numoverlap(4)};
%% Average Price For BeefChuckRoast (APU0000703213)(Monthly)
% itype=131
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ChuckRoastTable = readtable(fredfile131,'Sheet','Monthly');
[nrows131,ncols131]=size(ChuckRoastTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows131,1);
for n=1:nrows131
    nowstr=string(ChuckRoastTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Average Boneless Chuck Roast Prices';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows131,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
ChuckRoastTT=table2timetable(ChuckRoastTable,'RowTimes','Date');
ChuckRoastTT = addvars(ChuckRoastTT,DateNumbers);
CRoastmeanVal=mean(ChuckRoastTT.Price);
CRoastmedianVal=median(ChuckRoastTT.Price);
meanCRoast=zeros(nrows131,1);
medianCRoast=zeros(nrows131,1);
for n=1:nrows131
    meanCRoast(n,1)=CRoastmeanVal;
    medianCRoast(n,1)=CRoastmedianVal;
end
ChuckRoastTT = addvars(ChuckRoastTT,meanCRoast,medianCRoast);
SourceFile(131,1)="ChuckRoastPrices.xlsx";
Code(131,1)="APU0000703213";
Desc(131,1)="MeanBonelessChuckRoastPrices";
Freq(131,1)="Monthly";
StartYear(131,1)=1989;
EndYear(131,1)=2025;
SeasonalAdj(131,1)="No";
BaseYear(131,1)=1989;
NumObs(131,1)=449;
Chap(131,1)=19;
Section(131,1)=6;
itype=131;
% Calculate the Simple Stats
Data=ChuckRoastTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
croastsmooth = smoothdata(Data);
P0=croastsmooth(1);
PF=croastsmooth(449);
ChuckRoastTT= addvars(ChuckRoastTT,croastsmooth);
NYears=EndYear(131,1)-StartYear(131,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG131=100*GrowthRateAll(itype,1);
FRObj.SG131=SG131;
% Now pull of the Recession Probability data that matches the available
% time points in the ChuckRoastTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [ChuckRoastTT,icase] = OverlapTimeLinesRev1(ChuckRoastTT,RecessProbTT);
    FRObj.ChuckRoastTT=ChuckRoastTT;
    RecessionInfo(131,1)=icase;

end
FRObj.barval=4;
FRObj.ChuckRoastTT=ChuckRoastTT;
% Now plot this data
titlestr='ChuckRoastPrices';
PlotFredData(FRObj,ChuckRoastTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.ChuckRoastTT=ChuckRoastTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{131,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ChuckRoastPrices-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Food prices and BonelessHam
datacol=1;
minCorrPts=100;
ikind=2;
[rho(5),~,numoverlap(5)] = CalculateCorrelation(UrbanHFTT,ChuckRoastTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Chuck Roast Prices-',num2str(rho(5)));
disp(dispstr)
FoodCorrTable(5,:) = {126,"UrbanHFTT",StartYear1,EndYear1,131,"ChuckRoastTT",1989,2025,rho(5),SG131,numoverlap(5)};

%% Average Price For Bacon For North East Region (APU0100704111)(Monthly)
% itype=132
eval(['cd ' fredpath(1:length(fredpath)-1)]);
BaconTable = readtable(fredfile132,'Sheet','Monthly');
[nrows132,ncols132]=size(BaconTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows132,1);
for n=1:nrows132
    nowstr=string(BaconTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows132)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Average Sliced Bacon Prices';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows132,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
BaconPriceTT=table2timetable(BaconTable,'RowTimes','Date');
BaconPriceTT = addvars(BaconPriceTT,DateNumbers);
BaconmeanVal=mean(BaconPriceTT.Price);
BaconmedianVal=median(BaconPriceTT.Price);
meanBacon=zeros(nrows132,1);
medianBacon=zeros(nrows132,1);
for n=1:nrows132
    meanBacon(n,1)=BaconmeanVal;
    medianBacon(n,1)=BaconmedianVal;
end
BaconPriceTT = addvars(BaconPriceTT,meanBacon,medianBacon);
SourceFile(132,1)="BaconPrices.xlsx";
Code(132,1)="APU0100704111";
Desc(132,1)="MeanSliceBaconPrice";
Freq(132,1)="Monthly";
StartYear(132,1)=1980;
EndYear(132,1)=2025;
SeasonalAdj(132,1)="No";
BaseYear(132,1)=1980;
NumObs(132,1)=557;
Chap(132,1)=19;
Section(132,1)=7;
itype=132;
% Calculate the Simple Stats
Data=BaconPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
baconsmooth = smoothdata(Data);
P0=baconsmooth(1);
PF=baconsmooth(557);
BaconPriceTT= addvars(BaconPriceTT,baconsmooth);
NYears=EndYear(132,1)-StartYear(132,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG132=100*GrowthRateAll(itype,1);
FRObj.SG132=SG132;
% Now pull of the Recession Probability data that matches the available
% time points in the BaconPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [BaconPriceTT,icase] = OverlapTimeLinesRev1(BaconPriceTT,RecessProbTT);
    FRObj.BaconPriceTT=BaconPriceTT;
    RecessionInfo(132,1)=icase;

end
FRObj.barval=2;
FRObj.BaconPriceTT=BaconPriceTT;
% Now plot this data
titlestr='BaconPrices';
PlotFredData(FRObj,BaconPriceTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.BaconPriceTT=BaconPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{132,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='BaconPrices-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Food prices and Slice Bacon
datacol=1;
minCorrPts=100;
ikind=2;
[rho(6),~,numoverlap(6)] = CalculateCorrelation(UrbanHFTT,BaconPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Bacon Prices-',num2str(rho(6)));
disp(dispstr)
FoodCorrTable(6,:) = {126,"UrbanHFTT",StartYear1,EndYear1,132,"BaconPriceTT",1980,2025,rho(6),SG132,numoverlap(6)};

%% Average Index Of Soybeans (WPU01830131)(Monthly)
% itype=133
eval(['cd ' fredpath(1:length(fredpath)-1)]);
SoybeanTable = readtable(fredfile133,'Sheet','Monthly');
[nrows133,ncols133]=size(SoybeanTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows133,1);
for n=1:nrows133
    nowstr=string(SoybeanTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows133)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Global Soybean Price Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows133,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
SoybeanIndexTT=table2timetable(SoybeanTable,'RowTimes','Date');
SoybeanIndexTT = addvars(SoybeanIndexTT,DateNumbers);
SoybeanmeanVal=mean(SoybeanIndexTT.Index);
SoybeanmedianVal=median(SoybeanIndexTT.Index);
meanSoybean=zeros(nrows133,1);
medianSoybean=zeros(nrows133,1);
for n=1:nrows133
    meanSoybean(n,1)=SoybeanmeanVal;
    medianSoybean(n,1)=SoybeanmedianVal;
end
SoybeanIndexTT = addvars(SoybeanIndexTT,meanSoybean,medianSoybean);
SourceFile(133,1)="SoybeanIndex.xlsx";
Code(133,1)="WPU01830131";
Desc(133,1)="MeanSoybeanIndex";
Freq(133,1)="Monthly";
StartYear(133,1)=1947;
EndYear(133,1)=2025;
SeasonalAdj(133,1)="No";
BaseYear(133,1)=1982;
NumObs(133,1)=952;
Chap(133,1)=19;
Section(133,1)=8;
itype=133;
% Calculate the Simple Stats
Data=SoybeanIndexTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
soysmooth = smoothdata(Data);
P0=soysmooth(1);
PF=soysmooth(952);
SoybeanIndexTT= addvars(SoybeanIndexTT,soysmooth);
NYears=EndYear(133,1)-StartYear(133,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG133=100*GrowthRateAll(itype,1);
FRObj.SG133=SG133;
% Now pull of the Recession Probability data that matches the available
% time points in the SoybeanIndexTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    disp('start Soybean case)')
    [SoybeanIndexTT,icase] = OverlapTimeLinesRev1(SoybeanIndexTT,RecessProbTT);
    FRObj.SoybeanIndexTT=SoybeanIndexTT;
    RecessionInfo(133,1)=icase;

end
FRObj.barval=100;
FRObj.SoybeanIndexTT=SoybeanIndexTT;
disp('Finished Soybean Case')
% Now plot this data
titlestr='SoybeanIndex';
PlotFredData(FRObj,SoybeanIndexTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.SoybeanIndexTT=SoybeanIndexTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{133,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='SoybeanIndex-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Food prices and the Soybean Index
datacol=1;
minCorrPts=100;
ikind=1;
[rho(11),~,numoverlap(11)] = CalculateCorrelation(UrbanHFTT,SoybeanIndexTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and the Soybean Index-',num2str(rho(11)));
disp(dispstr)
FoodCorrTable(11,:) = {126,"UrbanHFTT",StartYear1,EndYear1,133,"SoybeanIndexTT",1952,2025,rho(11),SG133,numoverlap(11)};

%% Continue with Flour Prices  (APU0000701111) (Monthly)  Chap 19-9
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Flour Price Data For US Cities';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
FlourPriceTable = readtable(fredfile134,'Sheet','Monthly');
[nrows134,ncols134]=size(FlourPriceTable);
dateArray=strings(nrows134,1);
for n=1:nrows134
    nowstr=string(FlourPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows134)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows134,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FlourPriceTT=table2timetable(FlourPriceTable,'RowTimes','Date');
FlourPriceTT = addvars(FlourPriceTT,DateNumbers);
meanFlourPriceVal=mean(FlourPriceTT.Price);
medianFlourPriceVal=median(FlourPriceTT.Price);
meanFlourPrice=zeros(nrows134,1);
medianFlourPrice=zeros(nrows134,1);
for n=1:nrows134
    meanFlourPrice(n,1)=meanFlourPriceVal;
    medianFlourPrice(n,1)=medianFlourPriceVal;
end
FlourPriceTT = addvars(FlourPriceTT,meanFlourPrice,medianFlourPrice);
SourceFile(134,1)="FlourPrices.xlsx";
Code(134,1)="APU0000701111";
Desc(134,1)="FlourPrice-USD/lb";
Freq(134,1)="Monthly";
StartYear(134,1)=1980;
EndYear(134,1)=2025;
SeasonalAdj(134,1)="No";
BaseYear(134,1)=1980;
NumObs(134,1)=557;
FRObj.Desc=Desc;
Chap(134,1)=19;
Section(134,1)=9;
Commodity(134,1)=1;
% Calculate the Simple Stats
itype=134;
Data=FlourPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
floursmooth = smoothdata(Data);
P0=floursmooth(1);
PF=floursmooth(557);
FlourPriceTT= addvars(FlourPriceTT,floursmooth);
NYears=EndYear(134,1)-StartYear(134,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG134=100*GrowthRateAll(itype,1);
FRObj.SG134=SG134;
% Now pull of the Recession Probability data that matches the available
% time points in the FlourPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [FlourPriceTT,icase] = OverlapTimeLinesRev1(FlourPriceTT,RecessProbTT);
    FRObj.FlourPriceTT=FlourPriceTT;
    RecessionInfo(134,1)=icase;
end
FRObj.barval=1;
FRObj.FlourPriceTT=FlourPriceTT;
% Now plot this data
titlestr='FlourPrice';
PlotFredData(FRObj,FlourPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.FlourPriceTT=FlourPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{134,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=2;
[rho(14),~,numoverlap(14)] = CalculateCorrelation(UrbanHFTT,FlourPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Flour Prices-',num2str(rho(14)));
disp(dispstr)
FoodCorrTable(14,:) = {126,"UrbanHFTT",StartYear1,EndYear1,134,"FlourPriceTT",1980,2025,rho(14),SG134,numoverlap(14)};

%% Continue with Cooking Oil Price Index (WPU0278) (Monthly)  Chap 19-10
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Cooking Oil Price Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
CookingOilTable = readtable(fredfile135,'Sheet','Monthly');
[nrows135,ncols135]=size(CookingOilTable);
dateArray=strings(nrows135,1);
for n=1:nrows135
    nowstr=string(CookingOilTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows135)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows135,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CookingOilTT=table2timetable(CookingOilTable,'RowTimes','Date');
CookingOilTT = addvars(CookingOilTT,DateNumbers);
meanCookingOilIndexVal=mean(CookingOilTT.Index);
medianCookingOilIndexVal=median(CookingOilTT.Index);
meanCookingOilIndex=zeros(nrows135,1);
medianCookingOilIndex=zeros(nrows135,1);
for n=1:nrows135
    meanCookingOilIndex(n,1)=meanCookingOilIndexVal;
    medianCookingOilIndex(n,1)=medianCookingOilIndexVal;
end
CookingOilTT = addvars(CookingOilTT,meanCookingOilIndex,medianCookingOilIndex);
SourceFile(135,1)="CookingOilPriceIndex.xlsx";
Code(135,1)="WPU0278";
Desc(135,1)="CookingOilPriceIndex";
Freq(135,1)="Monthly";
StartYear(135,1)=1947;
EndYear(135,1)=2025;
SeasonalAdj(135,1)="No";
BaseYear(135,1)=1982;
NumObs(135,1)=953;
FRObj.Desc=Desc;
Chap(135,1)=19;
Section(135,1)=10;
Commodity(135,1)=1;
% Calculate the Simple Stats
itype=135;
Data=CookingOilTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
coilsmooth = smoothdata(Data);
P0=coilsmooth(1);
PF=coilsmooth(953);
CookingOilTT= addvars(CookingOilTT,coilsmooth);
NYears=EndYear(135,1)-StartYear(135,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG135=100*GrowthRateAll(itype,1);
FRObj.SG135=SG135;
% Now pull of the Recession Probability data that matches the available
% time points in the FlourPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [CookingOilTT,icase] = OverlapTimeLinesRev1(CookingOilTT,RecessProbTT);
    FRObj.CookingOilTT=CookingOilTT;
    RecessionInfo(135,1)=icase;
end
FRObj.barval=100;
FRObj.CookingOilTT=CookingOilTT;
% Now plot this data
titlestr='CookingOilIndex';
PlotFredData(FRObj,CookingOilTT,itype,titlestr)
% Add this table to the FredObj
FRObj.CookingOilTT=CookingOilTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{135,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CookingOilIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(15),~,numoverlap(15)] = CalculateCorrelation(UrbanHFTT,CookingOilTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Cooking Oil Index-',num2str(rho(15)));
disp(dispstr)
FoodCorrTable(15,:) = {126,"UrbanHFTT",StartYear1,EndYear1,135,"CookingOilTT",1947,2025,rho(15),SG135,numoverlap(15)};

%% Continue with Whole Chicken Prices (APU0000706111) (Monthly)  Chap 19-11
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Whole Chicken Prices';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
WholeChickenTable = readtable(fredfile136,'Sheet','Monthly');
[nrows136,ncols136]=size(WholeChickenTable);
dateArray=strings(nrows136,1);
for n=1:nrows136
    nowstr=string(WholeChickenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows136)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows136,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
WholeChickenTT=table2timetable(WholeChickenTable,'RowTimes','Date');
WholeChickenTT = addvars(WholeChickenTT,DateNumbers);
meanWChickenVal=mean(WholeChickenTT.Price);
medianWChickenVal=median(WholeChickenTT.Price);
meanWChickenPrice=zeros(nrows136,1);
medianWChickenPrice=zeros(nrows136,1);
for n=1:nrows136
    meanWChickenPrice(n,1)=meanWChickenVal;
    medianWChickenPrice(n,1)=medianWChickenVal;
end
WholeChickenTT = addvars(WholeChickenTT,meanWChickenPrice,medianWChickenPrice);
SourceFile(136,1)="WholeChickenPrices.xlsx";
Code(136,1)="APU0000706111";
Desc(136,1)="WholeChickenPrices";
Freq(136,1)="Monthly";
StartYear(136,1)=1980;
EndYear(136,1)=2025;
SeasonalAdj(136,1)="No";
BaseYear(136,1)=1980;
NumObs(136,1)=557;
FRObj.Desc=Desc;
Chap(136,1)=19;
Section(136,1)=11;
Commodity(136,1)=1;
% Calculate the Simple Stats
itype=136;
Data=WholeChickenTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
chicksmooth = smoothdata(Data);
P0=chicksmooth(1);
PF=chicksmooth(557);
WholeChickenTT= addvars(WholeChickenTT,chicksmooth);
NYears=EndYear(136,1)-StartYear(136,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG136=100*GrowthRateAll(itype,1);
FRObj.SG136=SG136;
% Now pull of the Recession Probability data that matches the available
% time points in the WholeChickenTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [WholeChickenTT,icase] = OverlapTimeLinesRev1(WholeChickenTT,RecessProbTT);
    FRObj.WholeChickenTT=WholeChickenTT;
    RecessionInfo(136,1)=icase;
end
FRObj.barval=1;
FRObj.WholeChickenTT=WholeChickenTT;
% Now plot this data
titlestr='WholeChickenPrices';
PlotFredData(FRObj,WholeChickenTT,itype,titlestr)
% Add this table to the FredObj
FRObj.WholeChickenTT=WholeChickenTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{136,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='WholeChickenPrices-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=2;
[rho(16),~,numoverlap(16)] = CalculateCorrelation(UrbanHFTT,WholeChickenTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Whole Chicken Prices-',num2str(rho(16)));
disp(dispstr)
FoodCorrTable(16,:) = {126,"UrbanHFTT",StartYear1,EndYear1,135,"WholeChickenTT",1980,2025,rho(16),SG136,numoverlap(16)};

%% Continue with PPI Farm Products (WPU01) (Monthly)  Chap 19-12
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Farm Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
FarmProdcutsTable = readtable(fredfile137,'Sheet','Monthly');
[nrows137,ncols137]=size(FarmProdcutsTable);
dateArray=strings(nrows137,1);
for n=1:nrows137
    nowstr=string(FarmProdcutsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows137)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows137,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FarmProductsTT=table2timetable(FarmProdcutsTable,'RowTimes','Date');
FarmProductsTT = addvars(FarmProductsTT,DateNumbers);
meanFPVal=mean(FarmProductsTT.Index);
medianFPVal=median(FarmProductsTT.Index);
meanFarmProducts=zeros(nrows137,1);
medianFarmProducts=zeros(nrows137,1);
for n=1:nrows137
    meanFarmProducts(n,1)=meanFPVal;
    medianFarmProducts(n,1)=medianFPVal;
end
FarmProductsTT = addvars(FarmProductsTT,meanFarmProducts,medianFarmProducts);
SourceFile(137,1)="PPIFarmProducts.xlsx";
Code(137,1)="WPU01";
Desc(137,1)="PPIFarmProducts";
Freq(137,1)="Monthly";
StartYear(137,1)=1913;
EndYear(137,1)=2025;
SeasonalAdj(137,1)="No";
BaseYear(137,1)=1982;
NumObs(137,1)=1361;
FRObj.Desc=Desc;
Chap(137,1)=19;
Section(137,1)=12;
Commodity(137,1)=1;
% Calculate the Simple Stats
itype=137;
Data=FarmProductsTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
farmsmooth = smoothdata(Data);
P0=farmsmooth(1);
PF=farmsmooth(1361);
FarmProductsTT= addvars(FarmProductsTT,farmsmooth);
NYears=EndYear(137,1)-StartYear(137,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG137=100*GrowthRateAll(itype,1);
FRObj.SG137=SG137;
% Now pull of the Recession Probability data that matches the available
% time points in the WholeChickenTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [FarmProductsTT,icase] = OverlapTimeLinesRev1(FarmProductsTT,RecessProbTT);
    FRObj.FarmProductsTT=FarmProductsTT;
    RecessionInfo(137,1)=icase;
end
FRObj.barval=80;
FRObj.FarmProductsTT=FarmProductsTT;
% Now plot this data
titlestr='FarmProductsIndex';
PlotFredData(FRObj,FarmProductsTT,itype,titlestr)
% Add this table to the FredObj
FRObj.FarmProductsTT=FarmProductsTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{137,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FarmProductsIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(17),~,numoverlap(17)] = CalculateCorrelation(UrbanHFTT,FarmProductsTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Farm Products Index-',num2str(rho(17)));
disp(dispstr)
FoodCorrTable(17,:) = {126,"UrbanHFTT",StartYear1,EndYear1,137,"FarmProductsTT",1913,2025,rho(17),SG137,numoverlap(17)};

%% Continue with PPI Slaughter Cattle (WPU0131) (Monthly)  Chap 19-13
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Cattle Products';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
CattleTable = readtable(fredfile138,'Sheet','Monthly');
[nrows138,ncols138]=size(CattleTable);
dateArray=strings(nrows138,1);
for n=1:nrows138
    nowstr=string(CattleTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows138)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows138,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CattleTT=table2timetable(CattleTable,'RowTimes','Date');
CattleTT = addvars(CattleTT,DateNumbers);
meanCattleVal=mean(CattleTT.Index);
medianCattleVal=median(CattleTT.Index);
meanCattle=zeros(nrows138,1);
medianCattle=zeros(nrows138,1);
for n=1:nrows138
    meanCattle(n,1)=meanCattleVal;
    medianCattle(n,1)=medianCattleVal;
end
CattleTT = addvars(CattleTT,meanCattle,medianCattle);
SourceFile(138,1)="PPICattle.xlsx";
Code(138,1)="WPU0131";
Desc(138,1)="PPISlaughterCattle";
Freq(138,1)="Monthly";
StartYear(138,1)=1947;
EndYear(138,1)=2025;
SeasonalAdj(138,1)="No";
BaseYear(138,1)=1982;
NumObs(138,1)=953;
FRObj.Desc=Desc;
Chap(138,1)=19;
Section(138,1)=13;
Commodity(138,1)=1;
% Calculate the Simple Stats
itype=138;
Data=CattleTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
cattlesmooth = smoothdata(Data);
P0=cattlesmooth(1);
PF=cattlesmooth(953);
CattleTT= addvars(CattleTT,cattlesmooth);
NYears=EndYear(138,1)-StartYear(138,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG138=100*GrowthRateAll(itype,1);
FRObj.SG138=SG138;
% Now pull of the Recession Probability data that matches the available
% time points in the CattleTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [CattleTT,icase] = OverlapTimeLinesRev1(CattleTT,RecessProbTT);
    FRObj.CattleTT=CattleTT;
    RecessionInfo(138,1)=icase;
end
FRObj.barval=120;
FRObj.CattleTT=CattleTT;
% Now plot this data
titlestr='CattleIndex';
PlotFredData(FRObj,CattleTT,itype,titlestr)
% Add this table to the FredObj
FRObj.CattleTT=CattleTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{138,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CattleIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(18),~,numoverlap(18)] = CalculateCorrelation(UrbanHFTT,CattleTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Cattle Index-',num2str(rho(18)));
disp(dispstr)
FoodCorrTable(18,:) = {126,"UrbanHFTT",StartYear1,EndYear1,138,"CattleTT",1947,2025,rho(18),SG138,numoverlap(18)};

%% Continue with PPI Tomatoes (WPU01130217) (Monthly)  Chap 19-14
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Tomatoes';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
TomatoesTable = readtable(fredfile139,'Sheet','Monthly');
[nrows139,ncols139]=size(TomatoesTable);
dateArray=strings(nrows139,1);
for n=1:nrows139
    nowstr=string(TomatoesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows139)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows139,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TomatoesTT=table2timetable(TomatoesTable,'RowTimes','Date');
TomatoesTT = addvars(TomatoesTT,DateNumbers);
meanTomatoesVal=mean(TomatoesTT.Index);
medianTomatoesVal=median(TomatoesTT.Index);
meanTomatoes=zeros(nrows139,1);
medianTomatoes=zeros(nrows139,1);
for n=1:nrows139
    meanTomatoes(n,1)=meanTomatoesVal;
    medianTomatoes(n,1)=medianTomatoesVal;
end
TomatoesTT = addvars(TomatoesTT,meanTomatoes,medianTomatoes);
SourceFile(139,1)="PPITomatoes.xlsx";
Code(139,1)="WPU01130217";
Desc(139,1)="PPITomatoes";
Freq(139,1)="Monthly";
StartYear(139,1)=1947;
EndYear(139,1)=2025;
SeasonalAdj(139,1)="No";
BaseYear(139,1)=1982;
NumObs(139,1)=951;
FRObj.Desc=Desc;
Chap(139,1)=19;
Section(139,1)=14;
Commodity(139,1)=1;
% Calculate the Simple Stats
itype=139;
Data=TomatoesTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
tomatoessmooth = smoothdata(Data);
P0=tomatoessmooth(1);
PF=tomatoessmooth(951);
TomatoesTT= addvars(TomatoesTT,tomatoessmooth);
NYears=EndYear(139,1)-StartYear(139,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG139=100*GrowthRateAll(itype,1);
FRObj.SG139=SG139;
% Now pull of the Recession Probability data that matches the available
% time points in the CattleTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [TomatoesTT,icase] = OverlapTimeLinesRev1(TomatoesTT,RecessProbTT);
    FRObj.TomatoesTT=TomatoesTT;
    RecessionInfo(139,1)=icase;
end
FRObj.barval=200;
FRObj.TomatoesTT=TomatoesTT;
% Now plot this data
titlestr='TomatoesIndex';
PlotFredData(FRObj,TomatoesTT,itype,titlestr)
% Add this table to the FredObj
FRObj.TomatoesTT=TomatoesTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{139,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='TomatoesIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(19),~,numoverlap(19)] = CalculateCorrelation(UrbanHFTT,TomatoesTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Tomatoes Index-',num2str(rho(19)));
disp(dispstr)
FoodCorrTable(19,:) = {126,"UrbanHFTT",StartYear1,EndYear1,139,"TomatoesTT",1947,2025,rho(19),SG139,numoverlap(19)};

%% Continue with PPI Corn (WPU01220205) (Monthly)  Chap 19-15
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Corn';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
CornTable = readtable(fredfile140,'Sheet','Monthly');
[nrows140,ncols140]=size(CornTable);
dateArray=strings(nrows140,1);
for n=1:nrows140
    nowstr=string(CornTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows140)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows140,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CornTT=table2timetable(CornTable,'RowTimes','Date');
CornTT = addvars(CornTT,DateNumbers);
meanCornVal=mean(CornTT.Index);
medianCornVal=median(CornTT.Index);
meanCorn=zeros(nrows140,1);
medianCorn=zeros(nrows140,1);
for n=1:nrows140
    meanCorn(n,1)=meanCornVal;
    medianCorn(n,1)=medianCornVal;
end
CornTT = addvars(CornTT,meanCorn,medianCorn);
SourceFile(140,1)="PPICorn.xlsx";
Code(140,1)="WPU01220205";
Desc(140,1)="PPICorn";
Freq(140,1)="Monthly";
StartYear(140,1)=1947;
EndYear(140,1)=2025;
SeasonalAdj(140,1)="No";
BaseYear(140,1)=1982;
NumObs(140,1)=953;
FRObj.Desc=Desc;
Chap(140,1)=19;
Section(140,1)=15;
Commodity(140,1)=1;
% Calculate the Simple Stats
itype=140;
Data=CornTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
cornsmooth = smoothdata(Data);
P0=cornsmooth(1);
PF=cornsmooth(951);
CornTT= addvars(CornTT,cornsmooth);
NYears=EndYear(140,1)-StartYear(140,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG140=100*GrowthRateAll(itype,1);
FRObj.SG140=SG140;
% Now pull of the Recession Probability data that matches the available
% time points in the CattleTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [CornTT,icase] = OverlapTimeLinesRev1(CornTT,RecessProbTT);
    FRObj.CornTT=CornTT;
    RecessionInfo(140,1)=icase;
end
FRObj.barval=100;
FRObj.CornTT=CornTT;
% Now plot this data
titlestr='CornIndex';
PlotFredData(FRObj,CornTT,itype,titlestr)
% Add this table to the FredObj
FRObj.CornTT=CornTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{140,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CornIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(20),~,numoverlap(20)] = CalculateCorrelation(UrbanHFTT,CornTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Corn Index-',num2str(rho(20)));
disp(dispstr)
FoodCorrTable(20,:) = {126,"UrbanHFTT",StartYear1,EndYear1,140,"CornTT",1947,2025,rho(20),SG140,numoverlap(20)};

%% Continue with PPI Raw Milk (WPU01610102) (Monthly)  Chap 19-16
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Raw Milk';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
RawMilkTable = readtable(fredfile141,'Sheet','Monthly');
[nrows141,ncols141]=size(RawMilkTable);
dateArray=strings(nrows141,1);
for n=1:nrows141
    nowstr=string(RawMilkTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows141)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows141,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RawMilkTT=table2timetable(RawMilkTable,'RowTimes','Date');
RawMilkTT = addvars(RawMilkTT,DateNumbers);
meanRawMilkVal=mean(RawMilkTT.Index);
medianRawMilkVal=median(RawMilkTT.Index);
meanRawMilk=zeros(nrows141,1);
medianRawMilk=zeros(nrows141,1);
for n=1:nrows141
    meanRawMilk(n,1)=meanRawMilkVal;
    medianRawMilk(n,1)=medianRawMilkVal;
end
RawMilkTT = addvars(RawMilkTT,meanRawMilk,medianRawMilk);
SourceFile(141,1)="PPIRawMilk.xlsx";
Code(141,1)="WPU01610102";
Desc(141,1)="PPIRawMilk";
Freq(141,1)="Monthly";
StartYear(141,1)=1973;
EndYear(141,1)=2025;
SeasonalAdj(141,1)="No";
BaseYear(141,1)=1982;
NumObs(141,1)=630;
FRObj.Desc=Desc;
Chap(141,1)=19;
Section(141,1)=16;
Commodity(141,1)=1;
% Calculate the Simple Stats
itype=141;
Data=RawMilkTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
milksmooth = smoothdata(Data);
P0=milksmooth(1);
PF=milksmooth(630);
RawMilkTT= addvars(RawMilkTT,milksmooth);
NYears=EndYear(141,1)-StartYear(141,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG141=100*GrowthRateAll(itype,1);
FRObj.SG141=SG141;
% Now pull of the Recession Probability data that matches the available
% time points in the RawMilkTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
     [RawMilkTT,icase] = OverlapTimeLinesRev1(RawMilkTT,RecessProbTT);
     FRObj.RawMilkTT=RawMilkTT;
     RecessionInfo(141,1)=icase;
end
FRObj.barval=50;
FRObj.RawMilkTT=RawMilkTT;
% Now plot this data
titlestr='MilkIndex';
PlotFredData(FRObj,RawMilkTT,itype,titlestr)
% Add this table to the FredObj
FRObj.RawMilkTT=RawMilkTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{141,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='MilkIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(21),~,numoverlap(21)] = CalculateCorrelation(UrbanHFTT,RawMilkTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Raw Milk Index-',num2str(rho(21)));
disp(dispstr)
FoodCorrTable(21,:) = {126,"UrbanHFTT",StartYear1,EndYear1,141,"RawMilkTT",1973,2025,rho(21),SG141,numoverlap(21)};

%% Continue with PPI Fruits and Mellons Vegetables and Nuts (WPU011) (Monthly)  Chap 19-17
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Fruits';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
FruitsTable = readtable(fredfile142,'Sheet','Monthly');
[nrows142,ncols142]=size(FruitsTable);
dateArray=strings(nrows142,1);
for n=1:nrows142
    nowstr=string(FruitsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows142)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows142,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PCIFruitsTT=table2timetable(FruitsTable,'RowTimes','Date');
PCIFruitsTT = addvars(PCIFruitsTT,DateNumbers);
meanFruitsVal=mean(PCIFruitsTT.Index);
medianFruitsVal=median(PCIFruitsTT.Index);
meanFruits=zeros(nrows142,1);
medianFruits=zeros(nrows142,1);
for n=1:nrows142
    meanFruits(n,1)=meanFruitsVal;
    medianFruits(n,1)=medianFruitsVal;
end
PCIFruitsTT = addvars(PCIFruitsTT,meanFruits,medianFruits);
SourceFile(142,1)="PPIFruits.xlsx";
Code(142,1)="WPU011";
Desc(142,1)="PPIFruits&Vegetables";
Freq(142,1)="Monthly";
StartYear(142,1)=1926;
EndYear(142,1)=2025;
SeasonalAdj(142,1)="No";
BaseYear(142,1)=1982;
NumObs(142,1)=1205;
FRObj.Desc=Desc;
Chap(142,1)=19;
Section(142,1)=17;
Commodity(142,1)=1;
% Calculate the Simple Stats
itype=142;
Data=PCIFruitsTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
fruitsmooth = smoothdata(Data);
P0=fruitsmooth(1);
PF=fruitsmooth(1205);
PCIFruitsTT= addvars(PCIFruitsTT,fruitsmooth);
NYears=EndYear(142,1)-StartYear(142,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG142=100*GrowthRateAll(itype,1);
FRObj.SG142=SG142;
% Now pull of the Recession Probability data that matches the available
% time points in the PCIFruitsTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
     [PCIFruitsTT,icase] = OverlapTimeLinesRev1(PCIFruitsTT,RecessProbTT);
     FRObj.PCIFruitsTT=PCIFruitsTT;   
     RecessionInfo(142,1)=icase;
end
FRObj.barval=100;
FRObj.PCIFruitsTT=PCIFruitsTT;
% Now plot this data
titlestr='FruitsIndex';
PlotFredData(FRObj,PCIFruitsTT,itype,titlestr)
% Add this table to the FredObj
FRObj.PCIFruitsTT=PCIFruitsTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{142,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FruitsIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(22),~,numoverlap(22)] = CalculateCorrelation(UrbanHFTT,PCIFruitsTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Fruit And Vegatable Index-',num2str(rho(22)));
disp(dispstr)
FoodCorrTable(22,:) = {126,"UrbanHFTT",StartYear1,EndYear1,142,"PCIFruitsTT",1926,2025,rho(22),SG142,numoverlap(22)};

%% Continue with PPI Cabbage (WPU01130211) (Monthly)  Chap 19-18
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Cabbage';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
CabbageTable = readtable(fredfile143,'Sheet','Monthly');
[nrows143,ncols143]=size(CabbageTable);
dateArray=strings(nrows143,1);
for n=1:nrows143
    nowstr=string(CabbageTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows143)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows143,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PPICabbageTT=table2timetable(CabbageTable,'RowTimes','Date');
PPICabbageTT = addvars(PPICabbageTT,DateNumbers);
meanCabbageVal=mean(PPICabbageTT.Index);
medianCabbageVal=median(PPICabbageTT.Index);
meanCabbage=zeros(nrows143,1);
medianCabbage=zeros(nrows143,1);
for n=1:nrows143
    meanCabbage(n,1)=meanCabbageVal;
    medianCabbage(n,1)=medianCabbageVal;
end
PPICabbageTT = addvars(PPICabbageTT,meanCabbage,medianCabbage);
SourceFile(143,1)="PPICabbage.xlsx";
Code(143,1)="WPU01130211";
Desc(143,1)="PPICabbage";
Freq(143,1)="Monthly";
StartYear(143,1)=1947;
EndYear(143,1)=2025;
SeasonalAdj(143,1)="No";
BaseYear(143,1)=1982;
NumObs(143,1)=951;
FRObj.Desc=Desc;
Chap(143,1)=19;
Section(143,1)=18;
Commodity(143,1)=1;
% Calculate the Simple Stats
itype=143;
Data=PPICabbageTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
cabbagesmooth = smoothdata(Data);
P0=cabbagesmooth(1);
PF=cabbagesmooth(951);
PPICabbageTT= addvars(PPICabbageTT,cabbagesmooth);
NYears=EndYear(143,1)-StartYear(143,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG143=100*GrowthRateAll(itype,1);
FRObj.SG143=SG143;
% Now pull of the Recession Probability data that matches the available
% time points in the PPICabageTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% Plot is missing 
     [PPICabbageTT,icase] = OverlapTimeLinesRev1(PPICabbageTT,RecessProbTT);
     FRObj.PPICabbageTT=PPICabbageTT;
     RecessionInfo(143,1)=icase;
end
FRObj.barval=200;
FRObj.PPICabbageTT=PPICabbageTT;
% Now plot this data
titlestr='CabbageIndex';
PlotFredData(FRObj,PPICabbageTT,itype,titlestr)
% Add this table to the FredObj
FRObj.PPICabbageTT=PPICabbageTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{143,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CabbageIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(23),~,numoverlap(23)] = CalculateCorrelation(UrbanHFTT,PPICabbageTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Cabbage Index-',num2str(rho(23)));
disp(dispstr)
FoodCorrTable(23,:) = {126,"UrbanHFTT",StartYear1,EndYear1,143,"PCICabbageTT",1947,2025,rho(23),SG143,numoverlap(23)};
%% Continue with PPI Rice (WPU01230103) (Monthly)  Chap 19-19
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Rice';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
RiceTable = readtable(fredfile144,'Sheet','Monthly');
[nrows144,ncols144]=size(RiceTable);
dateArray=strings(nrows144,1);
for n=1:nrows144
    nowstr=string(RiceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows144)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows144,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RiceTT=table2timetable(RiceTable,'RowTimes','Date');
RiceTT = addvars(RiceTT,DateNumbers);
meanRiceVal=mean(RiceTT.Index);
medianRiceVal=median(RiceTT.Index);
meanRice=zeros(nrows144,1);
medianRice=zeros(nrows144,1);
for n=1:nrows144
    meanRice(n,1)=meanRiceVal;
    medianRice(n,1)=medianRiceVal;
end
RiceTT = addvars(RiceTT,meanRice,medianRice);
SourceFile(144,1)="PPIRice.xlsx";
Code(144,1)="WPU01230103";
Desc(144,1)="PPIRice";
Freq(144,1)="Monthly";
StartYear(144,1)=2004;
EndYear(144,1)=2025;
SeasonalAdj(144,1)="No";
BaseYear(144,1)=2004;
NumObs(144,1)=258;
FRObj.Desc=Desc;
Chap(144,1)=19;
Section(144,1)=19;
Commodity(144,1)=1;
% Calculate the Simple Stats
itype=144;
Data=RiceTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
ricesmooth = smoothdata(Data);
P0=ricesmooth(1);
PF=ricesmooth(258);
RiceTT= addvars(RiceTT,ricesmooth);
NYears=EndYear(144,1)-StartYear(144,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG144=100*GrowthRateAll(itype,1);
FRObj.SG144=SG144;
RecessionInfo(144,1)=icase;
% Now pull of the Recession Probability data that matches the available
% time points in the RiceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% Plot is missing 
     [RiceTT,icase] = OverlapTimeLinesRev1(RiceTT,RecessProbTT);
     FRObj.RiceTT=RiceTT;
end
FRObj.barval=100;
FRObj.RiceTT=RiceTT;
% Now plot this data
titlestr='RiceIndex';
PlotFredData(FRObj,RiceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.RiceTT=RiceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{144,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RiceIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(24),~,numoverlap(24)] = CalculateCorrelation(UrbanHFTT,RiceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Rice Index-',num2str(rho(24)));
disp(dispstr)
FoodCorrTable(24,:) = {126,"UrbanHFTT",StartYear1,EndYear1,144,"RiceTT",2004,2025,rho(24),SG144,numoverlap(24)};

%% Continue with PPI Citrus Fruit(WPU011101) (Monthly)  Chap 19-20
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the PPI Citrus Fruits';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
CitrusTable = readtable(fredfile145,'Sheet','Monthly');
[nrows145,ncols145]=size(CitrusTable);
dateArray=strings(nrows145,1);
for n=1:nrows145
    nowstr=string(CitrusTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows145)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows145,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PPICitrusTT=table2timetable(CitrusTable,'RowTimes','Date');
PPICitrusTT = addvars(PPICitrusTT,DateNumbers);
meanCitrusVal=mean(PPICitrusTT.Index);
medianCitrusVal=median(PPICitrusTT.Index);
meanCitrus=zeros(nrows145,1);
medianCitrus=zeros(nrows145,1);
for n=1:nrows145
    meanCitrus(n,1)=meanCitrusVal;
    medianCitrus(n,1)=medianCitrusVal;
end
PPICitrusTT = addvars(PPICitrusTT,meanCitrus,medianCitrus);
SourceFile(145,1)="PPICitrusFruits.xlsx";
Code(145,1)="WPU011101";
Desc(145,1)="PPICitrusFruits";
Freq(145,1)="Monthly";
StartYear(145,1)=1947;
EndYear(145,1)=2025;
SeasonalAdj(145,1)="No";
BaseYear(145,1)=1982;
NumObs(145,1)=934;
FRObj.Desc=Desc;
Chap(145,1)=19;
Section(145,1)=20;
Commodity(145,1)=1;
% Calculate the Simple Stats
itype=145;
Data=PPICitrusTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
citrussmooth = smoothdata(Data);
P0=citrussmooth(1);
PF=citrussmooth(934);
PPICitrusTT= addvars(PPICitrusTT,citrussmooth);
NYears=EndYear(145,1)-StartYear(145,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG145=100*GrowthRateAll(itype,1);
FRObj.SG145=SG145;
% Now pull of the Recession Probability data that matches the available
% time points in the RiceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% Plot is missing 
     [PPICitrusTT,icase] = OverlapTimeLinesRev1(PPICitrusTT,RecessProbTT);
     FRObj.PPICitrusTT=PPICitrusTT;
     RecessionInfo(145,1)=icase;
end
FRObj.barval=100;
FRObj.PPICitrusTT=PPICitrusTT;
% Now plot this data
titlestr='CitrusFruitsIndex';
PlotFredData(FRObj,PPICitrusTT,itype,titlestr)
% Add this table to the FredObj
FRObj.PPICitrusTT=PPICitrusTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{145,1}=figstr2;
% Now create the data for a cumilaPPICitrusFruitsIndex-Cumiltive distribution plot
titlestr3='CitrusFruitsIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=1;
[rho(25),~,numoverlap(25)] = CalculateCorrelation(UrbanHFTT,PPICitrusTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and CitrusFruits Index Index-',num2str(rho(24)));
disp(dispstr)
FoodCorrTable(25,:) = {126,"UrbanHFTT",StartYear1,EndYear1,145,"PPICitrusTT",1947,2025,rho(25),SG145,numoverlap(25)};

%% Continue with the CoreSticky CPI Data (CORESTICKM159SFRBATL)(Monthly)
% itype=2
eval(['cd ' fredpath(1:length(fredpath)-1)]);
SCPITable = readtable(fredfile2,'Sheet','Monthly');
[nrows2,ncols2]=size(SCPITable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows2,1);
for n=1:nrows2
    nowstr=string(SCPITable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Sticky CPI Rate Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows2,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
SCPITT=table2timetable(SCPITable,'RowTimes','Date');
SCPITT = addvars(SCPITT,DateNumbers);
meanSCP=mean(SCPITT.SCPINFNE);
medianSCP=median(SCPITT.SCPINFNE);
meanSCPNFNE=zeros(nrows2,1);
medianSCPNFNE=zeros(nrows2,1);
for n=1:nrows2
    meanSCPNFNE(n,1)=meanSCP;
    medianSCPNFNE(n,1)=medianSCP;
end
SCPITT = addvars(SCPITT,meanSCPNFNE,medianSCPNFNE);
SourceFile(2,1)="CORESTICKM159SFRBATL.xlsx";
Code(2,1)="CORESTICKM159SFRBATL";
Desc(2,1)="StickyCPI";
Freq(2,1)="Monthly";
StartYear(2,1)=1968;
EndYear(2,1)=2025;
SeasonalAdj(2,1)="Yes";
BaseYear(2,1)=1968;
NumObs(2,1)=689;
Chap(2,1)=5;
Section(2,1)=2;
itype=2;
% Calculate the Simple Stats
Data=SCPITT.SCPINFNE;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
scpismooth = smoothdata(Data);
P0=scpismooth(1);
PF=scpismooth(689);
SCPITT= addvars(SCPITT,scpismooth);
% Now plot this data
titlestr='StickyCPI-1968-2025';
PlotFredData(FRObj,SCPITT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.SCPITT=SCPITT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{2,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='SCPI-Cumil-Distribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Labor force Participation Rate (CIVPart) (Chap 3 Section 2)
% itype=3
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ParticipationTable = readtable(fredfile3,'Sheet','Monthly');
[nrows3,~]=size(ParticipationTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows3,1);
for n=1:nrows3
    nowstr=string(ParticipationTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr3='Process the Labor Force Participation Rate ';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr3);
loopstr4=strcat('Data is available for-',num2str(nrows3,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr4);
ParticipationTT=table2timetable(ParticipationTable,'RowTimes','Date');
ParticipationTT = addvars(ParticipationTT,DateNumbers);
meanPartAllValue=mean(ParticipationTT.CIVPART_All);
meanPart_55Value=mean(ParticipationTT.CIVPART_55);
meanPart_25_54Value=mean(ParticipationTT.CIVPART_25_54);
meanPartAll=zeros(nrows3,1);
meanPart_55=zeros(nrows3,1);
meanPart_25_54=zeros(nrows3,1);
for n=1:nrows3
    meanPartAll(n,1)=meanPartAllValue;
    meanPart_55(n,1)=meanPart_55Value;
    meanPart_25_54(n,1)=meanPart_25_54Value;
end
ParticipationTT = addvars(ParticipationTT,meanPartAll,meanPart_55,meanPart_25_54);
loopstr4a=strcat('Mean Labor Force Participation Rate For All Workers-',num2str(meanPartAllValue),'-Pct');
fprintf(fid,'%50s\n',loopstr4a);
loopstr4b=strcat('Mean Labor Force Participation Rate Workers Over 55-',num2str(meanPart_55Value),'-Pct');
fprintf(fid,'%50s\n',loopstr4b);
loopstr4c=strcat('Mean Labor Force Participation Rate Workers Between 25 and 54-',num2str(meanPart_25_54Value),'-Pct');
fprintf(fid,'%50s\n',loopstr4c);
SourceFile(3,1)="CIVPART-1948-2025.xlsx";
Code(3,1)="CIVPART";
Desc(3,1)="LaborForceParticipationRate";
Freq(3,1)="Monthly";
StartYear(3,1)=1948;
EndYear(3,1)=2025;
SeasonalAdj(3,1)="Yes";
BaseYear(3,1)=1948;
NumObs(3,1)=929;
Chap(3,1)=3;
Section(3,1)=2;
% Now plot this data
itype=3;
titlestr='LaborForceParticipationRate-1948-2025';
PlotFredData(FRObj,ParticipationTT,itype,titlestr)
% Add this data to the FredObj
FRObj.ParticipationTT=ParticipationTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{3,1}=figstr2;

%% Continue with the Delinquency Rate on Single Family Home Loans DRSFRMACBS (Chap 6 Section 6)
% itype=4
eval(['cd ' fredpath(1:length(fredpath)-1)]);
SingleHomeDelRateTable = readtable(fredfile4,'Sheet','Quarterly');
[nrows4,~]=size(SingleHomeDelRateTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows4,1);
for n=1:nrows4
    nowstr=string(SingleHomeDelRateTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr5='Process the Home Mortgage Delinquency Rate ';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows4,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr6);
SingleHomeDelRateTT=table2timetable(SingleHomeDelRateTable,'RowTimes','Date');
SingleHomeDelRateTT = addvars(SingleHomeDelRateTT,DateNumbers);
meanDelinquencyValue=mean(SingleHomeDelRateTT.DRSFRMACBS);
medianDelinquencyValue=median(SingleHomeDelRateTT.DRSFRMACBS);
meanDelRate=zeros(nrows4,1);
medianDelRate=zeros(nrows4,1);
loopstr7=strcat('Mean Home Deliquency Rate-',num2str(meanDelinquencyValue),'-Pct');
fprintf(fid,'%30s\n',loopstr7);
for n=1:nrows4
    meanDelRate(n,1)=meanDelinquencyValue;
    medianDelRate(n,1)=medianDelinquencyValue;
end
SingleHomeDelRateTT = addvars(SingleHomeDelRateTT,meanDelRate,medianDelRate);
SourceFile(4,1)="DelinquencyRateSingleHomes-1991-2025.xlsx";
Code(4,1)="DRSFRMACBS";
Desc(4,1)="DelinquencyRate-Single-FamilyHomes";
Freq(4,1)="Quarterly";
StartYear(4,1)=1991;
EndYear(4,1)=2025;
SeasonalAdj(4,1)="Yes";
BaseYear(4,1)=1991;
NumObs(4,1)=137;
Chap(4,1)=6;
Section(4,1)=6;
% Calculate the Simple Stats
itype=4;
Data=SingleHomeDelRateTT.DRSFRMACBS;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the data before plotting
delsmooth = smoothdata(Data);
P0=delsmooth(1);
PF=delsmooth(137);
SingleHomeDelRateTT = addvars(SingleHomeDelRateTT,delsmooth);
NYears=EndYear(4,1)-StartYear(4,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG4=100*GrowthRateAll(itype,1);
FRObj.SG4=SG4;
% Now plot this data
titlestr='SingleHomeLoanDelinquencyRate-1991-2025';
PlotFredData(FRObj,SingleHomeDelRateTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{4,1}=figstr2;
% Add this data to the Fred Object
FRObj.SingleHomeDelRateTT=SingleHomeDelRateTT;
% Now create the data for a cumilative distribution plot
titlestr3='MortgageDelinquency-Cumil-Distribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Home Ownership Rate  (Chap 6 Section 1)
% itype=5
eval(['cd ' fredpath(1:length(fredpath)-1)]);
HomeOwnershipTable = readtable(fredfile5,'Sheet','Quarterly');
[nrows5,~]=size(HomeOwnershipTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows5,1);
for n=1:nrows5
    nowstr=string(HomeOwnershipTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr5='Process the Home Ownership Rate ';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows5,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr6);
HomeOwnershipTT=table2timetable(HomeOwnershipTable,'RowTimes','Date');
HomeOwnershipTT = addvars(HomeOwnershipTT,DateNumbers);
meanHomeOwnershipVal=mean(HomeOwnershipTT.HomeOwnership);
meanHomeOwner=zeros(nrows5,1);
medianHomeOwnershipVal=median(HomeOwnershipTT.HomeOwnership);
medianHomeOwner=zeros(nrows5,1);
for n=1:nrows5
    meanHomeOwner(n,1)=meanHomeOwnershipVal;
    medianHomeOwner(n,1)=meanHomeOwnershipVal;
end
HomeOwnershipTT = addvars(HomeOwnershipTT,meanHomeOwner,medianHomeOwner);
SourceFile(5,1)="HomeOwnership-1965-2025.xlsx";
Code(5,1)="RHORUSQ156N";
Desc(5,1)="HomeOwershipRate";
Freq(5,1)="Quarterly";
StartYear(5,1)=1965;
EndYear(5,1)=2025;
SeasonalAdj(5,1)="No";
BaseYear(5,1)=1965;
NumObs(5,1)=241;
loopstr7=strcat('Mean Home Ownership Rate-',num2str(meanHomeOwnershipVal),'-Pct');
fprintf(fid,'%30s\n',loopstr7);
Chap(5,1)=6;
Section(5,1)=1;
itype=5;
Data=HomeOwnershipTT.HomeOwnership;
hownsmooth = smoothdata(Data);
% Calculate the Simple Stats
FRObj=FRObj.SimpleStats(Data,itype);% Calculate the Simple Stats
P0=hownsmooth(1);
PF=hownsmooth(241);
HomeOwnershipTT = addvars(HomeOwnershipTT,hownsmooth);
NYears=EndYear(5,1)-StartYear(5,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG5=100*GrowthRateAll(itype,1);
FRObj.SG5=SG5;
% Calculate simple stats
FRObj=FRObj.SimpleStats(Data,itype);
% Plot the data
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{60,1}=figstr2;
titlestr='HomeOwnershipRate-1965-2025';
PlotFredData(FRObj,HomeOwnershipTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{5,1}=figstr2;
FRObj.HomeOwnershipTT=HomeOwnershipTT;
% Now create the data for a cumilative distribution plot
titlestr3='HomeOwnership-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Industrial ManufacturingProduction (IPMAN) (Chapter 11 Section 1)
%itype=6
eval(['cd ' fredpath(1:length(fredpath)-1)]);
IPMANTable = readtable(fredfile6,'Sheet','Monthly');
[nrows6,~]=size(IPMANTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows6,1);
for n=1:nrows6
    nowstr=string(IPMANTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr5='Process the Industrial Manufacturing Index data (2017==100)';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows6,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr6);
IPManMeanValue=mean(IPMANTable.IPMAN);
IPManMean=zeros(nrows6,1);
IPManMedianValue=median(IPMANTable.IPMAN);
IPManMedian=zeros(nrows6,1);
for n=1:nrows6
    IPManMean(n,1)=IPManMeanValue;
    IPManMedian(n,1)=IPManMedianValue;
end
loopstr7=strcat('Mean Industrial Production Index-',num2str(IPManMeanValue));
fprintf(fid,'%30s\n',loopstr7);
IPMANTT=table2timetable(IPMANTable,'RowTimes','Date');
IPMANTT = addvars(IPMANTT,DateNumbers);
IPMANTT = addvars(IPMANTT,IPManMean,IPManMedian);
SourceFile(6,1)="IPMAN-1972-2025.xlsx";
Code(6,1)="IPMAN";
Desc(6,1)="Industrial Production Index";
Freq(6,1)="Monthly";
StartYear(6,1)=1972;
EndYear(6,1)=2025;
SeasonalAdj(6,1)="Yes";
BaseYear(6,1)=2017;
NumObs(6,1)=640;
Chap(6,1)=11;
Section(6,1)=1;
% Calculate simple stats
itype=6;
Data=IPMANTT.IPMAN;
FRObj=FRObj.SimpleStats(Data,itype);
% Now smooth and then plot this data
ipmansmooth = smoothdata(Data);
P0=ipmansmooth(1);
PF=ipmansmooth(640);
IPMANTT = addvars(IPMANTT,ipmansmooth);
NYears=EndYear(6,1)-StartYear(6,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG6=100*GrowthRateAll(itype,1);
FRObj.SG6=SG6;
% Now pull of the Recession Probability data that matches the available
% time points in the IPMANTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [IPMANTT,icase] = OverlapTimeLinesRev1(IPMANTT,RecessProbTT);
    FRObj.IPMANTT=IPMANTT;
    RecessionInfo(6,1)=icase;
end

FRObj.barval=60;
FRObj.IPMANTT=IPMANTT;
% Plot the data over time
titlestr='IndustrialProduction-1972-2025';
PlotFredData(FRObj,IPMANTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{6,1}=figstr2;
FRObj.IPMANTT=IPMANTT;
% Now create the data for a cumilative distribution plot
titlestr3='IPMAN-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Real Median Household Income
% itype=7
eval(['cd ' fredpath(1:length(fredpath)-1)]);
RealMedianHouseholdIncomeTable = readtable(fredfile7,'Sheet','Annual');
[nrows7,~]=size(RealMedianHouseholdIncomeTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows7,1);
for n=1:nrows7
    nowstr=string(RealMedianHouseholdIncomeTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RealMedHouseIncTT=table2timetable(RealMedianHouseholdIncomeTable,'RowTimes','Date');
RealMedHouseIncTT = addvars(RealMedHouseIncTT,DateNumbers);
loopstr5='Process the Real Family Income Data For 1984 thru 2023';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows7,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr6);
HouseIncomeMeanValue=mean(RealMedHouseIncTT.Income);
HouseIncomeMean=zeros(nrows7,1);
HouseIncomeMedianValue=median(RealMedHouseIncTT.Income);
HouseIncomeMedian=zeros(nrows7,1);
for n=1:nrows7
    HouseIncomeMean(n,1)=HouseIncomeMeanValue;
    HouseIncomeMedian(n,1)=HouseIncomeMedianValue;
end
loopstr7=strcat('Real Mean Household Income-',num2str(HouseIncomeMeanValue/1000),'-Thousands USD');
fprintf(fid,'%30s\n',loopstr7);
RealMedHouseIncTT = addvars(RealMedHouseIncTT,HouseIncomeMean,HouseIncomeMedian);
SourceFile(7,1)="RealMedHouseholdIncome.xlsx";
Code(7,1)="MEHOINUSA672N";
Desc(7,1)="Real Median Household Income";
Freq(7,1)="Annual";
StartYear(7,1)=1984;
EndYear(7,1)=2023;
SeasonalAdj(7,1)="No";
BaseYear(7,1)=2023;
NumObs(7,1)=40;
Chap(7,1)=6;
Section(7,1)=7;
P0=RealMedHouseIncTT.Income(1)/1000;
PF=RealMedHouseIncTT.Income(40)/1000;
NYears=19;
itype=7;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG7=100*GrowthRateAll(itype,1);
FRObj.SG7=SG7;
% Now plot this data
titlestr='MedianHouseholdIncome';
PlotFredData(FRObj,RealMedHouseIncTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{7,1}=figstr2;
FRObj.RealMedHouseIncTT=RealMedHouseIncTT;

%% Continue with the CBOE Volitility Index (VIXCLS)
% itype=8
eval(['cd ' fredpath(1:length(fredpath)-1)]);
VixTable = readtable(fredfile8,'Sheet','Daily');
[nrows8,~]=size(VixTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows8,1);
for n=1:nrows8
    nowstr=string(VixTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
VixTT=table2timetable(VixTable,'RowTimes','Date');
VixTT = addvars(VixTT,DateNumbers);
VixMeanValue=mean(VixTT.VIXCLS);
VixMean=zeros(nrows8,1);
for n=1:nrows8
    VixMean(n,1)=VixMeanValue;
end
VixTT=addvars(VixTT,VixMean);
loopstr5='Process the CBOE VIX Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows8,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr6);
loopstr7=strcat('Mean Vix Value-',num2str(VixMeanValue));
fprintf(fid,'%10s\n',loopstr7);
SourceFile(8,1)="CBOE-VIX.xlsx";
Code(8,1)="VIXCLS";
Desc(8,1)="CBOE Volatility Index";
Freq(8,1)="Daily";
StartYear(8,1)=1990;
EndYear(8,1)=2025;
SeasonalAdj(8,1)="No";
BaseYear(8,1)=2020;
NumObs(8,1)=1280;
Chap(8,1)=10;
Section(8,1)=1;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=8;
% Calculate the Simple Stats
Data=VixTT.VIXCLS;
% Now smooth and then plot this data
vixsmooth = smoothdata(Data);
P0=vixsmooth(1);
PF=vixsmooth(1280);
VixTT = addvars(VixTT,vixsmooth);
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='CBOE-VIX-1990-2025';
PlotFredData(FRObj,VixTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{8,1}=figstr2;
FRObj.VixTT=VixTT;
% Now create the data for a cumilative distribution plot
titlestr3='CBOE-VIX-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Consumer Sentiment Index itype=9
% itype=9
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CCTable = readtable(fredfile9,'Sheet','Monthly');
[nrows9,ncols9]=size(CCTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows9,1);
for n=1:nrows9
    nowstr=string(CCTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CCTT=table2timetable(CCTable,'RowTimes','Date');
CCTT = addvars(CCTT,DateNumbers);
meanConfidenceVal=mean(CCTT.Confidence);
medianConfidenceVal=median(CCTT.Confidence);
ConfidenceMean=zeros(nrows9,1);
ConfidenceMedian=zeros(nrows9,1);
for n=1:nrows9
    ConfidenceMean(n,1)=meanConfidenceVal;
    ConfidenceMedian(n,1)=medianConfidenceVal;
end
CCTT = addvars(CCTT,ConfidenceMean,ConfidenceMedian);
loopstr5='Process the Consumer Confidence  Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows9,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr6);
loopstr7=strcat('Mean ConfidenceValue-',num2str(meanConfidenceVal));
fprintf(fid,'%10s\n',loopstr7);
SourceFile(9,1)="ConsumerConfidence-1978-2025.xlsx";
Code(9,1)="UMCSENT";
Desc(9,1)="Consumer Sentiment Index";
Freq(9,1)="Monthly";
StartYear(9,1)=1978;
EndYear(9,1)=2025;
SeasonalAdj(9,1)="No";
BaseYear(9,1)=1978;
NumObs(9,1)=568;
Chap(9,1)=8;
Section(9,1)=7;
% Now plot this data
itype=9;
titlestr='ConsumerConfidence-2020-2025';
% Calculate the Simple Stats
Data=CCTT.Confidence;
ccsmooth=smoothdata(Data);
P0=ccsmooth(1);
PF=ccsmooth(568);
CCTT = addvars(CCTT,ccsmooth);
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the CCTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [CCTT,icase] = OverlapTimeLinesRev1(CCTT,RecessProbTT);
    FRObj.CCTT=CCTT;
    RecessionInfo(9,1)=icase;
end

FRObj.barval=80;
FRObj.CCTT=CCTT;
% Plot this data
PlotFredData(FRObj,CCTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{9,1}=figstr2;
FRObj.CCTT=CCTT;
% Now create the data for a cumilative distribution plot
titlestr3='CSentiment-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

% Add Chapter 6 Section 2
%% Continue with the Home Inventory -Days on Market(MEDDAYONMARUS)
% itype=10
eval(['cd ' fredpath(1:length(fredpath)-1)]);
HouseSupplyTable = readtable(fredfile10,'Sheet','Monthly');
[nrows10,~]=size(HouseSupplyTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows10,1);
for n=1:nrows10
    nowstr=string(HouseSupplyTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
HouseSupplyTT=table2timetable(HouseSupplyTable,'RowTimes','Date');
HouseSupplyTT = addvars(HouseSupplyTT,DateNumbers);
meanDaysOnMarketVal=mean(HouseSupplyTT.DaysOnMarket);
meanDays=zeros(nrows10,1);
medianDaysOnMarketVal=median(HouseSupplyTT.DaysOnMarket);
medianDays=zeros(nrows10,1);
for n=1:nrows10
    meanDays(n,1)=meanDaysOnMarketVal;
    medianDays(n,1)=medianDaysOnMarketVal;
end
HouseSupplyTT = addvars(HouseSupplyTT,meanDays,medianDays);
SourceFile(10,1)="HouseInventory.xlsx";
Code(10,1)="MEDDAYONMARUS";
Desc(10,1)="Median Days On Market";
Freq(10,1)="Monthly";
StartYear(10,1)=2016;
EndYear(10,1)=2025;
SeasonalAdj(10,1)="No";
BaseYear(10,1)=2016;
NumObs(10,1)=107;
loopstr5='Process the House Supply Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows10,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean House Supply Days-',num2str(meanDaysOnMarketVal));
fprintf(fid,'%10s\n',loopstr7);
Chap(10,1)=6;
Section(10,1)=2;
% Now plot this data
itype=10;
% Calculate the Simple Stats
Data=HouseSupplyTT.DaysOnMarket;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='HouseSupply-2016-2025';
dayonmktsmooth = smoothdata(Data);
P0=dayonmktsmooth(1);
PF=dayonmktsmooth(107);
HouseSupplyTT = addvars(HouseSupplyTT,meanDays,dayonmktsmooth);
FRObj.HouseSupplyTT=HouseSupplyTT;
RecessionInfo(10,1)=icase;
% Now pull of the Recession Probability data that matches the available
% time points in the HouseSupplyTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [HouseSupplyTT,icase] = OverlapTimeLinesRev1(HouseSupplyTT,RecessProbTT);
    FRObj.HouseSupplyTT=HouseSupplyTT;
    RecessionInfo(10,1)=icase;
end
FRObj.barval=30;
FRObj.HouseSupplyTT=HouseSupplyTT;
% Plot the data
PlotFredData(FRObj,HouseSupplyTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{10,1}=figstr2;
FRObj.HouseSupplyTT=HouseSupplyTT;
% Now create the data for a cumilative distribution plot
titlestr3='HouseMedianDays-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Fed 10 Year Bond Rate
% itype=11
eval(['cd ' fredpath(1:length(fredpath)-1)]);
Fed10YearBondsTable = readtable(fredfile11,'Sheet','Monthly');
[nrows11,~]=size(Fed10YearBondsTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows11,1);
for n=1:nrows11
    nowstr=string(Fed10YearBondsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
Fed10YearBondsTT=table2timetable(Fed10YearBondsTable,'RowTimes','Date');
Fed10YearBondsTT = addvars(Fed10YearBondsTT,DateNumbers);
meanYield10YearBondVal=mean(Fed10YearBondsTT.BondYield10Years);
medianYield10YearBondVal=median(Fed10YearBondsTT.BondYield10Years);
meanYield10Years=zeros(nrows11,1);
medianYield10Years=zeros(nrows11,1);
for n=1:nrows11
    meanYield10Years(n,1)=meanYield10YearBondVal;
    medianYield10Years(n,1)=medianYield10YearBondVal;
end
Fed10YearBondsTT = addvars(Fed10YearBondsTT,meanYield10Years,medianYield10Years);
SourceFile(11,1)="Fed10YearBondYields.xlsx";
Code(11,1)="IRLTLT01USM156N";
Desc(11,1)="Ten Year Bond Yields";
Freq(11,1)="Monthly";
StartYear(11,1)=1953;
EndYear(11,1)=2025;
SeasonalAdj(11,1)="No";
BaseYear(11,1)=1953;
NumObs(11,1)=866;
loopstr5='Process the Fed 10 Year Bond Rate Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows11,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean 10 Year Bond Rate-',num2str(meanYield10YearBondVal),...
    '-Median Yield=',num2str(medianYield10YearBondVal));
fprintf(fid,'%10s\n',loopstr7);
Chap(11,1)=12;
Section(11,1)=1;
% Now plot this data
itype=11;
% Calculate the Simple Stats
Data=Fed10YearBondsTT.BondYield10Years;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='Fed10YearBonds-1953-2025';
bond10smooth = smoothdata(Data);
P0=bond10smooth(1);
PF=bond10smooth(866);
Fed10YearBondsTT = addvars(Fed10YearBondsTT,bond10smooth);
PlotFredData(FRObj,Fed10YearBondsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{11,1}=figstr2;
FRObj.Fed10YearBondsTT=Fed10YearBondsTT;
% Now create the data for a cumilative distribution plot
titlestr3='Fed10YearCumilRates';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the U2 UnemploymentRate U2Rate
%itype=12
eval(['cd ' fredpath(1:length(fredpath)-1)]);
U2RateTable = readtable(fredfile12,'Sheet','Monthly');
[nrows12,~]=size(U2RateTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows12,1);
for n=1:nrows12
    nowstr=string(U2RateTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows12)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
U2RateTT=table2timetable(U2RateTable,'RowTimes','Date');
U2RateTT = addvars(U2RateTT,DateNumbers);
FRObj.U2RateTT=U2RateTT;
meanU2RateVal=mean(U2RateTT.U2RATE);
medianU2RateVal=median(U2RateTT.U2RATE);
meanU2=zeros(nrows12,1);
medianU2=zeros(nrows12,1);
for n=1:nrows12
    meanU2(n,1)=meanU2RateVal;
    medianU2(n,1)=medianU2RateVal;
end
U2RateTT = addvars(U2RateTT,meanU2,medianU2);
SourceFile(12,1)="U2Rate-1967-2025.xlsx";
Code(12,1)="U2RATE";
Desc(12,1)="U2 Job Losers";
Freq(12,1)="Monthly";
StartYear(12,1)=1967;
EndYear(12,1)=2025;
SeasonalAdj(12,1)="Yes";
BaseYear(12,1)=1967;
NumObs(12,1)=701;
loopstr5='Process the U2 Unemployment Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows12,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean U2 Rate-',num2str(meanU2RateVal),...
    '-Median Yield=',num2str(medianU2RateVal));
fprintf(fid,'%10s\n',loopstr7);
Chap(12,1)=4;
Section(12,1)=7;
% Now plot this data
itype=12;
% Calculate the Simple Stats
Data=U2RateTT.U2RATE;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='U2Rate-1967-2025';
FRObj.U2RateTT=U2RateTT;
u2smooth = smoothdata(Data);
P0=u2smooth(1);
PF=u2smooth(701);
U2RateTT = addvars(U2RateTT,u2smooth);
PlotFredData(FRObj,U2RateTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{12,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='U2Rate-CumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
fprintf(fid,'\n');

%% Continue with the Real GDP
% itype=13
eval(['cd ' fredpath(1:length(fredpath)-1)]);
GDPTable = readtable(fredfile13,'Sheet','Quarterly');
[nrows13,~]=size(GDPTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows13,1);
for n=1:nrows13
    nowstr=string(GDPTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows13)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
GDPTT=table2timetable(GDPTable,'RowTimes','Date');
GDPTT = addvars(GDPTT,DateNumbers);
FRObj.GDPTT=GDPTT;
meanGDPVal=mean(GDPTT.GDPC1);
medianGDPVal=median(GDPTT.GDPC1);
meanGDP=zeros(nrows13,1);
medianGDP=zeros(nrows13,1);
for n=1:nrows13
    meanGDP(n,1)=meanGDPVal;
    medianGDP(n,1)=medianGDPVal;
end
GDPTT = addvars(GDPTT,meanGDP,medianGDP);
FRObj.GDPTT=GDPTT;
loopstr5='Process the Real GDP Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows13,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean GDP-',num2str(meanGDPVal),'-in Billion of USD Per Quarter');
fprintf(fid,'%10s\n',loopstr7);
SourceFile(13,1)="RealGDP-1947-2025.xlsx";
Code(13,1)="GDPC1";
Desc(13,1)="Real GDP";
Freq(13,1)="Quarterly";
StartYear(13,1)=1947;
EndYear(13,1)=2025;
SeasonalAdj(13,1)="Yes";
BaseYear(13,1)=2017;
NumObs(13,1)=313;
% smooth the data
Data=GDPTT.GDPC1;
realgdpsmooth = smoothdata(Data);
P0=realgdpsmooth(1)/1000;
PF=realgdpsmooth(313)/1000;
GDPTT = addvars(GDPTT,realgdpsmooth);
% Now plot this data
Chap(13,1)=13;
Section(13,1)=2;
% P0=GDPTT.GDPC1(1)/1000;
% PF=GDPTT.GDPC1(313)/1000;
NYears=EndYear(13,1)-StartYear(13,1)+1;
itype=13;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG13=100*GrowthRateAll(itype,1);
FRObj.SG13=SG13;
% Calculate the Simple Stats
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='GDPByQuarter-1947-2025';
PlotFredData(FRObj,GDPTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{13,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='GDPQuarterlyCumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Real GDP Per Capita (annual Value) sampled Quarterly
%% A939RX0Q048SBEA
% itype=14
eval(['cd ' fredpath(1:length(fredpath)-1)]);
GDPPerCapTable = readtable(fredfile14,'Sheet','Quarterly');
[nrows14,~]=size(GDPPerCapTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows14,1);
for n=1:nrows14
    nowstr=string(GDPPerCapTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
GDPPerCapTT=table2timetable(GDPPerCapTable,'RowTimes','Date');
GDPPerCapTT = addvars(GDPPerCapTT,DateNumbers);
meanGDPCapVal=mean(GDPPerCapTT.GDPPerCapita);
medianGDPCapVal=median(GDPPerCapTT.GDPPerCapita);
meanGDPPerCap=zeros(nrows14,1);
medianGDPPerCap=zeros(nrows14,1);
for n=1:nrows14
    meanGDPPerCap(n,1)=meanGDPCapVal;
    medianGDPPerCap(n,1)=medianGDPCapVal;
end
GDPPerCapTT = addvars(GDPPerCapTT,meanGDPPerCap,medianGDPPerCap);
SourceFile(14,1)="RealGDPPerCap-1947-2025.xlsx";
Code(14,1)="A939RX0Q048SBEA";
Desc(14,1)="Real GDP Per Capita";
Freq(14,1)="Quarterly";
StartYear(14,1)=1947;
EndYear(14,1)=2025;
SeasonalAdj(14,1)="Yes";
BaseYear(14,1)=2017;
NumObs(14,1)=313;
loopstr5='Process the Real GDP Per Capita  Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows14,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean GDPPerCap-',num2str(meanGDPVal),'-in Thousands of USD Per Quarter');
fprintf(fid,'%10s\n',loopstr7);
FRObj.GDPPerCapTT=GDPPerCapTT;
Chap(14,1)=13;
Section(14,1)=3;
itype=14;
% smooth the data
Data=GDPPerCapTT.GDPPerCapita/1000;
gdpsmooth = smoothdata(Data);
P0=gdpsmooth(1);
PF=gdpsmooth(313);
NYears=EndYear(14,1)-StartYear(14,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG14=100*GrowthRateAll(itype,1);
FRObj.SG14=SG14;
GDPPerCapTT = addvars(GDPPerCapTT,gdpsmooth);
% Now plot this data
% Calculate the Simple Stats
Data=GDPPerCapTT.GDPPerCapita;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='GDPPerCapByQuarter-1947-2025';
PlotFredData(FRObj,GDPPerCapTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{14,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='GDPPerCapByQuarterCumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Fed 2 Year Bond Yields
% itype=15
eval(['cd ' fredpath(1:length(fredpath)-1)]);
Fed2YearBondsTable = readtable(fredfile15,'Sheet','Daily');
[nrows15,~]=size(Fed2YearBondsTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows15,1);
for n=1:nrows15
    nowstr=string(Fed2YearBondsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
Fed2YearBondsTT=table2timetable(Fed2YearBondsTable,'RowTimes','Date');
Fed2YearBondsTT = addvars(Fed2YearBondsTT,DateNumbers);
meanYield2YearBondVal=mean(Fed2YearBondsTT.Yield,'omitnan');
medianYield2YearBondVal=median(Fed2YearBondsTT.Yield,'omitnan');
meanYield2Years=zeros(nrows15,1);
medianYield2Years=zeros(nrows15,1);
for n=1:nrows15
    meanYield2Years(n,1)=meanYield2YearBondVal;
    medianYield2Years(n,1)=medianYield2YearBondVal;
end
Fed2YearBondsTT = addvars(Fed2YearBondsTT,meanYield2Years,medianYield2Years);
SourceFile(15,1)="Fed2YearBondYields.xlsx";
Code(15,1)="DGS2";
Desc(15,1)="Market 2 Year Bond Yields";
Freq(15,1)="Daily";
StartYear(15,1)=1976;
EndYear(15,1)=2025;
SeasonalAdj(15,1)="Yes";
BaseYear(15,1)=2017;
NumObs(15,1)=12797;
loopstr5='Process the Fed 2 Year Bonds';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows15,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean 2 Year Yield=',num2str(meanYield2YearBondVal),...
    '-Median 2 Year Yield=',num2str(medianYield2YearBondVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.Fed2YearBondsTT=Fed2YearBondsTT;
Chap(15,1)=12;
Section(15,1)=2;
itype=15;
NYears=EndYear(15,1)-StartYear(15,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG15=100*GrowthRateAll(itype,1);
FRObj.SG15=SG15;
% Now plot this data
itype=15;
% Calculate the Simple Stats
Data=Fed2YearBondsTT.Yield;
FRObj=FRObj.SimpleStats(Data,itype);
bond2smooth = smoothdata(Data);
P0=bond2smooth(1);
PF=bond2smooth(12797);
Fed2YearBondsTT = addvars(Fed2YearBondsTT,bond2smooth);
titlestr='Fed2YearBonds-1976-2025';
PlotFredData(FRObj,Fed2YearBondsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{15,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='Fed2YearCumilRates';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Initial UnemploymentClaims ICSA)
% itype=16
eval(['cd ' fredpath(1:length(fredpath)-1)]);
InitialUnemploymentTable = readtable(fredfile16,'Sheet','Weekly');
[nrows16,~]=size(InitialUnemploymentTable);
clear DateNumbers dateArray
dateArray=strings(nrows16,1);
for n=1:nrows16
    nowstr=string(InitialUnemploymentTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
InitialUnemploymentTT=table2timetable(InitialUnemploymentTable,'RowTimes','Date');
InitialUnemploymentTT = addvars(InitialUnemploymentTT,DateNumbers);
meanInitialClaimsVal=mean(InitialUnemploymentTT.ICSA,'omitnan');
medianInitialClaimsVal=median(InitialUnemploymentTT.ICSA,'omitnan');
meanInitialClaims=zeros(nrows16,1);
medianInitialClaims=zeros(nrows16,1);
for n=1:nrows16
    meanInitialClaims(n,1)=meanInitialClaimsVal;
    medianInitialClaims(n,1)=medianInitialClaimsVal;
end
InitialUnemploymentTT = addvars(InitialUnemploymentTT,meanInitialClaims,medianInitialClaims);
SourceFile(16,1)="InitialUnemploymentClaims.xlsx";
Code(16,1)="ICSA";
Desc(16,1)="Initial Unemployment Claims";
Freq(16,1)="Weekly";
StartYear(16,1)=1967;
EndYear(16,1)=2025;
SeasonalAdj(16,1)="Yes";
BaseYear(16,1)=2017;
NumObs(16,1)=3050;
loopstr5='Process the Initial Unemployment Claims';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows16,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Claims=',num2str(meanInitialClaimsVal),...
    '-Median Claims=',num2str(medianInitialClaimsVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.InitialUnemploymentTT=InitialUnemploymentTT;
Chap(16,1)=3;
Section(16,1)=4;
% Now plot this data
itype=16;
% Calculate the Simple Stats
Data=InitialUnemploymentTT.ICSA;
initu2smooth = smoothdata(Data);
P0=initu2smooth(1);
PF=initu2smooth(3050);
InitialUnemploymentTT = addvars(InitialUnemploymentTT,initu2smooth);
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='InitialUnemploymentClaims-1967-2025';
PlotFredData(FRObj,InitialUnemploymentTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{16,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='Initial-UnEmploy-CumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Continued UnemploymentClaims (CCSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ContinueUnemploymentTable = readtable(fredfile17,'Sheet','Weekly');
[nrows17,~]=size(ContinueUnemploymentTable);
clear DateNumbers dateArray
dateArray=strings(nrows17,1);
for n=1:nrows17
    nowstr=string(ContinueUnemploymentTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ContinueUnemploymentTT=table2timetable(ContinueUnemploymentTable,'RowTimes','Date');
ContinueUnemploymentTT = addvars(ContinueUnemploymentTT,DateNumbers);
meanContinueClaimsVal=mean(ContinueUnemploymentTT.CCSA,'omitnan');
medianContinueClaimsVal=median(ContinueUnemploymentTT.CCSA,'omitnan');
meanContinueClaims=zeros(nrows17,1);
medianContinueClaims=zeros(nrows17,1);
for n=1:nrows17
    meanContinueClaims(n,1)=meanContinueClaimsVal;
    medianContinueClaims(n,1)=medianContinueClaimsVal;
end
ContinueUnemploymentTT = addvars(ContinueUnemploymentTT,meanContinueClaims,medianContinueClaims);
SourceFile(17,1)="ContinuedUnemploymentClaims.xlsx";
Code(17,1)="CCSA";
Desc(17,1)="Continued Unemployment Claims";
Freq(17,1)="Weekly";
StartYear(17,1)=1967;
EndYear(17,1)=2025;
SeasonalAdj(17,1)="Yes";
BaseYear(17,1)=1967;
NumObs(17,1)=3049;
loopstr5='Process the Continued Unemployment Claims';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows17,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Claims=',num2str(meanContinueClaimsVal),...
    '-Median Claims=',num2str(medianContinueClaimsVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.ContinueUnemploymentTT=ContinueUnemploymentTT;
Chap(17,1)=3;
Section(17,1)=5;
% Now plot this data
itype=17;
% Calculate the Simple Stats
Data=ContinueUnemploymentTT.CCSA/1E6;
contu2smooth = smoothdata(Data);
P0=contu2smooth(1);
PF=contu2smooth(3049);
ContinueUnemploymentTT = addvars(ContinueUnemploymentTT,contu2smooth);
Data=ContinueUnemploymentTT.CCSA;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='ContinuedUnemploymentClaims-1967-2025';
PlotFredData(FRObj,ContinueUnemploymentTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{17,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='Continued-UnEmploy-CumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Total Non Farm Job Openings (JTSJOL)
% itype=18
eval(['cd ' fredpath(1:length(fredpath)-1)]);
TotalNFJOpenTable = readtable(fredfile18,'Sheet','Monthly');
[nrows18,~]=size(TotalNFJOpenTable);
clear DateNumbers dateArray
dateArray=strings(nrows18,1);
for n=1:nrows18
    nowstr=string(TotalNFJOpenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TotalNFJOpenTT=table2timetable(TotalNFJOpenTable,'RowTimes','Date');
TotalNFJOpenTT = addvars(TotalNFJOpenTT,DateNumbers);
meanNFJOVal=mean(TotalNFJOpenTT.JTSJOL,'omitnan');
medianNFJOVal=median(TotalNFJOpenTT.JTSJOL,'omitnan');
meanNFJO=zeros(nrows18,1);
medianNFJO=zeros(nrows18,1);
for n=1:nrows18
    meanNFJO(n,1)=meanNFJOVal;
    medianNFJO(n,1)=medianNFJOVal;
end
TotalNFJOpenTT= addvars(TotalNFJOpenTT,meanNFJO,medianNFJO);
SourceFile(18,1)="TotalNonFarmJobOpen-2000-2025.xlsx";
Code(18,1)="JTSJOL";
Desc(18,1)="Total Non Farm Job Openings";
Freq(18,1)="Monthly";
StartYear(18,1)=2000;
EndYear(18,1)=2025;
SeasonalAdj(18,1)="Yes";
BaseYear(18,1)=2020;
NumObs(18,1)=293;
loopstr5='Process the total Non Farm Job Openings';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows18,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Openings=',num2str(meanNFJOVal,7),...
    '-Median Openings=',num2str(medianNFJOVal,7));
fprintf(fid,'%10s\n',loopstr7);
FRObj.TotalNFJOpenTT=TotalNFJOpenTT;
Chap(18,1)=4;
Section(18,1)=1;
FRObj.Chap=Chap;
FRObj.Section=Section;
Data=TotalNFJOpenTT.JTSJOL;
% Calculate the smoothed Non Farm Job Openings
nfarmsmooth = smoothdata(Data);
P0=nfarmsmooth(1);
PF=nfarmsmooth(293);
TotalNFJOpenTT= addvars(TotalNFJOpenTT,nfarmsmooth);
% Now plot this data
itype=18;
% Calculate the Simple Stats
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='TotalNonFarm-Job-Openings-2000-2025';
PlotFredData(FRObj,TotalNFJOpenTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{18,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='NonFarmOpenings-CumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Construction Job Openings (JTS2300JOL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ConstructionOpenTable = readtable(fredfile19,'Sheet','Monthly');
[nrows19,~]=size(ConstructionOpenTable);
clear DateNumbers dateArray
dateArray=strings(nrows19,1);
for n=1:nrows19
    nowstr=string(ConstructionOpenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ConstructionOpenTT=table2timetable(ConstructionOpenTable,'RowTimes','Date');
ConstructionOpenTT = addvars(ConstructionOpenTT,DateNumbers);
meanCJOpenVal=mean(ConstructionOpenTT.JTS2300JOL,'omitnan');
medianCJOpenVal=median(ConstructionOpenTT.JTS2300JOL,'omitnan');
maxCJOpenVal=max(ConstructionOpenTT.JTS2300JOL,[],'omitnan');
meanCJOpen=zeros(nrows19,1);
medianCJOpen=zeros(nrows19,1);
maxCJOpen=zeros(nrows19,1);
for n=1:nrows19
    meanCJOpen(n,1)=meanCJOpenVal;
    medianCJOpen(n,1)=medianCJOpenVal;
    maxCJOpen(n,1)=maxCJOpenVal;
end
ConstructionOpenTT= addvars(ConstructionOpenTT,meanCJOpen,medianCJOpen,maxCJOpen);
SourceFile(19,1)="ConstructionJobOpenings-2000-2025.xlsx";
Code(19,1)="JTS2300JOL";
Desc(19,1)="Construction Job Openings";
Freq(19,1)="Monthly";
StartYear(19,1)=2000;
EndYear(19,1)=2025;
SeasonalAdj(19,1)="Yes";
BaseYear(19,1)=2000;
NumObs(19,1)=293;
loopstr5='Process the Construction Job Openings';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows19,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Openings=',num2str(meanCJOpenVal,6),...
    '-Median Openings=',num2str(medianCJOpenVal,6));
fprintf(fid,'%10s\n',loopstr7);
Chap(19,1)=4;
Section(19,1)=2;
FRObj.ConstructionOpenTT=ConstructionOpenTT;
% Now plot this data
itype=19;
% Smooth the Data
constsmooth = smoothdata(ConstructionOpenTT.JTS2300JOL);
P0=constsmooth(1);
PF=constsmooth(293);
ConstructionOpenTT= addvars(ConstructionOpenTT,constsmooth);
% Calculate the Simple Stats
Data=ConstructionOpenTT.JTS2300JOL;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='ConstructionJobOpenings';
PlotFredData(FRObj,ConstructionOpenTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{19,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ConstructionOpenings-CumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Manufacturing Job Openings (JTS3000JOL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ManufacOpenTable = readtable(fredfile20,'Sheet','Monthly');
[nrows20,~]=size(ManufacOpenTable);
clear DateNumbers dateArray
dateArray=strings(nrows20,1);
for n=1:nrows20
    nowstr=string(ManufacOpenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ManufacOpenTT=table2timetable(ManufacOpenTable,'RowTimes','Date');
ManufacOpenTT = addvars(ManufacOpenTT,DateNumbers);
meanMFacJOpenVal=mean(ManufacOpenTT.JTS3000JOL,'omitnan');
medianMFacJOpenVal=median(ManufacOpenTT.JTS3000JOL,'omitnan');
maxMFacJOpenVal=max(ManufacOpenTT.JTS3000JOL,[],'omitnan');
meanMFacOpen=zeros(nrows20,1);
medianMFacOpen=zeros(nrows20,1);
maxMFacOpen=zeros(nrows20,1);
for n=1:nrows20
    meanMFacOpen(n,1)=meanMFacJOpenVal;
    medianMFacOpen(n,1)=medianMFacJOpenVal;
    maxMFacOpen(n,1)=maxMFacJOpenVal;
end
ManufacOpenTT= addvars(ManufacOpenTT,meanMFacOpen,medianMFacOpen,maxMFacOpen);
SourceFile(20,1)="ManufacturingJobOpenings-2000-2025.xlsx";
Code(20,1)="JTS3000JOL";
Desc(20,1)="Manufacturing Job Openings";
Freq(20,1)="Monthly";
StartYear(20,1)=2000;
EndYear(20,1)=2025;
SeasonalAdj(20,1)="Yes";
BaseYear(20,1)=2020;
NumObs(20,1)=293;
loopstr5='Process the Manufacturing Job Openings';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows20,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Openings=',num2str(meanMFacJOpenVal,6),...
    '-Median Openings=',num2str(medianMFacJOpenVal,6));
fprintf(fid,'%10s\n',loopstr7);
Chap(20,1)=4;
Section(20,1)=3;
FRObj.Chap=Chap;
FRObj.Section=Section;
FRObj.ManufacOpenTT=ManufacOpenTT;
% Now plot this data
itype=20;
% Smooth the Data
mansmooth = smoothdata(ManufacOpenTT.JTS3000JOL);
P0=mansmooth(1);
PF=mansmooth(293);
ManufacOpenTT= addvars(ManufacOpenTT,mansmooth);
% Calculate the Simple Stats
Data=ManufacOpenTT.JTS3000JOL;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='Manufacturing-Job-Openings-2000-2025';
PlotFredData(FRObj,ManufacOpenTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{20,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ManufacturingJobOpenings-CumilDist';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Professional Job Openings (JTS540099JOL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ProfOpenTable = readtable(fredfile21,'Sheet','Monthly');
[nrows21,~]=size(ProfOpenTable);
clear DateNumbers dateArray
dateArray=strings(nrows21,1);
for n=1:nrows21
    nowstr=string(ProfOpenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ProfOpenTT=table2timetable(ProfOpenTable,'RowTimes','Date');
ProfOpenTT = addvars(ProfOpenTT,DateNumbers);
meanProfJOpenVal=mean(ProfOpenTT.JTS540099JOL,'omitnan');
medianProfJOpenVal=median(ProfOpenTT.JTS540099JOL,'omitnan');
maxProfJOpenVal=max(ProfOpenTT.JTS540099JOL,[],'omitnan');
meanProfOpen=zeros(nrows21,1);
medianProfOpen=zeros(nrows21,1);
maxProfOpen=zeros(nrows21,1);
for n=1:nrows21
    meanProfOpen(n,1)=meanProfJOpenVal;
    medianProfOpen(n,1)=medianProfJOpenVal;
    maxProfOpen(n,1)=maxProfJOpenVal;
end
ProfOpenTT= addvars(ProfOpenTT,meanProfOpen,medianProfOpen,maxProfOpen);
SourceFile(21,1)="ProfJobOpen.xlsx";
Code(21,1)="JTS540099JOL";
Desc(21,1)="Professional Job Openings";
Freq(21,1)="Monthly";
StartYear(21,1)=2000;
EndYear(21,1)=2025;
SeasonalAdj(21,1)="Yes";
BaseYear(21,1)=2000;
NumObs(21,1)=293;
loopstr5='Process the Professional Job Openings';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows21,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Openings=',num2str(meanProfJOpenVal,6),...
    '-Median Openings=',num2str(medianProfJOpenVal,6));
fprintf(fid,'%10s\n',loopstr7);
Chap(21,1)=4;
Section(21,1)=4;
FRObj.ProfOpenTT=ProfOpenTT;
% Now plot this data
itype=21;
% Calculate the Simple Stats
Data=ProfOpenTT.JTS540099JOL;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='Professional-Job-Openings-2000-2025';
% Calculate the smoothed Prof Job Openings
profsmooth = smoothdata(ProfOpenTT.JTS540099JOL);
P0=profsmooth(1);
PF=profsmooth(293);
ProfOpenTT= addvars(ProfOpenTT,profsmooth);
% Plot the Job Openings Vs Time
PlotFredData(FRObj,ProfOpenTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{21,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ProfJobsOpen-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Health Care Job Openings
eval(['cd ' fredpath(1:length(fredpath)-1)]);
HCareOpenTable = readtable(fredfile22,'Sheet','Monthly');
[nrows22,~]=size(HCareOpenTable);
clear DateNumbers dateArray
dateArray=strings(nrows22,1);
for n=1:nrows22
    nowstr=string(HCareOpenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
HCareOpenTT=table2timetable(HCareOpenTable,'RowTimes','Date');
HCareOpenTT = addvars(HCareOpenTT,DateNumbers);
meanHCJOpenVal=mean(HCareOpenTT.JTS6200JOL,'omitnan');
medianHCJOpenVal=median(HCareOpenTT.JTS6200JOL,'omitnan');
maxHCJOpenVal=max(HCareOpenTT.JTS6200JOL,[],'omitnan');
meanHCOpen=zeros(nrows22,1);
medianHCOpen=zeros(nrows22,1);
maxHCOpen=zeros(nrows22,1);
for n=1:nrows22
    meanHCOpen(n,1)=meanHCJOpenVal;
    medianHCOpen(n,1)=medianHCJOpenVal;
    maxHCOpen(n,1)=maxHCJOpenVal;
end
HCareOpenTT= addvars(HCareOpenTT,meanHCOpen,medianHCOpen,maxHCOpen);
SourceFile(22,1)="HealthCareJobOpenings.xlsx";
Code(22,1)="JTS6200JOL";
Desc(22,1)="Health Care Job Openings";
Freq(22,1)="Monthly";
StartYear(22,1)=2000;
EndYear(22,1)=2025;
SeasonalAdj(22,1)="Yes";
BaseYear(22,1)=2000;
NumObs(22,1)=293;
loopstr5='Process the Health Care Job Openings';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows22,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Openings=',num2str(meanHCJOpenVal,6),...
    '-Median Openings=',num2str(medianHCJOpenVal,6));
fprintf(fid,'%10s\n',loopstr7);
Chap(22,1)=4;
Section(22,1)=5;
FRObj.Chap=Chap;
FRObj.Section=Section;
FRObj.HCareOpenTT=HCareOpenTT;
% Now plot this data
itype=22;
% Calculate the Simple Stats
Data=HCareOpenTT.JTS6200JOL;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
hcaresmooth = smoothdata(HCareOpenTT.JTS6200JOL);
P0=hcaresmooth(1);
PF=hcaresmooth(293);
HCareOpenTT= addvars(HCareOpenTT,hcaresmooth);
titlestr='HealthCare-Job-Openings-2000-2025';
PlotFredData(FRObj,HCareOpenTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{22,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='HCareJobsOpen-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Government Job Openings (JTS9000JOL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
GovOpenTable = readtable(fredfile23,'Sheet','Monthly');
[nrows23,~]=size(GovOpenTable);
clear DateNumbers dateArray
dateArray=strings(nrows23,1);
for n=1:nrows23
    nowstr=string(GovOpenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
GovOpenTT=table2timetable(GovOpenTable,'RowTimes','Date');
GovOpenTT = addvars(GovOpenTT,DateNumbers);
meanGovJOpenVal=mean(GovOpenTT.JTS9000JOL,'omitnan');
medianGovJOpenVal=median(GovOpenTT.JTS9000JOL,'omitnan');
maxGovJOpenVal=max(GovOpenTT.JTS9000JOL,[],'omitnan');
meanGovOpen=zeros(nrows23,1);
medianGovOpen=zeros(nrows23,1);
maxGovOpen=zeros(nrows23,1);
for n=1:nrows23
    meanGovOpen(n,1)=meanGovJOpenVal;
    medianGovOpen(n,1)=medianGovJOpenVal;
    maxGovOpen(n,1)=maxGovJOpenVal;
end
GovOpenTT= addvars(GovOpenTT,meanGovOpen,medianGovOpen,maxGovOpen);
SourceFile(23,1)="GovJobOpenings.xlsx";
Code(23,1)="JTS9000JOL";
Desc(23,1)="Government Job Openings";
Freq(23,1)="Monthly";
StartYear(23,1)=2000;
EndYear(23,1)=2025;
SeasonalAdj(23,1)="Yes";
BaseYear(23,1)=2000;
NumObs(23,1)=293;
Chap(23,1)=4;
Section(23,1)=6;
loopstr5='Process the Government Job Openings';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows23,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Openings=',num2str(meanGovJOpenVal,6),...
    '-Median Openings=',num2str(medianGovJOpenVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.GovOpenTT=GovOpenTT;
% Now plot this data
itype=23;
% Calculate the Simple Stats
Data=GovOpenTT.JTS9000JOL;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
govsmooth = smoothdata(Data);
P0=govsmooth(1);
PF=govsmooth(293);
GovOpenTT= addvars(GovOpenTT,govsmooth);
titlestr='Govt-Job-Openings-2000-2025';
PlotFredData(FRObj,GovOpenTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{23,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='GovJobsOpen-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Real Median Personal Income  
eval(['cd ' fredpath(1:length(fredpath)-1)]);
RealMedianPersIncomeTable = readtable(fredfile24,'Sheet','Annual');
[nrows24,~]=size(RealMedianPersIncomeTable);
clear DateNumbers dateArray
dateArray=strings(nrows24,1);
for n=1:nrows24
    nowstr=string(RealMedianPersIncomeTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RealMedianPersIncomeTT=table2timetable(RealMedianPersIncomeTable,'RowTimes','Date');
RealMedianPersIncomeTT = addvars(RealMedianPersIncomeTT,DateNumbers);
meanPIncomeVal=mean(RealMedianPersIncomeTT.Income,'omitnan');
medianPIncomeVal=median(RealMedianPersIncomeTT.Income,'omitnan');
maxPIncomeVal=max(RealMedianPersIncomeTT.Income,[],'omitnan');
meanPIncome=zeros(nrows24,1);
medianPIncome=zeros(nrows24,1);
maxPIncome=zeros(nrows24,1);
for n=1:nrows24
    meanPIncome(n,1)=meanPIncomeVal;
    medianPIncome(n,1)=medianPIncomeVal;
    maxPIncome(n,1)=maxPIncomeVal;
end
RealMedianPersIncomeTT= addvars(RealMedianPersIncomeTT,meanPIncome,medianPIncome,maxPIncome);
SourceFile(24,1)="RealMedianPersonalIncome.xlsx";
Code(24,1)="MEPAINUSA672N";
Desc(24,1)="Real Median Personal Income";
Freq(24,1)="Annual";
StartYear(24,1)=1974;
EndYear(24,1)=2023;
SeasonalAdj(24,1)="No";
BaseYear(24,1)=2023;
NumObs(24,1)=40;
loopstr5='Process the Real Median Personal Income Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows24,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Real PIncome=',num2str(meanPIncomeVal,6),...
    '-Median Real PIncome=',num2str(medianPIncomeVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.RealMedianPersIncomeTT=RealMedianPersIncomeTT;
% Now plot this data
Chap(24,1)=6;
Section(24,1)=8;
itype=24;
P0=RealMedianPersIncomeTT.Income(1);
PF=RealMedianPersIncomeTT.Income(40);
NYears=EndYear(24,1)-StartYear(24,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG24=100*GrowthRateAll(itype,1);
FRObj.SG24=SG24;
% Calculate the Simple Stats
Data=RealMedianPersIncomeTT.Income;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='MedianPersonalIncome';
PlotFredData(FRObj,RealMedianPersIncomeTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{24,1}=figstr2;

%% Continue with the 10 Year- 2 Year Fed Bond Rates
eval(['cd ' fredpath(1:length(fredpath)-1)]);
T10Y2YTable = readtable(fredfile25,'Sheet','Daily');
[nrows25,~]=size(T10Y2YTable);
clear DateNumbers dateArray
dateArray=strings(nrows25,1);
for n=1:nrows25
    nowstr=string(T10Y2YTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
T10Y2YTT=table2timetable(T10Y2YTable,'RowTimes','Date');
T10Y2YTT = addvars(T10Y2YTT,DateNumbers);
T10Y2YTT=rmmissing(T10Y2YTT);
[nrows25,ncols25]=size(T10Y2YTT);
meanRateDiffVal=mean(T10Y2YTT.T10Y2Y,'omitnan');
medianRateDiffVal=median(T10Y2YTT.T10Y2Y,'omitnan');
maxRateDiffVal=max(T10Y2YTT.T10Y2Y,[],'omitnan');
meanRateDiff=zeros(nrows25,1);
medianRateDiff=zeros(nrows25,1);
maxRateDiff=zeros(nrows25,1);
for n=1:nrows25
    meanRateDiff(n,1)=meanRateDiffVal;
    medianRateDiff(n,1)=medianRateDiffVal;
    maxRateDiff(n,1)=maxRateDiffVal;
end
T10Y2YTT= addvars(T10Y2YTT,meanRateDiff,medianRateDiff,maxRateDiff);
[ibig]=find(T10Y2YTT.T10Y2Y>0);
[ismall]=find(T10Y2YTT.T10Y2Y<=0);
numbig=length(ibig);
a1=isempty(ismall);
if(a1==0)
    numsmall=length(ismall);
else
    numsmall=0;
end
fracrateinversion=numsmall/nrows25;
SourceFile(25,1)="T10Y2Y-1976-2025.xlsx";
Code(25,1)="T10Y2Y";
Desc(25,1)="10 Yr Bonds Vs 2 Yr Bonds";
Freq(25,1)="Daily";
StartYear(25,1)=1976;
EndYear(25,1)=2023;
SeasonalAdj(25,1)="No";
BaseYear(25,1)=1976;
NumObs(25,1)=12263;
loopstr5='Process the Rate Difference Values Between 10 year - 2 Year Bonds';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows25,5),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Rate Diff=',num2str(meanRateDiffVal,6),...
    '-Median Rate Diff=',num2str(medianRateDiffVal,6),'-Frac Of Day With Rate inversion-',num2str(fracrateinversion,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.T10Y2YTT=T10Y2YTT;
FRObj.fracrateinversion=fracrateinversion;
Chap(25,1)=12;
Section(25,1)=4;
diffsmooth = smoothdata(T10Y2YTT.T10Y2Y);
P0=diffsmooth(1);
PF=diffsmooth(12263);
T10Y2YTT= addvars(T10Y2YTT,diffsmooth);
% Now plot this data
itype=25;
% Calculate the Simple Stats
Data=T10Y2YTT.T10Y2Y;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='RateDiff-10YrVs2YrBonds-1976-2025';
PlotFredData(FRObj,T10Y2YTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{25,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RateDiff-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the VISA Spending Momentum Discretionary
eval(['cd ' fredpath(1:length(fredpath)-1)]);
VisaDiscTable = readtable(fredfile26,'Sheet','Monthly');
[nrows26,~]=size(VisaDiscTable);
clear DateNumbers dateArray
dateArray=strings(nrows26,1);
for n=1:nrows26
    nowstr=string(VisaDiscTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
VisaDiscTT=table2timetable(VisaDiscTable,'RowTimes','Date');
VisaDiscTT = addvars(VisaDiscTT,DateNumbers);
meanDiscVal=mean(VisaDiscTT.VISADiscretionary,'omitnan');
medianDiscVal=median(VisaDiscTT.VISADiscretionary,'omitnan');
maxDiscVal=max(VisaDiscTT.VISADiscretionary,[],'omitnan');
meanDisc=zeros(nrows26,1);
medianDisc=zeros(nrows26,1);
maxDisc=zeros(nrows26,1);
for n=1:nrows26
    meanDisc(n,1)=meanDiscVal;
    medianDisc(n,1)=medianDiscVal;
    maxDisc(n,1)=maxDiscVal;
end
VisaDiscTT= addvars(VisaDiscTT,meanDisc,medianDisc,maxDisc);
loopstr5='Process the The Visa Spending Discretionary Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
SourceFile(26,1)="VISASMIDNSA-2014-2025.xlsx";
Code(26,1)="VISASMIDNSA";
Desc(26,1)="Visa Spending Momentum Index";
Freq(26,1)="Monthly";
StartYear(26,1)=2014;
EndYear(26,1)=2025;
SeasonalAdj(26,1)="No";
BaseYear(26,1)=2014;
NumObs(26,1)=137;
loopstr6=strcat('Data is available for-',num2str(nrows26,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Index=',num2str(meanDiscVal,4),...
    '-Median Index=',num2str(medianDiscVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.VisaDiscTT=VisaDiscTT;
% Now plot this data
Chap(26,1)=9;
Section(26,1)=10;
itype=26;
titlestr='Visa-Disc-Spending-Index';
PlotFredData(FRObj,VisaDiscTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{26,1}=figstr2;

%% Continue with the Case Shiller House Price Index (Not Seasonally Adjusted)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CaseShillerTable = readtable(fredfile27,'Sheet','Monthly');
[nrows27,~]=size(CaseShillerTable);
clear DateNumbers dateArray
dateArray=strings(nrows27,1);
for n=1:nrows27
    nowstr=string(CaseShillerTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CaseShillerTT=table2timetable(CaseShillerTable,'RowTimes','Date');
CaseShillerTT = addvars(CaseShillerTT,DateNumbers);
meanIndexVal=mean(CaseShillerTT.HousePriceIndex,'omitnan');
medianIndexVal=median(CaseShillerTT.HousePriceIndex,'omitnan');
maxIndexVal=max(CaseShillerTT.HousePriceIndex,[],'omitnan');
meanIndex=zeros(nrows27,1);
medianIndex=zeros(nrows27,1);
maxIndex=zeros(nrows27,1);
for n=1:nrows27
    meanIndex(n,1)=meanIndexVal;
    medianIndex(n,1)=medianIndexVal;
    maxIndex(n,1)=maxIndexVal;
end
CaseShillerTT= addvars(CaseShillerTT,meanIndex,medianIndex,maxIndex);
SourceFile(27,1)="CaseShillerHousePriceIndex.xlsx";
Code(27,1)="CSUSHPINSA";
Desc(27,1)="CaseShilleHousePriceIndex";
Freq(27,1)="Monthly";
StartYear(27,1)=1987;
EndYear(27,1)=2025;
SeasonalAdj(27,1)="No";
BaseYear(27,1)=1987;
NumObs(27,1)=460;
loopstr5='Process the Case Shiller House Price Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows27,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Index=',num2str(meanIndexVal,4),...
    '-Median Index=',num2str(medianIndexVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CaseShillerTT=CaseShillerTT;
Chap(27,1)=6;
Section(27,1)=3;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=27;
% Calculate the Simple Stats
Data=CaseShillerTT.HousePriceIndex;
shillersmooth = smoothdata(Data);
P0=shillersmooth(1);
PF=shillersmooth(460);
CaseShillerTT= addvars(CaseShillerTT,shillersmooth);
FRObj=FRObj.SimpleStats(Data,itype);
P0=CaseShillerTT.HousePriceIndex(1);
PF=CaseShillerTT.HousePriceIndex(460);
NYears=EndYear(27,1)-StartYear(27,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG27=100*GrowthRateAll(itype,1);
FRObj.SG27=SG27;
% Now pull of the Recession Probability data that matches the available
% time points in the RiceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0) 
     [CaseShillerTT,icase] = OverlapTimeLinesRev1(CaseShillerTT,RecessProbTT);
     FRObj.CaseShillerTT=CaseShillerTT;
end
FRObj.barval=200;
FRObj.CaseShillerTT=CaseShillerTT;
% Now plot the data
titlestr='CaseShiller-HousePrice-Index-1987-2025';
PlotFredData(FRObj,CaseShillerTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{27,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CaseShillerIndex-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Median Weekly Earnings (LES1252881600Q)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
WeeklyWageTable = readtable(fredfile28,'Sheet','Quarterly');
[nrows28,~]=size(WeeklyWageTable);
clear DateNumbers dateArray
dateArray=strings(nrows28,1);
for n=1:nrows28
    nowstr=string(WeeklyWageTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
WeeklyWageTT=table2timetable(WeeklyWageTable,'RowTimes','Date');
WeeklyWageTT = addvars(WeeklyWageTT,DateNumbers);
meanWageVal=mean(WeeklyWageTT.WeeklyWage,'omitnan');
medianWageVal=median(WeeklyWageTT.WeeklyWage,'omitnan');
maxWageVal=max(WeeklyWageTT.WeeklyWage,[],'omitnan');
meanWage=zeros(nrows28,1);
medianWage=zeros(nrows28,1);
maxWage=zeros(nrows28,1);
for n=1:nrows28
    meanWage(n,1)=meanWageVal;
    medianWage(n,1)=medianWageVal;
    maxWage(n,1)=maxWageVal;
end
WeeklyWageTT= addvars(WeeklyWageTT,meanWage,medianWage,maxWage);
SourceFile(28,1)="MedianWeeklyWage.xlsx";
Code(28,1)="LES1252881600Q";
Desc(28,1)="MedianWeeklyEarnings";
Freq(28,1)="Monthly";
StartYear(28,1)=1979;
EndYear(28,1)=2025;
SeasonalAdj(28,1)="Yes";
BaseYear(28,1)=1982;
NumObs(28,1)=185;
loopstr5='Process the Median Weekly Wage';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows28,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Wage=',num2str(meanWageVal,4),...
    '-Median Wage=',num2str(medianWageVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.WeeklyWageTT=WeeklyWageTT;
Chap(28,1)=9;
Section(28,1)=11;
% Now plot this data
itype=28;
wagessmooth = smoothdata(WeeklyWageTT.WeeklyWage);
P0=wagessmooth(1);
PF=wagessmooth(185);
WeeklyWageTT = addvars(WeeklyWageTT,wagessmooth);
NYears=EndYear(28,1)-StartYear(28,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG28=100*GrowthRateAll(itype,1);
FRObj.SG28=SG28;
% Calculate the Simple Stats
Data=WeeklyWageTT.WeeklyWage;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='MedianWeeklyWage-1979-2025';
PlotFredData(FRObj,WeeklyWageTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{28,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='MedianWeeklyEarning-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Fiscal Year GDP (FYGDP)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FYGDPTable = readtable(fredfile29,'Sheet','Annual');
[nrows29,~]=size(FYGDPTable);
clear DateNumbers dateArray
dateArray=strings(nrows29,1);
for n=1:nrows29
    nowstr=string(FYGDPTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FYGDPTT=table2timetable(FYGDPTable,'RowTimes','Date');
FYGDPTT = addvars(FYGDPTT,DateNumbers);
meanGDPVal=mean(FYGDPTT.FYGDP,'omitnan');
medianGDPVal=median(FYGDPTT.FYGDP,'omitnan');
maxGDPVal=max(FYGDPTT.FYGDP,[],'omitnan');
meanGDP=zeros(nrows29,1);
medianGDP=zeros(nrows29,1);
maxGDP=zeros(nrows29,1);
for n=1:nrows29
    meanGDP(n,1)=meanGDPVal;
    medianGDP(n,1)=medianGDPVal;
    maxGDP(n,1)=maxGDPVal;
end
FYGDPTT= addvars(FYGDPTT,meanGDP,medianGDP,maxGDP);
SourceFile(29,1)="FYGDP-1930-2023.xls";
Code(29,1)="FYGDP";
Desc(29,1)="GrossDomesticProduct";
Freq(29,1)="Annual";
StartYear(29,1)=1930;
EndYear(29,1)=2023;
SeasonalAdj(29,1)="No";
BaseYear(29,1)=1930;
NumObs(29,1)=94;
loopstr5='Process the Fiscal Year GDP Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows29,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean GDP=',num2str(meanGDPVal,8),...
    '-Median GDP=',num2str(medianGDPVal,8));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FYGDPTT=FYGDPTT;
P0=FYGDPTT.FYGDP(1)/1000;
PF=FYGDPTT.FYGDP(94)/1000;
NYears=EndYear(29,1)-StartYear(29,1)+1;
itype=29;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG29=100*GrowthRateAll(itype,1);
FRObj.SG29=SG29;
% Now plot this data
Chap(29,1)=13;
Section(29,1)=4;
titlestr='FYGDP-1930-2023';
PlotFredData(FRObj,FYGDPTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{29,1}=figstr2;

%% Continue with Public Debt as Function of GDP (GFDEGDQ188S)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PublicDebtGDPTable = readtable(fredfile30,'Sheet','Quarterly');
[nrows30,~]=size(PublicDebtGDPTable);
clear DateNumbers dateArray
dateArray=strings(nrows30,1);
for n=1:nrows30
    nowstr=string(PublicDebtGDPTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PublicDebtGDPTT=table2timetable(PublicDebtGDPTable,'RowTimes','Date');
PublicDebtGDPTT = addvars(PublicDebtGDPTT,DateNumbers);
meanDebtVal=mean(PublicDebtGDPTT.DebtPerCent,'omitnan');
medianDebtVal=median(PublicDebtGDPTT.DebtPerCent,'omitnan');
maxDebtVal=max(PublicDebtGDPTT.DebtPerCent,[],'omitnan');
meanDebt=zeros(nrows30,1);
medianDebt=zeros(nrows30,1);
maxDebt=zeros(nrows30,1);
for n=1:nrows30
    meanDebt(n,1)=meanDebtVal;
    medianDebt(n,1)=medianDebtVal;
    maxDebt(n,1)=maxDebtVal;
end
PublicDebtGDPTT= addvars(PublicDebtGDPTT,meanDebt,medianDebt,maxDebt);
SourceFile(30,1)="PublicDebtvsGDP-1966-2025.xlsx";
Code(30,1)="GFDEGDQ188S";
Desc(30,1)="TotalPublicDebtPerCentGDP";
Freq(30,1)="Quarterly";
StartYear(30,1)=1996;
EndYear(30,1)=2025;
SeasonalAdj(30,1)="Yes";
BaseYear(30,1)=1996;
NumObs(30,1)=237;
loopstr5='Process the Fiscal Year Debt Data as a Percent of GDP';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows30,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Debt %=',num2str(meanDebtVal,4),...
    '-Median Debt %=',num2str(medianDebtVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.PublicDebtGDPTT=PublicDebtGDPTT;
Chap(30,1)=13;
Section(30,1)=5;
% Now plot this data
itype=30;
debtsmooth = smoothdata(PublicDebtGDPTT.DebtPerCent);
P0=debtsmooth(1);
PF=debtsmooth(237);
PublicDebtGDPTT = addvars(PublicDebtGDPTT,debtsmooth);
NYears=EndYear(30,1)-StartYear(30,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG30=100*GrowthRateAll(itype,1);
FRObj.SG30=SG30;
% Calculate the Simple Stats
Data=PublicDebtGDPTT.DebtPerCent;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='PublicDebtPerCent-1966-2025';
PlotFredData(FRObj,PublicDebtGDPTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{30,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='PublicDebt-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Budget Surplus as Function of  (MTSDS133FMS)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
BudgetSurplusTable = readtable(fredfile31,'Sheet','Monthly');
[nrows31,~]=size(BudgetSurplusTable);
clear DateNumbers dateArray
dateArray=strings(nrows31,1);
BudgetSurplus=zeros(nrows31,1);
BudgetDeficit=zeros(nrows31,1);
for n=1:nrows31
    nowstr=string(BudgetSurplusTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
    nowval=BudgetSurplusTable.Surplus(n,1);
    if(nowval>0)
        BudgetSurplus(n,1)=1;
    else
        BudgetDeficit(n,1)=1;
    end
end
totalDeficit=sum(BudgetDeficit);
totalSurplus=sum(BudgetSurplus);
BudgetDeficitFraction=totalDeficit/nrows31;
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
BudgetSurplusTT=table2timetable(BudgetSurplusTable,'RowTimes','Date');
BudgetSurplusTT = addvars(BudgetSurplusTT,DateNumbers);
meanSurplusVal=mean(BudgetSurplusTT.Surplus,'omitnan')/1000;
medianSurplusVal=median(BudgetSurplusTT.Surplus,'omitnan')/1000;
maxSurplusVal=max(BudgetSurplusTT.Surplus,[],'omitnan')/1000;
meanSurplus=zeros(nrows31,1);
medianSurplus=zeros(nrows31,1);
maxSurplus=zeros(nrows31,1);
for n=1:nrows31
    meanSurplus(n,1)=meanSurplusVal;
    medianSurplus(n,1)=medianSurplusVal;
    maxSurplus(n,1)=maxSurplusVal;
end
BudgetSurplusTT= addvars(BudgetSurplusTT,meanSurplus,medianSurplus,maxSurplus);
SourceFile(31,1)="BudgetSurplus.xlsx";
Code(31,1)="MTSDS133FMS";
Desc(31,1)="FedSurplusOrDeficit";
Freq(31,1)="Monthly";
StartYear(31,1)=1980;
EndYear(31,1)=2025;
SeasonalAdj(31,1)="No";
BaseYear(31,1)=1980;
NumObs(31,1)=536;
loopstr5='Process the Budget Monthly Surplus/Deficit In Billion USD';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows31,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Surplus =',num2str(meanSurplusVal,5),...
    '-Median Surplus =',num2str(medianSurplusVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.BudgetSurplusTT=BudgetSurplusTT;
FRObj.BudgetSurplus=BudgetSurplus;
FRObj.BudgetDeficit=BudgetDeficit;
FRObj.BudgetDeficitFraction=BudgetDeficitFraction;
Chap(31,1)=13;
Section(31,1)=1;
% Now plot this data
itype=31;
Data=BudgetSurplusTT.Surplus/1000;
bdebtsmooth = smoothdata(Data);
P0=bdebtsmooth(1);
PF=bdebtsmooth(536);
BudgetSurplusTT = addvars(BudgetSurplusTT,bdebtsmooth);
NYears=EndYear(31,1)-StartYear(31,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG31=100*GrowthRateAll(itype,1);
FRObj.SG31=SG31;
% Calculate the Simple Stats
Data=BudgetSurplusTT.Surplus;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='FedGovtBudgetSurplus-1980-2025';
PlotFredData(FRObj,BudgetSurplusTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{31,1}=figstr2;
% Now create the data for a cumilative distribution plot-Fux the scale
titlestr3='BudgetDebt-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Net Federal Outlays as PCT Of GDP (FYONGDA188S)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
NetFedOutlayTable = readtable(fredfile32,'Sheet','Annual');
[nrows32,~]=size(NetFedOutlayTable);
clear DateNumbers dateArray
dateArray=strings(nrows32,1);
for n=1:nrows32
    nowstr=string(NetFedOutlayTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
NetFedOutlayTT=table2timetable(NetFedOutlayTable,'RowTimes','Date');
NetFedOutlayTT = addvars(NetFedOutlayTT,DateNumbers);
meanOutlayVal=mean(NetFedOutlayTT.NetOutlays,'omitnan');
medianOutlayVal=median(NetFedOutlayTT.NetOutlays,'omitnan');
maxOutlayVal=max(NetFedOutlayTT.NetOutlays,[],'omitnan');
meanOutlay=zeros(nrows32,1);
medianOutlay=zeros(nrows32,1);
maxOutlay=zeros(nrows32,1);
for n=1:nrows32
    meanOutlay(n,1)=meanOutlayVal;
    medianOutlay(n,1)=medianOutlayVal;
    maxOutlay(n,1)=maxOutlayVal;
end
NetFedOutlayTT= addvars(NetFedOutlayTT,meanOutlay,medianOutlay,maxOutlay);
loopstr5='Process the Net Federal Budget Outlays as a Per Centage of GDP';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
SourceFile(32,1)="NetFedOutlays.xlsx";
Code(32,1)="FYONGDA188S";
Desc(32,1)="NetFedOutlaysPctGDP";
Freq(32,1)="Annual";
StartYear(32,1)=1929;
EndYear(32,1)=2024;
SeasonalAdj(32,1)="No";
BaseYear(32,1)=1929;
NumObs(32,1)=96;
loopstr6=strcat('Data is available for-',num2str(nrows32,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Outlay % =',num2str(meanOutlayVal,5),...
    '-Median Outlay % =',num2str(medianOutlayVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.NetFedOutlayTT=NetFedOutlayTT;
P0=NetFedOutlayTT.NetOutlays(1);
PF=NetFedOutlayTT.NetOutlays(96);
NYears=EndYear(32,1)-StartYear(32,1)+1;
itype=32;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG32=100*GrowthRateAll(itype,1);
FRObj.SG32=SG32;
% Now plot this data
Chap(32,1)=13;
Section(32,1)=4;
itype=32;
titlestr='FedGovtNetOutlay-1929-2024';
PlotFredData(FRObj,NetFedOutlayTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{32,1}=figstr2;

%% Continue with Federal Receipts as PCT Of GDP (FYFRGDA188S)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FedReceiptsTable = readtable(fredfile33,'Sheet','Annual');
[nrows33,~]=size(FedReceiptsTable);
clear DateNumbers dateArray
dateArray=strings(nrows33,1);
for n=1:nrows33
    nowstr=string(FedReceiptsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FedReceiptsTT=table2timetable(FedReceiptsTable,'RowTimes','Date');
FedReceiptsTT = addvars(FedReceiptsTT,DateNumbers);
meanReceiptsVal=mean(FedReceiptsTT.Receipts,'omitnan');
medianReceiptsVal=median(FedReceiptsTT.Receipts,'omitnan');
maxReceiptsVal=max(FedReceiptsTT.Receipts,[],'omitnan');
meanReceipts=zeros(nrows33,1);
medianReceipts=zeros(nrows33,1);
maxReceipts=zeros(nrows33,1);
for n=1:nrows33
    meanReceipts(n,1)=meanReceiptsVal;
    medianReceipts(n,1)=medianReceiptsVal;
    maxReceipts(n,1)=maxReceiptsVal;
end
FedReceiptsTT= addvars(FedReceiptsTT,meanReceipts,medianReceipts,maxReceipts);
SourceFile(33,1)="FederalReceipts.xlsx";
Code(33,1)="FYFRGDA188S";
Desc(33,1)="FedReceiptsPctGDP";
Freq(33,1)="Annual";
StartYear(33,1)=1929;
EndYear(33,1)=2024;
SeasonalAdj(33,1)="No";
BaseYear(33,1)=1929;
NumObs(33,1)=96;
loopstr5='Process the Federal Budget Receipts as a % GDP';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows33,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Receipts % =',num2str(meanReceiptsVal,5),...
    '-Median Receipts % =',num2str(medianReceiptsVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FedReceiptsTT=FedReceiptsTT;
% Now plot this data
Chap(33,1)=13;
Section(33,1)=7;
itype=33;
receipsmooth = smoothdata(FedReceiptsTT.Receipts);
P0=receipsmooth(1);
PF=receipsmooth(96);
FedReceiptsTT = addvars(FedReceiptsTT,receipsmooth);
FRObj.FedReceiptsTT.Receipts=FedReceiptsTT.Receipts;
NYears=EndYear(33,1)-StartYear(33,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG33=100*GrowthRateAll(itype,1);
FRObj.SG33=SG33;
titlestr='FedGovtReceipts-1929-2024';
PlotFredData(FRObj,FedReceiptsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{33,1}=figstr2;

%% Continue with Federal Public Debt as (FYGFDPUN)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FedPublicDebtTable = readtable(fredfile34,'Sheet','Quarterly');
[nrows34,~]=size(FedPublicDebtTable);
clear DateNumbers dateArray
dateArray=strings(nrows34,1);
for n=1:nrows34
    nowstr=string(FedPublicDebtTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FedPublicDebtTT=table2timetable(FedPublicDebtTable,'RowTimes','Date');
FedPublicDebtTT = addvars(FedPublicDebtTT,DateNumbers);
meanDebtVal=mean(FedPublicDebtTT.PublicDebt,'omitnan');
medianDebtVal=median(FedPublicDebtTT.PublicDebt,'omitnan');
maxDebtVal=max(FedPublicDebtTT.PublicDebt,[],'omitnan');
meanDebt=zeros(nrows34,1);
medianDebt=zeros(nrows34,1);
maxDebt=zeros(nrows34,1);
for n=1:nrows34
    meanDebt(n,1)=meanDebtVal;
    medianDebt(n,1)=medianDebtVal;
    maxDebt(n,1)=maxDebtVal;
end
FedPublicDebtTT= addvars(FedPublicDebtTT,meanDebt,medianDebt,maxDebt);
SourceFile(34,1)="FederalPublicDebt.xlsx";
Code(34,1)="FYGFDPUN";
Desc(34,1)="FedPublicDebt";
Freq(34,1)="Quarterly";
StartYear(34,1)=1970;
EndYear(34,1)=2025;
SeasonalAdj(34,1)="No";
BaseYear(34,1)=1970;
NumObs(34,1)=221;
loopstr5='Process the Federal Public Debt Millions';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows34,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Debt =',num2str(meanDebtVal,8),...
    '-Median Debt =',num2str(medianDebtVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FedPublicDebtTT=FedPublicDebtTT;
% Now plot this data
Chap(34,1)=13;
Section(34,1)=8;
itype=34;
fpdsmooth = smoothdata(FedPublicDebtTT.PublicDebt);
P0=fpdsmooth(1);
PF=fpdsmooth(221);
FedPublicDebtTT = addvars(FedPublicDebtTT,fpdsmooth);
% Calculate the Simple Stats and Plot Data
Data=FedPublicDebtTT.PublicDebt;
FRObj=FRObj.SimpleStats(Data,itype);
P0=FedPublicDebtTT.PublicDebt(1);
PF=FedPublicDebtTT.PublicDebt(221);
NYears=EndYear(34,1)-StartYear(34,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG34=100*GrowthRateAll(itype,1);
FRObj.SG34=SG34;
titlestr='FedPublicDebt-1970-2025';
PlotFredData(FRObj,FedPublicDebtTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{34,1}=figstr2;
% Now create the data for a Federal Public Debt cumilative distribution plot
titlestr3='FedPublicDebt-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Federal Interest Payments Vs GDP (FYOIGDA188S)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FedGDPInterestTable = readtable(fredfile35,'Sheet','Annual');
[nrows35,~]=size(FedGDPInterestTable);
clear DateNumbers dateArray
dateArray=strings(nrows35,1);
for n=1:nrows35
    nowstr=string(FedGDPInterestTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FedGDPInterestTT=table2timetable(FedGDPInterestTable,'RowTimes','Date');
FedGDPInterestTT = addvars(FedGDPInterestTT,DateNumbers);
meanInterestVal=mean(FedGDPInterestTT.Interest,'omitnan');
medianInterestVal=median(FedGDPInterestTT.Interest,'omitnan');
maxInterestVal=max(FedGDPInterestTT.Interest,[],'omitnan');
meanInterest=zeros(nrows35,1);
medianInterest=zeros(nrows35,1);
maxInterest=zeros(nrows35,1);
for n=1:nrows35
    meanInterest(n,1)=meanInterestVal;
    medianInterest(n,1)=medianInterestVal;
    maxInterest(n,1)=maxInterestVal;
end
FedGDPInterestTT= addvars(FedGDPInterestTT,meanInterest,medianInterest,maxInterest);
SourceFile(35,1)="FedInterestPctGDP.xlsx";
Code(35,1)="FYOIGDA188S";
Desc(35,1)="FedInterestPctGDP";
Freq(35,1)="Annual";
StartYear(35,1)=1940;
EndYear(35,1)=2024;
SeasonalAdj(35,1)="No";
BaseYear(35,1)=1940;
NumObs(35,1)=85;
loopstr5='Process the Federal Interest Payments Vs GDP';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows35,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Interest =',num2str(meanInterestVal,5),...
    '-Median Interest =',num2str(medianInterestVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FedGDPInterestTT=FedGDPInterestTT;
% Now plot this data
Chap(35,1)=13;
Section(35,1)=9;
itype=35;
intpaysmooth = smoothdata(FedGDPInterestTT.Interest);
P0=intpaysmooth(1);
PF=intpaysmooth(85);
FedGDPInterestTT= addvars(FedGDPInterestTT,intpaysmooth);
NYears=EndYear(35,1)-StartYear(35,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG35=100*GrowthRateAll(itype,1);
FRObj.SG35=SG35;
titlestr='FedInterestVsGDP-1940-2024';
PlotFredData(FRObj,FedGDPInterestTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{35,1}=figstr2;

%% Continue with Federal Treasury Debt Vs GDP (MVMTD027MNFRBDAL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
TreasuryDebtTable = readtable(fredfile36,'Sheet','Monthly');
[nrows36,~]=size(TreasuryDebtTable);
clear DateNumbers dateArray
dateArray=strings(nrows36,1);
for n=1:nrows36
    nowstr=string(TreasuryDebtTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TreasuryDebtTT=table2timetable(TreasuryDebtTable,'RowTimes','Date');
TreasuryDebtTT = addvars(TreasuryDebtTT,DateNumbers);
meanTDebtVal=mean(TreasuryDebtTT.TreasuryDebt,'omitnan');
medianTDebtVal=median(TreasuryDebtTT.TreasuryDebt,'omitnan');
maxTDebtVal=max(TreasuryDebtTT.TreasuryDebt,[],'omitnan');
meanTDebt=zeros(nrows36,1);
medianTDebt=zeros(nrows36,1);
maxTDebt=zeros(nrows36,1);
for n=1:nrows36
    meanTDebt(n,1)=meanTDebtVal;
    medianTDebt(n,1)=medianTDebtVal;
    maxTDebt(n,1)=maxTDebtVal;
end
TreasuryDebtTT= addvars(TreasuryDebtTT,meanTDebt,medianTDebt,maxTDebt);
SourceFile(36,1)="TreasuryDebt.xlsx";
Code(36,1)="MVMTD027MNFRBDAL";
Desc(36,1)="TreasuryDebt";
Freq(36,1)="Monthly";
StartYear(36,1)=1942;
EndYear(36,1)=2025;
SeasonalAdj(36,1)="No";
BaseYear(36,1)=1942;
NumObs(36,1)=1001;
loopstr5='Process the Market Value of the Treasury Debt';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows36,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean TDebt =',num2str(meanTDebtVal/1000,5),...
    '-Median TDebt =',num2str(medianTDebtVal/1000,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.TreasuryDebtTT=TreasuryDebtTT;
% Now plot this data
Chap(36,1)=13;
Section(36,1)=10;
itype=36;
Data=TreasuryDebtTT.TreasuryDebt;
tdebtsmooth = smoothdata(Data);
P0=tdebtsmooth(1);
PF=tdebtsmooth(1001);
TreasuryDebtTT= addvars(TreasuryDebtTT,tdebtsmooth);
% Calculate the Simple Stats and Plot Data
Data=TreasuryDebtTT.TreasuryDebt;
FRObj=FRObj.SimpleStats(Data,itype);
P0=TreasuryDebtTT.TreasuryDebt(1);
PF=TreasuryDebtTT.TreasuryDebt(1001);
NYears=EndYear(36,1)-StartYear(36,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG36=100*GrowthRateAll(itype,1);
FRObj.SG36=SG36;
titlestr='TreasuryDebtMarketValue';
PlotFredData(FRObj,TreasuryDebtTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{36,1}=figstr2;
% Now create the data for a Federal Public Debt cumilative distribution plot
titlestr3='TreasuryDebt-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
FRObj.CurrentMedianValue=medianTDebtVal/1E3;
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Domestic Auto Inventories (AUINSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
DomAutoInvTable = readtable(fredfile37,'Sheet','Monthly');
[nrows37,~]=size(DomAutoInvTable);
clear DateNumbers dateArray
dateArray=strings(nrows37,1);
for n=1:nrows37
    nowstr=string(DomAutoInvTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
DomAutoInvTT=table2timetable(DomAutoInvTable,'RowTimes','Date');
DomAutoInvTT = addvars(DomAutoInvTT,DateNumbers);
meanInventoryVal=mean(DomAutoInvTT.AUINSA,'omitnan');
medianInventoryVal=median(DomAutoInvTT.AUINSA,'omitnan');
maxInventoryVal=max(DomAutoInvTT.AUINSA,[],'omitnan');
meanInventory=zeros(nrows37,1);
medianInventory=zeros(nrows37,1);
maxInventory=zeros(nrows37,1);
for n=1:nrows37
    meanInventory(n,1)=meanInventoryVal;
    medianInventory(n,1)=medianInventoryVal;
    maxInventory(n,1)=maxInventoryVal;
end
DomAutoInvTT= addvars(DomAutoInvTT,meanInventory,medianInventory,maxInventory);
SourceFile(37,1)="DomesticAutoInventories.xlsx";
Code(37,1)="AUINSA";
Desc(37,1)="DomesticAutoInventory";
Freq(37,1)="Monthly";
StartYear(37,1)=1993;
EndYear(37,1)=2025;
SeasonalAdj(37,1)="Yes";
BaseYear(37,1)=1993;
NumObs(37,1)=389;
loopstr5='Process the Domestic Auto Inventories';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows37,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Inventory =',num2str(meanInventoryVal,5),...
    '-Median Inventory =',num2str(medianInventoryVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.DomAutoInvTT=DomAutoInvTT;
% Now plot this data
Chap(37,1)=14;
Section(37,1)=1;
itype=37;
% Calculate the Simple Stats and Plot Data
Data=DomAutoInvTT.AUINSA;
FRObj=FRObj.SimpleStats(Data,itype);
autosmooth = smoothdata(DomAutoInvTT.AUINSA);
P0=autosmooth(1);
PF=autosmooth(389);
DomAutoInvTT = addvars(DomAutoInvTT,autosmooth);
NYears=EndYear(37,1)-StartYear(37,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG37=100*GrowthRateAll(itype,1);
titlestr='DomesticAutoInventories';
PlotFredData(FRObj,DomAutoInvTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{37,1}=figstr2;
FRObj.CurrentMedianValue=medianInventoryVal;
% Now create the data for a Domestic Auto Sales  cumilative distribution plot
titlestr3='DomesticAutoInventories-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Foreign Auto Sales (FAUTOSAAR)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ForeignAutoSalesTable = readtable(fredfile38,'Sheet','Monthly');
[nrows38,~]=size(ForeignAutoSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows38,1);
for n=1:nrows38
    nowstr=string(ForeignAutoSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ForeignAutoSalesTT=table2timetable(ForeignAutoSalesTable,'RowTimes','Date');
ForeignAutoSalesTT = addvars(ForeignAutoSalesTT,DateNumbers);
meanFSalesVal=mean(ForeignAutoSalesTT.FAUTOSAAR,'omitnan');
medianFSalesVal=median(ForeignAutoSalesTT.FAUTOSAAR,'omitnan');
maxFSalesVal=max(ForeignAutoSalesTT.FAUTOSAAR,[],'omitnan');
meanFSales=zeros(nrows38,1);
medianFSales=zeros(nrows38,1);
maxFSales=zeros(nrows38,1);
for n=1:nrows38
    meanFSales(n,1)=meanFSalesVal;
    medianFSales(n,1)=medianFSalesVal;
    maxFSales(n,1)=maxFSalesVal;
end
ForeignAutoSalesTT= addvars(ForeignAutoSalesTT,meanFSales,medianFSales,maxFSales);
SourceFile(38,1)="ForeignAutoSales.xlsx";
Code(38,1)="FAUTOSAAR";
Desc(38,1)="ForeignAutoSales";
Freq(38,1)="Monthly";
StartYear(38,1)=1967;
EndYear(38,1)=2025;
SeasonalAdj(38,1)="Yes'";
BaseYear(38,1)=1967;
NumObs(38,1)=701;
loopstr5='Process Foreign Auto Sales';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows38,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales =',num2str(meanFSalesVal,5),...
    '-Median Sales =',num2str(medianFSalesVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.ForeignAutoSalesTT=ForeignAutoSalesTT;
% Now plot this data
Chap(38,1)=14;
Section(38,1)=2;
itype=38;
autosmooth = smoothdata(ForeignAutoSalesTT.FAUTOSAAR);
P0=autosmooth(1);
PF=autosmooth(701);
ForeignAutoSalesTT = addvars(ForeignAutoSalesTT,autosmooth);
NYears=EndYear(38,1)-StartYear(38,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG38=100*GrowthRateAll(itype,1);
titlestr='ForeignAutoSales';
Data=ForeignAutoSalesTT.FAUTOSAAR;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,ForeignAutoSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{38,1}=figstr2;
FRObj.CurrentMedianValue=medianFSalesVal;
% Now create the data for a Foreign Auto Sales distribution plot
titlestr3='ForeignAutoSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Total Vehicle Sales (TOTALSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
TotVehSalesTable = readtable(fredfile39,'Sheet','Monthly');
[nrows39,~]=size(TotVehSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows39,1);
for n=1:nrows39
    nowstr=string(TotVehSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TotVehSalesTT=table2timetable(TotVehSalesTable,'RowTimes','Date');
TotVehSalesTT = addvars(TotVehSalesTT,DateNumbers);
meanTSalesVal=mean(TotVehSalesTT.TOTALSA,'omitnan');
medianTSalesVal=median(TotVehSalesTT.TOTALSA,'omitnan');
maxTSalesVal=max(TotVehSalesTT.TOTALSA,[],'omitnan');
meanTSales=zeros(nrows39,1);
medianTSales=zeros(nrows39,1);
maxTSales=zeros(nrows39,1);
for n=1:nrows39
    meanTSales(n,1)=meanTSalesVal;
    medianTSales(n,1)=medianTSalesVal;
    maxTSales(n,1)=maxTSalesVal;
end
TotVehSalesTT= addvars(TotVehSalesTT,meanTSales,medianTSales,maxTSales);
SourceFile(39,1)="TotalVehicleSales.xlsx";
Code(39,1)="TOTALSA";
Desc(39,1)="TotalVehicleSales";
Freq(39,1)="Monthly";
StartYear(39,1)=1976;
EndYear(39,1)=2025;
SeasonalAdj(39,1)="Yes";
BaseYear(39,1)=1976;
NumObs(39,1)=593;
loopstr5='Process Total Vehicle Sales';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows39,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales =',num2str(meanTSalesVal,5),...
    '-Median Sales =',num2str(medianTSalesVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.TotVehSalesTT=TotVehSalesTT;
% Now plot this data
Chap(39,1)=14;
Section(39,1)=4;
itype=39;
Data=TotVehSalesTT.TOTALSA;
FRObj=FRObj.SimpleStats(Data,itype);
autosmooth = smoothdata(TotVehSalesTT.TOTALSA);
P0=autosmooth(1);
PF=autosmooth(593);
TotVehSalesTT = addvars(TotVehSalesTT,autosmooth);
NYears=EndYear(39,1)-StartYear(39,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG39=100*GrowthRateAll(itype,1);
titlestr='TotalVehicleSales';
PlotFredData(FRObj,TotVehSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{39,1}=figstr2;
% Now create the data for a Total Auto Sales distribution plot
FRObj.CurrentMedianValue=medianTSalesVal;
titlestr3='TotalAutoSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Domestic Auto Production (DAUPSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
DomesticAutoProdTable = readtable(fredfile40,'Sheet','Monthly');
[nrows40,~]=size(DomesticAutoProdTable);
clear DateNumbers dateArray
dateArray=strings(nrows40,1);
for n=1:nrows40
    nowstr=string(DomesticAutoProdTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
DomesticAutoProdTT=table2timetable(DomesticAutoProdTable,'RowTimes','Date');
DomesticAutoProdTT = addvars(DomesticAutoProdTT,DateNumbers);
meanDomProdVal=mean(DomesticAutoProdTT.DAUPSA,'omitnan');
medianDomProdVal=median(DomesticAutoProdTT.DAUPSA,'omitnan');
maxDomProdVal=max(DomesticAutoProdTT.DAUPSA,[],'omitnan');
meanDomProd=zeros(nrows40,1);
medianDomProd=zeros(nrows40,1);
maxDomProd=zeros(nrows40,1);
for n=1:nrows40
    meanDomProd(n,1)=meanDomProdVal;
    medianDomProd(n,1)=medianDomProdVal;
    maxDomProd(n,1)=maxDomProdVal;
end
DomesticAutoProdTT= addvars(DomesticAutoProdTT,meanDomProd,medianDomProd,maxDomProd);
SourceFile(40,1)="DomesticAutoProduction.xlsx";
Code(40,1)="DAUPSA";
Desc(40,1)="DomesticAutoProduction";
Freq(40,1)="Monthly";
StartYear(40,1)=1993;
EndYear(40,1)=2025;
SeasonalAdj(40,1)="Yes";
BaseYear(40,1)=1993;
NumObs(40,1)=389;
loopstr5='Process Domestic Auto Production';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows40,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Production =',num2str(meanDomProdVal,5),...
    '-Median Production =',num2str(medianDomProdVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.DomesticAutoProdTT=DomesticAutoProdTT;
% Now plot this data
Chap(40,1)=14;
Section(40,1)=5;
itype=40;
dautosmooth = smoothdata(DomesticAutoProdTT.DAUPSA);
Data=DomesticAutoProdTT.DAUPSA;
FRObj=FRObj.SimpleStats(Data,itype);
P0=dautosmooth(1);
PF=dautosmooth(389);
DomesticAutoProdTT= addvars(DomesticAutoProdTT,dautosmooth);
NYears=EndYear(40,1)-StartYear(40,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG40=100*GrowthRateAll(itype,1);
titlestr='DomesticAutoProduction';
PlotFredData(FRObj,DomesticAutoProdTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{40,1}=figstr2;
% Now create the data for a Domestic Auto Production distribution plot
titlestr3='DomesticAutoProduction-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Auto Exports (AUENSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
AutoExportsTable = readtable(fredfile41,'Sheet','Monthly');
[nrows41,~]=size(AutoExportsTable);
clear DateNumbers dateArray
dateArray=strings(nrows41,1);
for n=1:nrows41
    nowstr=string(AutoExportsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
AutoExportsTT=table2timetable(AutoExportsTable,'RowTimes','Date');
AutoExportsTT = addvars(AutoExportsTT,DateNumbers);
meanAutoExportsVal=mean(AutoExportsTT.AUENSA,'omitnan');
medianAutoExportsVal=median(AutoExportsTT.AUENSA,'omitnan');
maxAutoExportsVal=max(AutoExportsTT.AUENSA,[],'omitnan');
meanAutoExports=zeros(nrows41,1);
medianAutoExports=zeros(nrows41,1);
maxAutoExports=zeros(nrows41,1);
for n=1:nrows41
    meanAutoExports(n,1)=meanAutoExportsVal;
    medianAutoExports(n,1)=medianAutoExportsVal;
    maxAutoExports(n,1)=maxAutoExportsVal;
end
AutoExportsTT= addvars(AutoExportsTT,meanAutoExports,medianAutoExports,maxAutoExports);
SourceFile(41,1)="AutoExports.xlsx";
Code(41,1)="AUENSA";
Desc(41,1)="USAutoExports";
Freq(41,1)="Monthly";
StartYear(41,1)=1993;
EndYear(41,1)=2025;
SeasonalAdj(41,1)="No";
BaseYear(41,1)=1993;
NumObs(41,1)=388;
loopstr5='Process US Auto Exports';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows41,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Production =',num2str(meanAutoExportsVal,5),...
    '-Median Production =',num2str(medianAutoExportsVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.AutoExportsTT=AutoExportsTT;
% Now plot this data
Chap(41,1)=14;
Section(41,1)=6;
itype=41;
exsmooth = smoothdata(AutoExportsTT.AUENSA);
AutoExportsTT= addvars(AutoExportsTT,exsmooth);
P0=exsmooth(1);
PF=exsmooth(388);
NYears=EndYear(41,1)-StartYear(41,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG41=100*GrowthRateAll(itype,1);
FRObj.SG41=SG41;
titlestr='USAutoExports';
% Calculate simple stats
Data=AutoExportsTT.AUENSA;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,AutoExportsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{41,1}=figstr2;
% Now create the data for a US Auto Exports distribution plot
titlestr3='USAutoExports-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Vehicle Miles Travelled (TRFVOLUSM227NFWA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
VehicleMilesTable = readtable(fredfile42,'Sheet','Monthly');
[nrows42,~]=size(VehicleMilesTable);
clear DateNumbers dateArray
dateArray=strings(nrows42,1);
for n=1:nrows42
    nowstr=string(VehicleMilesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
VehicleMilesTT=table2timetable(VehicleMilesTable,'RowTimes','Date');
VehicleMilesTT = addvars(VehicleMilesTT,DateNumbers);
meanVehMilesVal=mean(VehicleMilesTT.Miles,'omitnan')/1E3;% convert to Billions
medianVehMilesVal=median(VehicleMilesTT.Miles,'omitnan')/1E3;
maxVehMilesVal=max(VehicleMilesTT.Miles,[],'omitnan')/1E3;
meanVehMiles=zeros(nrows42,1);
medianVehMiles=zeros(nrows42,1);
maxVehMiles=zeros(nrows42,1);
for n=1:nrows42
    meanVehMiles(n,1)=meanVehMilesVal;
    medianVehMiles(n,1)=medianVehMilesVal;
    maxVehMiles(n,1)=maxVehMilesVal;
end
VehicleMilesTT= addvars(VehicleMilesTT,meanVehMiles,medianVehMiles,maxVehMiles);
% Calculate the smoothed miles
span=12;
vmsmooth = smoothdata(VehicleMilesTT.Miles/1000);
VehicleMilesTT= addvars(VehicleMilesTT,vmsmooth);
SourceFile(42,1)="VehicleMilesTravelled.xlsx";
Code(42,1)="TRFVOLUSM227NFWA";
Desc(42,1)="VehicleMilesTravelled";
Freq(42,1)="Monthly";
StartYear(42,1)=1970;
EndYear(42,1)=2025;
SeasonalAdj(42,1)="No";
BaseYear(42,1)=1970;
NumObs(42,1)=664;
loopstr5='Process US Vehicle Miles Travelled';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows42,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Miles =',num2str(meanVehMilesVal,5),...
    '-Median Miles =',num2str(medianVehMilesVal,5),'-In Billions of Miles');
fprintf(fid,'%10s\n',loopstr7);
FRObj.VehicleMilesTT=VehicleMilesTT;
% Now plot this data
Chap(42,1)=7;
Section(42,1)=13;
itype=42;
P0=vmsmooth(1);
PF=vmsmooth(664);
NYears=EndYear(42,1)-StartYear(42,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG42=100*GrowthRateAll(itype,1);
FRObj.SG42=SG42;
titlestr='VehicleMilesTravelled';
% Calculate simple stats
Data=VehicleMilesTT.Miles/1E3;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the TCUTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [VehicleMilesTT,icase] = OverlapTimeLinesRev1(VehicleMilesTT,RecessProbTT);
     FRObj.VehicleMilesTT=VehicleMilesTT;
     RecessionInfo(42,1)=icase;
end
FRObj.barval=200;
FRObj.VehicleMilesTT=VehicleMilesTT;
titlestr='VehicleMilesTravelled';
PlotFredData(FRObj,VehicleMilesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{42,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='VehMiles-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with FreightTransportIndex (TSIFRGHT)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FreightIndexTable = readtable(fredfile43,'Sheet','Monthly');
[nrows43,~]=size(FreightIndexTable);
clear DateNumbers dateArray
dateArray=strings(nrows43,1);
for n=1:nrows43
    nowstr=string(FreightIndexTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FreightIndexTT=table2timetable(FreightIndexTable,'RowTimes','Date');
FreightIndexTT = addvars(FreightIndexTT,DateNumbers);
meanFreightIndexVal=mean(FreightIndexTT.FTI,'omitnan');
medianFreightIndexVal=median(FreightIndexTT.FTI,'omitnan');
maxFreightIndexVal=max(FreightIndexTT.FTI,[],'omitnan');
meanFreightIndex=zeros(nrows43,1);
medianFreightIndex=zeros(nrows43,1);
maxFreightIndex=zeros(nrows43,1);
for n=1:nrows43
    meanFreightIndex(n,1)=meanFreightIndexVal;
    medianFreightIndex(n,1)=medianFreightIndexVal;
    maxFreightIndex(n,1)=maxFreightIndexVal;
end
FreightIndexTT= addvars(FreightIndexTT,meanFreightIndex,medianFreightIndex,maxFreightIndex);
SourceFile(43,1)="FreightTransportIndex.xlsx";
Code(43,1)="TSIFRGHT";
Desc(43,1)="FreightIndex";
Freq(43,1)="Monthly";
StartYear(43,1)=2000;
EndYear(43,1)=2025;
SeasonalAdj(43,1)="Yes'";
BaseYear(43,1)=2000;
NumObs(43,1)=304;
loopstr5='Process Freight Transport Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows43,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Index =',num2str(meanFreightIndexVal,4),...
    '-Median Miles =',num2str(medianFreightIndexVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FreightIndexTT=FreightIndexTT;
% Now plot this data
Chap(43,1)=7;
Section(43,1)=14;
itype=43;
titlestr='FreightTransportIndex';
% Calculate simple stats
Data=FreightIndexTT.FTI;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the FreightIndexTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [FreightIndexTT,icase] = OverlapTimeLinesRev1(FreightIndexTT,RecessProbTT);
     FRObj.FreightIndexTT=FreightIndexTT;
     RecessionInfo(43,1)=icase;
end
FRObj.barval=100;
FRObj.FreightIndexTT=FreightIndexTT;
% Plot the Data
titlestr='FreightTransportIndex';
PlotFredData(FRObj,FreightIndexTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{43,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FreightIndex-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with RailCarLoads (RAILFRTCARLOADSD11)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
RailCarTable = readtable(fredfile44,'Sheet','Monthly');
[nrows44,~]=size(RailCarTable);
clear DateNumbers
clear dateArray
clear DateNumbers dateArray
dateArray=strings(nrows44,1);
for n=1:nrows44
    nowstr=string(RailCarTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RailCarLoadsTT=table2timetable(RailCarTable,'RowTimes','Date');
RailCarLoadsTT = addvars(RailCarLoadsTT,DateNumbers);
meanRailLoadsVal=mean(RailCarLoadsTT.RailCarLoads,'omitnan');
medianRailLoadsVal=median(RailCarLoadsTT.RailCarLoads,'omitnan');
maxRailLoadsVal=max(RailCarLoadsTT.RailCarLoads,[],'omitnan');
meanRailLoads=zeros(nrows44,1);
medianRailLoads=zeros(nrows44,1);
maxRailLoads=zeros(nrows44,1);
for n=1:nrows44
    meanRailLoads(n,1)=meanRailLoadsVal;
    medianRailLoads(n,1)=medianRailLoadsVal;
    maxRailLoads(n,1)=maxRailLoadsVal;
end
RailCarLoadsTT= addvars(RailCarLoadsTT,meanRailLoads,medianRailLoads,maxRailLoads);
SourceFile(44,1)="RailCarloads.xlsx";
Code(44,1)="RAILFRTCARLOADSD11";
Desc(44,1)="RailCarLoad";
Freq(44,1)="Monthly";
StartYear(44,1)=2000;
EndYear(44,1)=2025;
SeasonalAdj(44,1)="Yes";
BaseYear(44,1)=2000;
NumObs(44,1)=304;
loopstr5='Process Rail Car Loads';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows44,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Loads=',num2str(meanRailLoadsVal,4),...
    '-Median Loads =',num2str(medianRailLoadsVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.RailCarLoadsTT=RailCarLoadsTT;

% Now plot this data
Chap(44,1)=7;
Section(44,1)=15;
itype=44;
P0=RailCarLoadsTT.RailCarLoads(1);
PF=RailCarLoadsTT.RailCarLoads(304);
NYears=EndYear(44,1)-StartYear(44,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG44=100*GrowthRateAll(itype,1);
FRObj.SG44=SG44;
% Now pull of the Recession Probability data that matches the available
% time points in the RailCarLoadsTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [RailCarLoadsTT,icase] = OverlapTimeLinesRev1(RailCarLoadsTT,RecessProbTT);
     FRObj.RailCarLoadsTT=RailCarLoadsTT;
     RecessionInfo(44,1)=icase;
end
FRObj.barval=500;
FRObj.RailCarLoadsTT=RailCarLoadsTT;
% Calculate simple stats
Data=RailCarLoadsTT.RailCarLoads;
FRObj=FRObj.SimpleStats(Data,itype);
% Plot the data
titlestr='RailCarLoads';
PlotFredData(FRObj,RailCarLoadsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{44,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RailLoads-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Airline Load factors (LOADFACTOR)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
AirLoadTable = readtable(fredfile45,'Sheet','Monthly');
[nrows45,~]=size(AirLoadTable);
clear DateNumbers dateArray
dateArray=strings(nrows45,1);
for n=1:nrows45
    nowstr=string(AirLoadTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
AirLoadTT=table2timetable(AirLoadTable,'RowTimes','Date');
AirLoadTT = addvars(AirLoadTT,DateNumbers);
meanAirLoadVal=mean(AirLoadTT.Loadfactor,'omitnan');
medianAirLoadVal=median(AirLoadTT.Loadfactor,'omitnan');
maxAirLoadVal=max(AirLoadTT.Loadfactor,[],'omitnan');
meanAirLoads=zeros(nrows45,1);
medianAirLoads=zeros(nrows45,1);
maxAirLoads=zeros(nrows45,1);
for n=1:nrows45
    meanAirLoads(n,1)=meanAirLoadVal;
    medianAirLoads(n,1)=medianAirLoadVal;
    maxAirLoads(n,1)=maxAirLoadVal;
end
AirLoadTT= addvars(AirLoadTT,meanAirLoads,medianAirLoads,maxAirLoads);
% Calculate the smoothed load factor
loadsmooth = smoothdata(AirLoadTT.Loadfactor);
AirLoadTT= addvars(AirLoadTT,loadsmooth);
SourceFile(45,1)="AirlineLoadfactor.xlsx";
Code(45,1)="LOADFACTOR";
Desc(45,1)="AirlineLoadFactor";
Freq(45,1)="Monthly";
StartYear(45,1)=2000;
EndYear(45,1)=2025;
SeasonalAdj(45,1)="Yes";
BaseYear(45,1)=2000;
NumObs(45,1)=302;
loopstr5='Process Airline Loadfactors';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows45,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Loads=',num2str(meanAirLoadVal,4),...
    '-Median Loads =',num2str(medianAirLoadVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.AirLoadTT=AirLoadTT;
% Now plot this data
Chap(45,1)=7;
Section(45,1)=16;
itype=45;
P0=loadsmooth(1);
PF=loadsmooth(302);
NYears=EndYear(45,1)-StartYear(45,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG45=100*GrowthRateAll(itype,1);
FRObj.SG45=SG45;
% Now pull of the Recession Probability data that matches the available
% time points in the AirLoadTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [AirLoadTT,icase] = OverlapTimeLinesRev1(AirLoadTT,RecessProbTT);
     FRObj.AirLoadTT=AirLoadTT;
     RecessionInfo(45,1)=icase;
end
FRObj.barval=50;
FRObj.AirLoadTT=AirLoadTT;
titlestr='AirlineLoadFactor';
% Calculate simple stats
Data=AirLoadTT.Loadfactor;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='AirlineLoadFactor';
PlotFredData(FRObj,AirLoadTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{45,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='AirlineLoadFactors-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Available Seat Miles (ASM)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ASMTable = readtable(fredfile46,'Sheet','Monthly');
[nrows46,~]=size(ASMTable);
clear DateNumbers dateArray
dateArray=strings(nrows46,1);
for n=1:nrows46
    nowstr=string(ASMTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ASMTT=table2timetable(ASMTable,'RowTimes','Date');
ASMTT = addvars(ASMTT,DateNumbers);
meanASMVal=mean(ASMTT.AvailMiles/1E6,'omitnan');% Convert to Millions Of Miles
medianASMVal=median(ASMTT.AvailMiles/1E6,'omitnan');
maxASMVal=max(ASMTT.AvailMiles/1E6,[],'omitnan');
meanASM=zeros(nrows46,1);
medianASM=zeros(nrows46,1);
maxASM=zeros(nrows46,1);
for n=1:nrows46
    meanASM(n,1)=meanASMVal;
    medianASM(n,1)=medianASMVal;
    maxASM(n,1)=maxASMVal;
end
ASMTT= addvars(ASMTT,meanASM,medianASM,maxASM);
SourceFile(46,1)="ASM.xlsx";
Code(46,1)="ASM";
Desc(46,1)="AvailableSeat Miles";
Freq(46,1)="Monthly";
StartYear(46,1)=2000;
EndYear(46,1)=2025;
SeasonalAdj(46,1)="No";
BaseYear(46,1)=2000;
NumObs(46,1)=302;
loopstr5='Process Airline Vailable Seatmiles';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows46,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Miles=',num2str(meanASMVal,5),...
    '-Median Miles =',num2str(medianASMVal,5));
fprintf(fid,'%10s\n',loopstr7);
FRObj.ASMTT=ASMTT;
% Now plot this data
Chap(46,1)=7;
Section(46,1)=17;
itype=46;
% Calculate the smoothed load factor
asmsmooth = smoothdata(ASMTT.AvailMiles);
P0=asmsmooth(1);
PF=asmsmooth(302);
ASMTT = addvars(ASMTT,asmsmooth);
NYears=EndYear(46,1)-StartYear(46,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG46=100*GrowthRateAll(itype,1);
FRObj.SG46=SG46;
% Calculate simple stats
Data=ASMTT.AvailMiles;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the AirLoadTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [ASMTT,icase] = OverlapTimeLinesRev1(ASMTT,RecessProbTT);
     FRObj.ASMTT=ASMTT;
     RecessionInfo(46,1)=icase;
end
FRObj.barval=50;
FRObj.ASMTT=ASMTT;
% Plot the Data
titlestr='USAirlineAvailableSeatMiles';
PlotFredData(FRObj,ASMTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{46,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ASM-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with PipelinePetrol Movement (PETROLEUMD11)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PetrolTable = readtable(fredfile47,'Sheet','Monthly');
[nrows47,~]=size(PetrolTable);
clear DateNumbers dateArray
dateArray=strings(nrows47,1);
for n=1:nrows47
    nowstr=string(PetrolTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PipelinePetrolTT=table2timetable(PetrolTable,'RowTimes','Date');
PipelinePetrolTT = addvars(PipelinePetrolTT,DateNumbers);
meanPetrolVal=mean(PipelinePetrolTT.Petrol,'omitnan')/1E6;
medianPetrolVal=median(PipelinePetrolTT.Petrol,'omitnan')/1E6;
maxPetrolVal=max(PipelinePetrolTT.Petrol,[],'omitnan')/1E6;
meanPetrol=zeros(nrows47,1);
medianPetrol=zeros(nrows47,1);
maxPetrol=zeros(nrows47,1);
for n=1:nrows47
    meanPetrol(n,1)=meanPetrolVal;
    medianPetrol(n,1)=medianPetrolVal;
    maxPetrol(n,1)=maxPetrolVal;
end
PipelinePetrolTT= addvars(PipelinePetrolTT,meanPetrol,medianPetrol,maxPetrol);
SourceFile(47,1)="PipelinePetrol.xlsx";
Code(47,1)="PETROLEUMD11";
Desc(47,1)="PipelinePetrolMovement";
Freq(47,1)="Monthly";
StartYear(47,1)=2000;
EndYear(47,1)=2025;
SeasonalAdj(47,1)="Yes";
BaseYear(47,1)=2000;
NumObs(47,1)=303;
loopstr5='Process Petrol Movement Through Pipelines';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows47,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Barrels=',num2str(meanPetrolVal,7),...
    '-Median Barrels =',num2str(medianPetrolVal,7));
fprintf(fid,'%10s\n',loopstr7);
FRObj.PipelinePetrolTT=PipelinePetrolTT;
% Now plot this data
Chap(47,1)=7;
Section(47,1)=18;
itype=47;
oilsmooth = smoothdata(PipelinePetrolTT.Petrol);
P0=oilsmooth(1);
PF=oilsmooth(303);
PipelinePetrolTT = addvars(PipelinePetrolTT,oilsmooth);
NYears=EndYear(47,1)-StartYear(47,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG47=100*GrowthRateAll(itype,1);
FRObj.SG47=SG47;
% Calculate simple stats
Data=PipelinePetrolTT.Petrol;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the AirLoadTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [PipelinePetrolTT,icase] = OverlapTimeLinesRev1(PipelinePetrolTT,RecessProbTT);
     FRObj.PipelinePetrolTT=PipelinePetrolTT;
     RecessionInfo(47,1)=icase;
end
FRObj.barval=0.5;
FRObj.PipelinePetrolTT=PipelinePetrolTT;
% Plot data
titlestr='PipelinePetrolMovement';
PlotFredData(FRObj,PipelinePetrolTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{47,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='PetrolMovement-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Housing Starts (HOUST1F)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
HouseStartsTable = readtable(fredfile48,'Sheet','Monthly');
[nrows48,~]=size(HouseStartsTable);
clear DateNumbers dateArray
dateArray=strings(nrows48,1);
for n=1:nrows48
    nowstr=string(HouseStartsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
HouseStartsTT=table2timetable(HouseStartsTable,'RowTimes','Date');
HouseStartsTT = addvars(HouseStartsTT,DateNumbers);
meanHouseStartsVal=mean(HouseStartsTT.HousingStarts,'omitnan');
medianHouseStartsVal=median(HouseStartsTT.HousingStarts,'omitnan');
maxHouseStartsVal=max(HouseStartsTT.HousingStarts,[],'omitnan');
meanHousing=zeros(nrows48,1);
medianHousing=zeros(nrows48,1);
maxHousing=zeros(nrows48,1);
for n=1:nrows48
    meanHousing(n,1)=meanHouseStartsVal;
    medianHousing(n,1)=medianHouseStartsVal;
    maxHousing(n,1)=maxHouseStartsVal;
end
HouseStartsTT= addvars(HouseStartsTT,meanHousing,medianHousing,maxHousing);
SourceFile(48,1)="HouseStarts.xlsx";
Code(48,1)="HOUST1F";
Desc(48,1)="SingleFamilyHousingStarts";
Freq(48,1)="Monthly";
StartYear(48,1)=1959;
EndYear(48,1)=2025;
SeasonalAdj(48,1)="Yes";
BaseYear(48,1)=1959;
NumObs(48,1)=797;
loopstr5='Process Single Family Housing Starts';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows48,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Houses=',num2str(meanHouseStartsVal,6),...
    '-Median Houses =',num2str(medianHouseStartsVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.HouseStartsTT=HouseStartsTT;
Chap(48,1)=6;
Section(48,1)=4;
% Now pull of the Recession Probability data that matches the available
% time points in the HouseStartsTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [HouseStartsTT,icase] = OverlapTimeLinesRev1(HouseStartsTT,RecessProbTT);
     FRObj.HouseStartsTT=HouseStartsTT;
     RecessionInfo(48,1)=icase;
end
FRObj.barval=800;
FRObj.HouseStartsTT=HouseStartsTT;
% Now plot this data
itype=48;
% Calculate the smoothed housing starts
housesmooth = smoothdata(HouseStartsTT.HousingStarts);
P0=housesmooth(1);
PF=housesmooth(797);
HouseStartsTT = addvars(HouseStartsTT,housesmooth);
NYears=EndYear(48,1)-StartYear(48,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG48=100*GrowthRateAll(itype,1);
FRObj.SG48=SG48;
% Calculate simple stats
Data=HouseStartsTT.HousingStarts;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='SingleFamilyHouseStarts';
PlotFredData(FRObj,HouseStartsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{48,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='HousingStarts-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Mortgage Debt Service Payments (MDSP)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
MDSPTable = readtable(fredfile49,'Sheet','Quarterly');
[nrows49,~]=size(MDSPTable);
clear DateNumbers dateArray
dateArray=strings(nrows49,1);
for n=1:nrows49
    nowstr=string(MDSPTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
MDSPTT=table2timetable(MDSPTable,'RowTimes','Date');
MDSPTT = addvars(MDSPTT,DateNumbers);
meanMDSPVal=mean(MDSPTT.MDSP,'omitnan');
medianMDSPVal=median(MDSPTT.MDSP,'omitnan');
maxMDSPVal=max(MDSPTT.MDSP,[],'omitnan');
meanMDSP=zeros(nrows49,1);
medianMDSP=zeros(nrows49,1);
maxMDSP=zeros(nrows49,1);
for n=1:nrows49
    meanMDSP(n,1)=meanMDSPVal;
    medianMDSP(n,1)=medianMDSPVal;
    maxMDSP(n,1)=maxMDSPVal;
end
MDSPTT= addvars(MDSPTT,meanMDSP,medianMDSP,maxMDSP);
SourceFile(49,1)="MDSP.xlsx'";
Code(49,1)="MDSP";
Desc(49,1)="MortgageDebtService";
Freq(49,1)="Quarterly";
StartYear(49,1)=1980;
EndYear(49,1)=2025;
SeasonalAdj(49,1)="Yes";
BaseYear(49,1)=1980;
NumObs(49,1)=181;
loopstr5='Process Mortgage Debt Service Payments';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows49,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean MDSP=',num2str(meanMDSPVal,4),...
    '-Median MDSP =',num2str(medianMDSPVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.MDSPTT=MDSPTT;
% Now plot this data
Chap(49,1)=6;
Section(49,1)=9;
itype=49;
% Calculate the smoothed housing starts
mdspsmooth = smoothdata(MDSPTT.MDSP);
P0=mdspsmooth(1);
PF=mdspsmooth(181);
MDSPTT = addvars(MDSPTT,mdspsmooth);
% Calculate simple stats
Data=MDSPTT.MDSP;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='MortgageDebtServicePayments';
PlotFredData(FRObj,MDSPTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{49,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='MDSP-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Vacant Housing Units (EVACANTUSQ176N)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
VacHouseUnitsTable = readtable(fredfile50,'Sheet','Quarterly');
[nrows50,~]=size(VacHouseUnitsTable);
clear DateNumbers dateArray
dateArray=strings(nrows50,1);
for n=1:nrows50
    nowstr=string(VacHouseUnitsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
VacHouseUnitsTT=table2timetable(VacHouseUnitsTable,'RowTimes','Date');
VacHouseUnitsTT = addvars(VacHouseUnitsTT,DateNumbers);
meanVacantVal=mean(VacHouseUnitsTT.Vacant,'omitnan');
medianVacantVal=median(VacHouseUnitsTT.Vacant,'omitnan');
maxVacantVal=max(VacHouseUnitsTT.Vacant,[],'omitnan');
meanVacant=zeros(nrows50,1);
medianVacant=zeros(nrows50,1);
maxVacant=zeros(nrows50,1);
for n=1:nrows50
    meanVacant(n,1)=meanVacantVal;
    medianVacant(n,1)=medianVacantVal;
    maxVacant(n,1)=maxVacantVal;
end
VacHouseUnitsTT= addvars(VacHouseUnitsTT,meanVacant,medianVacant,maxVacant);
SourceFile(50,1)="VacantHousingUnits.xlsx";
Code(50,1)="EVACANTUSQ176N";
Desc(50,1)="VacantHousingUnits";
Freq(50,1)="Quarterly";
StartYear(50,1)=2000;
EndYear(50,1)=2025;
SeasonalAdj(50,1)="No";
BaseYear(50,1)=2000;
NumObs(50,1)=100;
loopstr5='Process Vacant Housing Units';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows50,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Vacant=',num2str(meanVacantVal,5),...
    '-Median Vacant =',num2str(medianVacantVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.VacHouseUnitsTT=VacHouseUnitsTT;
% Now plot this data
Chap(50,1)=6;
Section(50,1)=14;
itype=50;
titlestr='VacantHousingUnits';
PlotFredData(FRObj,VacHouseUnitsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{50,1}=figstr2;

%% Continue with US Granted Patents (PATENTUSALLTOTAL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
USPatentsTable = readtable(fredfile51,'Sheet','Annual');
[nrows51,~]=size(USPatentsTable);
clear DateNumbers dateArray
dateArray=strings(nrows51,1);
for n=1:nrows51
    nowstr=string(USPatentsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
USPatentsTT=table2timetable(USPatentsTable,'RowTimes','Date');
USPatentsTT = addvars(USPatentsTT,DateNumbers);
meanPatentsVal=mean(USPatentsTT.USPatents,'omitnan');
medianPatentsVal=median(USPatentsTT.USPatents,'omitnan');
maxPatentsVal=max(USPatentsTT.USPatents,[],'omitnan');
meanPatents=zeros(nrows51,1);
medianPatents=zeros(nrows51,1);
maxPatents=zeros(nrows51,1);
for n=1:nrows51
    meanPatents(n,1)=meanPatentsVal;
    medianPatents(n,1)=medianPatentsVal;
    maxPatents(n,1)=maxPatentsVal;
end
USPatentsTT= addvars(USPatentsTT,meanPatents,medianPatents,maxPatents);
SourceFile(51,1)="USPatents.xlsx";
Code(51,1)="PATENTUSALLTOTAL";
Desc(51,1)="GrantedUSPatents";
Freq(51,1)="Quarterly";
StartYear(51,1)=1992;
EndYear(51,1)=2020;
SeasonalAdj(51,1)="No";
BaseYear(51,1)=1992;
NumObs(51,1)=29;
loopstr5='Process Granted US Patents';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows51,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Patents=',num2str(meanPatentsVal,6),...
    '-Median Patents =',num2str(medianPatentsVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.USPatentsTT=USPatentsTT;
% Now plot this data
Chap(51,1)=15;
Section(51,1)=1;
itype=51;
patsmooth = smoothdata(USPatentsTT.USPatents);
P0=patsmooth(1);
PF=patsmooth(29);
USPatentsTT= addvars(USPatentsTT,patsmooth);
NYears=EndYear(51,1)-StartYear(51,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG51=100*GrowthRateAll(itype,1);
titlestr='GrantedUSPatents';
PlotFredData(FRObj,USPatentsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{51,1}=figstr2;

%% Continue with Total Capacity Utilization (TCU)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
TCUTable = readtable(fredfile52,'Sheet','Monthly');
[nrows52,~]=size(TCUTable);
clear DateNumbers dateArray
dateArray=strings(nrows52,1);
for n=1:nrows52
    nowstr=string(TCUTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TCUTT=table2timetable(TCUTable,'RowTimes','Date');
TCUTT = addvars(TCUTT,DateNumbers);
meanTCUVal=mean(TCUTT.TCU,'omitnan');
medianTCUVal=median(TCUTT.TCU,'omitnan');
maxTCUVal=max(TCUTT.TCU,[],'omitnan');
meanTCU=zeros(nrows52,1);
medianTCU=zeros(nrows52,1);
maxTCU=zeros(nrows52,1);
for n=1:nrows52
    meanTCU(n,1)=meanTCUVal;
    medianTCU(n,1)=medianTCUVal;
    maxTCU(n,1)=maxTCUVal;
end
TCUTT= addvars(TCUTT,meanTCU,medianTCU,maxTCU);
SourceFile(52,1)="TCU.xlsx";
Code(52,1)="TCU";
Desc(52,1)="TotalCapacityUlilization";
Freq(52,1)="Monthly";
StartYear(52,1)=1967;
EndYear(52,1)=2025;
SeasonalAdj(52,1)="Yes";
BaseYear(52,1)=1967;
NumObs(52,1)=701;
loopstr5='Process Capacity Utilization';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows52,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Capacity=',num2str(meanTCUVal,5),...
    '-Median Capacity =',num2str(medianTCUVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.TCUTT=TCUTT;
% Now plot this data
Chap(52,1)=15;
Section(52,1)=2;
itype=52;
% smooth the data
Data=TCUTT.TCU;
capsmooth = smoothdata(Data);
P0=capsmooth(1);
PF=capsmooth(701);
TCUTT= addvars(TCUTT,capsmooth);
titlestr='TotalCapacityUtlizization';
% Calculate simple stats
Data=TCUTT.TCU;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the TCUTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [TCUTT,icase] = OverlapTimeLinesRev1(TCUTT,RecessProbTT);
     FRObj.TCUTT=TCUTT;
     RecessionInfo(52,1)=icase;
end
FRObj.barval=80;
FRObj.TCUTT=TCUTT;
PlotFredData(FRObj,TCUTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{52,1}=figstr2;
% Now create the data for a cumilative distribution plot
FRObj.CurrentMedianValue=80.11;
titlestr3='TotalCapacity-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Semiconductor Production Index (IPG3344S)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
SemiconductorsTable = readtable(fredfile53,'Sheet','Monthly');
[nrows53,~]=size(SemiconductorsTable);
clear DateNumbers dateArray
dateArray=strings(nrows53,1);
for n=1:nrows53
    nowstr=string(SemiconductorsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
SemiconductorsTT=table2timetable(SemiconductorsTable,'RowTimes','Date');
SemiconductorsTT = addvars(SemiconductorsTT,DateNumbers);
meanSemiVal=mean(SemiconductorsTT.Semiconductors,'omitnan');
medianSemiVal=median(SemiconductorsTT.Semiconductors,'omitnan');
maxSemiVal=max(SemiconductorsTT.Semiconductors,[],'omitnan');
meanSemi=zeros(nrows53,1);
medianSemi=zeros(nrows53,1);
maxSemi=zeros(nrows53,1);
for n=1:nrows53
    meanSemi(n,1)=meanSemiVal;
    medianSemi(n,1)=medianSemiVal;
    maxSemi(n,1)=maxSemiVal;
end
SemiconductorsTT= addvars(SemiconductorsTT,meanSemi,medianSemi,maxSemi);
SourceFile(53,1)="IPSemiconductors.xlsx";
Code(53,1)="IPG3344S";
Desc(53,1)="SemiconductorProduction";
Freq(53,1)="Monthly";
StartYear(53,1)=1972;
EndYear(53,1)=2025;
SeasonalAdj(53,1)="Yes";
BaseYear(53,1)=1972;
NumObs(53,1)=641;
loopstr5='Process Granted US Patents';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows53,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Capacity=',num2str(meanSemiVal,5),...
    '-Median Capacity =',num2str(medianSemiVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.SemiconductorsTT=SemiconductorsTT;
% Now plot this data
Chap(53,1)=15;
Section(53,1)=3;
itype=53;
techsmooth = smoothdata(SemiconductorsTT.Semiconductors);
P0=techsmooth(1);
PF=techsmooth(641);
SemiconductorsTT= addvars(SemiconductorsTT,techsmooth);
NYears=EndYear(53,1)-StartYear(53,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG53=100*GrowthRateAll(itype,1);
% Now pull of the Recession Probability data that matches the available
% time points in the TCUTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [SemiconductorsTT,icase] = OverlapTimeLinesRev1(SemiconductorsTT,RecessProbTT);
     FRObj.SemiconductorsTT=SemiconductorsTT;
     RecessionInfo(53,1)=icase;
end
FRObj.barval=100;
FRObj.SemiconductorsTT=SemiconductorsTT;
titlestr='SemiconductorCapacity';
% Calculate simple stats
Data=SemiconductorsTT.Semiconductors;
FRObj=FRObj.SimpleStats(Data,itype);
% Now plot the data
titlestr='SemiconductorCapacity';
PlotFredData(FRObj,SemiconductorsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{53,1}=figstr2;
FRObj.CurrentMedianValue=medianSemiVal;
% Now create the data for a cumilative distribution plot
titlestr3='SC-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Defense Production Index (IPB52300S)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
DefenseTable = readtable(fredfile54,'Sheet','Monthly');
[nrows54,~]=size(DefenseTable);
clear DateNumbers dateArray
dateArray=strings(nrows54,1);
for n=1:nrows54
    nowstr=string(DefenseTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
DefenseTT=table2timetable(DefenseTable,'RowTimes','Date');
DefenseTT = addvars(DefenseTT,DateNumbers);
meanDefenseVal=mean(DefenseTT.Defense,'omitnan');
medianDefenseVal=median(DefenseTT.Defense,'omitnan');
maxDefenseVal=max(DefenseTT.Defense,[],'omitnan');
meanDefense=zeros(nrows54,1);
medianDefense=zeros(nrows54,1);
maxDefense=zeros(nrows54,1);
for n=1:nrows54
    meanDefense(n,1)=meanDefenseVal;
    medianDefense(n,1)=medianDefenseVal;
    maxDefense(n,1)=maxDefenseVal;
end
DefenseTT= addvars(DefenseTT,meanDefense,medianDefense,maxDefense);
SourceFile(54,1)="IPDefense.xlsx";
Code(54,1)="IPB52300S";
Desc(54,1)="DefenseProduction";
Freq(54,1)="Monthly";
StartYear(54,1)=1947;
EndYear(54,1)=2025;
SeasonalAdj(54,1)="Yes";
BaseYear(54,1)=2017;
NumObs(54,1)=941;
loopstr5='Process Granted US Patents';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows54,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Capacity=',num2str(meanDefenseVal,5),...
    '-Median Capacity =',num2str(medianDefenseVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.DefenseTT=DefenseTT;
% Now plot this data
Chap(54,1)=15;
Section(54,1)=4;
itype=54;
defsmooth = smoothdata(DefenseTT.Defense);
P0=defsmooth(1);
PF=defsmooth(941);
DefenseTT= addvars(DefenseTT,defsmooth);
NYears=EndYear(54,1)-StartYear(54,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG54=100*GrowthRateAll(itype,1);
% Now pull of the Recession Probability data that matches the available
% time points in the TCUTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [DefenseTT,icase] = OverlapTimeLinesRev1(DefenseTT,RecessProbTT);
     FRObj.DefenseTT=DefenseTT;
     RecessionInfo(54,1)=icase;
end
FRObj.barval=80;
FRObj.DefenseTT=DefenseTT;
% Calculate simple stats
Data=DefenseTT.Defense;
FRObj=FRObj.SimpleStats(Data,itype);
% Now plot the data
titlestr='DefenseCapacity';
PlotFredData(FRObj,DefenseTT,itype,titlestr);
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{54,1}=figstr2;
% Now create the data for a cumilative distribution plot
FRObj.CurrentMedianValue=medianDefenseVal;
titlestr3='Defense-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Total Hospital Revenue (REV622ALLEST144QSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
TotHospRevenueTable = readtable(fredfile55,'Sheet','Quarterly');
[nrows55,~]=size(TotHospRevenueTable);
clear DateNumbers dateArray
dateArray=strings(nrows55,1);
for n=1:nrows55
    nowstr=string(TotHospRevenueTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TotHospRevenueTT=table2timetable(TotHospRevenueTable,'RowTimes','Date');
TotHospRevenueTT = addvars(TotHospRevenueTT,DateNumbers);
meanTotRevVal=mean(TotHospRevenueTT.TotalRevenue,'omitnan')/1E3;
medianTotRevVal=median(TotHospRevenueTT.TotalRevenue,'omitnan')/1E3;
maxTotRevVal=max(TotHospRevenueTT.TotalRevenue,[],'omitnan')/1E3;
meanTotRev=zeros(nrows55,1);
medianTotRev=zeros(nrows55,1);
maxTotRev=zeros(nrows55,1);
for n=1:nrows55
    meanTotRev(n,1)=meanTotRevVal;
    medianTotRev(n,1)=medianTotRevVal;
    maxTotRev(n,1)=maxTotRevVal;
end
TotHospRevenueTT= addvars(TotHospRevenueTT,meanTotRev,medianTotRev,maxTotRev);
SourceFile(55,1)="TotalRevenueAllHospitals.xlsx";
Code(55,1)="REV622ALLEST144QSA";
Desc(55,1)="TotalRevenueAllHosp";
Freq(55,1)="Quarterly";
StartYear(55,1)=2004;
EndYear(55,1)=2025;
SeasonalAdj(55,1)="Yes";
BaseYear(55,1)=2004;
NumObs(55,1)=82;
loopstr5='Process Total Revenue All Hospitals';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows55,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Revenue=',num2str(meanTotRevVal,5),...
    '-Median Revenue =',num2str(medianTotRevVal,6),'-In Billions USD');
fprintf(fid,'%10s\n',loopstr7);
FRObj.TotHospRevenueTT=TotHospRevenueTT;
% Now plot this data
Chap(55,1)=15;
Section(55,1)=5;
itype=55;
hospsmooth = smoothdata(TotHospRevenueTT.TotalRevenue);
P0=hospsmooth(1);
PF=hospsmooth(82);
TotHospRevenueTT= addvars(TotHospRevenueTT,hospsmooth);
NYears=EndYear(55,1)-StartYear(55,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG55=100*GrowthRateAll(itype,1);
titlestr='TotalHospitalRevnues';
PlotFredData(FRObj,TotHospRevenueTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{55,1}=figstr2;

%% Continue with PharmaPriceIndex (PHMEPRPIHCSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PharmaPriceTable = readtable(fredfile56,'Sheet','Annual');
[nrows56,~]=size(PharmaPriceTable);
clear DateNumbers dateArray
dateArray=strings(nrows56,1);
for n=1:nrows56
    nowstr=string(PharmaPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PharmaPriceTT=table2timetable(PharmaPriceTable,'RowTimes','Date');
PharmaPriceTT = addvars(PharmaPriceTT,DateNumbers);
meanPriceVal=mean(PharmaPriceTT.PharmaIndex,'omitnan');
medianPriceVal=median(PharmaPriceTT.PharmaIndex,'omitnan');
maxPriceVal=max(PharmaPriceTT.PharmaIndex,[],'omitnan')/1E3;
meanPrice=zeros(nrows56,1);
medianPrice=zeros(nrows56,1);
maxPrice=zeros(nrows56,1);
for n=1:nrows56
    meanPrice(n,1)=meanPriceVal;
    medianPrice(n,1)=medianPriceVal;
    maxPrice(n,1)=maxPriceVal;
end
PharmaPriceTT= addvars(PharmaPriceTT,meanPrice,medianPrice,maxPrice);
SourceFile(56,1)="PharmaceuticalPriceIndex.xlsx";
Code(56,1)="PHMEPRPIHCSA";
Desc(56,1)="PharmaPriceIndex";
Freq(56,1)="Annual";
StartYear(56,1)=2000;
EndYear(56,1)=2021;
SeasonalAdj(56,1)="No";
BaseYear(56,1)=2017;
NumObs(56,1)=22;
loopstr5='Process PharmaPrice Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows56,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Price=',num2str(meanPriceVal,5),...
    '-Median Price =',num2str(medianPriceVal,6),'-Relative to 2017');
fprintf(fid,'%10s\n',loopstr7);
FRObj.PharmaPriceTT=PharmaPriceTT;
% Now plot this data
Chap(56,1)=15;
Section(56,1)=6;
itype=56;
titlestr='PharmaPriceIndex';
PlotFredData(FRObj,PharmaPriceTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{56,1}=figstr2;

%% Continue with ProducePriceIndex (PPIACO)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PPITable = readtable(fredfile57,'Sheet','Monthly');
[nrows57,~]=size(PPITable);
clear DateNumbers dateArray
dateArray=strings(nrows57,1);
for n=1:nrows57
    nowstr=string(PPITable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ProdPriceTT=table2timetable(PPITable,'RowTimes','Date');
ProdPriceTT = addvars(ProdPriceTT,DateNumbers);
meanPPIVal=mean(ProdPriceTT.PPIACO,'omitnan');
medianPPIVal=median(ProdPriceTT.PPIACO,'omitnan');
maxPPIVal=max(ProdPriceTT.PPIACO,[],'omitnan')/1E3;
meanPPI=zeros(nrows57,1);
medianPPI=zeros(nrows57,1);
maxPPI=zeros(nrows57,1);
for n=1:nrows57
    meanPPI(n,1)=meanPPIVal;
    medianPPI(n,1)=medianPPIVal;
    maxPPI(n,1)=maxPPIVal;
end
ProdPriceTT= addvars(ProdPriceTT,meanPPI,medianPPI,maxPPI);
SourceFile(57,1)="ProducerPriceIndex.xlsx";
Code(57,1)="PPIACO";
Desc(57,1)="ProducerPriceIndex";
Freq(57,1)="Monthly";
StartYear(57,1)=1913;
EndYear(57,1)=2025;
SeasonalAdj(57,1)="No";
BaseYear(57,1)=1982;
NumObs(57,1)=1349;
loopstr5='Process Producer Price Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows57,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean PPI=',num2str(meanPPIVal,5),...
    '-Median PPI =',num2str(medianPPIVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.ProdPriceTT=ProdPriceTT;
% Now plot this data
Chap(57,1)=15;
Section(57,1)=7;
itype=57;
% Now pull of the Recession Probability data that matches the available
% time points in the TCUTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [ProdPriceTT,icase] = OverlapTimeLinesRev1(ProdPriceTT,RecessProbTT);
     FRObj.ProdPriceTT=ProdPriceTT;
     RecessionInfo(57,1)=icase;
end
FRObj.barval=150;
FRObj.ProdPriceTT=ProdPriceTT;
% Calculate simple stats
Data=ProdPriceTT.PPIACO;
ppismooth = smoothdata(Data);
P0=ppismooth(1);
PF=ppismooth(1349);
ProdPriceTT= addvars(ProdPriceTT,ppismooth);
NYears=EndYear(57,1)-StartYear(57,1)+1;
FRObj=FRObj.SimpleStats(Data,itype);
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG57=100*GrowthRateAll(itype,1);
FRObj.SG57=SG57;
% Plot Data
titlestr='ProducerPriceIndex';
PlotFredData(FRObj,ProdPriceTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{57,1}=figstr2;
% Now create the data for a cumilative distribution plot of the Producer
% Price Index
titlestr3='PPI-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Flexible Consumer Price Index (FLEXCPIM159SFRBATL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FlexCPITable = readtable(fredfile58,'Sheet','Monthly');
[nrows58,~]=size(FlexCPITable);
clear DateNumbers dateArray
dateArray=strings(nrows58,1);
for n=1:nrows58
    nowstr=string(FlexCPITable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FlexCPITT=table2timetable(FlexCPITable,'RowTimes','Date');
FlexCPITT = addvars(FlexCPITT,DateNumbers);
meanFCPIVal=mean(FlexCPITT.FlexCPI,'omitnan');
medianFCPIVal=median(FlexCPITT.FlexCPI,'omitnan');
maxFCPIVal=max(FlexCPITT.FlexCPI,[],'omitnan');
meanFCPI=zeros(nrows58,1);
medianFCPI=zeros(nrows58,1);
maxFCPI=zeros(nrows58,1);
for n=1:nrows58
    meanFCPI(n,1)=meanFCPIVal;
    medianFCPI(n,1)=medianFCPIVal;
    maxFCPI(n,1)=maxFCPIVal;
end
FlexCPITT= addvars(FlexCPITT,meanFCPI,medianFCPI,maxFCPI);
SourceFile(58,1)="FlexCPIIndex.xlsx";
Code(58,1)="FlexCPI";
Desc(58,1)="FlexCPIIndex";
Freq(58,1)="Monthly";
StartYear(58,1)=1968;
EndYear(58,1)=2025;
SeasonalAdj(58,1)="Yes";
BaseYear(58,1)=1968;
NumObs(58,1)=690;
loopstr5='Process Flex CPI';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows58,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean FCPI=',num2str(meanFCPIVal,5),...
    '-Median FCPI =',num2str(medianFCPIVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FlexCPITT=FlexCPITT;
Chap(58,1)=5;
Section(58,1)=2;
FRObj.Chap=Chap;
FRObj.Section=Section;
itype=58;
% Calculate the smoothed Flex CPI Index
flexsmooth = smoothdata(FlexCPITT.FlexCPI);
P0=flexsmooth(1);
PF=flexsmooth(690);
FlexCPITT = addvars(FlexCPITT,flexsmooth);
NYears=EndYear(58,1)-StartYear(58,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG58=100*GrowthRateAll(itype,1);
FRObj.SG58=SG58;
% Now pull of the Recession Probability data that matches the available
% time points in the FlexCPITT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [FlexCPITT,icase] = OverlapTimeLinesRev1(FlexCPITT,RecessProbTT);
     FRObj.FlexCPITT=FlexCPITT;
     RecessionInfo(58,1)=icase;
end
FRObj.barval=5;
FRObj.FlexCPITT=FlexCPITT;
% Now plot this data
titlestr='FlexCPI';
% Calculate simple stats
Data=FlexCPITT.FlexCPI;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,FlexCPITT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{58,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FlexCPI-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)


%% Continue with Single Family Homes Completed (COMPU1USA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CompHousesTable = readtable(fredfile59,'Sheet','Monthly');
[nrows59,~]=size(CompHousesTable);
clear DateNumbers dateArray
dateArray=strings(nrows59,1);
for n=1:nrows59
    nowstr=string(CompHousesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CompHousesTT=table2timetable(CompHousesTable,'RowTimes','Date');
CompHousesTT = addvars(CompHousesTT,DateNumbers);
meanStartsVal=mean(CompHousesTT.Completed,'omitnan');
medianStartsVal=median(CompHousesTT.Completed,'omitnan');
maxStartsVal=max(CompHousesTT.Completed,[],'omitnan');
meanHStarts=zeros(nrows59,1);
medianHStarts=zeros(nrows59,1);
maxHStarts=zeros(nrows59,1);
for n=1:nrows59
    meanHStarts(n,1)=meanStartsVal;
    medianHStarts(n,1)=medianStartsVal;
    maxHStarts(n,1)=maxStartsVal;
end
CompHousesTT= addvars(CompHousesTT,meanHStarts,medianHStarts,maxHStarts);
SourceFile(59,1)="COMPU1USA.xlsx'";
Code(59,1)="COMPU1USA";
Desc(59,1)="CompletedHouseStarts";
Freq(59,1)="Monthly";
StartYear(59,1)=1968;
EndYear(59,1)=2025;
SeasonalAdj(59,1)="Yes";
BaseYear(59,1)=1968;
NumObs(59,1)=690;
loopstr5='Process Single Family House Completion Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows59,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Starts=',num2str(meanStartsVal,5),...
    '-Median Starts =',num2str(medianStartsVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CompHousesTT=CompHousesTT;
Chap(59,1)=6;
Section(59,1)=5;
% Now plot this data Finished 10/07/25
itype=59;
% Calculate the smoothed housing starts
compsmooth = smoothdata(CompHousesTT.Completed);
P0=compsmooth(1);
PF=compsmooth(690);
CompHousesTT = addvars(CompHousesTT,compsmooth);
NYears=EndYear(59,1)-StartYear(59,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG59=100*GrowthRateAll(itype,1);
FRObj.SG59=SG59;
titlestr='SingleFamilyHousesCompleted';
% Calculate simple stats
Data=CompHousesTT.Completed;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the CompHousesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [CompHousesTT,icase] = OverlapTimeLinesRev1(CompHousesTT,RecessProbTT);
     FRObj.CompHousesTT=CompHousesTT;
     RecessionInfo(59,1)=icase;
end
FRObj.barval=500;
FRObj.CompHousesTT=CompHousesTT;
% Plot Data
titlestr='SingleFamilyHousesCompleted';
PlotFredData(FRObj,CompHousesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{59,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='HouseCompletions-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Advance Retail Sales (RSXFS)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
AdvanceRetailSalesTable = readtable(fredfile60,'Sheet','Monthly');
[nrows60,~]=size(AdvanceRetailSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows60,1);
for n=1:nrows60
    nowstr=string(AdvanceRetailSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
AdvRetailSalesTT=table2timetable(AdvanceRetailSalesTable,'RowTimes','Date');
AdvRetailSalesTT = addvars(AdvRetailSalesTT,DateNumbers);
meanSalesVal=mean(AdvRetailSalesTT.Sales,'omitnan');
medianSalesVal=median(AdvRetailSalesTT.Sales,'omitnan');
maxSalesVal=max(AdvRetailSalesTT.Sales,[],'omitnan');
meanAdvSales=zeros(nrows60,1);
medianAdvSales=zeros(nrows60,1);
maxAdvSales=zeros(nrows60,1);
for n=1:nrows60
    meanAdvSales(n,1)=meanSalesVal;
    medianAdvSales(n,1)=medianSalesVal;
    maxAdvSales(n,1)=maxSalesVal;
end
AdvRetailSalesTT= addvars(AdvRetailSalesTT,meanAdvSales,medianAdvSales,maxAdvSales);
SourceFile(60,1)="AdvanceRetailSales.xlsx'";
Code(60,1)="RSXFS";
Desc(60,1)="AdvanceRetailSales";
Freq(60,1)="Monthly";
StartYear(60,1)=1992;
EndYear(60,1)=2025;
SeasonalAdj(60,1)="Yes";
BaseYear(60,1)=1992;
NumObs(60,1)=402;
loopstr5='Process Advance Retail Sales Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows60,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Starts=',num2str(meanSalesVal,6),...
    '-Median Starts =',num2str(medianSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.AdvRetailSalesTT=AdvRetailSalesTT;
Chap(60,1)=7;
Section(60,1)=1;
% Now plot this data
itype=60;
P0=AdvRetailSalesTT.Sales(1);
PF=AdvRetailSalesTT.Sales(402);
% Calculate the smoothed housing starts
retailsmooth = smoothdata(AdvRetailSalesTT.Sales);
P0=retailsmooth(1);
PF=retailsmooth(402);
AdvRetailSalesTT = addvars(AdvRetailSalesTT,retailsmooth);
NYears=EndYear(60,1)-StartYear(60,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG60=100*GrowthRateAll(itype,1);
FRObj.SG60=SG60;
titlestr='AdvanceRetailSales';
% Calculate simple stats
Data=AdvRetailSalesTT.Sales;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the AdvReailSalesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [AdvRetailSalesTT,icase] = OverlapTimeLinesRev1(AdvRetailSalesTT,RecessProbTT);
     FRObj.AdvRetailSalesTT=AdvRetailSalesTT;
     RecessionInfo(60,1)=icase;
end
FRObj.barval=400;
FRObj.AdvRetailSalesTT=AdvRetailSalesTT;
titlestr='AdvanceRetailSales';
PlotFredData(FRObj,AdvRetailSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{60,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='AdvanceRetailSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with ECommerceRetailSales (ECOMSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ECommRSalesTable = readtable(fredfile61,'Sheet','Quarterly');
[nrows61,~]=size(ECommRSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows61,1);
for n=1:nrows61
    nowstr=string(ECommRSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ECommRSalesTT=table2timetable(ECommRSalesTable,'RowTimes','Date');
ECommRSalesTT = addvars(ECommRSalesTT,DateNumbers);
meanSalesVal=mean(ECommRSalesTT.Sales,'omitnan');
medianSalesVal=median(ECommRSalesTT.Sales,'omitnan');
maxSalesVal=max(ECommRSalesTT.Sales,[],'omitnan');
meanSales=zeros(nrows61,1);
medianSales=zeros(nrows61,1);
maxSales=zeros(nrows61,1);
for n=1:nrows61
    meanSales(n,1)=meanSalesVal;
    medianSales(n,1)=medianSalesVal;
    maxSales(n,1)=maxSalesVal;
end
ECommRSalesTT= addvars(ECommRSalesTT,meanSales,medianSales,maxSales);
SourceFile(61,1)="ECommerceRSales.xlsx'";
Code(61,1)="ECOMSA";
Desc(61,1)="ECommerce Retail Sales";
Freq(61,1)="Quarterly";
StartYear(61,1)=1999;
EndYear(61,1)=2025;
SeasonalAdj(61,1)="Yes";
BaseYear(61,1)=1999;
NumObs(61,1)=102;
loopstr5='Process ECommerce Retail Sales Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows61,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales=',num2str(meanSalesVal,6),...
    '-Median Starts =',num2str(medianSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.ECommRSalesTT=ECommRSalesTT;
Chap(61,1)=7;
Section(61,1)=2;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=61;
% Calculate the smoothed E commerce sales
ecomsmooth = smoothdata(ECommRSalesTT.Sales);
P0=ecomsmooth(1);
PF=ecomsmooth(102);
ECommRSalesTT = addvars(ECommRSalesTT,ecomsmooth);
NYears=EndYear(61,1)-StartYear(61,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG61=100*GrowthRateAll(itype,1);
FRObj.SG61=SG61;
% Calculate simple stats
Data=ECommRSalesTT.Sales;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='ECommerceRetailSales';
PlotFredData(FRObj,ECommRSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{61,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ECommerceRetailSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with InventoryToSales (RETAILIRSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
InventoryTable = readtable(fredfile62,'Sheet','Monthly');
[nrows62,~]=size(InventoryTable);
clear DateNumbers dateArray
dateArray=strings(nrows62,1);
for n=1:nrows62
    nowstr=string(InventoryTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
InventorySalesTT=table2timetable(InventoryTable,'RowTimes','Date');
InventorySalesTT = addvars(InventorySalesTT,DateNumbers);
meanInventoryVal=mean(InventorySalesTT.SalesRatio,'omitnan');
medianInventoryVal=median(InventorySalesTT.SalesRatio,'omitnan');
maxInventoryVal=max(InventorySalesTT.SalesRatio,[],'omitnan');
meanInventory=zeros(nrows62,1);
medianInventory=zeros(nrows62,1);
maxInventory=zeros(nrows62,1);
for n=1:nrows62
    meanInventory(n,1)=meanInventoryVal;
    medianInventory(n,1)=medianInventoryVal;
    maxInventory(n,1)=maxInventoryVal;
end
InventorySalesTT= addvars(InventorySalesTT,meanInventory,medianInventory,maxInventory);
SourceFile(62,1)="InventoryToSales.xlsx";
Code(62,1)="RETAILIRSA";
Desc(62,1)="InventoryToSalesRatio";
Freq(62,1)="Monthly";
StartYear(62,1)=1992;
EndYear(62,1)=2025;
SeasonalAdj(62,1)="Yes";
BaseYear(62,1)=1992;
NumObs(62,1)=401;
loopstr5='Process Inventory To Sales Ratio Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows62,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Inventory=',num2str(meanInventoryVal,6),...
    '-Median Inventory =',num2str(medianInventoryVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.InventorySalesTT=InventorySalesTT;
Chap(62,1)=7;
Section(62,1)=3;
% Now plot this data
itype=62;
Data=InventorySalesTT.SalesRatio;
invsmooth = smoothdata(Data);
P0=invsmooth(1);
PF=invsmooth(401);
InventorySalesTT= addvars(InventorySalesTT,invsmooth);
NYears=EndYear(62,1)-StartYear(62,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG62x=100*GrowthRateAll(itype,1);
FRObj.SG62x=SG62x;
% Now pull of the Recession Probability data that matches the available
% time points in the InventorySalesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [InventorySalesTT,icase] = OverlapTimeLinesRev1(InventorySalesTT,RecessProbTT);
     FRObj.InventorySalesTT=InventorySalesTT;
     RecessionInfo(62,1)=icase;
end
FRObj.barval=1.5;
FRObj.InventorySalesTT=InventorySalesTT;
titlestr='InventoryToSalesRatio';
% Calculate simple stats
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,InventorySalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{62,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='InventoryToSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Retail Inventories (RETAILIMSA)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
RetailInvenTable = readtable(fredfile63,'Sheet','Monthly');
[nrows63,~]=size(RetailInvenTable);
clear DateNumbers dateArray
dateArray=strings(nrows63,1);
for n=1:nrows63
    nowstr=string(RetailInvenTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RetailInvenTT=table2timetable(RetailInvenTable,'RowTimes','Date');
RetailInvenTT = addvars(RetailInvenTT,DateNumbers);
meanRInventoryVal=mean(RetailInvenTT.Inventories,'omitnan');
medianRInventoryVal=median(RetailInvenTT.Inventories,'omitnan');
maxRInventoryVal=max(RetailInvenTT.Inventories,[],'omitnan');
meanRInventory=zeros(nrows63,1);
medianRInventory=zeros(nrows63,1);
maxRInventory=zeros(nrows63,1);
for n=1:nrows63
    meanRInventory(n,1)=meanRInventoryVal;
    medianRInventory(n,1)=medianRInventoryVal;
    maxRInventory(n,1)=maxRInventoryVal;
end
RetailInvenTT= addvars(RetailInvenTT,meanRInventory,medianRInventory,maxRInventory);
SourceFile(63,1)="RetailInventories.xlsx";
Code(63,1)="RETAILIMSA";
Desc(63,1)="RetailInventories";
Freq(63,1)="Monthly";
StartYear(63,1)=1992;
EndYear(63,1)=2025;
SeasonalAdj(63,1)="Yes";
BaseYear(63,1)=1992;
NumObs(63,1)=401;
loopstr5='Process Retail Inventories Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows63,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Inventory=',num2str(meanRInventoryVal,6),...
    '-Median Inventory =',num2str(medianRInventoryVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.RetailInvenTT=RetailInvenTT;
Chap(63,1)=7;
Section(63,1)=4;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=63;
Data=RetailInvenTT.Inventories;
retailsmooth = smoothdata(Data);
P0=retailsmooth(1);
PF=retailsmooth(401);
RetailInvenTT= addvars(RetailInvenTT,retailsmooth);
NYears=EndYear(63,1)-StartYear(63,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG63=100*GrowthRateAll(itype,1);
FRObj.SG63=SG63;
% Calculate simple stats
Data=RetailInvenTT.Inventories;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='RetailInventories';
% Now pull of the Recession Probability data that matches the available
% time points in the InventorySalesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [RetailInvenTT,icase] = OverlapTimeLinesRev1(RetailInvenTT,RecessProbTT);
     FRObj.RetailInvenTT=RetailInvenTT;
     RecessionInfo(63,1)=icase;
end
FRObj.barval=500;
FRObj.RetailInvenTT=RetailInvenTT;
% Plot the data
titlestr='RetailInventories';
PlotFredData(FRObj,RetailInvenTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{63,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RetailInventories-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Retail Sales Of Used Cars (MRTSSM44112USN)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
UsedCarTable = readtable(fredfile64,'Sheet','Monthly');
[nrows64,~]=size(UsedCarTable);
clear DateNumbers dateArray
dateArray=strings(nrows64,1);
for n=1:nrows64
    nowstr=string(UsedCarTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
UsedCarSalesTT=table2timetable(UsedCarTable,'RowTimes','Date');
UsedCarSalesTT = addvars(UsedCarSalesTT,DateNumbers);
meanUsedCarSalesVal=mean(UsedCarSalesTT.UsedCars,'omitnan');
medianUsedCarSalesVal=median(UsedCarSalesTT.UsedCars,'omitnan');
maxUsedCarSalesVal=max(UsedCarSalesTT.UsedCars,[],'omitnan');
meanUsedCarSales=zeros(nrows64,1);
medianUsedCarSales=zeros(nrows64,1);
maxUsedCarSales=zeros(nrows64,1);
for n=1:nrows64
    meanUsedCarSales(n,1)=meanUsedCarSalesVal;
    medianUsedCarSales(n,1)=medianUsedCarSalesVal;
    maxUsedCarSales(n,1)=maxUsedCarSalesVal;
end
UsedCarSalesTT= addvars(UsedCarSalesTT,meanUsedCarSales,medianUsedCarSales,maxUsedCarSales);
SourceFile(64,1)="UsedCarSales.xlsx";
Code(64,1)="MRTSSM44112USN";
Desc(64,1)="RetailUsedCarSales";
Freq(64,1)="Monthly";
StartYear(64,1)=1992;
EndYear(64,1)=2025;
SeasonalAdj(64,1)="No";
BaseYear(64,1)=1992;
NumObs(64,1)=401;
loopstr5='Process Retail Used Car Sales Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows64,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales=',num2str(meanUsedCarSalesVal,6),...
    '-Median Sales =',num2str(medianUsedCarSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.UsedCarSalesTT=UsedCarSalesTT;
Chap(64,1)=7;
Section(64,1)=5;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=64;
% Calculate the smoothed Used Car Sales
salessmooth = smoothdata(UsedCarSalesTT.UsedCars);
P0=salessmooth(1);
PF=salessmooth(401);
UsedCarSalesTT = addvars(UsedCarSalesTT,salessmooth);
NYears=EndYear(64,1)-StartYear(64,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG64=100*GrowthRateAll(itype,1);
FRObj.SG64=SG64;
% Calculate simple stats
Data=UsedCarSalesTT.UsedCars;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the InventorySalesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [UsedCarSalesTT,icase] = OverlapTimeLinesRev1(UsedCarSalesTT,RecessProbTT);
     FRObj.UsedCarSalesTT=UsedCarSalesTT;
     RecessionInfo(64,1)=icase;
end
FRObj.barval=10;
FRObj.UsedCarSalesTT=UsedCarSalesTT;
% Plot this data
titlestr='RetailUsedCarSales';
PlotFredData(FRObj,UsedCarSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{64,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RetailUsedCarSales-CumilDistribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Restaurant Sales(MRTSSM7225USN)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
RestaurantSalesTable = readtable(fredfile65,'Sheet','Monthly');
[nrows65,~]=size(RestaurantSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows65,1);
for n=1:nrows65
    nowstr=string(RestaurantSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RestaurantSalesTT=table2timetable(RestaurantSalesTable,'RowTimes','Date');
RestaurantSalesTT = addvars(RestaurantSalesTT,DateNumbers);
meanRSalesVal=mean(RestaurantSalesTT.Expenses,'omitnan');
medianRSalesVal=median(RestaurantSalesTT.Expenses,'omitnan');
maxRSalesVal=max(RestaurantSalesTT.Expenses,[],'omitnan');
meanRSales=zeros(nrows65,1);
medianRSales=zeros(nrows65,1);
maxRSales=zeros(nrows65,1);
for n=1:nrows65
    meanRSales(n,1)=meanRSalesVal;
    medianRSales(n,1)=medianRSalesVal;
    maxRSales(n,1)=maxRSalesVal;
end
RestaurantSalesTT= addvars(RestaurantSalesTT,meanRSales,medianRSales,maxRSales);
SourceFile(65,1)="RestuarantSales.xlsx";
Code(65,1)="MRTSSM7225USN";
Desc(65,1)="RestaurantSales";
Freq(65,1)="Monthly";
StartYear(65,1)=1992;
EndYear(65,1)=2025;
SeasonalAdj(65,1)="No";
BaseYear(65,1)=1992;
NumObs(65,1)=401;
loopstr5='Process Retail Restaurant Sales Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows65,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales=',num2str(meanRSalesVal,6),...
    '-Median Sales =',num2str(medianRSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.RestaurantSalesTT=RestaurantSalesTT;
Chap(65,1)=7;
Section(65,1)=6;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=65;
% Calculate the smoothed Restaurant Sales
restsmooth = smoothdata(RestaurantSalesTT.Expenses);
P0=restsmooth(1);
PF=restsmooth(401);
RestaurantSalesTT = addvars(RestaurantSalesTT,restsmooth);
NYears=EndYear(65,1)-StartYear(65,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG65=100*GrowthRateAll(itype,1);
FRObj.SG65=SG65;

% Calculate simple stats
Data=RestaurantSalesTT.Expenses;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the CompHousesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [RestaurantSalesTT,icase] = OverlapTimeLinesRev1(RestaurantSalesTT,RecessProbTT);
     FRObj.RestaurantSalesTT=RestaurantSalesTT;
     RecessionInfo(65,1)=icase;
end
FRObj.barval=40;
FRObj.RestaurantSalesTT=RestaurantSalesTT;
titlestr='RestaurantSales';
PlotFredData(FRObj,RestaurantSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{65,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RestaurantSales-CumilDistribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Furniture Sales(RSFHFS)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FurnitureSalesTable = readtable(fredfile66,'Sheet','Monthly');
[nrows66,~]=size(FurnitureSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows66,1);
for n=1:nrows66
    nowstr=string(FurnitureSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FurnitureSalesTT=table2timetable(FurnitureSalesTable,'RowTimes','Date');
FurnitureSalesTT = addvars(FurnitureSalesTT,DateNumbers);
meanFSalesVal=mean(FurnitureSalesTT.Hfurn,'omitnan');
medianFSalesVal=median(FurnitureSalesTT.Hfurn,'omitnan');
maxFSalesVal=max(FurnitureSalesTT.Hfurn,[],'omitnan');
meanFSales=zeros(nrows66,1);
medianFSales=zeros(nrows66,1);
maxFSales=zeros(nrows66,1);
for n=1:nrows66
    meanFSales(n,1)=meanFSalesVal;
    medianFSales(n,1)=medianFSalesVal;
    maxFSales(n,1)=maxFSalesVal;
end
FurnitureSalesTT= addvars(FurnitureSalesTT,meanFSales,medianFSales,maxFSales);
SourceFile(66,1)="FurnitureSales.xlsx";
Code(66,1)="RSFHFS";
Desc(66,1)="FurnitureSales";
Freq(66,1)="Monthly";
StartYear(66,1)=1992;
EndYear(66,1)=2025;
SeasonalAdj(66,1)="Yes";
BaseYear(66,1)=1992;
NumObs(66,1)=402;
loopstr5='Process Retail Furniture Sales Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows66,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales=',num2str(meanFSalesVal,6),...
    '-Median Sales =',num2str(medianFSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FurnitureSalesTT=FurnitureSalesTT;
Chap(66,1)=7;
Section(66,1)=7;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now pull of the Recession Probability data that matches the available
% time points in the CompHousesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [FurnitureSalesTT,icase] = OverlapTimeLinesRev1(FurnitureSalesTT,RecessProbTT);
     FRObj.FurnitureSalesTT=FurnitureSalesTT;
     RecessionInfo(66,1)=icase;
end
FRObj.barval=5;
FRObj.FurnitureSalesTT=FurnitureSalesTT;
% Plot Data
% Now plot this data
itype=66;
% Calculate the smoothed Furniture Sales
furnsmooth = smoothdata(FurnitureSalesTT.Hfurn);
P0=furnsmooth(1);
PF=furnsmooth(401);
FurnitureSalesTT = addvars(FurnitureSalesTT,furnsmooth);
NYears=EndYear(66,1)-StartYear(66,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG66=100*GrowthRateAll(itype,1);
FRObj.SG66=SG66;
titlestr='FurnitureSales';
% Calculate simple stats
Data=FurnitureSalesTT.Hfurn;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,FurnitureSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{66,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FurnitureSales-CumilDistribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Manufacturing Sales(CMRMTSPL)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
ManufacturingSalesTable = readtable(fredfile67,'Sheet','Monthly');
[nrows67,~]=size(ManufacturingSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows67,1);
for n=1:nrows67
    nowstr=string(ManufacturingSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ManufacturingSalesTT=table2timetable(ManufacturingSalesTable,'RowTimes','Date');
ManufacturingSalesTT = addvars(ManufacturingSalesTT,DateNumbers);
meanMSalesVal=mean(ManufacturingSalesTT.Sales,'omitnan');
medianMSalesVal=median(ManufacturingSalesTT.Sales,'omitnan');
maxMSalesVal=max(ManufacturingSalesTT.Sales,[],'omitnan');
meanMSales=zeros(nrows67,1);
medianMSales=zeros(nrows67,1);
maxMSales=zeros(nrows67,1);
for n=1:nrows67
    meanMSales(n,1)=meanMSalesVal;
    medianMSales(n,1)=medianMSalesVal;
    maxMSales(n,1)=maxMSalesVal;
end
ManufacturingSalesTT= addvars(ManufacturingSalesTT,meanMSales,medianMSales,maxMSales);
SourceFile(67,1)="ManufacturingSales.xlsx";
Code(67,1)="CMRMTSPL";
Desc(67,1)="ManufacturingSales";
Freq(67,1)="Monthly";
StartYear(67,1)=1967;
EndYear(67,1)=2025;
SeasonalAdj(67,1)="Yes";
BaseYear(67,1)=2017;
NumObs(67,1)=701;
loopstr5='Process Manufacturing And Trade Sales Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows67,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales=',num2str(meanMSalesVal,8),...
    '-Median Sales =',num2str(medianMSalesVal,8));
fprintf(fid,'%10s\n',loopstr7);
FRObj.ManufacturingSalesTT=ManufacturingSalesTT;
Chap(67,1)=7;
Section(67,1)=8;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=67;
% Calculate the smoothed Manufacturing Sales
mansmooth = smoothdata(ManufacturingSalesTT.Sales);
P0=mansmooth(1);
PF=mansmooth(701);
ManufacturingSalesTT = addvars(ManufacturingSalesTT,mansmooth);
NYears=EndYear(67,1)-StartYear(67,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG67=100*GrowthRateAll(itype,1);
FRObj.SG67=SG67;
% Calculate simple stats
Data=ManufacturingSalesTT.Sales;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the Manufacturing SalesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [ManufacturingSalesTT,icase] = OverlapTimeLinesRev1(ManufacturingSalesTT,RecessProbTT);
     FRObj.ManufacturingSalesTT=ManufacturingSalesTT;
     RecessionInfo(67,1)=icase;
end
FRObj.barval=1;
FRObj.ManufacturingSalesTT=ManufacturingSalesTT;

titlestr='ManufacturingSales';
PlotFredData(FRObj,ManufacturingSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{67,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ManufacturingSales-CumilDistribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Dealer Sales Of New Cars (MRTSSM44111USN)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
NewCarTable = readtable(fredfile68,'Sheet','Monthly');
[nrows68,~]=size(UsedCarTable);
clear DateNumbers dateArray
dateArray=strings(nrows68,1);
for n=1:nrows68
    nowstr=string(UsedCarTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
NewCarSalesTT=table2timetable(NewCarTable,'RowTimes','Date');
NewCarSalesTT = addvars(NewCarSalesTT,DateNumbers);
meanNewCarSalesVal=mean(NewCarSalesTT.NewCars,'omitnan');
medianNewCarSalesVal=median(NewCarSalesTT.NewCars,'omitnan');
maxNewCarSalesVal=max(NewCarSalesTT.NewCars,[],'omitnan');
meanNewCarSales=zeros(nrows68,1);
medianNewCarSales=zeros(nrows68,1);
maxNewCarSales=zeros(nrows68,1);
for n=1:nrows68
    meanNewCarSales(n,1)=meanNewCarSalesVal;
    medianNewCarSales(n,1)=medianNewCarSalesVal;
    maxNewCarSales(n,1)=maxNewCarSalesVal;
end
NewCarSalesTT= addvars(NewCarSalesTT,meanNewCarSales,medianNewCarSales,maxNewCarSales);
SourceFile(68,1)="NewCarSales.xlsx";
Code(68,1)="MRTSSM44111USN";
Desc(68,1)="DealerNewCarSales";
Freq(68,1)="Monthly";
StartYear(68,1)=1992;
EndYear(68,1)=2025;
SeasonalAdj(68,1)="No";
BaseYear(68,1)=1992;
NumObs(68,1)=401;
loopstr5='Process Dealer New Car Sales Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows68,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales=',num2str(meanNewCarSalesVal,6),...
    '-Median Sales =',num2str(medianNewCarSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.NewCarSalesTT=NewCarSalesTT;
Chap(68,1)=7;
Section(68,1)=9;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=68;
% Calculate the smoothed New Car Sales 
carsmooth = smoothdata(NewCarSalesTT.NewCars);
P0=carsmooth(1);
PF=carsmooth(401);
NewCarSalesTT = addvars(NewCarSalesTT,carsmooth);
NYears=EndYear(68,1)-StartYear(68,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG68=100*GrowthRateAll(itype,1);
FRObj.SG68=SG68;
titlestr='DealerNewCarSales';
% Calculate simple stats
Data=NewCarSalesTT.NewCars;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the NewCarSalesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [NewCarSalesTT,icase] = OverlapTimeLinesRev1(NewCarSalesTT,RecessProbTT);
     FRObj.NewCarSalesTT=NewCarSalesTT;
     RecessionInfo(68,1)=icase;
end
FRObj.barval=80;
FRObj.NewCarSalesTT=NewCarSalesTT;
PlotFredData(FRObj,NewCarSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{68,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='NewCarSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Full Serve Restaurants Sales (SM722511USN)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FullServeRestaurantsTable = readtable(fredfile69,'Sheet','Monthly');
[nrows69,~]=size(FullServeRestaurantsTable);
clear DateNumbers dateArray
dateArray=strings(nrows69,1);
for n=1:nrows69
    nowstr=string(FullServeRestaurantsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FullServeRestaurantsTT=table2timetable(FullServeRestaurantsTable,'RowTimes','Date');
FullServeRestaurantsTT = addvars(FullServeRestaurantsTT,DateNumbers);
meanRestSalesVal=mean(FullServeRestaurantsTT.Sales,'omitnan');
medianRestSalesVal=median(FullServeRestaurantsTT.Sales,'omitnan');
maxRestSalesVal=max(FullServeRestaurantsTT.Sales,[],'omitnan');
meanRestSales=zeros(nrows69,1);
medianRestSales=zeros(nrows69,1);
maxRestSales=zeros(nrows69,1);
for n=1:nrows69
    meanRestSales(n,1)=meanRestSalesVal;
    medianRestSales(n,1)=medianSalesVal;
    maxRestSales(n,1)=maxRestSalesVal;
end
FullServeRestaurantsTT= addvars(FullServeRestaurantsTT,meanRestSales,medianRestSales,maxRestSales);
SourceFile(69,1)="FullServeRestaurants.xlsx";
Code(69,1)="MRTSSM7221USN";
Desc(69,1)="FullServeRestaurantSales";
Freq(69,1)="Monthly";
StartYear(69,1)=1992;
EndYear(69,1)=2025;
SeasonalAdj(69,1)="No";
BaseYear(69,1)=1992;
NumObs(69,1)=337;
loopstr5='Process Full Serve Restaurant Sales';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows69,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Sales=',num2str(meanRestSalesVal,6),...
    '-Median Sales =',num2str(medianRestSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FullServeRestaurantsTT=FullServeRestaurantsTT;
Chap(69,1)=7;
Section(69,1)=10;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=69;
% Calculate the smoothed Restaurant Sales
restsmooth = smoothdata(FullServeRestaurantsTT.Sales);
P0=restsmooth(1);
PF=restsmooth(337);
FullServeRestaurantsTT = addvars(FullServeRestaurantsTT,restsmooth);
NYears=EndYear(69,1)-StartYear(69,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG69=100*GrowthRateAll(itype,1);
FRObj.SG69=SG69;
% Now pull of the Recession Probability data that matches the available
% time points in the FullServeRestaurantsTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [FullServeRestaurantsTT,icase] = OverlapTimeLinesRev1(FullServeRestaurantsTT,RecessProbTT);
     FRObj.FullServeRestaurantsTT=FullServeRestaurantsTT;
     RecessionInfo(69,1)=icase;
end
FRObj.barval=30;
FRObj.FullServeRestaurantsTT=FullServeRestaurantsTT;
titlestr='FullServeRestaurantSales';
% Calculate simple stats
Data=FullServeRestaurantsTT.Sales;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,FullServeRestaurantsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{69,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FullServeRest-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Retail Gas Sales (MRTSSM447USN)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
GasSalesTable = readtable(fredfile70,'Sheet','Monthly');
[nrows70,~]=size(GasSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows70,1);
for n=1:nrows70
    nowstr=string(GasSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
GasSalesTT=table2timetable(GasSalesTable,'RowTimes','Date');
GasSalesTT = addvars(GasSalesTT,DateNumbers);
meanGasSalesVal=mean(GasSalesTT.Gas,'omitnan');
medianGasSalesVal=median(GasSalesTT.Gas,'omitnan');
maxGasSalesVal=max(GasSalesTT.Gas,[],'omitnan');
meanGasSales=zeros(nrows70,1);
medianGasSales=zeros(nrows70,1);
maxGasSales=zeros(nrows70,1);
for n=1:nrows70
    meanGasSales(n,1)=meanGasSalesVal;
    medianGasSales(n,1)=medianGasSalesVal;
    maxGasSales(n,1)=maxGasSalesVal;
end
GasSalesTT= addvars(GasSalesTT,meanGasSales,medianGasSales,maxGasSales);
SourceFile(70,1)="RetailGasSales.xlsx";
Code(70,1)="MRTSSM447USN";
Desc(70,1)="GasSales";
Freq(70,1)="Monthly";
StartYear(70,1)=1992;
EndYear(70,1)=2025;
SeasonalAdj(70,1)="No";
BaseYear(70,1)=1992;
NumObs(70,1)=401;
loopstr5='Process Retail Gas Sales';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows70,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Gas Sales=',num2str(meanGasSalesVal,6),...
    '-Median Gas Sales =',num2str(medianGasSalesVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.GasSalesTT=GasSalesTT;
Chap(70,1)=7;
Section(70,1)=11;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=70;
% Calculate the smoothed Retail Gas Sales 
gassmooth = smoothdata(GasSalesTT.Gas);
P0=gassmooth(1);
PF=gassmooth(401);
GasSalesTT = addvars(GasSalesTT,gassmooth);
NYears=EndYear(70,1)-StartYear(70,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG70=100*GrowthRateAll(itype,1);
FRObj.SG70=SG70;
% Now pull of the Recession Probability data that matches the available
% time points in the CompHousesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [GasSalesTT,icase] = OverlapTimeLinesRev1(GasSalesTT,RecessProbTT);
     FRObj.GasSalesTT=GasSalesTT;
     RecessionInfo(70,1)=icase;
end
FRObj.barval=30;
FRObj.GasSalesTT=GasSalesTT;
titlestr='RetailGasSales';
% Calculate simple stats
Data=GasSalesTT.Gas;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,GasSalesTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{70,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RetailGasSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Retail Auto Parts (MRTSSM441USS)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
AutoPartsTable = readtable(fredfile71,'Sheet','Monthly');
[nrows71,~]=size(GasSalesTable);
clear DateNumbers dateArray
dateArray=strings(nrows71,1);
for n=1:nrows71
    nowstr=string(AutoPartsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
AutoPartsTT=table2timetable(AutoPartsTable,'RowTimes','Date');
AutoPartsTT = addvars(AutoPartsTT,DateNumbers);
meanAutoPartsVal=mean(AutoPartsTT.Parts,'omitnan');
medianAutoPartsVal=median(AutoPartsTT.Parts,'omitnan');
maxAutoPartsVal=max(AutoPartsTT.Parts,[],'omitnan');
meanAutoParts=zeros(nrows71,1);
medianAutoParts=zeros(nrows71,1);
maxAutoParts=zeros(nrows71,1);
for n=1:nrows71
    meanAutoParts(n,1)=meanAutoPartsVal;
    medianAutoParts(n,1)=medianAutoPartsVal;
    maxAutoParts(n,1)=maxAutoPartsVal;
end
AutoPartsTT= addvars(AutoPartsTT,meanAutoParts,medianAutoParts,maxAutoParts);
SourceFile(71,1)="RetailAutoParts.xlsx";
Code(71,1)="MRTSSM441USS";
Desc(71,1)="AutoPartsSales";
Freq(71,1)="Monthly";
StartYear(71,1)=1992;
EndYear(71,1)=2025;
SeasonalAdj(71,1)="Yes";
BaseYear(71,1)=1992;
NumObs(71,1)=401;
loopstr5='Process Retail Auto Parts Sales';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows71,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Parts Sales=',num2str(meanAutoPartsVal,6),...
    '-Median Parts Sales =',num2str(medianAutoPartsVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.AutoPartsTT=AutoPartsTT;
Chap(71,1)=7;
Section(71,1)=12;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=71;
% Calculate the smoothed Auto Parts Sales 
autopartssmooth = smoothdata(AutoPartsTT.Parts);
P0=autopartssmooth(1);
PF=autopartssmooth(401);
AutoPartsTT = addvars(AutoPartsTT,autopartssmooth);
NYears=EndYear(71,1)-StartYear(71,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG71=100*GrowthRateAll(itype,1);
FRObj.SG71=SG71;
% Calculate simple stats
Data=AutoPartsTT.Parts;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the CompHousesTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [AutoPartsTT,icase] = OverlapTimeLinesRev1(AutoPartsTT,RecessProbTT);
     FRObj.AutoPartsTT=AutoPartsTT;
     RecessionInfo(71,1)=icase;
end
FRObj.barval=100;
FRObj.AutoPartsTT=AutoPartsTT;
titlestr='RetailAutoPartsSales';
PlotFredData(FRObj,AutoPartsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{71,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='AutoPartSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Leading Indicator(USSLIND)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
LeadIndexTable = readtable(fredfile72,'Sheet','Monthly');
[nrows72,~]=size(LeadIndexTable);
clear DateNumbers dateArray
dateArray=strings(nrows72,1);
for n=1:nrows72
    nowstr=string(LeadIndexTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
LeadIndexTT=table2timetable(LeadIndexTable,'RowTimes','Date');
LeadIndexTT = addvars(LeadIndexTT,DateNumbers);
meanLIVal=mean(LeadIndexTT.Index,'omitnan');
medianLIVal=median(LeadIndexTT.Index,'omitnan');
maxLIVal=max(LeadIndexTT.Index,[],'omitnan');
meanLI=zeros(nrows72,1);
medianLI=zeros(nrows72,1);
maxLI=zeros(nrows72,1);
for n=1:nrows72
    meanLI(n,1)=meanLIVal;
    medianLI(n,1)=medianLIVal;
    maxLI(n,1)=maxLIVal;
end
LeadIndexTT= addvars(LeadIndexTT,meanLI,medianLI,maxLI);
SourceFile(72,1)="LeadingIndex.xlsx";
Code(72,1)="USSLIND";
Desc(72,1)="LeadIndex";
Freq(72,1)="Monthly";
StartYear(72,1)=1982;
EndYear(72,1)=2020;
SeasonalAdj(72,1)="Yes";
BaseYear(72,1)=1982;
NumObs(72,1)=458;
loopstr5='Process Leading Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows72,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean LI=',num2str(meanLIVal,4),...
    '-Median LI =',num2str(medianLIVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.LeadIndexTT=LeadIndexTT;
Chap(72,1)=8;
Section(72,1)=1;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=72;
% Calculate the smoothed Leading Index Values 
leadsmooth = smoothdata(LeadIndexTT.Index);
P0=leadsmooth(1);
PF=leadsmooth(401);
LeadIndexTT = addvars(LeadIndexTT,leadsmooth);
titlestr='LeadingIndex';
% Calculate simple stats
Data=LeadIndexTT.Index;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,LeadIndexTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{72,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='USLeadingIndex-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)


%% Continue with CoIncident Economic Indicators(USPHCI)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CoEconomicActivityTable = readtable(fredfile74,'Sheet','Monthly');
[nrows74,~]=size(CoEconomicActivityTable);
clear DateNumbers dateArray
dateArray=strings(nrows74,1);
for n=1:nrows74
    nowstr=string(CoEconomicActivityTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CoEconomicActivityTT=table2timetable(CoEconomicActivityTable,'RowTimes','Date');
CoEconomicActivityTT = addvars(CoEconomicActivityTT,DateNumbers);
meanIndicatorVal=mean(CoEconomicActivityTT.Indicator,'omitnan');
medianIndicatorVal=median(CoEconomicActivityTT.Indicator,'omitnan');
maxIndicatorVal=max(CoEconomicActivityTT.Indicator,[],'omitnan');
meanIndicator=zeros(nrows74,1);
medianIndicator=zeros(nrows74,1);
maxIndicator=zeros(nrows74,1);
for n=1:nrows74
    meanIndicator(n,1)=meanIndicatorVal;
    medianIndicator(n,1)=medianIndicatorVal;
    maxIndicator(n,1)=maxIndicatorVal;
end
CoEconomicActivityTT= addvars(CoEconomicActivityTT,meanIndicator,medianIndicator,maxIndicator);
SourceFile(74,1)="CoIncidentEconomicActivity.xlsx";
Code(74,1)="USPHCI";
Desc(74,1)="CoIncidentEconomicActivity";
Freq(74,1)="Monthly";
StartYear(74,1)=1979;
EndYear(74,1)=2025;
SeasonalAdj(74,1)="Yes";
BaseYear(74,1)=2007;
NumObs(74,1)=558;
loopstr5='Process CoIncidentEconomic Activity';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows74,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Indicator=',num2str(meanIndicatorVal,4),...
    '-Median Indicator =',num2str(medianIndicatorVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CoEconomicActivityTT=CoEconomicActivityTT;
Chap(74,1)=8;
Section(74,1)=3;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=74;
% Calculate simple stats
% Calculate the smoothed CoIncident Economic Index Values 
Data=CoEconomicActivityTT.Indicator;
coeasmooth = smoothdata(Data);
P0=coeasmooth(1);
PF=coeasmooth(558);
CoEconomicActivityTT = addvars(CoEconomicActivityTT,coeasmooth);
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='CoincidentEconomicActivity';
PlotFredData(FRObj,CoEconomicActivityTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{74,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CoIncidentIndex-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Bank Balance Sheets(QBPBSTAS)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
BalanceSheetsTable = readtable(fredfile75,'Sheet','Quarterly');
[nrows75,~]=size(BalanceSheetsTable);
clear DateNumbers dateArray
dateArray=strings(nrows75,1);
for n=1:nrows75
    nowstr=string(BalanceSheetsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
BankBalanceTT=table2timetable(BalanceSheetsTable,'RowTimes','Date');
BankBalanceTT = addvars(BankBalanceTT,DateNumbers);
meanBankAssetsVal=mean(BankBalanceTT.Assets,'omitnan');
medianBankAssetsVal=median(BankBalanceTT.Assets,'omitnan');
maxBankAssetsVal=max(BankBalanceTT.Assets,[],'omitnan');
meanBankAssets=zeros(nrows75,1);
medianBankAssets=zeros(nrows75,1);
maxBankAssets=zeros(nrows75,1);
for n=1:nrows75
    meanBankAssets(n,1)=meanBankAssetsVal;
    medianBankAssets(n,1)=medianBankAssetsVal;
    maxBankAssets(n,1)=maxBankAssetsVal;
end
BankBalanceTT= addvars(BankBalanceTT,meanBankAssets,medianBankAssets,maxBankAssets);
SourceFile(75,1)="BalanceSheets.xlsx";
Code(75,1)="QBPBSTAS";
Desc(75,1)="BankTotalAssets";
Freq(75,1)="Quarterly";
StartYear(75,1)=1984;
EndYear(75,1)=2025;
SeasonalAdj(75,1)="No";
BaseYear(75,1)=1984;
NumObs(75,1)=165;
loopstr5='Process Total Bank Assets';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows75,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Assets=',num2str(meanBankAssetsVal,8),...
    '-Median Assets =',num2str(medianBankAssetsVal,8));
fprintf(fid,'%10s\n',loopstr7);
FRObj.BankBalanceTT=BankBalanceTT;
Chap(75,1)=8;
Section(75,1)=4;
FRObj.Chap=Chap;
FRObj.Section=Section;
itype=75;
% Calculate the smoothed Bank Balance Values 
Data=BankBalanceTT.Assets;
bbalsmooth = smoothdata(Data);
P0=bbalsmooth(1);
PF=bbalsmooth(165);
BankBalanceTT = addvars(BankBalanceTT,bbalsmooth);
% Now plot this data
% P0=BankBalanceTT.Assets(1);
% PF=BankBalanceTT.Assets(165);
NYears=EndYear(75,1)-StartYear(75,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG75=100*GrowthRateAll(itype,1);
FRObj.SG75=SG75;
% Calculate simple stats
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='TotalBankAssets';
PlotFredData(FRObj,BankBalanceTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{75,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='BankBalance-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with CreditCardDebt(QBPBSTASLNINDVCRD)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CreditCardTable = readtable(fredfile76,'Sheet','Quarterly');
[nrows76,~]=size(CreditCardTable);
clear DateNumbers dateArray
dateArray=strings(nrows76,1);
for n=1:nrows76
    nowstr=string(CreditCardTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CreditCardTT=table2timetable(CreditCardTable,'RowTimes','Date');
CreditCardTT = addvars(CreditCardTT,DateNumbers);
meanCreditDebtVal=mean(CreditCardTT.Balance,'omitnan');
medianCreditDebtVal=median(CreditCardTT.Balance,'omitnan');
maxCreditDebtVal=max(CreditCardTT.Balance,[],'omitnan');
meanCreditDebt=zeros(nrows76,1);
medianCreditDebt=zeros(nrows76,1);
maxCreditDebt=zeros(nrows76,1);
for n=1:nrows76
    meanCreditDebt(n,1)=meanCreditDebtVal;
    medianCreditDebt(n,1)=medianCreditDebtVal;
    maxCreditDebt(n,1)=maxCreditDebtVal;
end
CreditCardTT= addvars(CreditCardTT,meanCreditDebt,medianCreditDebt,maxCreditDebt);
SourceFile(76,1)="CreditCardDebt.xlsx";
Code(76,1)="QBPBSTASLNINDVCRD";
Desc(76,1)="CreditCardDebt";
Freq(76,1)="Quarterly";
StartYear(76,1)=1984;
EndYear(76,1)=2025;
SeasonalAdj(76,1)="No";
BaseYear(76,1)=1984;
NumObs(76,1)=165;
loopstr5='Process Total Credit Card Debt';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows76,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Credit Debt=',num2str(meanCreditDebtVal,4),...
    '-Median Assets =',num2str(medianCreditDebtVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CreditCardTT=CreditCardTT;
Chap(76,1)=8;
Section(76,1)=5;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=76;
creditsmooth = smoothdata(CreditCardTT.Balance);
CreditCardTT= addvars(CreditCardTT,creditsmooth);
P0=creditsmooth(1);
PF=creditsmooth(165);
NYears=EndYear(76,1)-StartYear(76,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG76=100*GrowthRateAll(itype,1);
FRObj.SG76=SG76;
% Calculate simple stats
Data=CreditCardTT.Balance;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='TotalCreditCardDebt';
PlotFredData(FRObj,CreditCardTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{76,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CCDebt-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Loan Performance(QBPLNTLNNCUR)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
LoanPerfTable = readtable(fredfile77,'Sheet','Quarterly');
[nrows77,~]=size(LoanPerfTable);
clear DateNumbers dateArray
dateArray=strings(nrows77,1);
for n=1:nrows77
    nowstr=string(LoanPerfTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
LoanPerfTT=table2timetable(LoanPerfTable,'RowTimes','Date');
LoanPerfTT = addvars(LoanPerfTT,DateNumbers);
meanLPerfVal=mean(LoanPerfTT.Performance,'omitnan');
medianLPerfVal=median(LoanPerfTT.Performance,'omitnan');
maxLPerfVal=max(LoanPerfTT.Performance,[],'omitnan');
meanLPerf=zeros(nrows77,1);
medianLPerf=zeros(nrows77,1);
maxLPerf=zeros(nrows77,1);
for n=1:nrows77
    meanLPerf(n,1)=meanLPerfVal;
    medianLPerf(n,1)=medianLPerfVal;
    maxLPerf(n,1)=maxLPerfVal;
end
LoanPerfTT= addvars(LoanPerfTT,meanLPerf,medianLPerf,maxLPerf);
SourceFile(77,1)="LoanPerformance.xlsx";
Code(77,1)="QBPLNTLNNCUR";
Desc(77,1)="LoanPerformance";
Freq(77,1)="Quarterly";
StartYear(77,1)=1984;
EndYear(77,1)=2025;
SeasonalAdj(77,1)="No";
BaseYear(77,1)=1984;
NumObs(77,1)=165;
loopstr5='Process Loan Performance';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows77,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Non Perf Loans=',num2str(meanLPerfVal,4),...
    '-Median Non Perf Loans =',num2str(medianLPerfVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.LoanPerfTT=LoanPerfTT;
Chap(77,1)=8;
Section(77,1)=6;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=77;
% Calculate simple stats
Data=LoanPerfTT.Performance;
loansmooth = smoothdata(Data);
LoanPerfTT= addvars(LoanPerfTT,loansmooth);
P0=loansmooth(1);
PF=loansmooth(165);
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='PerCentNonPerformingLoans';
PlotFredData(FRObj,LoanPerfTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{77,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='NonPerfLoans-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with US Population(POPTHM)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PopulationTable = readtable(fredfile78,'Sheet','Monthly');
[nrows78,~]=size(PopulationTable);
clear DateNumbers dateArray
dateArray=strings(nrows78,1);
for n=1:nrows78
    nowstr=string(PopulationTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PopulationTT=table2timetable(PopulationTable,'RowTimes','Date');
PopulationTT = addvars(PopulationTT,DateNumbers);
meanPopVal=mean(PopulationTT.Pop,'omitnan');
medianPopVal=median(PopulationTT.Pop,'omitnan');
maxPopVal=max(PopulationTT.Pop,[],'omitnan');
meanPop=zeros(nrows78,1);
medianPop=zeros(nrows78,1);
maxPop=zeros(nrows78,1);
for n=1:nrows78
    meanPop(n,1)=meanPopVal;
    medianPop(n,1)=medianPopVal;
    maxPop(n,1)=maxPopVal;
end
PopulationTT= addvars(PopulationTT,meanPop,medianPop,maxPop);
SourceFile(78,1)="Population.xlsx";
Code(78,1)="POPTHM";
Desc(78,1)="US Population";
Freq(78,1)="Monthly";
StartYear(78,1)=1959;
EndYear(78,1)=2025;
SeasonalAdj(78,1)="No";
BaseYear(78,1)=1959;
NumObs(78,1)=798;
loopstr5='Process US Population';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows78,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Population=',num2str(meanPopVal,6),...
    '-Median Population =',num2str(medianPopVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.PopulationTT=PopulationTT;
Chap(78,1)=9;
Section(78,1)=1;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=78;
P0=PopulationTT.Pop(1);
PF=PopulationTT.Pop(798);
NYears=EndYear(78,1)-StartYear(78,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG78=100*GrowthRateAll(itype,1);
FRObj.SG78=SG78;
% Calculate simple stats
Data=PopulationTT.Pop;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='US-Population';
PlotFredData(FRObj,PopulationTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{78,1}=figstr2;

%% Continue with Total HouseHolds (TTLHH)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
TotHouseHoldsTable = readtable(fredfile79,'Sheet','Annual');
[nrows79,~]=size(TotHouseHoldsTable);
clear DateNumbers dateArray
dateArray=strings(nrows79,1);
for n=1:nrows79
    nowstr=string(TotHouseHoldsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TotHouseHoldsTT=table2timetable(TotHouseHoldsTable,'RowTimes','Date');
TotHouseHoldsTT = addvars(TotHouseHoldsTT,DateNumbers);
meanHHVal=mean(TotHouseHoldsTT.Households,'omitnan');
medianHHVal=median(TotHouseHoldsTT.Households,'omitnan');
maxHHVal=max(TotHouseHoldsTT.Households,[],'omitnan');
meanHH=zeros(nrows79,1);
medianHH=zeros(nrows79,1);
maxHH=zeros(nrows79,1);
for n=1:nrows79
    meanHH(n,1)=meanHHVal;
    medianHH(n,1)=medianHHVal;
    maxHH(n,1)=maxHHVal;
end
TotHouseHoldsTT= addvars(TotHouseHoldsTT,meanHH,medianHH,maxHH);
SourceFile(79,1)="TotalHouseHolds.xlsx";
Code(79,1)="TTLHH";
Desc(79,1)="Total US Households";
Freq(79,1)="Annual";
StartYear(79,1)=1940;
EndYear(79,1)=2024;
SeasonalAdj(79,1)="No";
BaseYear(79,1)=1940;
NumObs(79,1)=85;
loopstr5='Process Total US Households';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows79,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Households=',num2str(meanHHVal,6),...
    '-Median Households =',num2str(medianHHVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.TotHouseHoldsTT=TotHouseHoldsTT;
Chap(79,1)=9;
Section(79,1)=2;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=79;
P0=TotHouseHoldsTT.Households(1);
PF=TotHouseHoldsTT.Households(85);
NYears=EndYear(79,1)-StartYear(79,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG79=100*GrowthRateAll(itype,1);
FRObj.SG79=SG79;
titlestr='US-TotalHouseHolds';
PlotFredData(FRObj,TotHouseHoldsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{79,1}=figstr2;

%% Continue with US Population 55 and over (LNU00024230)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
POP55Table = readtable(fredfile80,'Sheet','Monthly');
[nrows80,~]=size(POP55Table);
clear DateNumbers dateArray
dateArray=strings(nrows80,1);
for n=1:nrows80
    nowstr=string(POP55Table.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
POP55TT=table2timetable(POP55Table,'RowTimes','Date');
POP55TT = addvars(POP55TT,DateNumbers);
meanP55Val=mean(POP55TT.POP55,'omitnan');
medianP55Val=median(POP55TT.POP55,'omitnan');
maxP55Val=max(POP55TT.POP55,[],'omitnan');
meanP55=zeros(nrows80,1);
medianP55=zeros(nrows80,1);
maxP55=zeros(nrows80,1);
for n=1:nrows80
    meanP55(n,1)=meanP55Val;
    medianP55(n,1)=medianP55Val;
    maxP55(n,1)=maxP55Val;
end
POP55TT= addvars(POP55TT,meanP55,medianP55,maxP55);
SourceFile(80,1)="POP55.xlsx";
Code(80,1)="LNU00024230";
Desc(80,1)="US POP Over 55";
Freq(80,1)="Monthly";
StartYear(80,1)=1948;
EndYear(80,1)=2025;
SeasonalAdj(80,1)="No";
BaseYear(80,1)=1948;
NumObs(80,1)=931;
loopstr5='Process US PoP Over 55';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows80,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Over 55=',num2str(meanP55Val,6),...
    '-Median Over 55 =',num2str(medianP55Val,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.POP55TT=POP55TT;
Chap(80,1)=9;
Section(80,1)=3;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=80;
P0=POP55TT.POP55(1);
PF=POP55TT.POP55(931);
NYears=EndYear(80,1)-StartYear(80,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG80=100*GrowthRateAll(itype,1);
FRObj.SG80=SG80;
% Calculate simple stats
Data=POP55TT.POP55;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='US-PopOver55';
PlotFredData(FRObj,POP55TT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{80,1}=figstr2;

%% Continue with US Population between 25 and 54 (LNU00000060)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
POP2554Table = readtable(fredfile81,'Sheet','Monthly');
[nrows81,~]=size(POP2554Table);
clear DateNumbers dateArray
dateArray=strings(nrows81,1);
for n=1:nrows81
    nowstr=string(POP2554Table.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
POP2554TT=table2timetable(POP2554Table,'RowTimes','Date');
POP2554TT = addvars(POP2554TT,DateNumbers);
meanP2554Val=mean(POP2554TT.Pop,'omitnan');
medianP2554Val=median(POP2554TT.Pop,'omitnan');
maxP2554Val=max(POP2554TT.Pop,[],'omitnan');
meanP2554=zeros(nrows81,1);
medianP2554=zeros(nrows81,1);
maxP2554=zeros(nrows81,1);
for n=1:nrows81
    meanP2554(n,1)=meanP2554Val;
    medianP2554(n,1)=medianP2554Val;
    maxP2554(n,1)=maxP2554Val;
end
POP2554TT= addvars(POP2554TT,meanP2554,medianP2554,maxP2554);
SourceFile(81,1)="POP-25-54.xlsx";
Code(81,1)="LNU00000060";
Desc(81,1)="US POP Between 25 and 54";
Freq(81,1)="Monthly";
StartYear(81,1)=1948;
EndYear(81,1)=2025;
SeasonalAdj(81,1)="No";
BaseYear(81,1)=1948;
NumObs(81,1)=931;
loopstr5='Process US PoP Between 25 and 54';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows81,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean 25 To 54=',num2str(meanP2554Val,6),...
    '-Median 25 to 54=',num2str(medianP2554Val,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.POP2554TT=POP2554TT;
Chap(81,1)=9;
Section(81,1)=4;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=81;
P0=POP2554TT.Pop(1);
PF=POP2554TT.Pop(931);
NYears=EndYear(81,1)-StartYear(81,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG81=100*GrowthRateAll(itype,1);
FRObj.SG81=SG81;
% Calculate simple stats
Data=POP2554TT.Pop;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='US-Pop-25-54';
PlotFredData(FRObj,POP2554TT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{81,1}=figstr2;

%% Continue with US Families With Children Under 18 (TTLFMCU)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FamWChildTable = readtable(fredfile82,'Sheet','Annual');
[nrows82,~]=size(FamWChildTable);
clear DateNumbers dateArray
dateArray=strings(nrows82,1);
for n=1:nrows82
    nowstr=string(FamWChildTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FamWChildTT=table2timetable(FamWChildTable,'RowTimes','Date');
FamWChildTT = addvars(FamWChildTT,DateNumbers);
meanChildVal=mean(FamWChildTT.Children,'omitnan');
medianChildVal=median(FamWChildTT.Children,'omitnan');
maxChildVal=max(FamWChildTT.Children,[],'omitnan');
meanChild=zeros(nrows82,1);
medianChild=zeros(nrows82,1);
maxChild=zeros(nrows82,1);
for n=1:nrows82
    meanChild(n,1)=meanChildVal;
    medianChild(n,1)=medianChildVal;
    maxChild(n,1)=maxChildVal;
end
FamWChildTT= addvars(FamWChildTT,meanChild,medianChild,maxChild);
SourceFile(82,1)="FamiliesWithChildren.xlsx";
Code(82,1)="TTLFMCU";
Desc(82,1)="Families W Children Under 18";
Freq(82,1)="Annual";
StartYear(82,1)=1950;
EndYear(82,1)=2024;
SeasonalAdj(82,1)="No";
BaseYear(82,1)=1950;
NumObs(82,1)=75;
loopstr5='Process US PoP Between 25 and 54';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows82,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Families With Children=',num2str(meanChildVal,6),...
    '-Median =',num2str(medianChildVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FamWChildTT=FamWChildTT;
Chap(82,1)=9;
Section(82,1)=5;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=82;
P0=FamWChildTT.Children(1);
PF=FamWChildTT.Children(75);
NYears=EndYear(82,1)-StartYear(82,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG82=100*GrowthRateAll(itype,1);
FRObj.SG82=SG82;
titlestr='FamiliesLivingWChildren';
PlotFredData(FRObj,FamWChildTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{82,1}=figstr2;

%% Continue with US Black Population (LNU00000006)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
BlackPopTable = readtable(fredfile83,'Sheet','Monthly');
[nrows83,~]=size(BlackPopTable);
clear DateNumbers dateArray
dateArray=strings(nrows83,1);
for n=1:nrows83
    nowstr=string(BlackPopTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
BlackPopTT=table2timetable(BlackPopTable,'RowTimes','Date');
BlackPopTT = addvars(BlackPopTT,DateNumbers);
meanBlackVal=mean(BlackPopTT.BlackPop,'omitnan');
medianBlackVal=median(BlackPopTT.BlackPop,'omitnan');
maxBlackVal=max(BlackPopTT.BlackPop,[],'omitnan');
meanBlack=zeros(nrows83,1);
medianBlack=zeros(nrows83,1);
maxBlack=zeros(nrows83,1);
for n=1:nrows83
    meanBlack(n,1)=meanBlackVal;
    medianBlack(n,1)=medianBlackVal;
    maxBlack(n,1)=maxBlackVal;
end
BlackPopTT= addvars(BlackPopTT,meanBlack,medianBlack,maxBlack);
SourceFile(83,1)="BlackPop.xlsx";
Code(83,1)="LNS12300002";
Desc(83,1)="Black Population";
Freq(83,1)="Monthly";
StartYear(83,1)=1972;
EndYear(83,1)=2025;
SeasonalAdj(83,1)="Yes";
BaseYear(83,1)=1972;
NumObs(83,1)=643;
loopstr5='Process US Black Population';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows83,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Black Population=',num2str(meanBlackVal,6),...
    '-Median =',num2str(medianBlackVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.BlackPopTT=BlackPopTT;
Chap(83,1)=9;
Section(83,1)=6;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=83;
P0=BlackPopTT.BlackPop(1);
PF=BlackPopTT.BlackPop(643);
NYears=EndYear(83,1)-StartYear(83,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG83=100*GrowthRateAll(itype,1);
FRObj.SG83=SG83;
% Calculate simple stats
Data=BlackPopTT.BlackPop;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='BlackPopulation';
PlotFredData(FRObj,BlackPopTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{83,1}=figstr2;

%% Continue with US White Population (LNU00000003)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
WhitePopTable = readtable(fredfile84,'Sheet','Monthly');
[nrows84,~]=size(WhitePopTable);
clear DateNumbers dateArray
dateArray=strings(nrows84,1);
for n=1:nrows84
    nowstr=string(WhitePopTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
WhitePopTT=table2timetable(WhitePopTable,'RowTimes','Date');
WhitePopTT = addvars(WhitePopTT,DateNumbers);
meanWhiteVal=mean(WhitePopTT.WhitePop,'omitnan');
medianWhiteVal=median(WhitePopTT.WhitePop,'omitnan');
maxWhiteVal=max(WhitePopTT.WhitePop,[],'omitnan');
meanWhite=zeros(nrows84,1);
medianWhite=zeros(nrows84,1);
maxWhite=zeros(nrows84,1);
for n=1:nrows84
    meanWhite(n,1)=meanWhiteVal;
    medianWhite(n,1)=medianWhiteVal;
    maxWhite(n,1)=maxWhiteVal;
end
WhitePopTT= addvars(WhitePopTT,meanWhite,medianWhite,maxWhite);
SourceFile(84,1)="WhitePop.xlsx";
Code(84,1)="LNS12300003";
Desc(84,1)="White Population";
Freq(84,1)="Monthly";
StartYear(84,1)=1954;
EndYear(84,1)=2025;
SeasonalAdj(84,1)="No";
BaseYear(84,1)=1954;
NumObs(84,1)=859;
loopstr5='Process US White Population';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows84,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean White Population=',num2str(meanWhiteVal,6),...
    '-Median =',num2str(medianWhiteVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.WhitePopTT=WhitePopTT;
Chap(84,1)=9;
Section(84,1)=7;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=84;
P0=WhitePopTT.WhitePop(1);
PF=WhitePopTT.WhitePop(859);
NYears=EndYear(84,1)-StartYear(84,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG84=100*GrowthRateAll(itype,1);
FRObj.SG84=SG84;
% Calculate simple stats
Data=WhitePopTT.WhitePop;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='WhitePopulation';
PlotFredData(FRObj,WhitePopTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{84,1}=figstr2;

%% Continue with US Hispanic Population ( LNU00000009)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
HispanicPopTable = readtable(fredfile85,'Sheet','Monthly');
[nrows85,~]=size(HispanicPopTable);
clear DateNumbers dateArray
dateArray=strings(nrows85,1);
for n=1:nrows85
    nowstr=string(HispanicPopTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
HispanicPopTT=table2timetable(HispanicPopTable,'RowTimes','Date');
HispanicPopTT = addvars(HispanicPopTT,DateNumbers);
meanHispVal=mean(HispanicPopTT.HispanicPop,'omitnan');
medianHispVal=median(HispanicPopTT.HispanicPop,'omitnan');
maxHispVal=max(HispanicPopTT.HispanicPop,[],'omitnan');
meanHisp=zeros(nrows85,1);
medianHisp=zeros(nrows85,1);
maxHisp=zeros(nrows85,1);
for n=1:nrows85
    meanHisp(n,1)=meanHispVal;
    medianHisp(n,1)=medianHispVal;
    maxHisp(n,1)=maxHispVal;
end
HispanicPopTT= addvars(HispanicPopTT,meanHisp,medianHisp,maxHisp);
SourceFile(85,1)="HispanicPop.xlsx";
Code(85,1)="LNU00000009";
Desc(85,1)="Hispanic Population";
Freq(85,1)="Monthly";
StartYear(85,1)=1973;
EndYear(85,1)=2025;
SeasonalAdj(85,1)="No";
BaseYear(85,1)=1973;
NumObs(85,1)=629;
loopstr5='Process US Hispanic Population';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows85,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Hispanic Population=',num2str(meanHispVal,6),...
    '-Median =',num2str(medianHispVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.HispanicPopTT=HispanicPopTT;
Chap(85,1)=9;
Section(85,1)=8;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=85;
P0=HispanicPopTT.HispanicPop(1);
PF=HispanicPopTT.HispanicPop(629);
NYears=EndYear(85,1)-StartYear(85,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG85=100*GrowthRateAll(itype,1);
FRObj.SG85=SG85;
% Calculate simple stats
Data=HispanicPopTT.HispanicPop;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='HispanicPopulation';
PlotFredData(FRObj,HispanicPopTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{85,1}=figstr2;

%% Continue with US Female Employment Ratio (LNS12300002)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
FemaleERatioTable = readtable(fredfile86,'Sheet','Monthly');
[nrows86,~]=size(FemaleERatioTable);
clear DateNumbers dateArray
dateArray=strings(nrows86,1);
for n=1:nrows86
    nowstr=string(FemaleERatioTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
FemaleERatioTT=table2timetable(FemaleERatioTable,'RowTimes','Date');
FemaleERatioTT = addvars(FemaleERatioTT,DateNumbers);
meanFeRatioVal=mean(FemaleERatioTT.Ratio,'omitnan');
medianFeRatioVal=median(FemaleERatioTT.Ratio,'omitnan');
maxFeRatioVal=max(FemaleERatioTT.Ratio,[],'omitnan');
meanFeRatio=zeros(nrows86,1);
medianFeRatio=zeros(nrows86,1);
maxFeRatio=zeros(nrows86,1);
for n=1:nrows86
    meanFeRatio(n,1)=meanFeRatioVal;
    medianFeRatio(n,1)=medianFeRatioVal;
    maxFeRatio(n,1)=maxFeRatioVal;
end
FemaleERatioTT= addvars(FemaleERatioTT,meanFeRatio,medianFeRatio,maxFeRatio);
SourceFile(86,1)="FemaleEmploymentRatio.xlsx";
Code(86,1)="LNS12300002";
Desc(86,1)="Female EmploymentRatio";
Freq(86,1)="Monthly";
StartYear(86,1)=1948;
EndYear(86,1)=2025;
SeasonalAdj(86,1)="Yes";
BaseYear(86,1)=1948;
NumObs(86,1)=931;
loopstr5='Process Female Employment Ratio';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows86,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Female Employment Ratio=',num2str(meanFeRatioVal,4),...
    '-Median =',num2str(medianFeRatioVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.FemaleERatioTT=FemaleERatioTT;
Chap(86,1)=9;
Section(86,1)=9;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now smooth and plot this data
itype=86;
% Smooth the Data
Data=FemaleERatioTT.Ratio;
femsmooth = smoothdata(Data);
P0=femsmooth(1);
PF=femsmooth(931);
FemaleERatioTT= addvars(FemaleERatioTT,femsmooth);
NYears=EndYear(86,1)-StartYear(86,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG86=100*GrowthRateAll(itype,1);
FRObj.SG86=SG86;
% Calculate simple stats
Data=FemaleERatioTT.Ratio;
FRObj=FRObj.SimpleStats(Data,itype);
% Now pull of the Recession Probability data that matches the available
% time points in the FullServeRestaurantsTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [FemaleERatioTT,icase] = OverlapTimeLinesRev1(FemaleERatioTT,RecessProbTT);
     FRObj.FemaleERatioTT=FemaleERatioTT;
     RecessionInfo(86,1)=icase;
end
FRObj.barval=50;
% Plot th data
titlestr='FemaleEmploymentRatio';
PlotFredData(FRObj,FemaleERatioTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{86,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='FemaleEmploymentRatio-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with US CBO Nasdaq Volatility (VXNCLS)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CBOENasdaqVolTable = readtable(fredfile87,'Sheet','Daily');
[nrows87,~]=size(CBOENasdaqVolTable);
clear DateNumbers dateArray
dateArray=strings(nrows87,1);
for n=1:nrows87
    nowstr=string(CBOENasdaqVolTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CBOENasdaqVolTT=table2timetable(CBOENasdaqVolTable,'RowTimes','Date');
CBOENasdaqVolTT = addvars(CBOENasdaqVolTT,DateNumbers);
meanVolaVal=mean(CBOENasdaqVolTT.VXNCLS,'omitnan');
medianVolaVal=median(CBOENasdaqVolTT.VXNCLS,'omitnan');
maxVolaVal=max(CBOENasdaqVolTT.VXNCLS,[],'omitnan');
meanVola=zeros(nrows87,1);
medianVola=zeros(nrows87,1);
maxVola=zeros(nrows87,1);
for n=1:nrows87
    meanVola(n,1)=meanVolaVal;
    medianVola(n,1)=medianVolaVal;
    maxVola(n,1)=maxVolaVal;
end
CBOENasdaqVolTT= addvars(CBOENasdaqVolTT,meanVola,medianVola,maxVola);
SourceFile(87,1)="CBOENasdaqVolatility.xlsx";
Code(87,1)="VXNCLS";
Desc(87,1)="CBOE Nasdaq Volatility";
Freq(87,1)="Daily";
StartYear(87,1)=2001;
EndYear(87,1)=2025;
SeasonalAdj(87,1)="No";
BaseYear(87,1)=2001;
NumObs(87,1)=6170;
loopstr5='Process CBOE Nasdaq Volatility';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows87,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Volatility=',num2str(meanVolaVal,4),...
    '-Median =',num2str(medianVolaVal,6));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CBOENasdaqVolTT=CBOENasdaqVolTT;
Chap(87,1)=10;
Section(87,1)=1;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=87;
% Calculate simple stats
Data=CBOENasdaqVolTT.VXNCLS;
volsmooth = smoothdata(Data);
P0=volsmooth(1);
PF=volsmooth(6170);
CBOENasdaqVolTT= addvars(CBOENasdaqVolTT,volsmooth);
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='CBOENasdaqVolatility';
PlotFredData(FRObj,CBOENasdaqVolTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{87,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='NasdaqVolatility-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Leading Index Of US (USSLIND)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
LeadingIndexTable = readtable(fredfile88,'Sheet','Monthly');
[nrows88,~]=size(LeadingIndexTable);
clear DateNumbers dateArray
dateArray=strings(nrows88,1);
for n=1:nrows88
    nowstr=string(LeadingIndexTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
LeadingIndexTT=table2timetable(LeadingIndexTable,'RowTimes','Date');
LeadingIndexTT = addvars(LeadingIndexTT,DateNumbers);
meanLeadingVal=mean(LeadingIndexTT.USSLIND,'omitnan');
medianLeadingVal=median(LeadingIndexTT.USSLIND,'omitnan');
maxLeadingVal=max(LeadingIndexTT.USSLIND,[],'omitnan');
meanLeading=zeros(nrows88,1);
medianLeading=zeros(nrows88,1);
maxLeading=zeros(nrows88,1);
for n=1:nrows88
    meanLeading(n,1)=meanLeadingVal;
    medianLeading(n,1)=medianLeadingVal;
    maxLeading(n,1)=maxLeadingVal;
end
LeadingIndexTT= addvars(LeadingIndexTT,meanLeading,medianLeading,maxLeading);
SourceFile(88,1)="LeadingIndexUSA.xlsx";
Code(88,1)="USSLIND";
Desc(88,1)="USA Leading Indicators";
Freq(88,1)="Monthly";
StartYear(88,1)=1982;
EndYear(88,1)=2020;
SeasonalAdj(88,1)="Yes";
BaseYear(88,1)=1982;
NumObs(88,1)=458;
loopstr5='Process US Leading Indicators';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows88,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean Indicator=',num2str(meanLeadingVal,4),...
    '-Median =',num2str(medianLeadingVal,4));
fprintf(fid,'%10s\n',loopstr7);
FRObj.LeadingIndexTT=LeadingIndexTT;
Chap(88,1)=10;
Section(88,1)=3;
FRObj.Chap=Chap;
FRObj.Section=Section;
% Now plot this data
itype=88;
% Calculate simple stats
Data=LeadingIndexTT.USSLIND;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='USLeadingIndicators';
PlotFredData(FRObj,LeadingIndexTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{88,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='LeadingIndicators-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Fed 3 Month Bond Yields
eval(['cd ' fredpath(1:length(fredpath)-1)]);
Fed3MonthBondsTable = readtable(fredfile89,'Sheet','Daily');
[nrows89,~]=size(Fed3MonthBondsTable);
clear DateNumbers dateArray
dateArray=strings(nrows89,1);
for n=1:nrows89
    nowstr=string(Fed3MonthBondsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
Fed3MonthBondsTT=table2timetable(Fed3MonthBondsTable,'RowTimes','Date');
Fed3MonthBondsTT = addvars(Fed3MonthBondsTT,DateNumbers);
meanYield3MonthBondVal=mean(Fed3MonthBondsTT.Yield,'omitnan');
medianYield3MonthBondVal=median(Fed3MonthBondsTT.Yield,'omitnan');
meanYield3Months=zeros(nrows89,1);
medianYield3Months=zeros(nrows89,1);
for n=1:nrows89
    meanYield3Months(n,1)=meanYield3MonthBondVal;
    medianYield3Months(n,1)=medianYield3MonthBondVal;
end
Fed3MonthBondsTT = addvars(Fed3MonthBondsTT,meanYield3Months,medianYield3Months);
SourceFile(89,1)="Fed3MonthBondYields.xlsx";
Code(89,1)="DGS3MO";
Desc(89,1)="Market 3 Month Bond Yields";
Freq(89,1)="Daily";
StartYear(89,1)=1981;
EndYear(89,1)=2025;
SeasonalAdj(89,1)="No";
BaseYear(89,1)=1981;
NumObs(89,1)=10992;
loopstr5='Process the Fed 3 Month Bonds';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows89,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean 3 Month Yield=',num2str(meanYield3MonthBondVal),...
    '-Median Yield=',num2str(medianYield3MonthBondVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.Fed3MonthBondsTT=Fed3MonthBondsTT;
Chap(89,1)=12;
Section(89,1)=3;
% Now plot this data
itype=89;
m3smooth = smoothdata(Fed3MonthBondsTT.Yield);
P0=m3smooth(1);
PF=m3smooth(10992);
Fed3MonthBondsTT = addvars(Fed3MonthBondsTT,m3smooth);
NYears=EndYear(89,1)-StartYear(89,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG89=100*GrowthRateAll(itype,1);
FRObj.SG89=SG89;
% Calculate simple stats
Data=Fed3MonthBondsTT.Yield;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='Fed3MonthBonds-1981-2025';
PlotFredData(FRObj,Fed3MonthBondsTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{89,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ThreeMonthRate-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Household Debt Service Payments (TDSP)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
TDSPTable = readtable(fredfile90,'Sheet','Quarterly');
[nrows90,~]=size(TDSPTable);
clear DateNumbers dateArray
dateArray=strings(nrows90,1);
for n=1:nrows90
    nowstr=string(TDSPTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
TDSPTT=table2timetable(TDSPTable,'RowTimes','Date');
TDSPTT = addvars(TDSPTT,DateNumbers);
meanTDSPVal=mean(TDSPTT.TDSP,'omitnan');
medianTDSPVal=median(TDSPTT.TDSP,'omitnan');
meanTDSP=zeros(nrows90,1);
medianTDSP=zeros(nrows90,1);
for n=1:nrows90
    meanTDSP(n,1)=meanTDSPVal;
    medianTDSP(n,1)=medianTDSPVal;
end
TDSPTT = addvars(TDSPTT,meanTDSP,medianTDSP);
SourceFile(90,1)="TDSP.xlsx";
Code(90,1)="TDSP";
Desc(90,1)="Household Debt Service Payments";
Freq(90,1)="Daily";
StartYear(90,1)=1980;
EndYear(90,1)=2025;
SeasonalAdj(90,1)="Yes";
BaseYear(90,1)=1980;
NumObs(90,1)=181;
loopstr5='Process the Household Debt Service Payments';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows90,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanTDSPVal),...
    '-Median =',num2str(medianTDSPVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.TDSPTT=TDSPTT;
Chap(90,1)=6;
Section(90,1)=10;
% Now plot this data
itype=90;
titlestr='HouseholdDebtService';
hdsmooth = smoothdata(TDSPTT.TDSP);
P0=hdsmooth(1);
PF=hdsmooth(181);
TDSPTT = addvars(TDSPTT,hdsmooth);
% Calculate simple stats
Data=TDSPTT.TDSP;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,TDSPTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{90,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='HouseHoldDebtService-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Consumer Debt Service Payments (CDSP)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CDSPTable = readtable(fredfile91,'Sheet','Quarterly');
[nrows91,~]=size(CDSPTable);
clear DateNumbers dateArray
dateArray=strings(nrows91,1);
for n=1:nrows91
    nowstr=string(CDSPTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CDSPTT=table2timetable(CDSPTable,'RowTimes','Date');
CDSPTT = addvars(CDSPTT,DateNumbers);
meanCDSPVal=mean(CDSPTT.CDSP,'omitnan');
medianCDSPVal=median(CDSPTT.CDSP,'omitnan');
meanCDSP=zeros(nrows91,1);
medianCDSP=zeros(nrows91,1);
for n=1:nrows91
    meanCDSP(n,1)=meanCDSPVal;
    medianCDSP(n,1)=medianCDSPVal;
end
CDSPTT = addvars(CDSPTT,meanCDSP,medianCDSP);
SourceFile(91,1)="CDSP.xlsx";
Code(91,1)="CDSP";
Desc(91,1)="Consumer Debt Service Payments";
Freq(91,1)="Quarterly";
StartYear(91,1)=1980;
EndYear(91,1)=2025;
SeasonalAdj(91,1)="Yes";
BaseYear(91,1)=1980;
NumObs(91,1)=181;
loopstr5='Process the Consumer Debt Service Payments';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows91,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanCDSPVal),...
    '-Median =',num2str(medianCDSPVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CDSPTT=CDSPTT;
Chap(91,1)=6;
Section(91,1)=11;
% Now plot this data
itype=91;
cdsmooth = smoothdata(CDSPTT.CDSP);
P0=cdsmooth(1);
PF=cdsmooth(181);
CDSPTT = addvars(CDSPTT,cdsmooth);
% Calculate simple stats
Data=CDSPTT.CDSP;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='ConsumerDebtService';
PlotFredData(FRObj,CDSPTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{91,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ConsumerDebtService-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Real Disposible Income (DSPIC96)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
RDIncTable = readtable(fredfile92,'Sheet','Monthly');
[nrows92,~]=size(RDIncTable);
clear DateNumbers dateArray
dateArray=strings(nrows92,1);
for n=1:nrows92
    nowstr=string(RDIncTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RDIncTT=table2timetable(RDIncTable,'RowTimes','Date');
RDIncTT = addvars(RDIncTT,DateNumbers);
meanRDIncVal=mean(RDIncTT.DIncome,'omitnan');
medianRDIncVal=median(RDIncTT.DIncome,'omitnan');
meanRDInc=zeros(nrows92,1);
medianRDInc=zeros(nrows92,1);
for n=1:nrows92
    meanRDInc(n,1)=meanRDIncVal;
    medianRDInc(n,1)=medianRDIncVal;
end
RDIncTT = addvars(RDIncTT,meanRDInc,medianRDInc);
SourceFile(92,1)="RealDisposable.xlsx";
Code(92,1)="DSPIC96";
Desc(92,1)="Real Disposable Income";
Freq(92,1)="Quarterly";
StartYear(92,1)=1959;
EndYear(92,1)=2025;
SeasonalAdj(92,1)="Yes";
BaseYear(92,1)=2017;
NumObs(92,1)=799;
loopstr5='Process the Real Disposable Consumer Income';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows92,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanRDIncVal),...
    '-Median =',num2str(medianRDIncVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.RDIncTT=RDIncTT;
Chap(92,1)=6;
Section(92,1)=12;
% Now plot this data
itype=92;
dincsmooth = smoothdata(RDIncTT.DIncome);
P0=dincsmooth(1);
PF=dincsmooth(799);
RDIncTT = addvars(RDIncTT,dincsmooth);
NYears=EndYear(92,1)-StartYear(92,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG92=100*GrowthRateAll(itype,1);
FRObj.SG92=SG92;
% Calculate simple stats
Data=RDIncTT.DIncome;
% Now pull of the Recession Probability data that matches the available
% time points in the FlexCPITT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)% 
     [RDIncTT,icase] = OverlapTimeLinesRev1(RDIncTT,RecessProbTT);
     FRObj.RDIncTT=RDIncTT;
     RecessionInfo(92,1)=icase;
end
FRObj.barval=10;
FRObj.RDIncTT=RDIncTT;
FRObj=FRObj.SimpleStats(Data,itype);
titlestr='RealDispIncome';
PlotFredData(FRObj,RDIncTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{92,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RealDispIncome-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Personal Consumption Expenditures (PCE)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PCETable = readtable(fredfile93,'Sheet','Monthly');
[nrows93,~]=size(PCETable);
clear DateNumbers dateArray
dateArray=strings(nrows93,1);
for n=1:nrows93
    nowstr=string(PCETable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PCETT=table2timetable(PCETable,'RowTimes','Date');
PCETT = addvars(PCETT,DateNumbers);
meanPCEVal=mean(PCETT.PCE,'omitnan');
medianPCEVal=median(PCETT.PCE,'omitnan');
meanPCE=zeros(nrows93,1);
medianPCE=zeros(nrows93,1);
for n=1:nrows93
    meanPCE(n,1)=meanPCEVal;
    medianPCE(n,1)=medianPCEVal;
end
PCETT = addvars(PCETT,meanPCE,medianPCE);
SourceFile(93,1)="PCE.xlsx";
Code(93,1)="PCE";
Desc(93,1)="Personal Consumption";
Freq(93,1)="Monthly";
StartYear(93,1)=1959;
EndYear(93,1)=2025;
SeasonalAdj(93,1)="Yes";
BaseYear(93,1)=2017;
NumObs(93,1)=799;
loopstr5='Process the Personal Consumption Expenditures';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows93,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanPCEVal/1000),...
    '-Median =',num2str(medianPCEVal/1000));
fprintf(fid,'%10s\n',loopstr7);
FRObj.PCETT=PCETT;
Chap(93,1)=6;
Section(93,1)=13;
% Now plot this data
itype=93;
pcesmooth = smoothdata(PCETT.PCE);
PCETT = addvars(PCETT,pcesmooth);
P0=pcesmooth(1);
PF=pcesmooth(799);
NYears=EndYear(93,1)-StartYear(93,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG93=100*GrowthRateAll(itype,1);
FRObj.SG93=SG93;
titlestr='PersonalConsumption';
% Calculate simple stats
Data=PCETT.PCE;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,PCETT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{93,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='PersonalDispIncome-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Domestic Auto Sales (DAUTOSAAR)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
DAUTOTable = readtable(fredfile94,'Sheet','Monthly');
[nrows94,~]=size(DAUTOTable);
clear DateNumbers dateArray
dateArray=strings(nrows94,1);
for n=1:nrows94
    nowstr=string(DAUTOTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
DAUTOTT=table2timetable(DAUTOTable,'RowTimes','Date');
DAUTOTT = addvars(DAUTOTT,DateNumbers);
meanSalesVal=mean(DAUTOTT.Sales,'omitnan');
medianSalesVal=median(DAUTOTT.Sales,'omitnan');
meanSales=zeros(nrows94,1);
medianSales=zeros(nrows94,1);
for n=1:nrows94
    meanSales(n,1)=meanSalesVal;
    medianSales(n,1)=medianSalesVal;
end
DAUTOTT = addvars(DAUTOTT,meanSales,medianSales);
SourceFile(94,1)="DAUTOSAAR.xlsx";
Code(94,1)="DAUTOSAAR";
Desc(94,1)="Domestic Auto Sales";
Freq(94,1)="Monthly";
StartYear(94,1)=1967;
EndYear(94,1)=2025;
SeasonalAdj(94,1)="Yes";
BaseYear(94,1)=1967;
NumObs(94,1)=703;
loopstr5='Process the Domestic Auto Sales';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows94,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanSalesVal),...
    '-Median =',num2str(medianSalesVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.DAUTOTT=DAUTOTT;
Chap(94,1)=14;
Section(94,1)=3;
% Now plot this data
itype=94;
autosmooth = smoothdata(DAUTOTT.Sales);
P0=autosmooth(1);
PF=autosmooth(703);
DAUTOTT = addvars(DAUTOTT,autosmooth);
NYears=EndYear(94,1)-StartYear(94,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG94=100*GrowthRateAll(itype,1);
FRObj.SG94=SG94;
titlestr='DomesticAutoSales';
% Calculate simple stats
Data=DAUTOTT.Sales;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,DAUTOTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{94,1}=figstr2;
FRObj.CurrentMedianValue=medianSalesVal;
% Now create the data for a Domestic Auto Sales  cumilative distribution plot
titlestr3='DomesticAutoSales-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the HomePriceIndex (USSTHPI)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
THPITable = readtable(fredfile95,'Sheet','Quarterly');
[nrows95,~]=size(THPITable);
clear DateNumbers dateArray
dateArray=strings(nrows95,1);
for n=1:nrows95
    nowstr=string(DAUTOTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
THPITT=table2timetable(THPITable,'RowTimes','Date');
THPITT = addvars(THPITT,DateNumbers);
meanPriceVal=mean(THPITT.PriceIndex,'omitnan');
medianPriceVal=median(THPITT.PriceIndex,'omitnan');
meanPrice=zeros(nrows95,1);
medianPrice=zeros(nrows95,1);
for n=1:nrows95
    meanPrice(n,1)=meanPriceVal;
    medianPrice(n,1)=medianPriceVal;
end
THPITT = addvars(THPITT,meanPrice,medianPrice);
SourceFile(95,1)="USSTHPI.xlsx";
Code(95,1)="USSTHPI";
Desc(95,1)="HousePriceIndex";
Freq(95,1)="Quarterly";
StartYear(95,1)=1975;
EndYear(95,1)=2025;
SeasonalAdj(95,1)="No";
BaseYear(95,1)=1980;
NumObs(95,1)=202;
loopstr5='Process the All Trans House Price Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows95,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanPriceVal),...
    '-Median =',num2str(medianPriceVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.THPITT=THPITT;
Chap(95,1)=6;
Section(95,1)=15;
% Now plot this data
itype=95;
transmooth = smoothdata(THPITT.PriceIndex);
P0=transmooth(1);
PF=transmooth(202);
THPITT = addvars(THPITT,transmooth);
NYears=EndYear(95,1)-StartYear(95,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG95=100*GrowthRateAll(itype,1);
FRObj.SG95=SG95;
titlestr='AllTransHousePriceIndex';
% Calculate simple stats
Data=THPITT.PriceIndex;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,THPITT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{95,1}=figstr2;

%% Continue with the Credit Card Balances (RCCCBBALTOT)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CCBALTable = readtable(fredfile96,'Sheet','Quarterly');
[nrows96,~]=size(CCBALTable);
clear DateNumbers dateArray
dateArray=strings(nrows96,1);
for n=1:nrows96
    nowstr=string(CCBALTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CCBALTT=table2timetable(CCBALTable,'RowTimes','Date');
CCBALTT = addvars(CCBALTT,DateNumbers);
meanBalVal=mean(CCBALTT.Balance,'omitnan');
medianBalVal=median(CCBALTT.Balance,'omitnan');
meanBalance=zeros(nrows96,1);
medianBalance=zeros(nrows96,1);
for n=1:nrows96
    meanBalance(n,1)=meanBalVal;
    medianBalance(n,1)=medianBalVal;
end
CCBALTT = addvars(CCBALTT,meanBalance,medianBalance);
SourceFile(96,1)="RCCCBBALTOT.xlsx";
Code(96,1)="RCCCBBALTOT";
Desc(96,1)="ConsumerCreditCard";
Freq(96,1)="Quarterly";
StartYear(96,1)=2012;
EndYear(96,1)=2025;
SeasonalAdj(96,1)="No";
BaseYear(96,1)=2012;
NumObs(96,1)=51;
loopstr5='Process Consumer Credit Card Balances';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows96,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanBalVal),...
    '-Median =',num2str(medianBalVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CCBALTT=CCBALTT;
Chap(96,1)=16;
Section(96,1)=1;
% Now plot this data
itype=96;
creditsmooth = smoothdata(CCBALTT.Balance);
P0=creditsmooth(1);
PF=creditsmooth(51);
CCBALTT = addvars(CCBALTT,creditsmooth);
NYears=EndYear(96,1)-StartYear(96,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG96=100*GrowthRateAll(itype,1);
FRObj.SG96=SG96;
titlestr='CreditCardBalances';
PlotFredData(FRObj,CCBALTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{96,1}=figstr2;

%% Continue with the Large Bank Loan Originations (RCMFLOORIG)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
LBANKLORTable = readtable(fredfile97,'Sheet','Quarterly');
[nrows97,~]=size(LBANKLORTable);
clear DateNumbers dateArray
dateArray=strings(nrows97,1);
for n=1:nrows97
    nowstr=string(LBANKLORTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
LBANKLORTT=table2timetable(LBANKLORTable,'RowTimes','Date');
LBANKLORTT = addvars(LBANKLORTT,DateNumbers);
meanSumVal=mean(LBANKLORTT.Sum,'omitnan');
medianSumVal=median(LBANKLORTT.Sum,'omitnan');
meanSum=zeros(nrows97,1);
medianSum=zeros(nrows97,1);
for n=1:nrows97
    meanSum(n,1)=meanSumVal;
    medianSum(n,1)=medianSumVal;
end
LBANKLORTT = addvars(LBANKLORTT,meanSum,medianSum);
SourceFile(97,1)="RCMFLOORIG.xlsx";
Code(97,1)="RCMFLOORIG";
Desc(97,1)=" New Mortgage Loans";
Freq(97,1)="Quarterly";
StartYear(97,1)=2012;
EndYear(97,1)=2025;
SeasonalAdj(97,1)="No";
BaseYear(97,1)=2012;
NumObs(97,1)=51;
loopstr5='Process Large Bank New Mortgage Loan Originations';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows97,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanSumVal),...
    '-Median =',num2str(medianSumVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.LBANKLORTT=LBANKLORTT;
Chap(97,1)=16;
Section(97,1)=2;
% Now plot this data
itype=97;
loansmooth = smoothdata(LBANKLORTT.Sum);
P0=loansmooth(1);
PF=loansmooth(51);
LBANKLORTT = addvars(LBANKLORTT,loansmooth);
NYears=EndYear(97,1)-StartYear(97,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG97=100*GrowthRateAll(itype,1);
FRObj.SG97=SG97;
titlestr='MortgageLoanOriginations';
PlotFredData(FRObj,LBANKLORTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{97,1}=figstr2;

%% Continue with the Past Due  (RCMFLBBALDPDPCT30P)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
PastDueMorTable = readtable(fredfile98,'Sheet','Quarterly');
[nrows98,~]=size(PastDueMorTable);
clear DateNumbers dateArray
dateArray=strings(nrows98,1);
for n=1:nrows98
    nowstr=string(PastDueMorTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
PastDueMorTT=table2timetable(PastDueMorTable,'RowTimes','Date');
PastDueMorTT = addvars(PastDueMorTT,DateNumbers);
meanPastDueVal=mean(PastDueMorTT.PastDue,'omitnan');
medianPastDueVal=median(PastDueMorTT.PastDue,'omitnan');
meanPastDue=zeros(nrows98,1);
medianPastDue=zeros(nrows98,1);
for n=1:nrows98
    meanPastDue(n,1)=meanPastDueVal;
    medianPastDue(n,1)=medianPastDueVal;
end
PastDueMorTT = addvars(PastDueMorTT,meanPastDue,medianPastDue);
SourceFile(98,1)="PastDueMortgages.xlsx";
Code(98,1)="RCMFLBBALDPDPCT30P";
Desc(98,1)=" Past Due Mortgages";
Freq(98,1)="Quarterly";
StartYear(98,1)=2012;
EndYear(98,1)=2025;
SeasonalAdj(98,1)="No";
BaseYear(98,1)=2012;
NumObs(98,1)=51;
loopstr5='Process Past Due Mortgages';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows98,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanPastDueVal),...
    '-Median =',num2str(medianSumVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.PastDueMorTT=PastDueMorTT;
Chap(98,1)=16;
Section(98,1)=3;
% Now plot this data
itype=98;
titlestr='PastDue30DaysMortgages';
PlotFredData(FRObj,PastDueMorTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{98,1}=figstr2;

%% Continue with Consumer Credit Scores 50th Ptile (RCCCBSCOREPCT50)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CreditScoreTable = readtable(fredfile99,'Sheet','Quarterly');
[nrows99,~]=size(CreditScoreTable);
clear DateNumbers dateArray
dateArray=strings(nrows99,1);
for n=1:nrows99
    nowstr=string(CreditScoreTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CreditScoreTT=table2timetable(CreditScoreTable,'RowTimes','Date');
CreditScoreTT = addvars(CreditScoreTT,DateNumbers);
meanScoreVal=mean(CreditScoreTT.Score,'omitnan');
medianScoreVal=median(CreditScoreTT.Score,'omitnan');
meanScore=zeros(nrows99,1);
medianScore=zeros(nrows99,1);
for n=1:nrows99
    meanScore(n,1)=meanScoreVal;
    medianScore(n,1)=medianScoreVal;
end
CreditScoreTT = addvars(CreditScoreTT,meanScore,medianScore);
SourceFile(99,1)="CreditScore50.xlsx";
Code(99,1)="RCCCBSCOREPCT50";
Desc(99,1)=" MedianCreditScore";
Freq(99,1)="Quarterly";
StartYear(99,1)=2012;
EndYear(99,1)=2025;
SeasonalAdj(99,1)="No";
BaseYear(99,1)=2012;
NumObs(99,1)=51;
loopstr5='Process Consumer Credit Scores';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows99,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanScoreVal),...
    '-Median =',num2str(medianScoreVal));
fprintf(fid,'%10s\n',loopstr7);
FRObj.CreditScoreTT=CreditScoreTT;
Chap(99,1)=16;
Section(99,1)=4;
% Now plot this data
itype=99;
titlestr='ConsumerCreditScores';
PlotFredData(FRObj,CreditScoreTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{99,1}=figstr2;

%% Continue with HomeEquityLines (QBPBSTASLNREALHOMEQ)
eval(['cd ' fredpath(1:length(fredpath)-1)]);
HomeEquityTable = readtable(fredfile100,'Sheet','Quarterly');
[nrows100,~]=size(HomeEquityTable);
clear DateNumbers dateArray
dateArray=strings(nrows100,1);
for n=1:nrows100
    nowstr=string(HomeEquityTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
HomeEquityTT=table2timetable(HomeEquityTable,'RowTimes','Date');
HomeEquityTT = addvars(HomeEquityTT,DateNumbers);
meanEquityVal=mean(HomeEquityTT.Assets,'omitnan');
medianEquityVal=median(HomeEquityTT.Assets,'omitnan');
meanEquity=zeros(nrows100,1);
medianEquity=zeros(nrows100,1);
for n=1:nrows100
    meanEquity(n,1)=meanEquityVal;
    medianEquity(n,1)=medianEquityVal;
end
HomeEquityTT = addvars(HomeEquityTT,meanEquity,medianEquity);
SourceFile(100,1)="HomeEquityLines.xlsx";
Code(100,1)="QBPBSTASLNREALHOMEQ";
Desc(100,1)=" HomeEquityLoans";
Freq(100,1)="Quarterly";
StartYear(100,1)=1987;
EndYear(100,1)=2025;
SeasonalAdj(100,1)="No";
BaseYear(100,1)=1987;
NumObs(100,1)=149;
loopstr5='Process Home Equity Loans';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr5);
loopstr6=strcat('Data is available for-',num2str(nrows100,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%30s\n',loopstr6);
loopstr7=strcat('Mean=',num2str(meanEquityVal/1000),...
    '-Median =',num2str(medianEquityVal/1000));
fprintf(fid,'%10s\n',loopstr7);
FRObj.HomeEquityTT=HomeEquityTT;
homesmooth = smoothdata(HomeEquityTT.Assets);
P0=homesmooth(1);
PF=homesmooth(149);
HomeEquityTT = addvars(HomeEquityTT,homesmooth);
Chap(100,1)=16;
Section(100,1)=5;
% Now plot this data
itype=100;
titlestr='HomeEquityLoans';
% Calculate simple stats
Data=HomeEquityTT.Assets;
FRObj=FRObj.SimpleStats(Data,itype);
PlotFredData(FRObj,HomeEquityTT,itype,titlestr)
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{100,1}=figstr2;

%% Continue with the Conversion Rate of USD To Pound Sterling (DEXUSUK)(Daily)
itype=101;
eval(['cd ' fredpath(1:length(fredpath)-1)]);
USDPoundsTable = readtable(fredfile101,'Sheet','Daily');
[nrows101,ncols101]=size(USDPoundsTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows101,1);
for n=1:nrows101
    nowstr=string(USDPoundsTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows101)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the USD To Pounds Sterling Rate';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows101,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
USDPoundsTT=table2timetable(USDPoundsTable,'RowTimes','Date');
USDPoundsTT = addvars(USDPoundsTT,DateNumbers);
meanUSDPounds=mean(USDPoundsTT.DEXUSUK);
medianUSDPounds=median(USDPoundsTT.DEXUSUK);
meanUSD=zeros(nrows101,1);
medianUSD=zeros(nrows101,1);
for n=1:nrows101
    meanUSD(n,1)=meanUSDPounds;
    medianUSD(n,1)=medianUSDPounds;
end
USDPoundsTT = addvars(USDPoundsTT,meanUSD,medianUSD);
SourceFile(101,1)="USDToPoundSterling.xlsx";
Code(101,1)="DEXUSUK";
Desc(101,1)="Conversion USDToPounds";
Freq(101,1)="Daily";
StartYear(101,1)=1971;
EndYear(101,1)=2026;
SeasonalAdj(101,1)="No";
BaseYear(101,1)=1971;
NumObs(101,1)=13816;
Chap(101,1)=17;
Section(101,1)=1;
% Calculate the Simple Stats
Data=USDPoundsTT.DEXUSUK;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
conv1smooth = smoothdata(Data);
P0=conv1smooth(1);
PF=conv1smooth(13816);
USDPoundsTT= addvars(USDPoundsTT,conv1smooth);
% Now plot this data
titlestr='USDToPounds';
PlotFredData(FRObj,USDPoundsTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.USDPoundsTT=USDPoundsTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{101,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='USDVsPound-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Conversion Rate of USD To Broad Market Currencies (DTWEXBGS)(Daily)
itype=102;
eval(['cd ' fredpath(1:length(fredpath)-1)]);
USDBroadIndexTable = readtable(fredfile102,'Sheet','Daily');
[nrows102,ncols102]=size(USDBroadIndexTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows102,1);
for n=1:nrows102
    nowstr=string(USDBroadIndexTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows102)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the USD To Broad Currency Index';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows102,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
USDBroadIndexTT=table2timetable(USDBroadIndexTable,'RowTimes','Date');
USDBroadIndexTT = addvars(USDBroadIndexTT,DateNumbers);
meanUSDconv2=mean(USDBroadIndexTT.DTWEXBGS,'omitnan');
medianUSDconv2=median(USDBroadIndexTT.DTWEXBGS,'omitnan');
meanUSD=zeros(nrows102,1);
medianUSD=zeros(nrows102,1);
for n=1:nrows102
    meanUSD(n,1)=meanUSDconv2;
    medianUSD(n,1)=medianUSDconv2;
end
USDBroadIndexTT = addvars(USDBroadIndexTT,meanUSD,medianUSD);
SourceFile(102,1)="NominalBroadUSDollarIndex.xlsx";
Code(102,1)="DTWEXBGS";
Desc(102,1)="Conversion USD To Broad Trading Currencies";
Freq(102,1)="Daily";
StartYear(102,1)=2006;
EndYear(102,1)=2026;
SeasonalAdj(102,1)="No";
BaseYear(102,1)=2006;
NumObs(102,1)=5039;
Chap(102,1)=17;
Section(102,1)=2;
% Calculate the Simple Stats
Data=USDBroadIndexTT.DTWEXBGS;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
conv2smooth = smoothdata(Data);
P0=conv2smooth(1);
PF=conv2smooth(5039);
USDBroadIndexTT= addvars(USDBroadIndexTT,conv2smooth);
% Now plot this data
titlestr='USDToBroadCurrencyRates';
PlotFredData(FRObj,USDBroadIndexTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.USDBroadIndexTT=USDBroadIndexTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{102,1}=figstr2;
ab=1;
%Now create the data for a cumilative distribution plot
titlestr3='BroadCurrency-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Conversion Rate of Japanes Yen To USD (DEXJPUS)(Daily)
itype=103;
eval(['cd ' fredpath(1:length(fredpath)-1)]);
JapYenUSDTable = readtable(fredfile103,'Sheet','Daily');
[nrows103,ncols103]=size(JapYenUSDTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows103,1);
for n=1:nrows103
    nowstr=string(JapYenUSDTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows103)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Jap Yen To USD Rate';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows103,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
JapYenUSDTT=table2timetable(JapYenUSDTable,'RowTimes','Date');
JapYenUSDTT = addvars(JapYenUSDTT,DateNumbers);
meanUSDconv3=mean(JapYenUSDTT.DEXJPUS,'omitnan');
medianUSDconv3=median(JapYenUSDTT.DEXJPUS,'omitnan');
meanUSD=zeros(nrows103,1);
medianUSD=zeros(nrows103,1);
for n=1:nrows103
    meanUSD(n,1)=meanUSDconv3;
    medianUSD(n,1)=medianUSDconv3;
end
JapYenUSDTT = addvars(JapYenUSDTT,meanUSD,medianUSD);
SourceFile(103,1)="JapaneseYenToUSD.xlsx";
Code(103,1)="DEXJPUSS";
Desc(103,1)="Conversion Yen To USD";
Freq(103,1)="Daily";
StartYear(103,1)=1971;
EndYear(103,1)=2026;
SeasonalAdj(103,1)="No";
BaseYear(103,1)=1971;
NumObs(103,1)=14375;
Chap(103,1)=17;
Section(103,1)=3;
% Calculate the Simple Stats
Data=JapYenUSDTT.DEXJPUS;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
conv3smooth = smoothdata(Data);
P0=conv3smooth(1);
PF=conv3smooth(14375);
JapYenUSDTT= addvars(JapYenUSDTT,conv3smooth);
% Now plot this data
titlestr='JapaneseYenToUSD';
PlotFredData(FRObj,JapYenUSDTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.JapYenUSDTT=JapYenUSDTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{103,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='JapaneseYen-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the Stock Market Capitilization vs GDP (DDDM01USA156NWDB)(Annual)
itype=104;
eval(['cd ' fredpath(1:length(fredpath)-1)]);
StockMktCapTable = readtable(fredfile104,'Sheet','Annual');
[nrows104,ncols104]=size(StockMktCapTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows104,1);
for n=1:nrows104
    nowstr=string(StockMktCapTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows104)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Stock Market Capitilization Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows104,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
StockMktCapTT=table2timetable(StockMktCapTable,'RowTimes','Date');
StockMktCapTT = addvars(StockMktCapTT,DateNumbers);
meanStkCap=mean(StockMktCapTT.DDDM01USA156NWDB,'omitnan');
medianStkCap=median(StockMktCapTT.DDDM01USA156NWDB,'omitnan');
meanCap=zeros(nrows104,1);
medianCap=zeros(nrows104,1);
for n=1:nrows104
    meanCap(n,1)=meanStkCap;
    medianCap(n,1)=medianStkCap;
end
StockMktCapTT = addvars(StockMktCapTT,meanCap,medianCap);
SourceFile(104,1)="StockMarketCapitalization.xlsx";
Code(104,1)="DDDM01USA156NWDB";
Desc(104,1)="StockMkt Cap";
Freq(104,1)="Annual";
StartYear(104,1)=1975;
EndYear(104,1)=2020;
SeasonalAdj(104,1)="No";
BaseYear(104,1)=1975;
NumObs(104,1)=46;
Chap(104,1)=17;
Section(104,1)=4;
% Calculate the Simple Stats
Data=StockMktCapTT.DDDM01USA156NWDB;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
capsmooth = smoothdata(Data);
P0=capsmooth(1);
PF=capsmooth(46);
StockMktCapTT= addvars(StockMktCapTT,capsmooth);
% Now plot this data
titlestr='StockMktCapVsGDP';
PlotFredData(FRObj,StockMktCapTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.StockMktCapTT=StockMktCapTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{104,1}=figstr2;
ab=1;

% 
%  Continue with the Consumer Price Index All Items (CPALTT01USM657N)(monthly)
itype=105;
eval(['cd ' fredpath(1:length(fredpath)-1)]);
CPIAllTable = readtable(fredfile105,'Sheet','Monthly');
[nrows105,ncols105]=size(CPIAllTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows105,1);
for n=1:nrows105
    nowstr=string(CPIAllTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows105)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the CPI All Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows105,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
CPIAllTT=table2timetable(CPIAllTable,'RowTimes','Date');
CPIAllTT = addvars(CPIAllTT,DateNumbers);
meanCPIAll=mean(CPIAllTT.CPALTT01USM657N,'omitnan');
medianCPIAll=median(CPIAllTT.CPALTT01USM657N,'omitnan');
meanCPI=zeros(nrows105,1);
medianCPI=zeros(nrows105,1);
for n=1:nrows105
    meanCPI(n,1)=meanCPIAll;
    medianCPI(n,1)=medianCPIAll;
end
CPIAllTT = addvars(CPIAllTT,meanCPI,medianCPI);
SourceFile(105,1)="CPI_All.xlsx";
Code(105,1)="CPALTT01USM657N";
Desc(105,1)="CPI Price Index All Items";
Freq(105,1)="Monthly";
StartYear(105,1)=1955;
EndYear(105,1)=2024;
SeasonalAdj(105,1)="No";
BaseYear(105,1)=1955;
NumObs(105,1)=830;
Chap(105,1)=17;
Section(105,1)=5;
% Calculate the Simple Stats
Data=CPIAllTT.CPALTT01USM657N;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
cpiallsmooth = smoothdata(Data);
P0=cpiallsmooth(1);
PF=cpiallsmooth(830);
CPIAllTT= addvars(CPIAllTT,cpiallsmooth);
% Now plot this data
titlestr='CPIAllItems';
PlotFredData(FRObj,CPIAllTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.CPIAllTT=CPIAllTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{105,1}=figstr2;
ab=1;
% Now create the data for a cumilative distribution plot
titlestr3='CPIALL-Cumil-Distribution';
titlest3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with the GrossNationalIncome (MKTGNIUSA646NWDB)(Annual)
itype=106;
eval(['cd ' fredpath(1:length(fredpath)-1)]);
GNATIncTable = readtable(fredfile106,'Sheet','Annual');
[nrows106,ncols106]=size(GNATIncTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows106,1);
for n=1:nrows106
    nowstr=string(GNATIncTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows106)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the Gross National Income';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows106,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
GNATIncTT=table2timetable(GNATIncTable,'RowTimes','Date');
GNATIncTT = addvars(GNATIncTT,DateNumbers);
meanNatInc=mean(GNATIncTT.MKTGNIUSA646NWDB,'omitnan');
medianNatInc=median(GNATIncTT.MKTGNIUSA646NWDB,'omitnan');
meanUSD=zeros(nrows106,1);
medianUSD=zeros(nrows106,1);
for n=1:nrows106
    meanUSD(n,1)=meanNatInc;
    medianUSD(n,1)=medianNatInc;
end
GNATIncTT = addvars(GNATIncTT,meanUSD,medianUSD);
SourceFile(106,1)="GrossNationalIncome.xlsx";
Code(106,1)="MKTGNIUSA646NWDB";
Desc(106,1)="Related to GNP";
Freq(106,1)="Annual";
StartYear(106,1)=1960;
EndYear(106,1)=2024;
SeasonalAdj(106,1)="No";
BaseYear(106,1)=1960;
NumObs(106,1)=65;
Chap(106,1)=17;
Section(106,1)=6;
% Calculate the Simple Stats
Data=GNATIncTT.MKTGNIUSA646NWDB;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
gnatincsmooth = smoothdata(Data);
P0=gnatincsmooth(1);
PF=gnatincsmooth(65);
GNATIncTT= addvars(GNATIncTT,gnatincsmooth);
% Now plot this data
titlestr='GrossNationalIncome';
PlotFredData(FRObj,GNATIncTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.GNATIncTT=GNATIncTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{106,1}=figstr2;

%% Continue with Regular Gas Price (GASREGW) (Weekly)  Chap 18-1
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the GASREGW Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
GASREGTable = readtable(fredfile107,'Sheet','Weekly');
[nrows107,ncols107]=size(GASREGTable);
dateArray=strings(nrows107,1);
for n=1:nrows107
    nowstr=string(GASREGTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows107)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows107,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
GASREGTT=table2timetable(GASREGTable,'RowTimes','Date');
GASREGTT = addvars(GASREGTT,DateNumbers);
meanRegGasVal=mean(GASREGTT.GASREGW);
medianRegGasVal=median(GASREGTT.GASREGW);
meanRegGas=zeros(nrows107,1);
medianRegGas=zeros(nrows107,1);
for n=1:nrows107
    meanRegGas(n,1)=meanRegGasVal;
    medianRegGas(n,1)=medianRegGasVal;
end
GASREGTT = addvars(GASREGTT,meanRegGas,medianRegGas);
SourceFile(107,1)="GASREG.xlsx";
Code(107,1)="GASREGW";
Desc(107,1)="Regular Gas Price";
Freq(107,1)="Weekly";
StartYear(107,1)=1990;
EndYear(107,1)=2025;
SeasonalAdj(107,1)="No";
BaseYear(107,1)=1990;
NumObs(107,1)=1852;
FRObj.Desc=Desc;
Chap(107,1)=18;
Section(107,1)=1;
Commodity(107,1)=1;
% Calculate the Simple Stats
itype=107;
Data=GASREGTT.GASREGW;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
gasregsmooth = smoothdata(Data);
P0=gasregsmooth(1);
PF=gasregsmooth(1852);
GASREGTT= addvars(GASREGTT,gasregsmooth);
% Now plot this data
titlestr='RegularGasPrices';
PlotFredData(FRObj,GASREGTT,itype,titlestr)
% Add this table to the FredObj
FRObj.GASREGTT=GASREGTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{107,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RegGasPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with  Regular Gas Price (DCOILBRENTEU) (Daily)  Chap 18-2
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the DCOILBRENTEU Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
BrentEUTable = readtable(fredfile108,'Sheet','Daily');
[nrows108,ncols108]=size(BrentEUTable);
dateArray=strings(nrows108,1);
for n=1:nrows108
    nowstr=string(BrentEUTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows108)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows108,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
BrentEUTT=table2timetable(BrentEUTable,'RowTimes','Date');
BrentEUTT = addvars(BrentEUTT,DateNumbers);
meanBrentOilVal=mean(BrentEUTT.DCOILBRENTEU);
medianBrentOilVal=median(BrentEUTT.DCOILBRENTEU);
meanBrentOil=zeros(nrows108,1);
medianBrentOil=zeros(nrows108,1);
for n=1:nrows108
    meanBrentOil(n,1)=meanBrentOilVal;
    medianBrentOil(n,1)=medianBrentOilVal;
end
BrentEUTT = addvars(BrentEUTT,meanBrentOil,medianBrentOil);
SourceFile(108,1)="DCOILBRENTEU.xlsx";
Code(108,1)="DCOILBRENTEU";
Desc(108,1)="Regular Gas Price";
Freq(108,1)="Daily";
StartYear(108,1)=1987;
EndYear(108,1)=2025;
SeasonalAdj(108,1)="No";
BaseYear(108,1)=1987;
NumObs(108,1)=9846;
FRObj.Desc=Desc;
Chap(108,1)=18;
Section(108,1)=2;
Commodity(108,1)=1;
% Calculate the Simple Stats
itype=108;
Data=BrentEUTT.DCOILBRENTEU;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
brentsmooth = smoothdata(Data);
P0=brentsmooth(1);
PF=brentsmooth(9846);
BrentEUTT= addvars(BrentEUTT,brentsmooth);
% Now plot this data
titlestr='BrentOilPrice';
PlotFredData(FRObj,BrentEUTT,itype,titlestr)
% Add this table to the FredObj
FRObj.BrentEUTT=BrentEUTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{108,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='BrentOilPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with  EggPrices (APU0000708111) (Monthly)  Chap 18-3
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the EggPrice Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
EggPriceTable = readtable(fredfile109,'Sheet','Monthly');
[nrows109,ncols109]=size(EggPriceTable);
dateArray=strings(nrows109,1);
for n=1:nrows109
    nowstr=string(EggPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows109)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows109,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
EggPriceTT=table2timetable(EggPriceTable,'RowTimes','Date');
EggPriceTT = addvars(EggPriceTT,DateNumbers);
meanEggPricesVal=mean(EggPriceTT.Prices);
medianEggPricesVal=median(EggPriceTT.Prices);
meanEggPrices=zeros(nrows109,1);
medianEggPrices=zeros(nrows109,1);
for n=1:nrows109
    meanEggPrices(n,1)=meanEggPricesVal;
    medianEggPrices(n,1)=medianEggPricesVal;
end
EggPriceTT = addvars(EggPriceTT,meanEggPrices,medianEggPrices);
SourceFile(109,1)="EggPrices.xlsx";
Code(109,1)="APU0000708111";
Desc(109,1)="Grade A Egg Price";
Freq(109,1)="Monthly";
StartYear(109,1)=1980;
EndYear(109,1)=2025;
SeasonalAdj(109,1)="No";
BaseYear(109,1)=1980;
NumObs(109,1)=553;
FRObj.Desc=Desc;
Chap(109,1)=18;
Section(109,1)=3;
Commodity(109,1)=1;
% Calculate the Simple Stats
itype=109;
Data=EggPriceTT.Prices;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
eggsmooth = smoothdata(Data);
P0=eggsmooth(1);
PF=eggsmooth(553);
EggPriceTT= addvars(EggPriceTT,eggsmooth);
NYears=EndYear(109,1)-StartYear(109,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG109=100*GrowthRateAll(itype,1);
FRObj.SG109=SG109;
% Now pull of the Recession Probability data that matches the available
% time points in the EggPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [EggPriceTT,icase] = OverlapTimeLinesRev1(EggPriceTT,RecessProbTT);
    FRObj.EggPriceTT=EggPriceTT;
    RecessionInfo(109,1)=icase;
end
FRObj.barval=100;
FRObj.EggPriceTT=EggPriceTT;
% Now plot this data
titlestr='GradeAEggPrice';
PlotFredData(FRObj,EggPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.EggPriceTT=EggPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{109,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='EggPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between eggs prices and the UrbanFood Price
% Index
datacol=1;
minCorrPts=100;
ikind=3;
[rho(6),~,numoverlap(6)] = CalculateCorrelation(UrbanHFTT,EggPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Eggs Prices-',num2str(rho(6)));
disp(dispstr)
FoodCorrTable(6,:) = {126,"UrbanHFTT",StartYear1,EndYear1,109,"EggPriceTT",1980,2025,rho(6),SG109,numoverlap(6)};

%% Continue with GroundBeefPrices (APU0000703112) (Monthly)  Chap 18-4
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Ground Beef Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
GroundBeefPriceTable = readtable(fredfile110,'Sheet','Monthly');
[nrows110,ncols110]=size(GroundBeefPriceTable);
dateArray=strings(nrows110,1);
for n=1:nrows110
    nowstr=string(GroundBeefPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows110)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows110,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
GroundBeefPriceTT=table2timetable(GroundBeefPriceTable,'RowTimes','Date');
GroundBeefPriceTT = addvars(GroundBeefPriceTT,DateNumbers);
meanGroundBeefPricesVal=mean(GroundBeefPriceTT.Price,'omitnan');
medianGroundBeefPricesVal=median(GroundBeefPriceTT.Price,'omitnan');
meanGroundBeefPrices=zeros(nrows110,1);
medianGroundBeefPrices=zeros(nrows110,1);
for n=1:nrows110
    meanGroundBeefPrices(n,1)=meanGroundBeefPricesVal;
    medianGroundBeefPrices(n,1)=medianGroundBeefPricesVal;
end
GroundBeefPriceTT = addvars(GroundBeefPriceTT,meanGroundBeefPrices,medianGroundBeefPrices);
SourceFile(110,1)="GroundBeefPrices.xlsx";
Code(110,1)="APU0000703112";
Desc(110,1)="Ground Beef Price/lb";
Freq(110,1)="Monthly";
StartYear(110,1)=1984;
EndYear(110,1)=2025;
SeasonalAdj(110,1)="No";
BaseYear(110,1)=1984;
NumObs(110,1)=505;
FRObj.Desc=Desc;
Chap(110,1)=18;
Section(110,1)=4;
Commodity(110,1)=1;
% Calculate the Simple Stats
itype=110;
Data=GroundBeefPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
beefsmooth = smoothdata(Data);
P0=beefsmooth(1);
PF=beefsmooth(505);
GroundBeefPriceTT= addvars(GroundBeefPriceTT,beefsmooth);
NYears=EndYear(110,1)-StartYear(110,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG110=100*GrowthRateAll(itype,1);
FRObj.SG110=SG110;
% Now pull of the Recession Probability data that matches the available
% time points in the EggPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [GroundBeefPriceTT,icase] = OverlapTimeLinesRev1(GroundBeefPriceTT,RecessProbTT);
    FRObj.GroundBeefPriceTT=GroundBeefPriceTT;
    RecessionInfo(110,1)=icase;
end
FRObj.barval=4;
FRObj.GroundBeefPriceTT=GroundBeefPriceTT;
% Now plot this data
titlestr='GroundBeefPrice';
PlotFredData(FRObj,GroundBeefPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.GroundBeefPriceTT=GroundBeefPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{110,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='GroundBeefPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Ground Beef prices and the UrbanFood Price
% Index
datacol=1;
minCorrPts=100;
ikind=2;
[rho(7),~,numoverlap(7)] = CalculateCorrelation(UrbanHFTT,GroundBeefPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Ground Prices-',num2str(rho(7)));
disp(dispstr)
FoodCorrTable(7,:) = {126,"UrbanHFTT",StartYear1,EndYear1,110,"GroundBeefPriceTT",1984,2025,rho(7),SG110,numoverlap(7)};


%% Continue with Electricity Prices (APU000072610) (Monthly)  Chap 18-5
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Electricity Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
ElectricityPriceTable = readtable(fredfile111,'Sheet','Monthly');
[nrows111,ncols111]=size(ElectricityPriceTable);
dateArray=strings(nrows111,1);
for n=1:nrows111
    nowstr=string(ElectricityPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows111)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows111,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
ElectricityPriceTT=table2timetable(ElectricityPriceTable,'RowTimes','Date');
ElectricityPriceTT = addvars(ElectricityPriceTT,DateNumbers);
meanElectricityPricesVal=mean(ElectricityPriceTT.Price,'omitnan');
medianElectricityPricesVal=median(ElectricityPriceTT.Price,'omitnan');
meanElectrcityPrices=zeros(nrows111,1);
medianElectricityPrices=zeros(nrows111,1);
for n=1:nrows111
    meanElectrcityPrices(n,1)=meanElectricityPricesVal;
    medianElectricityPrices(n,1)=medianElectricityPricesVal;
end
ElectricityPriceTT = addvars(ElectricityPriceTT,meanElectrcityPrices,medianElectricityPrices);
SourceFile(111,1)="ElectricityPrices.xlsx";
Code(111,1)="APU0000703112";
Desc(111,1)="Avg Electricity Price-kWHr";
Freq(111,1)="Monthly";
StartYear(111,1)=1978;
EndYear(111,1)=2025;
SeasonalAdj(111,1)="No";
BaseYear(111,1)=1978;
NumObs(111,1)=566;
FRObj.Desc=Desc;
Chap(111,1)=18;
Section(111,1)=5;
Commodity(111,1)=1;
% Calculate the Simple Stats
itype=111;
Data=ElectricityPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
elecsmooth = smoothdata(Data);
P0=elecsmooth(1);
PF=elecsmooth(566);
ElectricityPriceTT= addvars(ElectricityPriceTT,elecsmooth);
NYears=EndYear(111,1)-StartYear(111,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG111=100*GrowthRateAll(itype,1);
FRObj.SG111=SG111;
% Now pull of the Recession Probability data that matches the available
% time points in the ElectricityPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [ElectricityPriceTT,icase] = OverlapTimeLinesRev1(ElectricityPriceTT,RecessProbTT);
    FRObj.ElectricityPriceTT=ElectricityPriceTT;
    RecessionInfo(111,1)=icase;
end
FRObj.barval=.10;
FRObj.ElectricityPriceTT=ElectricityPriceTT;
% Now plot this data
titlestr='ElectricityPrice';
PlotFredData(FRObj,ElectricityPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.ElectricityPriceTT=ElectricityPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{111,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='ElectricityPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Electricity prices and the UrbanFood Price
% Index
datacol=1;
minCorrPts=100;
ikind=2;
[rho(8),~,numoverlap(8)] = CalculateCorrelation(UrbanHFTT,ElectricityPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Electricity Prices-',num2str(rho(8)));
disp(dispstr)
FoodCorrTable(8,:) = {126,"UrbanHFTT",StartYear1,EndYear1,111,"ElectricityPriceTT",1978,2025,rho(8),SG111,numoverlap(8)};

%% Start West Texas Crude Prices (WTISPLC) (Monthly)  Chap 18-6
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the West Texas Intermediate Crude Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
WestTexasCrudeTable = readtable(fredfile112,'Sheet','Monthly');
[nrows112,ncols112]=size(WestTexasCrudeTable);
dateArray=strings(nrows112,1);
for n=1:nrows112
    nowstr=string(WestTexasCrudeTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows112)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows112,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
WestTexasCrudeTT=table2timetable(WestTexasCrudeTable,'RowTimes','Date');
WestTexasCrudeTT = addvars(WestTexasCrudeTT,DateNumbers);
meanWTIPricesVal=mean(WestTexasCrudeTT.Price,'omitnan');
medianWTIPricesVal=median(WestTexasCrudeTT.Price,'omitnan');
meanWTIPrices=zeros(nrows112,1);
medianWTIPrices=zeros(nrows112,1);
for n=1:nrows112
    meanWTIPrices(n,1)=meanWTIPricesVal;
    medianWTIPrices(n,1)=medianWTIPricesVal;
end
WestTexasCrudeTT = addvars(WestTexasCrudeTT,meanWTIPrices,medianWTIPrices);
SourceFile(112,1)="WestTexasIntermediateCrude.xlsx";
Code(112,1)="WTISPLC";
Desc(112,1)="WTI Price Per Barrel";
Freq(112,1)="Monthly";
StartYear(112,1)=1946;
EndYear(112,1)=2025;
SeasonalAdj(112,1)="No";
BaseYear(112,1)=1946;
NumObs(112,1)=963;
FRObj.Desc=Desc;
Chap(112,1)=18;
Section(112,1)=6;
Commodity(112,1)=1;
% Calculate the Simple Stats
itype=112;
Data=WestTexasCrudeTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
wtismooth = smoothdata(Data);
P0=wtismooth(1);
PF=wtismooth(963);
WestTexasCrudeTT= addvars(WestTexasCrudeTT,wtismooth);
NYears=EndYear(112,1)-StartYear(112,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG112=100*GrowthRateAll(itype,1);
FRObj.SG112=SG112;
% Now pull of the Recession Probability data that matches the available
% time points in the ElectricityPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [WestTexasCrudeTT,icase] = OverlapTimeLinesRev1(WestTexasCrudeTT,RecessProbTT);
    FRObj.WestTexasCrudeTT=WestTexasCrudeTT;
    RecessionInfo(112,1)=icase;
end
FRObj.barval=30;
FRObj.WestTexasCrudeTT=WestTexasCrudeTT;
% Now plot this data
titlestr='WestTexasCrudePrice';
PlotFredData(FRObj,WestTexasCrudeTT,itype,titlestr)
% Add this table to the FredObj
FRObj.WestTexasCrudeTT=WestTexasCrudeTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{112,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='WTIPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Continue with Natural Gas Spot Price (DHHNGSP) (Daily)  Chap 18-7
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Henry Hub Natural Gas Prices Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
HHubNatGasPriceTable = readtable(fredfile113,'Sheet','Daily');
[nrows113,ncols113]=size(HHubNatGasPriceTable);
dateArray=strings(nrows113,1);
for n=1:nrows113
    nowstr=string(HHubNatGasPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows113)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows113,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
HHubNatGasPriceTT=table2timetable(HHubNatGasPriceTable,'RowTimes','Date');
HHubNatGasPriceTT = addvars(HHubNatGasPriceTT,DateNumbers);
meanNatGasPricesVal=mean(HHubNatGasPriceTT.Price,'omitnan');
medianNatGasPricesVal=median(HHubNatGasPriceTT.Price,'omitnan');
meanNatGasPrices=zeros(nrows113,1);
medianNatGasPrices=zeros(nrows113,1);
for n=1:nrows113
    meanNatGasPrices(n,1)=meanNatGasPricesVal;
    medianNatGasPrices(n,1)=medianNatGasPricesVal;
end
HHubNatGasPriceTT = addvars(HHubNatGasPriceTT,meanNatGasPrices,medianNatGasPrices);
SourceFile(113,1)="HenryHubNaturalGasPrices.xlsx";
Code(113,1)="DHHNGSP";
Desc(113,1)="NaturalGasPrices";
Freq(113,1)="Daily";
StartYear(113,1)=1997;
EndYear(113,1)=2025;
SeasonalAdj(113,1)="No";
BaseYear(113,1)=1997;
NumObs(113,1)=7625;
FRObj.Desc=Desc;
Chap(113,1)=18;
Section(113,1)=7;
Commodity(113,1)=1;
% Calculate the Simple Stats
itype=113;
Data=HHubNatGasPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
natgassmooth = smoothdata(Data);
P0=natgassmooth(1);
PF=natgassmooth(7625);
HHubNatGasPriceTT= addvars(HHubNatGasPriceTT,natgassmooth);
NYears=EndYear(113,1)-StartYear(113,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG113=100*GrowthRateAll(itype,1);
FRObj.SG113=SG113;
% Now pull of the Recession Probability data that matches the available
% time points in the HHubNatGasPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;% Can not superimpose because The base item is daily not monthly
 if(ishowrecession>0)
    [HHubNatGasPriceTT,icase] = OverlapTimeLinesRev1(HHubNatGasPriceTT,RecessProbTT);
    FRObj.HHubNatGasPriceTT=HHubNatGasPriceTT;
   RecessionInfo(113,1)=icase;
end
FRObj.barval=10;
FRObj.HHubNatGasPriceTT=HHubNatGasPriceTT;
% Now plot this data
titlestr='NaturalGasPrice';
PlotFredData(FRObj,HHubNatGasPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.HHubNatGasPriceTT=HHubNatGasPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{113,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='NaturalGasPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
%% Start Global Copper Price (PCOPPUSDM) (Monthly)  Chap 18-8
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Copper Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
CopperPriceTable = readtable(fredfile114,'Sheet','Monthly');
[nrows114,ncols114]=size(CopperPriceTable);
dateArray=strings(nrows114,1);
for n=1:nrows114
    nowstr=string(CopperPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows114)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows114,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CopperPriceTT=table2timetable(CopperPriceTable,'RowTimes','Date');
CopperPriceTT = addvars(CopperPriceTT,DateNumbers);
meanCopperVal=mean(CopperPriceTT.Price);
medianCopperVal=median(CopperPriceTT.Price);
meanCopper=zeros(nrows114,1);
medianCopper=zeros(nrows114,1);
for n=1:nrows114
    meanCopper(n,1)=meanCopperVal;
    medianCopper(n,1)=medianCopperVal;
end
CopperPriceTT = addvars(CopperPriceTT,meanCopper,medianCopper);
SourceFile(114,1)="GlobalCopperPrice.xlsx";
Code(114,1)="PCOPPUSDM";
Desc(114,1)="Copper Price Per Ton USD";
Freq(114,1)="Monthly";
StartYear(114,1)=1992;
EndYear(114,1)=2025;
SeasonalAdj(114,1)="No";
BaseYear(114,1)=1992;
NumObs(114,1)=410;
FRObj.Desc=Desc;
Chap(114,1)=18;
Section(114,1)=8;
Commodity(114,1)=1;
% Calculate the Simple Stats
itype=114;
Data=CopperPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
coppersmooth = smoothdata(Data);
P0=coppersmooth(1);
PF=coppersmooth(410);
CopperPriceTT= addvars(CopperPriceTT,coppersmooth);
NYears=EndYear(114,1)-StartYear(114,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG114=100*GrowthRateAll(itype,1);
FRObj.SG114=SG114;
% Now pull of the Recession Probability data that matches the available
% time points in the ElectricityPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [CopperPriceTT,icase] = OverlapTimeLinesRev1(CopperPriceTT,RecessProbTT);
    FRObj.CopperPriceTT=CopperPriceTT;
    RecessionInfo(114,1)=icase;
end
FRObj.barval=5;
FRObj.CopperPriceTT=CopperPriceTT;
% Now plot this data
titlestr='CopperPrices';
PlotFredData(FRObj,CopperPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.CopperPriceTT=CopperPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{114,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CopperPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
%% Start Global  Diesel Gas Price (GASDESW) (Monthly)  Chap 18-9
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Diesel Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
DieselPriceTable = readtable(fredfile115,'Sheet','Weekly');
[nrows115,ncols115]=size(DieselPriceTable);
dateArray=strings(nrows115,1);
for n=1:nrows115
    nowstr=string(DieselPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows115)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows115,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
DieselPriceTT=table2timetable(DieselPriceTable,'RowTimes','Date');
DieselPriceTT = addvars(DieselPriceTT,DateNumbers);
meanDieselVal=mean(DieselPriceTT.Price);
medianDieselVal=median(DieselPriceTT.Price);
meanDiesel=zeros(nrows115,1);
medianDiesel=zeros(nrows115,1);
for n=1:nrows115
    meanDiesel(n,1)=meanDieselVal;
    medianDiesel(n,1)=medianDieselVal;
end
DieselPriceTT = addvars(DieselPriceTT,meanDiesel,medianDiesel);
SourceFile(115,1)="DieselPrices.xlsx";
Code(115,1)="GASDESW";
Desc(115,1)="Diesel Price USD";
Freq(115,1)="Weekly";
StartYear(115,1)=1994;
EndYear(115,1)=2025;
SeasonalAdj(115,1)="No";
BaseYear(115,1)=1992;
NumObs(115,1)=1672;
FRObj.Desc=Desc;
Chap(115,1)=18;
Section(115,1)=9;
Commodity(115,1)=1;
% Calculate the Simple Stats
itype=115;
Data=DieselPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
dieselsmooth = smoothdata(Data);
P0=dieselsmooth(1);
PF=dieselsmooth(1672);
DieselPriceTT= addvars(DieselPriceTT,dieselsmooth);
NYears=EndYear(115,1)-StartYear(115,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG115=100*GrowthRateAll(itype,1);
FRObj.SG115=SG115;
% Now pull of the Recession Probability data that matches the available
% time points in the ElectricityPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [DieselPriceTT,icase] = OverlapTimeLinesRev1(DieselPriceTT,RecessProbTT);
    FRObj.DieselPriceTT=DieselPriceTT;
    RecessionInfo(115,1)=icase;
end
FRObj.barval=5;
FRObj.DieselPriceTT=DieselPriceTT;
% Now plot this data
titlestr='GlobalDieselPrices';
PlotFredData(FRObj,DieselPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.DieselPriceTT=DieselPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{115,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='GlobalDieselPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
%% Start Kerosene Jet Fuel Price (WJFUELUSGULF) (Weekly)  Chap 18-10
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Jet FuelPrice Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
JetFuelPriceTable = readtable(fredfile116,'Sheet','Weekly');
[nrows116,ncols116]=size(JetFuelPriceTable);
dateArray=strings(nrows116,1);
for n=1:nrows116
    nowstr=string(JetFuelPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows116)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows116,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
JetFuelPriceTT=table2timetable(JetFuelPriceTable,'RowTimes','Date');
JetFuelPriceTT = addvars(JetFuelPriceTT,DateNumbers);
meanJetVal=mean(JetFuelPriceTT.Price);
medianJetVal=median(JetFuelPriceTT.Price);
meanJet=zeros(nrows116,1);
medianJet=zeros(nrows116,1);
for n=1:nrows116
    meanJet(n,1)=meanJetVal;
    medianJet(n,1)=medianJetVal;
end
JetFuelPriceTT = addvars(JetFuelPriceTT,meanJet,medianJet);
SourceFile(116,1)="JetFuelPrices.xlsx";
Code(116,1)="WJFUELUSGULF";
Desc(116,1)="Kerosene Jet Fuel Price USD";
Freq(116,1)="Weekly";
StartYear(116,1)=1990;
EndYear(116,1)=2025;
SeasonalAdj(116,1)="No";
BaseYear(116,1)=1990;
NumObs(116,1)=1878;
FRObj.Desc=Desc;
Chap(116,1)=18;
Section(116,1)=10;
Commodity(116,1)=1;
% Calculate the Simple Stats
itype=116;
Data=JetFuelPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
jetsmooth = smoothdata(Data);
P0=jetsmooth(1);
PF=jetsmooth(1672);
JetFuelPriceTT= addvars(JetFuelPriceTT,jetsmooth);
NYears=EndYear(116,1)-StartYear(116,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG116=100*GrowthRateAll(itype,1);
FRObj.SG116=SG116;
% Now pull of the Recession Probability data that matches the available
% time points in the ElectricityPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [JetFuelPriceTT,icase] = OverlapTimeLinesRev1(JetFuelPriceTT,RecessProbTT);
    FRObj.JetFuelPriceTT=JetFuelPriceTT;
    RecessionInfo(116,1)=icase;
end
FRObj.barval=2;
FRObj.JetFuelPriceTT=JetFuelPriceTT;
% Now plot this data
titlestr='JetFuelPrices';
PlotFredData(FRObj,JetFuelPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.JetFuelPriceTT=JetFuelPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{116,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='JetFuelPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Start Price Global Aluminum Price(PALUMUSDM) (Monthly)  Chap 18-11
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Aluminum Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
AluminumTable = readtable(fredfile117,'Sheet','Monthly');
[nrows117,ncols117]=size(AluminumTable);
dateArray=strings(nrows117,1);
for n=1:nrows117
    nowstr=string(AluminumTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows117)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows117,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
AluminumTT=table2timetable(AluminumTable,'RowTimes','Date');
AluminumTT = addvars(AluminumTT,DateNumbers);
meanAluminumVal=mean(AluminumTT.Price);
medianAluminumVal=median(AluminumTT.Price);
meanAluminum=zeros(nrows117,1);
medianAluminum=zeros(nrows117,1);
for n=1:nrows117
    meanAluminum(n,1)=meanAluminumVal;
    medianAluminum(n,1)=medianAluminumVal;
end
AluminumTT = addvars(AluminumTT,meanAluminum,medianAluminum);
SourceFile(117,1)="GlobalAluminumPrice.xlsx";
Code(117,1)="PALUMUSDM";
Desc(117,1)="Global Aluminum Price/Ton USD";
Freq(117,1)="Monthly";
StartYear(117,1)=1992;
EndYear(117,1)=2025;
SeasonalAdj(117,1)="No";
BaseYear(117,1)=1992;
NumObs(117,1)=410;
FRObj.Desc=Desc;
Chap(117,1)=18;
Section(117,1)=11;
Commodity(117,1)=1;
% Calculate the Simple Stats
itype=117;
Data=AluminumTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
alsmooth = smoothdata(Data);
P0=alsmooth(1);
PF=alsmooth(410);
AluminumTT= addvars(AluminumTT,alsmooth);
NYears=EndYear(117,1)-StartYear(117,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG117=100*GrowthRateAll(itype,1);
FRObj.SG117=SG117;
% Now pull of the Recession Probability data that matches the available
% time points in the ElectricityPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [AluminumTT,icase] = OverlapTimeLinesRev1(AluminumTT,RecessProbTT);
    FRObj.AluminumTT=AluminumTT;
    RecessionInfo(117,1)=icase;
end
FRObj.barval=2;
FRObj.AluminumTT=AluminumTT;
% Now plot this data
titlestr='AluminumPrices';
PlotFredData(FRObj,AluminumTT,itype,titlestr)
% Add this table to the FredObj
FRObj.AluminumTT=AluminumTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{117,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='AluminumPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
%% Start Price Global Cocoa Price(PCOCOUSDM) (Monthly)  Chap 18-12
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Cocoa Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
CocoaTable = readtable(fredfile118,'Sheet','Monthly');
[nrows118,ncols118]=size(CocoaTable);
dateArray=strings(nrows118,1);
for n=1:nrows118
    nowstr=string(CocoaTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows118)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows118,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
CocoaTT=table2timetable(CocoaTable,'RowTimes','Date');
CocoaTT = addvars(CocoaTT,DateNumbers);
meanCocoaVal=mean(CocoaTT.Price);
medianCocoaVal=median(CocoaTT.Price);
meanCocoa=zeros(nrows118,1);
medianCocoa=zeros(nrows118,1);
for n=1:nrows118
    meanCocoa(n,1)=meanCocoaVal;
    medianCocoa(n,1)=medianCocoaVal;
end
CocoaTT = addvars(CocoaTT,meanCocoa,medianCocoa);
SourceFile(118,1)="CocoaPrice.xlsx";
Code(118,1)="PCOCOUSDM";
Desc(118,1)="Cocoa Price/Ton USD";
Freq(118,1)="Monthly";
StartYear(118,1)=1992;
EndYear(118,1)=2025;
SeasonalAdj(118,1)="No";
BaseYear(118,1)=1992;
NumObs(118,1)=410;
FRObj.Desc=Desc;
Chap(118,1)=18;
Section(118,1)=12;
Commodity(118,1)=1;
% Calculate the Simple Stats
itype=118;
Data=CocoaTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
cocoasmooth = smoothdata(Data);
P0=cocoasmooth(1);
PF=cocoasmooth(410);
CocoaTT= addvars(CocoaTT,cocoasmooth);
NYears=EndYear(118,1)-StartYear(118,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG118=100*GrowthRateAll(itype,1);
FRObj.SG118=SG118;
% Now pull of the Recession Probability data that matches the available
% time points in the CocoaTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [CocoaTT,icase] = OverlapTimeLinesRev1(CocoaTT,RecessProbTT);
    FRObj.CocoaTT=CocoaTT;
    RecessionInfo(118,1)=icase;
end
FRObj.barval=4;
FRObj.CocoaTT=CocoaTT;
% Now plot this data
titlestr='CocoaPrices';
PlotFredData(FRObj,CocoaTT,itype,titlestr)
% Add this table to the FredObj
FRObj.CocoaTT=CocoaTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{118,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='CocoaPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Cocoa prices and the UrbanFood Price
% Index
datacol=1;
minCorrPts=100;
ikind=2;
[rho(9),~,numoverlap(9)] = CalculateCorrelation(UrbanHFTT,CocoaTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Cocoa Prices-',num2str(rho(9)));
disp(dispstr)
FoodCorrTable(9,:) = {126,"UrbanHFTT",StartYear1,EndYear1,118,"CocoaTT",1992,2025,rho(9),SG118,numoverlap(9)};

%% Start Global Energy Index (PNRGINDEXM) (Monthly)  Chap 18-13
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Global Energy Price Index Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
GlobalEnergyTable = readtable(fredfile119,'Sheet','Monthly');
[nrows119,ncols119]=size(GlobalEnergyTable);
dateArray=strings(nrows119,1);
for n=1:nrows119
    nowstr=string(GlobalEnergyTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows119)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows119,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
GlobalEnergyTT=table2timetable(GlobalEnergyTable,'RowTimes','Date');
GlobalEnergyTT = addvars(GlobalEnergyTT,DateNumbers);
meanGlobalEnergyVal=mean(GlobalEnergyTT.Price);
medianGlobalEnergyVal=median(GlobalEnergyTT.Price);
meanGlobalEnergy=zeros(nrows119,1);
medianGlobalEnergy=zeros(nrows119,1);
for n=1:nrows119
    meanGlobalEnergy(n,1)=meanGlobalEnergyVal;
    medianGlobalEnergy(n,1)=medianGlobalEnergyVal;
end
GlobalEnergyTT = addvars(GlobalEnergyTT,meanGlobalEnergy,medianGlobalEnergy);
SourceFile(119,1)="GlobalEnergyPrice.xlsx";
Code(119,1)="PNRGINDEXM";
Desc(119,1)="GlobalEnergyPriceIndex";
Freq(119,1)="Monthly";
StartYear(119,1)=1992;
EndYear(119,1)=2025;
SeasonalAdj(119,1)="No";
BaseYear(119,1)=2016;
NumObs(119,1)=410;
FRObj.Desc=Desc;
Chap(119,1)=18;
Section(119,1)=13;
% Calculate the Simple Stats
itype=119;
Data=GlobalEnergyTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
energysmooth = smoothdata(Data);
P0=energysmooth(1);
PF=energysmooth(410);
GlobalEnergyTT= addvars(GlobalEnergyTT,energysmooth);
NYears=EndYear(119,1)-StartYear(119,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG119=100*GrowthRateAll(itype,1);
FRObj.SG119=SG119;
% Now plot this data
titlestr='GlobalEnergyIndex';
PlotFredData(FRObj,GlobalEnergyTT,itype,titlestr)
% Add this table to the FredObj
FRObj.GlobalEnergyTT=GlobalEnergyTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{119,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='GlobalEnergyIndex-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)


%% Start Bread Prices  (APU0000702111) (Monthly)  Chap 18-14
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Bread Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
BreadPriceTable = readtable(fredfile120,'Sheet','Monthly');
[nrows120,ncols120]=size(BreadPriceTable);
dateArray=strings(nrows120,1);
for n=1:nrows120
    nowstr=string(BreadPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows120)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows120,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
BreadPriceTT=table2timetable(BreadPriceTable,'RowTimes','Date');
BreadPriceTT = addvars(BreadPriceTT,DateNumbers);
meanBreadPriceVal=mean(BreadPriceTT.Price);
medianBreadPriceVal=median(BreadPriceTT.Price);
meanBreadPrice=zeros(nrows120,1);
medianBreadPrice=zeros(nrows120,1);
for n=1:nrows120
    meanBreadPrice(n,1)=meanBreadPriceVal;
    medianBreadPrice(n,1)=medianBreadPriceVal;
end
BreadPriceTT = addvars(BreadPriceTT,meanBreadPrice,medianBreadPrice);
SourceFile(120,1)="BreadPrice.xlsx";
Code(120,1)="APU0000702111";
Desc(120,1)="Avg Bread Price USD/lb";
Freq(120,1)="Monthly";
StartYear(120,1)=1980;
EndYear(120,1)=2025;
SeasonalAdj(120,1)="No";
BaseYear(120,1)=1980;
NumObs(120,1)=553;
FRObj.Desc=Desc;
Chap(120,1)=18;
Section(120,1)=14;
Commodity(120,1)=1;
% Calculate the Simple Stats
itype=120;
Data=BreadPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
breadsmooth = smoothdata(Data);
P0=breadsmooth(1);
PF=breadsmooth(553);
BreadPriceTT= addvars(BreadPriceTT,breadsmooth);
NYears=EndYear(120,1)-StartYear(120,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG120=100*GrowthRateAll(itype,1);
FRObj.SG120=SG120;
% Now pull of the Recession Probability data that matches the available
% time points in the BreadPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [BreadPriceTT,icase] = OverlapTimeLinesRev1(BreadPriceTT,RecessProbTT);
    FRObj.BreadPriceTT=BreadPriceTT;
    RecessionInfo(120,1)=icase;
end
FRObj.barval=1;
FRObj.BreadPriceTT=BreadPriceTT;
% Now plot this data
titlestr='BreadPrice';
PlotFredData(FRObj,BreadPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.BreadPriceTT=BreadPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{120,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='BreadPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
% Now calculate the correlation between Bread prices and the UrbanFood Price
% Index
datacol=1;
minCorrPts=100;
ikind=2;
[rho(10),~,numoverlap(10)] = CalculateCorrelation(UrbanHFTT,BreadPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Bread Prices-',num2str(rho(10)));
disp(dispstr)
FoodCorrTable(10,:) = {126,"UrbanHFTT",StartYear1,EndYear1,120,"BreadPriceTT",1980,2025,rho(10),SG120,numoverlap(10)};

%% Start Wheat Prices  (PWHEAMTUSDM) (Monthly)  Chap 18-15
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Wheat Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
WheatPriceTable = readtable(fredfile121,'Sheet','Monthly');
[nrows121,ncols121]=size(WheatPriceTable);
dateArray=strings(nrows121,1);
for n=1:nrows121
    nowstr=string(WheatPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows121)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows121,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
WheatPriceTT=table2timetable(WheatPriceTable,'RowTimes','Date');
WheatPriceTT = addvars(WheatPriceTT,DateNumbers);
meanWheatPriceVal=mean(WheatPriceTT.Price);
medianWheatPriceVal=median(WheatPriceTT.Price);
meanWheatPrice=zeros(nrows121,1);
medianWheatPrice=zeros(nrows121,1);
for n=1:nrows121
    meanWheatPrice(n,1)=meanWheatPriceVal;
    medianWheatPrice(n,1)=medianWheatPriceVal;
end
WheatPriceTT = addvars(WheatPriceTT,meanWheatPrice,medianWheatPrice);
SourceFile(121,1)="WheatPrices.xlsx";
Code(121,1)="PWHEAMTUSDM";
Desc(121,1)="WheatPrice-USD/Metric Ton";
Freq(121,1)="Monthly";
StartYear(121,1)=1992;
EndYear(121,1)=2025;
SeasonalAdj(121,1)="No";
BaseYear(121,1)=1992;
NumObs(121,1)=410;
FRObj.Desc=Desc;
Chap(121,1)=18;
Section(121,1)=15;
Commodity(121,1)=1;
% Calculate the Simple Stats
itype=121;
Data=WheatPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
wheatsmooth = smoothdata(Data);
P0=wheatsmooth(1);
PF=wheatsmooth(410);
WheatPriceTT= addvars(WheatPriceTT,wheatsmooth);
NYears=EndYear(121,1)-StartYear(121,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG121=100*GrowthRateAll(itype,1);
FRObj.SG121=SG121;
% Now pull of the Recession Probability data that matches the available
% time points in the WheatPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [WheatPriceTT,icase] = OverlapTimeLinesRev1(WheatPriceTT,RecessProbTT);
    FRObj.WheatPriceTT=WheatPriceTT;
    RecessionInfo(121,1)=icase;
end
FRObj.barval=150;
FRObj.WheatPriceTT=WheatPriceTT;
% Now plot this data
titlestr='WheatPrice';
PlotFredData(FRObj,WheatPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.WheatPriceTT=WheatPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{121,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='WheatPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
ikind=2;
[rho(12),~,numoverlap(12)] = CalculateCorrelation(UrbanHFTT,WheatPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Wheat Prices-',num2str(rho(12)));
disp(dispstr)
FoodCorrTable(12,:) = {126,"UrbanHFTT",StartYear1,EndYear1,121,"WheatPriceTT",1992,2025,rho(12),SG121,numoverlap(12)};
%% Start Uranium Prices  (PURANUSDM) (Monthly)  Chap 18-16
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Uranium Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
UraniumPriceTable = readtable(fredfile122,'Sheet','Monthly');
[nrows122,ncols122]=size(UraniumPriceTable);
dateArray=strings(nrows122,1);
for n=1:nrows122
    nowstr=string(UraniumPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows122)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows122,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
UraniumPriceTT=table2timetable(UraniumPriceTable,'RowTimes','Date');
UraniumPriceTT = addvars(UraniumPriceTT,DateNumbers);
meanUraniumPriceVal=mean(UraniumPriceTT.Price);
medianUraniumPriceVal=median(UraniumPriceTT.Price);
meanUraniumPrice=zeros(nrows122,1);
medianUraniumPrice=zeros(nrows122,1);
for n=1:nrows122
    meanUraniumPrice(n,1)=meanUraniumPriceVal;
    medianUraniumPrice(n,1)=medianUraniumPriceVal;
end
UraniumPriceTT = addvars(UraniumPriceTT,meanUraniumPrice,medianUraniumPrice);
SourceFile(122,1)="UraniumPrices.xlsx";
Code(122,1)="PURANUSDM";
Desc(122,1)="UraniumPrice-USD/lb";
Freq(122,1)="Monthly";
StartYear(122,1)=1992;
EndYear(122,1)=2025;
SeasonalAdj(122,1)="No";
BaseYear(122,1)=1992;
NumObs(122,1)=410;
FRObj.Desc=Desc;
Chap(122,1)=18;
Section(122,1)=16;
Commodity(122,1)=1;
% Calculate the Simple Stats
itype=122;
Data=UraniumPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
uransmooth = smoothdata(Data);
P0=uransmooth(1);
PF=uransmooth(410);
UraniumPriceTT= addvars(UraniumPriceTT,uransmooth);
NYears=EndYear(122,1)-StartYear(122,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG122=100*GrowthRateAll(itype,1);
FRObj.SG122=SG122;
% Now pull of the Recession Probability data that matches the available
% time points in the UraniumPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [UraniumPriceTT,icase] = OverlapTimeLinesRev1(UraniumPriceTT,RecessProbTT);
    FRObj.UraniumPriceTT=UraniumPriceTT;
    RecessionInfo(122,1)=icase;
end
FRObj.barval=50;
FRObj.UraniumPriceTT=UraniumPriceTT;
% Now plot this data
titlestr='UraniumPrice';
PlotFredData(FRObj,UraniumPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.UraniumPriceTT=UraniumPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{122,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='UraniumPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)

%% Start Nickel Prices  (PNICKUSDM) (Monthly)  Chap 18-17
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Nickel Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
NickelPriceTable = readtable(fredfile123,'Sheet','Monthly');
[nrows123,ncols123]=size(NickelPriceTable);
dateArray=strings(nrows123,1);
for n=1:nrows123
    nowstr=string(NickelPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows123)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows123,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
NickelPriceTT=table2timetable(NickelPriceTable,'RowTimes','Date');
NickelPriceTT = addvars(NickelPriceTT,DateNumbers);
meanNickelPriceVal=mean(NickelPriceTT.Price);
medianNickelPriceVal=median(NickelPriceTT.Price);
meanNickelPrice=zeros(nrows123,1);
medianNickelPrice=zeros(nrows123,1);
for n=1:nrows123
    meanNickelPrice(n,1)=meanNickelPriceVal;
    medianNickelPrice(n,1)=medianNickelPriceVal;
end
NickelPriceTT = addvars(NickelPriceTT,meanNickelPrice,medianNickelPrice);
SourceFile(123,1)="NickelPrices.xlsx";
Code(123,1)="PNICKUSDM";
Desc(123,1)="NickelPrice-USD/Ton";
Freq(123,1)="Monthly";
StartYear(123,1)=1992;
EndYear(123,1)=2025;
SeasonalAdj(123,1)="No";
BaseYear(123,1)=1992;
NumObs(123,1)=410;
FRObj.Desc=Desc;
Chap(123,1)=18;
Section(123,1)=17;
Commodity(123,1)=1;
% Calculate the Simple Stats
itype=123;
Data=NickelPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
nicksmooth = smoothdata(Data);
P0=nicksmooth(1);
PF=nicksmooth(410);
NickelPriceTT= addvars(NickelPriceTT,nicksmooth);
NYears=EndYear(123,1)-StartYear(123,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG123=100*GrowthRateAll(itype,1);
FRObj.SG123=SG123;
% Now pull of the Recession Probability data that matches the available
% time points in the NickelPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [NickelPriceTT,icase] = OverlapTimeLinesRev1(NickelPriceTT,RecessProbTT);
    FRObj.NickelPriceTT=NickelPriceTT;
    RecessionInfo(123,1)=icase;
end
FRObj.barval=20;
FRObj.NickelPriceTT=NickelPriceTT;
% Now plot this data
titlestr='NickelPrice';
PlotFredData(FRObj,NickelPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.NickelPriceTT=NickelPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{123,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='NickelPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
%% Start Rubber Prices  (PRUBBUSDM) (Monthly)  Chap 18-18
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Rubber Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
RubberPriceTable = readtable(fredfile124,'Sheet','Monthly');
[nrows124,ncols124]=size(RubberPriceTable);
dateArray=strings(nrows124,1);
for n=1:nrows124
    nowstr=string(RubberPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows124)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows124,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
RubberPriceTT=table2timetable(RubberPriceTable,'RowTimes','Date');
RubberPriceTT = addvars(RubberPriceTT,DateNumbers);
meanRubberPriceVal=mean(RubberPriceTT.Price);
medianRubberPriceVal=median(RubberPriceTT.Price);
meanRubberPrice=zeros(nrows124,1);
medianRubberPrice=zeros(nrows124,1);
for n=1:nrows124
    meanRubberPrice(n,1)=meanRubberPriceVal;
    medianRubberPrice(n,1)=medianRubberPriceVal;
end
RubberPriceTT = addvars(RubberPriceTT,meanRubberPrice,medianRubberPrice);
SourceFile(124,1)="RubberPrices.xlsx";
Code(124,1)="PRUBBUSDM";
Desc(124,1)="RubberPrice-USD/lb";
Freq(124,1)="Monthly";
StartYear(124,1)=1992;
EndYear(124,1)=2025;
SeasonalAdj(124,1)="No";
BaseYear(124,1)=1992;
NumObs(124,1)=410;
FRObj.Desc=Desc;
Chap(124,1)=18;
Section(124,1)=18;
Commodity(124,1)=1;
% Calculate the Simple Stats
itype=124;
Data=RubberPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
rubbersmooth = smoothdata(Data);
P0=rubbersmooth(1);
PF=rubbersmooth(410);
RubberPriceTT= addvars(RubberPriceTT,rubbersmooth);
NYears=EndYear(124,1)-StartYear(124,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG124=100*GrowthRateAll(itype,1);
FRObj.SG124=SG124;
% Now pull of the Recession Probability data that matches the available
% time points in the RubberPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [RubberPriceTT,icase] = OverlapTimeLinesRev1(RubberPriceTT,RecessProbTT);
    FRObj.RubberPriceTT=RubberPriceTT;
    RecessionInfo(124,1)=icase;
end
FRObj.barval=2;
FRObj.RubberPriceTT=RubberPriceTT;
% Now plot this data
titlestr='RubberPrice';
PlotFredData(FRObj,RubberPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.RubberPriceTT=RubberPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{124,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='RubberPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);

%% Start Sugar Prices  (PSUGAISAUSDM) (Monthly)  Chap 18-19
loopstr='**********Start Looping through the available FRED data**********';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr);
eval(['cd ' fredpath(1:length(fredpath)-1)]);
loopstr1='Process the Sugar Price Data';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
SugarPriceTable = readtable(fredfile125,'Sheet','Monthly');
[nrows125,ncols125]=size(SugarPriceTable);
dateArray=strings(nrows125,1);
for n=1:nrows125
    nowstr=string(SugarPriceTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows125)
        nowEndDate=nowstr;
    end
end
loopstr2=strcat('Data is available for-',num2str(nrows125,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
SugarPriceTT=table2timetable(SugarPriceTable,'RowTimes','Date');
SugarPriceTT = addvars(SugarPriceTT,DateNumbers);
meanSugarPriceVal=mean(SugarPriceTT.Price);
medianSugarPriceVal=median(SugarPriceTT.Price);
meanSugarPrice=zeros(nrows125,1);
medianSugarPrice=zeros(nrows125,1);
for n=1:nrows125
    meanSugarPrice(n,1)=meanSugarPriceVal;
    medianSugarPrice(n,1)=medianSugarPriceVal;
end
SugarPriceTT = addvars(SugarPriceTT,meanSugarPrice,medianSugarPrice);
SourceFile(125,1)="SugarPrices.xlsx";
Code(125,1)="PSUGAISAUSDM";
Desc(125,1)="SugarPrice-USD/lb";
Freq(125,1)="Monthly";
StartYear(125,1)=1992;
EndYear(125,1)=2025;
SeasonalAdj(125,1)="No";
BaseYear(125,1)=1992;
NumObs(125,1)=410;
FRObj.Desc=Desc;
Chap(125,1)=18;
Section(125,1)=19;
Commodity(125,1)=1;
% Calculate the Simple Stats
itype=125;
Data=SugarPriceTT.Price;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
sugarsmooth = smoothdata(Data);
P0=sugarsmooth(1);
PF=sugarsmooth(410);
SugarPriceTT= addvars(SugarPriceTT,sugarsmooth);
NYears=EndYear(125,1)-StartYear(125,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG125=100*GrowthRateAll(itype,1);
FRObj.SG125=SG125;
% Now pull of the Recession Probability data that matches the available
% time points in the SugarPriceTT
RecessProbTT=FRObj.RecessProbTT;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [SugarPriceTT,icase] = OverlapTimeLinesRev1(SugarPriceTT,RecessProbTT);
    FRObj.SugarPriceTT=SugarPriceTT;
    RecessionInfo(125,1)=icase;
end
FRObj.barval=0.5;
FRObj.SugarPriceTT=SugarPriceTT;
% Now plot this data
titlestr='SugarPrice';
PlotFredData(FRObj,SugarPriceTT,itype,titlestr)
% Add this table to the FredObj
FRObj.SugarPriceTT=SugarPriceTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{125,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='SugarPrice-CumilDist';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3);
% Calculate the correlation
ikind=2;
[rho(13),significance,numoverlap(13)] = CalculateCorrelation(UrbanHFTT,SugarPriceTT,ikind,minCorrPts);
dispstr=strcat('Price Correlation Between Urban Home Food and Sugar Prices-',num2str(rho(13)));
disp(dispstr)
FoodCorrTable(13,:) = {126,"UrbanHFTT",StartYear1,EndYear1,125,"SugarPriceTT",1992,2025,rho(13),SG125,numoverlap(13)};

%% Create a Catalog table to hold key data extracted from the FRED database
Catalog = table(Code,Desc,Freq,StartYear,EndYear,SeasonalAdj,BaseYear,NumObs,Chap,Section,Commodity);
FRObj.Catalog=Catalog;
FRObj.FredPngList=FredPngList;
[PStatsObj,FRObj] = CreateFredDetailsReport(PStatsObj,FRObj);
ab=1;
fprintf(fid,'%10s\n','------Catalog Table Contents-----');
fprintf(fid,'%10s\n',' Code     Description    Freq  Start-Year  End-Year  SeasonAdj   NumObj Chapter Section Commodity');
eval(['cd ' logfilepath(1:length(logfilepath)-1)]);
writetable(Catalog,logfilename,'Delimiter','\t','WriteMode','append');  
writetable(Catalog,'CatalogFile.xlsx','Sheet',1)
disp('Wrote CatalogFile to Excel Spreadsheet')
%% Close and display PDF report if one is created
a1=exist('rpt','var');
if((iCreatePDFReport==1) && (RptGenPresent==1))
   close(rpt);
    rptview(rpt)
else
    disp('No pdf report generated by this run');
end
%% Save the object holding the imported data
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
% if(a1==1)
%     varstr='FRObj FoodCorrTable';
% else
%     varstr='FRObj FoodCorrTable';
% end
varstr='FRObj FoodCorrTable';
qualstr='-v7.3';
TableName='ImportedFredData144.mat';
[cmdString]=MyStrcatV73(actionstr,TableName,varstr,qualstr);
eval(cmdString);
wrtstr1=strcat('Wrote Imported Fred Data To File-',TableName);
disp(wrtstr1);
%fprintf(fid,'%30s\n',wrtstr1);

%% Run Close out
fprintf(fid,'\n');
disp('Run Completed');
%fprintf(fid,'%40s\n','**********Run Completed**********');
fclose(fid);
ab=1;