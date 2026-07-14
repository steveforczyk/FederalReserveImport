function CalculateMarketIndexCorrelations(EquityTT,istocknum)
% This function will calculate the correlation of an individual stock to
% one of four major maarket indices.
% These are 1=DowJones,2=SP500,3=NASDAQ and 4=Russel 2000
% Written By: Stephen Forczyk
% Created: Mar 10,2025
% Revised:------
global DowJonesTT SP500TT NasdaqTT Rusell2000TT;
global StockIndexCorr;

% Compare to Dow Jones
[nowCorr1] = FindMatchingData(EquityTT,DowJonesTT);
StockIndexCorr(istocknum,1)=nowCorr1;
% Compare to the SP500
[nowCorr2] = FindMatchingData(EquityTT,SP500TT);
StockIndexCorr(istocknum,2)=nowCorr2;
% Compare to the NASDAQ
[nowCorr3] = FindMatchingData(EquityTT,NasdaqTT);
StockIndexCorr(istocknum,3)=nowCorr3;
% Compare to the Ruseel 2000
[nowCorr4] = FindMatchingData(EquityTT,Rusell2000TT);
StockIndexCorr(istocknum,4)=nowCorr4;
ab=1;
end