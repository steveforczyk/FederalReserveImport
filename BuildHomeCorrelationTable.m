function [HomeCorrTable] = BuildHomeCorrelationTable(FRObj)
% This function will calculate the elements of the HomeCorrelationTable
% This is a fixed size table that will contain the correlations between 
% the 10 variables
%
% Written By: Stephen Forczyk
% Created Sept 1,2026
% Revised:

% Pull Out some arrays that will be used several times
GrowthRateAll=FRObj.GrowthRateAll;
rho=zeros(25,1);
rho2=zeros(45,1);
numoverlap=zeros(45,1);
RecessionInfo=zeros(159,1);
UnrateTT=FRObj.UnrateTT;
SCPITT=FRObj.SCPITT;
CaseShillerTT=FRObj.CaseShillerTT;
LumberPriceTT=FRObj.LumberPriceTT;
SoftWoodIndexTT=FRObj.SoftWoodIndexTT;
HardWoodIndexTT=FRObj.HardWoodIndexTT;
HardwoodFlooringTT=FRObj.HardwoodFlooringTT;
MillworkTT=FRObj.MillworkTT;
TreatedWoodTT=FRObj.TreatedWoodTT;
PlasticPipeTT=FRObj.PlasticPipeTT;
% Pre Allocate a table to store Home Price data that will be used later
sz2 = [45 11];
varTypes = ["double","string","double","double","double","string","double","double","double","double","double"];
varNames = ["BaseiType","BaseTableName","StartYear1","EndYear1","CompiType","CompTableName","StartYear2","EndYear2",...
    "rho","GR","numovrlp"];
HomeCorrTable = table('Size',sz2,'VariableTypes',varTypes,'VariableNames',varNames);
%
% Note that this table does NOT include the self correlations which are 1
% by definition. These will be added in later

