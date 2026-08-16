%% Light Truck Sales(ALTSALES) Monthly
% itype=147
eval(['cd ' fredpath(1:length(fredpath)-1)]);
AltSalesTable = readtable(fredfile147,'Sheet','Monthly');
[nrows147,ncols147]=size(AltSalesTable);
clear DateNumbers
clear dateArray
dateArray=strings(nrows147,1);
for n=1:nrows147
    nowstr=string(AltSalesTable.Date(n,1));
    dateArray(n,1)=nowstr;
    if(n==1)
        nowStartDate=nowstr;
    elseif(n==nrows147)
        nowEndDate=nowstr;
    end
end
rowTimes=datetime(dateArray);
DateNumbers=datenum(rowTimes);
loopstr1='Process the The Sales for Light Trucks';
fprintf(fid,'\n');
fprintf(fid,'%50s\n',loopstr1);
loopstr2=strcat('Data is available for-',num2str(nrows147,4),'-dates-',...
    'From-',nowStartDate,'-to-',nowEndDate');
fprintf(fid,'%50s\n',loopstr2);
AltSalesTT=table2timetable(AltSalesTable,'RowTimes','Date');
AltSalesTT = addvars(AltSalesTT,DateNumbers);
UnitsmeanVal=mean(AltSalesTT.Units);
UnitsmedianVal=median(AltSalesTT.Units);
meanUnits=zeros(nrows147,1);
medianUnits=zeros(nrows147,1);
for n=1:nrows147
    meanUnits(n,1)=UnitsmeanVal;
    medianUnits(n,1)=UnitsmedianVal;
end
AltSalesTT = addvars(AltSalesTT,meanUnits,medianUnits);
SourceFile(147,1)="ALTSALES.xlsx";
Code(147,1)="ALTSALES";
Desc(147,1)="LightTruckSales";
Freq(147,1)="Monthly";
StartYear(147,1)=1976;
EndYear(147,1)=2025;
SeasonalAdj(147,1)="Yes";
BaseYear(147,1)=1976;
NumObs(147,1)=606;
Chap(147,1)=7;
Section(147,1)=19;
itype=147;
% Calculate the Simple Stats
Data=AltSalesTT.Units;
FRObj=FRObj.SimpleStats(Data,itype);
% Smooth the Data
trkunitssmooth = smoothdata(Data);
P0=trkunitssmooth(1);
PF=trkunitssmooth(605);
AltSalesTT= addvars(AltSalesTT,trkunitssmooth);
NYears=EndYear(147,1)-StartYear(147,1)+1;
FRObj=FRObj.SimpleGrowthAll(P0,PF,NYears,itype);
GrowthRateAll=FRObj.GrowthRateAll;
SG147=100*GrowthRateAll(itype,1);
FRObj.SG147=SG147;
ishowrecession=FRObj.ishowrecession;
if(ishowrecession>0)
    [AltSalesTT,icase] = OverlapTimeLinesRev1(AltSalesTT,RecessProbTT);
    FRObj.AltSalesTT=AltSalesTT;
    RecessionInfo(147,1)=icase;
end
% Now plot this data
FRObj.barval=15;
% Now plot this data
titlestr='LightTruck-Sales';
PlotFredData(FRObj,AltSalesTT,itype,titlestr)
% Add this data to the Fred Obj
FRObj.AltSalesTT=AltSalesTT;
titlestr=char(titlestr);
figstr2=strcat(titlestr,'.png');
figstr2=char(figstr2);
FredPngList{147,1}=figstr2;
% Now create the data for a cumilative distribution plot
titlestr3='LightTruck-CumilDistribution';
titlestr3=char(titlestr3);
figstr3=strcat(titlestr3,'.png');
figstr3=char(figstr3);
PlotCumilFredData(FRObj,itype,titlestr3)
ab=1;