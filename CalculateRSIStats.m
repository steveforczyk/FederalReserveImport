function CalculateRSIStats(RSIWhole)
% Calculate the stats for selected RSI items
% Written By: Stwephen Forczyk
% Created: Feb 5,2025
% Revised:Feb 10,2025 moved assignment of RSI values inside this function
% to reduce code length
%global RSIStats istocknum meanRSI;
%global fid;
meanRSI=0;
minRSI=0;
maxRSI=0;
stdevRSI=0;

meanRSI=mean(RSIWhole,'omitnan');
minRSI=min(RSIWhole,[],"all",'omitnan');
maxRSI=max(RSIWhole,[],"all",'omitnan');
stdevRSI=std(RSIWhole,'omitmissing');
RSIStats(istocknum,1)=meanRSI;
RSIStats(istocknum,2)=minRSI;
RSIStats(istocknum,3)=maxRSI;
RSIStats(istocknum,4)=stdevRSI;

end