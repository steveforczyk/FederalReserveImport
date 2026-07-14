function [FirstStatsObj]=CalculateRSIStatsRev2(FirstStatsObj,RSIWhole)
% Calculate the stats for selected RSI items
% modified from original version to use OOP
% Written By: Stwephen Forczyk
% Created: May 23,2025,2025
% Revised: May 24,2025 turn this back to record the stats from only one
% stock
% to reduce code length
%global RSIStats istocknum meanRSI;
%global fid;
% meanRSI=0;
% minRSI=0;
% maxRSI=0;
% stdevRSI=0;

istocknum=FirstStatsObj.istocknum;

meanRSI=mean(RSIWhole,'omitnan');
minRSI=min(RSIWhole,[],"all",'omitnan');
maxRSI=max(RSIWhole,[],"all",'omitnan');
stdevRSI=std(RSIWhole,'omitmissing');
RSIStats(1,1)=meanRSI;
RSIStats(1,2)=minRSI;
RSIStats(1,3)=maxRSI;
RSIStats(1,4)=stdevRSI;
RSIStats(1,5)=0;
RSIStats(1,6)=0;
RSIStats(1,7)=0;
FirstStatsObj.RSIStats=RSIStats;
ab=1;
end