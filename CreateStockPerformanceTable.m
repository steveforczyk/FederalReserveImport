function [StockPerformanceTable] = CreateStockPerformanceTable(StockStats,StockSymbols,dataYear)
% Create a table of stocks that shows their performance for a single year
% Written By: Stephen Forczyk
% Created Mar 29,2025
% Revised

numStocks=length(StockSymbols);

startPrice=StockStats(:,1);
endPrice=StockStats(:,2);
AnnualGainDollars=StockStats(:,3);
AnnualGainPct=StockStats(:,4);
DownDays=StockStats(:,5);
UpDays=StockStats(:,6);
Volatility=StockStats(:,7);
ReportYears=dataYear*ones(numStocks,1);
StockPerformanceTable = table(StockSymbols,startPrice,endPrice,AnnualGainDollars,AnnualGainPct,DownDays,UpDays,Volatility,ReportYears);
end