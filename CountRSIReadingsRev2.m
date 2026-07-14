function [FirstStatsObj] = CountRSIReadingsRev2(FirstStatsObj,RSIWhole)
% This function will take a RSI Table and count the number of readings that
% were oversold,neutral or overbought modified from original version to
% use OOP
% Written By: Stephen Forczyk
% Created: May 23,2025
% Revised: May 24,2023 Store only 1 stock stats in the array


% Revised: 
% global RSIStats RSILowLimit RSIHighLimit istocknum;
% global fid;

numlow=0;
numneutral=0;
numhigh=0.0;
RSILowLimit=FirstStatsObj.RSILowLimit;
RSIHighLimit=FirstStatsObj.RSIHighLimit;
istocknum=FirstStatsObj.istocknum;
numvals=length(RSIWhole);
RSIStats=FirstStatsObj.RSIStats;
meanRSI=RSIStats(1,1);
minRSI=RSIStats(1,2);
maxRSI=RSIStats(1,3);
stdevRSI=RSIStats(1,4);

for ii=1:numvals
    nowval=RSIWhole(ii,1);
    a1=isnan(RSIWhole(ii,1));
    if(a1==0)% It is not a NaN so use it
        if(nowval<RSILowLimit)
            numlow=numlow+1;
        elseif((nowval>=RSILowLimit) && (nowval<RSIHighLimit))
            numneutral=numneutral+1;
        elseif(nowval>RSIHighLimit)
            numhigh=numhigh+1;
        end
    end
end %%
RSIStats(1,1)=meanRSI;
RSIStats(1,2)=minRSI;
RSIStats(1,3)=maxRSI;
RSIStats(1,4)=stdevRSI;
RSIStats(1,5)=numlow;
RSIStats(1,6)=numneutral;
RSIStats(1,7)=numhigh;
FirstStatsObj.RSIStats=RSIStats;
ab=1;
end
