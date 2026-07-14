function [SetUpObj,StockIndexCorr]=CalculateMarketIndexCorrelationsRev1(SetUpObj,WorkObj,FirstStatsObj,StockIndexCorr,nowIndex,fid)
% This function will calculate the correlation of an individual stock to
% one of four major maarket indices.
% this version has been modified to utilize classes
% These are 1=DowJones,2=SP500,3=NASDAQ and 4=Russel 2000
% Written By: Stephen Forczyk
% Created: May 15,2025
% Revised: May 18,2025 added additional columns to StockIndexCorr
% cell array to study what is taking so long to calculate
StockIndexCorr{1,10}='First Valid Index';
StockIndexCorr{1,11}='Last Valid Index';
StockIndexCorr{1,12}='NumValid';
StockIndexCorr{1,13}='CalclTime';
%StockIndexCorr=SetUpObj.StockIndexCorr;
EquityTT=WorkObj.EquitySPTT;
DowJonesTT=SetUpObj.DowJonesTT;
NasdaqTT=SetUpObj.NasdaqTT;
SP500TT=SetUpObj.SP500TT;
Rusell2000TT=SetUpObj.Rusell2000TT;
nowStock=WorkObj.StockSymbol;
ab=1;

% Compare to Dow Jones
tic;
[nowCorr1,jjstart,jjlast] = FindMatchingDataRev2(EquityTT,DowJonesTT);
StockIndexCorr{1+nowIndex,6}=nowCorr1;
StockIndexCorr{1+nowIndex,10}=jjstart;
StockIndexCorr{1+nowIndex,11}=jjlast;
numvalid=jjlast-jjstart+1;
StockIndexCorr{1+nowIndex,12}=numvalid;
elapsed_time=toc;
StockIndexCorr{1+nowIndex,13}=elapsed_time;
dispstr=strcat('For Stock-',nowStock,'-Correlation with Dow Jones=',num2str(nowCorr1));
disp(dispstr)
fprintf(fid,'%50s\n',dispstr);
% Compare to the Nasdaq
[nowCorr2,~,~] = FindMatchingDataRev2(EquityTT,NasdaqTT);
StockIndexCorr{1+nowIndex,7}=nowCorr2;
dispstr=strcat('For Stock-',nowStock,'-Correlation with Nasdaq=',num2str(nowCorr2));
disp(dispstr)
fprintf(fid,'%50s\n',dispstr);
% Compare to the SP500
[nowCorr3,~,~] = FindMatchingDataRev2(EquityTT,SP500TT);
StockIndexCorr{1+nowIndex,8}=nowCorr3;
dispstr=strcat('For Stock-',nowStock,'-Correlation with SP500=',num2str(nowCorr3));
disp(dispstr)
fprintf(fid,'%50s\n',dispstr);
% Compare to the Rusell 2000
[nowCorr4,~,~] = FindMatchingDataRev2(EquityTT,Rusell2000TT);
StockIndexCorr{1+nowIndex,9}=nowCorr4;
dispstr=strcat('For Stock-',nowStock,'-Correlation with Rusell2000=',num2str(nowCorr4));
disp(dispstr)
fprintf(fid,'%50s\n',dispstr);
fprintf(fid,'\n');
ab=1;
end