% Start Building Column 1-Item 1
% Now calculate the correlation between Unemployment Rate and the
% CoreSticky CPI for the HomePrice Correlation Table-Item 2
% Index
datacol=1;
minCorrPts=100;
ikind2=1;
itype=2;
[rho2(1),~,numoverlap(2)] = CalculateHomeCorrelation(UnrateTT,SCPITT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and Inflation-',num2str(rho2(1)));
disp(dispstr)
SG2=100*GrowthRateAll(itype,1);
StartYear1=1952;
EndYear1=2025;
HomeCorrTable(1,:) = {1,"UnrateTT",StartYear1,EndYear1,2,"SCPITT",1968,2025,rho2(1),SG2,numoverlap(2)};

% Start Building Column 1 Item 3 value
% Now calculate the correlation between Unemployment Rate and the
% Case Shiller Home Price Index for the HomePrice Correlation Table
% Index
datacol=1;
minCorrPts=100;
ikind2=27;
[rho2(2),~,numoverlap(2)] = CalculateHomeCorrelation(UnrateTT,CaseShillerTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and Case Shiller Index-',num2str(rho2(2)));
disp(dispstr)
SG27=100*GrowthRateAll(itype,1);
StartYear1=1952;
EndYear1=2025;
HomeCorrTable(2,:) = {1,"UnrateTT",StartYear1,EndYear1,27,"CaseShillerTT",1987,2025,rho2(2),SG27,numoverlap(2)};

% Start Building Column 1 Item 3 value
% Now calculate the correlation between Unemployment Rate and the
% Lumber Price Index
% Index
datacol=1;
minCorrPts=100;
ikind2=3;
itype=153;
[rho2(3),~,numoverlap(3)] = CalculateHomeCorrelation(UnrateTT,LumberPriceTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and Lumber Price-',num2str(rho2(3)));
disp(dispstr)
SG153=100*GrowthRateAll(itype,1);
StartYear1=1926;
EndYear1=2025;
HomeCorrTable(3,:) = {1,"UnrateTT",StartYear1,EndYear1,153,"LumberPriceTT",1926,2025,rho2(3),SG153,numoverlap(3)};

% Start Building Column 1 Item 4 value
% Now calculate the correlation between Unemployment Rate and the
% HardwoodPrice Index
% Index
datacol=1;
minCorrPts=100;
ikind2=3;
[rho2(4),~,numoverlap(4)] = CalculateHomeCorrelation(UnrateTT,HardWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and HardWood Index-',num2str(rho2(4)));
disp(dispstr)
SG154=100*GrowthRateAll(itype,1);
StartYear1=1947;
EndYear1=2025;
HomeCorrTable(4,:) = {1,"UnrateTT",StartYear1,EndYear1,154,"HardWoodIndexTT",1947,2025,rho2(4),SG154,numoverlap(4)};

% Start Building Column 1 Item 5 value
% Now calculate the correlation between Unemployment Rate and the
% SoftwoodPrice Index
% Index
datacol=1;
minCorrPts=100;
ikind2=3;
[rho2(5),~,numoverlap(5)] = CalculateHomeCorrelation(UnrateTT,SoftWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and SoftWood Index-',num2str(rho2(5)));
disp(dispstr)
itype=155;
SG155=100*GrowthRateAll(itype,1);
StartYear1=1947;
EndYear1=2025;
HomeCorrTable(5,:) = {1,"UnrateTT",StartYear1,EndYear1,155,"SoftWoodIndexTT",1947,2025,rho2(5),SG155,numoverlap(5)};

% Start Building Column 1 Item 6 value
% Now calculate the correlation between Unemployment Rate and the
% Hardwood Floor Price Index
% Index
datacol=1;
minCorrPts=100;
ikind2=5;
[rho2(6),~,numoverlap(6)] = CalculateHomeCorrelation(UnrateTT,HardwoodFlooringTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and Hardwood Flooring Index-',num2str(rho2(6)));
disp(dispstr)
itype=156;
SG156=100*GrowthRateAll(itype,1);
StartYear1=1984;
EndYear1=2025;
HomeCorrTable(6,:) = {1,"UnrateTT",StartYear1,EndYear1,156,"HardwoodFlooringTT",1984,2025,rho2(6),SG156,numoverlap(6)};

% Start Building Column 1 Item 7 value
% Now calculate the correlation between Unemployment Rate and the
% Hardwood Millwork Price Index
% Index
datacol=1;
minCorrPts=100;
ikind2=5;
[rho2(7),~,numoverlap(7)] = CalculateHomeCorrelation(UnrateTT,MillworkTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and Millwork Price  Index-',num2str(rho2(7)));
disp(dispstr)
itype=157;
SG157=100*GrowthRateAll(itype,1);
StartYear1=1964;
EndYear1=2025;
HomeCorrTable(7,:) = {1,"UnrateTT",StartYear1,EndYear1,157,"MillworkTT",1964,2025,rho2(7),SG157,numoverlap(7)};

% Start Building Column 1 Item 8 value
% Now calculate the correlation between Unemployment Rate and the
% Hardwood Treated Wood Price Index
% Index
datacol=1;
minCorrPts=100;
ikind2=5;
[rho2(8),~,numoverlap(8)] = CalculateHomeCorrelation(UnrateTT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and Millwork Price  Index-',num2str(rho2(8)));
disp(dispstr)
itype=158;
SG158=100*GrowthRateAll(itype,1);
StartYear1=1985;
EndYear1=2025;
HomeCorrTable(8,:) = {1,"UnrateTT",StartYear1,EndYear1,158,"TreatedWoodTT",1985,2025,rho2(8),SG158,numoverlap(8)};

% Start Building Column 1 Item 9 value
% Now calculate the correlation between Unemployment Rate and the
% Plastic Pipe Price Index
% Index
datacol=1;
minCorrPts=100;
ikind2=5;
[rho2(9),~,numoverlap(9)] = CalculateHomeCorrelation(UnrateTT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between U2 Unemployment and Plastic Pipe Price  Index-',num2str(rho2(9)));
disp(dispstr)
itype=159;
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(9,:) = {1,"UnrateTT",StartYear1,EndYear1,159,"PlasticPipeTT",1987,2025,rho2(9),SG159,numoverlap(9)};

% Start Building Column 2 Item 1
% Now calculate the correlation between SCPITT and the
% CoreSticky CPI for the HomePrice Correlation Table
% Index
datacol=1;
minCorrPts=100;
ikind2=6;
itype=27;
[rho2(10),~,numoverlap(10)] = CalculateHomeCorrelation(SCPITT,CaseShillerTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between Sticky Inflation and The Shiller House Price Index-',num2str(rho2(10)));
disp(dispstr)
itype=2;
SG2=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(10,:) = {2,"SCPITT",StartYear1,EndYear1,27,"CaseShiller",1987,2025,rho2(10),SG2,numoverlap(10)};

% Start Building Column 2 Item 2
datacol=1;
minCorrPts=100;
ikind2=7;
itype=153;
[rho2(11),~,numoverlap(11)] = CalculateHomeCorrelation(SCPITT,LumberPriceTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Sticky Inflation and The Lumber Price Index-',num2str(rho2(11)));
disp(dispstr)
itype=153;
SG153=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(11,:) = {2,"SCPITT",StartYear1,EndYear1,153,"LumberPrice",1926,2025,rho2(11),SG153,numoverlap(11)};

% Start Building Column 2 Item 3
% Now calculate the correlation between SCIPTT and the
% Hardwood Price indexfor the HomePrice Correlation Table
% Index
datacol=1;
minCorrPts=100;
ikind2=7;
itype=154;
[rho2(12),~,numoverlap(12)] = CalculateHomeCorrelation(SCPITT,HardWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Sticky Inflation and The Hardwood Price Index-',num2str(rho2(12)));
disp(dispstr)
itype=154;
SG154=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(12,:) = {2,"SCPITT",StartYear1,EndYear1,154,"HardWoodPrice",1947,2025,rho2(12),SG154,numoverlap(12)};

% Start Building Column 2 Item 4
% Now calculate the correlation between CoreSticky CPI and the SoftWood Price Index
% Index
datacol=1;
minCorrPts=100;
ikind2=7;
itype=155;
[rho2(13),~,numoverlap(13)] = CalculateHomeCorrelation(SCPITT,SoftWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Sticky Inflation and The SoftWood Price Index-',num2str(rho2(13)));
disp(dispstr)
itype=155;
SG155=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(13,:) = {2,"SCPITT",StartYear1,EndYear1,155,"SoftWoodPrice",1947,2025,rho2(13),SG155,numoverlap(13)};

% Start Building Column 2 Item 5
% Now calculate correlations involving SCPITT as the base
% and the HardwoodFlooring Price
datacol=1;
minCorrPts=100;
ikind2=8;
itype=155;
[rho2(14),~,numoverlap(14)] = CalculateHomeCorrelation(SCPITT,HardwoodFlooringTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Sticky Inflation and The HardwoodFloring Index-',num2str(rho2(14)));
disp(dispstr)
itype=156;
SG156=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(14,:) = {2,"SCPITT",StartYear1,EndYear1,156,"FloorPrice",1947,2025,rho2(14),SG156,numoverlap(14)};

% Start Building Column 2 Item 6
% Now calculate correlations involving SCPITT as the base
% and the Millwork Price Index
datacol=1;
minCorrPts=100;
ikind2=7;
itype=157;
[rho2(15),~,numoverlap(15)] = CalculateHomeCorrelation(SCPITT,MillworkTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Sticky Inflation and The MillworkPrice Index-',num2str(rho2(15)));
disp(dispstr)
SG157=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(15,:) = {2,"SCPITT",StartYear1,EndYear1,157,"MillworkPrice",1964,2025,rho2(15),SG157,numoverlap(15)};

% Start Building Column 2 Item 7
% Now calculate correlations involving SCPITT as the base
% and the Treated Wood Price Index
datacol=1;
minCorrPts=100;
ikind2=8;
itype=158;
[rho2(16),~,numoverlap(16)] = CalculateHomeCorrelation(SCPITT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Sticky Inflation and The Treated Wood Index-',num2str(rho2(16)));
disp(dispstr)
SG158=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(16,:) = {2,"SCPITT",StartYear1,EndYear1,158,"TreatedWood",1985,2025,rho2(16),SG158,numoverlap(16)};

% Start Building Column 2 Item 8
% Now calculate correlations involving SCPITT as the base
% and the Plastic Pipe Price Index
datacol=1;
minCorrPts=100;
ikind2=8;
itype=159;
[rho2(17),~,numoverlap(17)] = CalculateHomeCorrelation(SCPITT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Sticky Inflation and The Plastic Pipe Index-',num2str(rho2(17)));
disp(dispstr)
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(17,:) = {2,"SCPITT",StartYear1,EndYear1,159,"PlasticPipe",1987,2025,rho2(17),SG159,numoverlap(17)};

% ----Now work on Row 3 Data  Item 1---
% Now calculate correlations involving CaseShiller House Price Index as the base
% and the Plastic Pipe Price Index vs the Lumber Price Index
datacol=1;
minCorrPts=100;
ikind2=9;
itype=153;
[rho2(18),~,numoverlap(18)] = CalculateHomeCorrelation(CaseShillerTT,LumberPriceTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The CaseShiller Price Index and The Lumber Price Index-',num2str(rho2(18)));
disp(dispstr)
SG153=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(18,:) = {27,"CaseShiller",StartYear1,EndYear1,153,"LumberPriceIndex",1926,2025,rho2(18),SG153,numoverlap(18)};

% Now calculate correlations involving CaseShiller House Price Index as the base
% and the Plastic Pipe Price Index vs the HardWoodIndexTT Item 2
datacol=1;
minCorrPts=100;
ikind2=9;
itype=154;
[rho2(19),~,numoverlap(19)] = CalculateHomeCorrelation(CaseShillerTT,HardWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The CaseShiller Price Index and The HardWood Price Index-',num2str(rho2(19)));
disp(dispstr)
SG154=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(19,:) = {27,"CaseShiller",StartYear1,EndYear1,154,"HardWoodIndex",1947,2025,rho2(19),SG154,numoverlap(19)};

% Now calculate correlations involving CaseShiller House Price Index as the base
% and the SoftWoodIndex  Item 3
datacol=1;
minCorrPts=100;
ikind2=9;
itype=155;
[rho2(20),~,numoverlap(20)] = CalculateHomeCorrelation(CaseShillerTT,SoftWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The CaseShiller Price Index and The Soft Price Index-',num2str(rho2(20)));
disp(dispstr)
SG155=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(20,:) = {27,"CaseShiller",StartYear1,EndYear1,155,"SoftWoodIndex",1947,2025,rho2(20),SG155,numoverlap(20)};

% Now calculate correlations involving CaseShiller Price Index as the base
% and the Floor Price Index Item 4
datacol=1;
minCorrPts=100;
ikind2=9;
itype=156;
[rho2(21),~,numoverlap(21)] = CalculateHomeCorrelation(CaseShillerTT,HardwoodFlooringTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The CaseShiller Price Index and Hardwood Flooring Price Index-',num2str(rho2(21)));
disp(dispstr)
SG156=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(21,:) = {27,"CaseShiller",StartYear1,EndYear1,155,"HardWoodFloorIndex",1947,2025,rho2(21),SG156,numoverlap(21)};

% Now calculate correlations involving CaseShiller Price Index as the base
% and the Shaped wood pieces MillworkTT Item 5
datacol=1;
minCorrPts=100;
ikind2=9;
itype=157;
[rho2(22),~,numoverlap(22)] = CalculateHomeCorrelation(CaseShillerTT,MillworkTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The CaseShiller Price Index and Millwork Price Index-',num2str(rho2(22)));
disp(dispstr)
SG157=100*GrowthRateAll(itype,1);
HomeCorrTable(22,:) = {27,"CaseShiller",StartYear1,EndYear1,157,"MillworkPriceIndex",1964,2025,rho2(22),SG157,numoverlap(22)};

% Now calculate correlations involving CaseShiller Price Index as the base
% and the Treated WoodPieces Item 6
datacol=1;
minCorrPts=100;
ikind2=9;
itype=158;
[rho2(23),~,numoverlap(23)] = CalculateHomeCorrelation(CaseShillerTT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The CaseShiller Price Index and Treated Wood Price Index-',num2str(rho2(23)));
disp(dispstr)
SG158=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(23,:) = {27,"CaseShiller",StartYear1,EndYear1,158,"TreatedWoodPriceIndex",1985,2025,rho2(23),SG158,numoverlap(23)};

% Now calculate correlations involving CaseShiller Price Index as the base
% and the Plastic Pipe MillworkTT Item 7
datacol=1;
minCorrPts=100;
ikind2=9;
itype=159;
[rho2(24),~,numoverlap(24)] = CalculateHomeCorrelation(CaseShillerTT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The CaseShiller Price Index and Plastic Pipe Index Price Index-',num2str(rho2(24)));
disp(dispstr)
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(24,:) = {27,"CaseShiller",StartYear1,EndYear1,159,"PlasticPipePriceIndex",1987,2025,rho2(24),SG159,numoverlap(24)};

% Start work on Column 4 as the base
% Now calculate correlations involving Lumber Price Index as the base
% and the Hardwood Lumber Index as the dependent variable Item 1
datacol=1;
minCorrPts=100;
ikind2=10;
itype=154;
[rho2(25),~,numoverlap(25)] = CalculateHomeCorrelation(LumberPriceTT,HardWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Lumber Price Index and Hardwood Price Index-',num2str(rho2(25)));
disp(dispstr)
SG154=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(25,:) = {153,"LumberPrice",StartYear1,EndYear1,154,"Hardwood Price",1947,2025,rho2(25),SG154,numoverlap(25)};

% Now calculate correlations involving Lumber Price Index as the base
% and the SoftWood Lumber Index as the dependent variable Item 2
datacol=1;
minCorrPts=100;
ikind2=10;
itype=155;
[rho2(26),~,numoverlap(26)] = CalculateHomeCorrelation(LumberPriceTT,SoftWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Lumber Price Index and Softwood Price Index-',num2str(rho2(26)));
disp(dispstr)
SG155=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(26,:) = {153,"LumberPrice",StartYear1,EndYear1,155,"Soft Wood Price",1947,2025,rho2(26),SG155,numoverlap(26)};

% Now calculate correlations involving Lumber Price Index as the base
% and the HardWood Floor Index as the dependent variable Item 3 
datacol=1;
minCorrPts=100;
ikind2=10;
itype=156;
[rho2(27),~,numoverlap(27)] = CalculateHomeCorrelation(LumberPriceTT,SoftWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Lumber Price Index and Hardwood Floor  Price Index-',num2str(rho2(27)));
disp(dispstr)
SG156=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(27,:) = {153,"LumberPrice",StartYear1,EndYear1,156,"HardWoodFloorPrice",1984,2025,rho2(27),SG156,numoverlap(27)};

% Now calculate correlations involving Lumber Price Index as the base
% and the Millwork Price Index as the dependent variable Item 4
datacol=1;
minCorrPts=100;
ikind2=10;
itype=157;
[rho2(28),~,numoverlap(28)] = CalculateHomeCorrelation(LumberPriceTT,MillworkTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Lumber Price Index and the Millwork Price Index-',num2str(rho2(28)));
disp(dispstr)
SG157=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(28,:) = {153,"LumberPrice",StartYear1,EndYear1,157,"MillworkPrice",1964,2025,rho2(28),SG157,numoverlap(28)};

% Now calculate correlations involving Lumber Price Index as the base
% and the Treated Wood Index as the dependent variable Item 5
datacol=1;
minCorrPts=100;
ikind2=10;
itype=158;
[rho2(29),~,numoverlap(29)] = CalculateHomeCorrelation(LumberPriceTT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Lumber Price Index and the Treated Wood Price Index-',num2str(rho2(29)));
disp(dispstr)
SG158=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(29,:) = {153,"LumberPrice",StartYear1,EndYear1,158,"TreatedWood",1985,2025,rho2(29),SG158,numoverlap(29)};

% Now calculate correlations involving Lumber Price Index as the base
% and the Plastic Pipe Index as the dependent variable
datacol=1;
minCorrPts=100;
ikind2=10;
itype=159;
[rho2(30),~,numoverlap(30)] = CalculateHomeCorrelation(LumberPriceTT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Between The Lumber Price Index and the Plastic Pipe Price Index-',num2str(rho2(30)));
disp(dispstr)
SG159=100*GrowthRateAll(itype,1);
HomeCorrTable(30,:) = {153,"LumberPrice",StartYear1,EndYear1,159,"PlasticPipe",1987,2025,rho2(30),SG159,numoverlap(30)};

% ------Start work on Column 5 as the base---- Item 1
% Now calculate correlations involving Hardwood Lumber Index as the base
% and the Softwood Lumber Index Index as the dependent variable
datacol=1;
minCorrPts=100;
ikind2=10;
itype=154;
[rho2(31),~,numoverlap(31)] = CalculateHomeCorrelation(HardWoodIndexTT,SoftWoodIndexTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Hardwood Price Index- and SoftWood Price Index',num2str(rho2(31)));
disp(dispstr)
SG155=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(31,:) = {154,"HardWoodPrice",StartYear1,EndYear1,155,"SoftWoodPrice",1947,2025,rho2(31),SG155,numoverlap(31)};

% Now calculate correlations involving Hardwood Lumber Index as the base
% and the Hardwood Flooring Index as the dependent variable Item 2
datacol=1;
minCorrPts=100;
ikind2=10;
itype=154;
[rho2(32),~,numoverlap(32)] = CalculateHomeCorrelation(HardWoodIndexTT,HardwoodFlooringTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Hardwood Price Index- and Hardwood Flooring Index',num2str(rho2(32)));
disp(dispstr)
SG156=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(32,:) = {154,"HardWoodPrice",StartYear1,EndYear1,156,"HardwoodFlooring",1984,2025,rho2(32),SG156,numoverlap(32)};

% Now calculate correlations involving Hardwood Lumber Index as the base
% and the Millwork Index as the dependent variable Item 3
datacol=1;
minCorrPts=100;
ikind2=10;
itype=157;
[rho2(33),~,numoverlap(33)] = CalculateHomeCorrelation(HardWoodIndexTT,MillworkTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Hardwood Price Index- and MillWood Index',num2str(rho2(33)));
disp(dispstr)
SG157=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(33,:) = {154,"HardWoodPrice",StartYear1,EndYear1,157,"Millwork",1964,2025,rho2(33),SG157,numoverlap(33)};

% Now calculate correlations involving Hardwood Lumber Index as the base
% and the Treated Wood Index as the dependent variable Item 4
datacol=1;
minCorrPts=100;
ikind2=10;
itype=158;
[rho2(34),~,numoverlap(34)] = CalculateHomeCorrelation(HardWoodIndexTT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Hardwood Price Index- and Treated Wood Index',num2str(rho2(34)));
disp(dispstr)
SG158=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(34,:) = {154,"HardWoodPrice",StartYear1,EndYear1,158,"Treated Wood",1985,2025,rho2(34),SG158,numoverlap(34)};

% Now calculate correlations involving Hardwood Lumber Index as the base
% and the Plastic Pipe Index as the dependent variable Item 5
datacol=1;
minCorrPts=100;
ikind2=10;
itype=159;
[rho2(35),~,numoverlap(35)] = CalculateHomeCorrelation(HardWoodIndexTT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Hardwood Price Index- and Plastic Pipe Index',num2str(rho2(35)));
disp(dispstr)
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(35,:) = {154,"HardWoodPrice",StartYear1,EndYear1,158,"Plastic Pipe",1987,2025,rho2(35),SG159,numoverlap(35)};

% ------Start work on Column 6 as the base----Item 1
% Now calculate correlations involving SoftWood Lumber Index as the base
% and the Treated Wood Index as the dependent variable
datacol=1;
minCorrPts=100;
ikind2=10;
itype=156;
[rho2(36),~,numoverlap(36)] = CalculateHomeCorrelation(SoftWoodIndexTT,HardwoodFlooringTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation SoftWood Price Index- and HardWoodFlooring Index',num2str(rho2(36)));
disp(dispstr)
SG156=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(36,:) = {155,"SoftWoodPrice",StartYear1,EndYear1,156,"Hard Flooring",1985,2025,rho2(36),SG156,numoverlap(36)};

% Now calculate correlations involving SoftWood  Lumber Index as the base
% and the Millwork Price Index as the dependent variable Item 2
datacol=1;
minCorrPts=100;
ikind2=10;
itype=157;
[rho2(37),~,numoverlap(37)] = CalculateHomeCorrelation(SoftWoodIndexTT,MillworkTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Hardwood Price Index- and Millwork Index',num2str(rho2(37)));
disp(dispstr)
SG157=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(37,:) = {155,"SoftWoodPrice",StartYear1,EndYear1,157,"Millwork",1964,2025,rho2(35),SG157,numoverlap(37)};

% Now calculate correlations involving SoftWood Lumber Index as the base
% and the Treated Wood Index as the dependent variable Item 3
datacol=1;
minCorrPts=100;
ikind2=10;
itype=158;
[rho2(38),~,numoverlap(38)] = CalculateHomeCorrelation(SoftWoodIndexTT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation SoftWood Price Index- and Treated Wood Index',num2str(rho2(38)));
disp(dispstr)
SG156=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(38,:) = {155,"SoftWoodPrice",StartYear1,EndYear1,158,"Treated Wood",1985,2025,rho2(36),SG156,numoverlap(38)};

% Now calculate correlations involving SoftWood  Lumber Index as the base
% and the Plastic Pipe as the dependent variable iTEM 4
datacol=1;
minCorrPts=100;
ikind2=10;
itype=159;
[rho2(39),~,numoverlap(39)] = CalculateHomeCorrelation(SoftWoodIndexTT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation SoftWood Price Index- and Plastic Pipe Index',num2str(rho2(39)));
disp(dispstr)
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(39,:) = {155,"SoftWoodPrice",StartYear1,EndYear1,159,"Plastic Pipe",1987,2025,rho2(37),SG159,numoverlap(39)};

% ----- Start Work On Column 7---- Item 1
% Now calculate correlations involving SoftWood  Lumber Index as the base
% and the Millwork as the dependent variable 
datacol=1;
minCorrPts=100;
ikind2=10;
itype=157;
[rho2(40),~,numoverlap(40)] = CalculateHomeCorrelation(HardwoodFlooringTT,MillworkTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Floor Price Index- and Millwork Index',num2str(rho2(40)));
disp(dispstr)
SG157=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(40,:) = {156,"FloorPrice",StartYear1,EndYear1,157,"Millwork Index",1964,2025,rho2(40),SG157,numoverlap(40)};

% Now calculate correlations involving HardWood Floor Price Index as the base
% and the Treated Wood Price Index as the dependent variable Item 2
datacol=1;
minCorrPts=100;
ikind2=10;
itype=158;
[rho2(41),~,numoverlap(39)] = CalculateHomeCorrelation(HardwoodFlooringTT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Floor Price Index- and Treated Wood Index',num2str(rho2(41)));
disp(dispstr)
SG158=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(41,:) = {156,"FloorPrice",StartYear1,EndYear1,158,"Treated Wood Index",1985,2025,rho2(41),SG158,numoverlap(41)};


% now compute the correlation between the Floor Price Index and the Plastic
% Pipe Index Item 3
datacol=1;
minCorrPts=100;
ikind2=10;
itype=159;
[rho2(42),~,numoverlap(42)] = CalculateHomeCorrelation(HardwoodFlooringTT,PlasticPipeTT,ikind2,minCorrPts);
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(42,:) = {156,"FloorPrice",StartYear1,EndYear1,159,"Plastic PipeIndex",1985,2025,rho2(42),SG159,numoverlap(42)};

% ------Start work on Column 8 as the base---- Item 1
% Now calculate correlations table involving Millwork Price Index as the base
% and the Treated Wood Index as the dependent variable
nCorrPts=100;
idatacol=1;
mikind2=10;
itype=158;
[rho2(43),~,numoverlap(43)] = CalculateHomeCorrelation(MillworkTT,TreatedWoodTT,ikind2,minCorrPts);
dispstr=strcat('Millwork Index vs Treated Wood',num2str(rho2(43)));
disp(dispstr)
SG158=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(43,:) = {157,"Millwork",StartYear1,EndYear1,158,"Treated Wood Index",1985,2025,rho2(43),SG158,numoverlap(43)};

% Now calculate correlations involving Millwork Index as the base
% and the Plastic Pipe Price Index as the dependent variable Item 2
datacol=1;
minCorrPts=100;
ikind2=10;
itype=159;
[rho2(44),~,numoverlap(44)] = CalculateHomeCorrelation(MillworkTT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Price Correlation Millwork Index- and Plastic PipeIndex',num2str(rho2(44)));
disp(dispstr)
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(44,:) = {157,"Millwork",StartYear1,EndYear1,159,"Plastic PipeIndex",1987,2025,rho2(44),SG159,numoverlap(44)};

% ----- Start Work On Column 9 -----Item 1
% Now calculate correlations table involving Treated Wood Index as the base
% and the Plastic Pipe Index as the dependent variable this is Column 9
nCorrPts=100;
idatacol=1;
mikind2=10;
itype=159;
[rho2(45),~,numoverlap(45)] = CalculateHomeCorrelation(TreatedWoodTT,PlasticPipeTT,ikind2,minCorrPts);
dispstr=strcat('Treated Wood Index vs Plastic Pipe',num2str(rho2(45)));
disp(dispstr)
SG159=100*GrowthRateAll(itype,1);
StartYear1=1987;
EndYear1=2025;
HomeCorrTable(45,:) = {157,"Treated Wood",StartYear1,EndYear1,159,"PlasticPipe",1987,2025,rho2(45),SG159,numoverlap(45)};
end