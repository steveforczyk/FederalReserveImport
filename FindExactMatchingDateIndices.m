function [startIndex,endIndex] = FindExactMatchingDateIndices(desiredStartNum,desiredEndNum,WorkingTT)
% The purpose of this function is to find the exact indices in the
% EquityTimeTable that match the desired start and end dates
% 
% Written By: Stephen Forczyk
% Created: April 10,2025
% Revised:
startIndex=0;
endIndex=0;
numvals=height(WorkingTT);

for n=1:numvals
    dispstr=strcat('looking at index-',num2str(n));
    disp(dispstr)
    entry=WorkingTT(n,'nowDate');
    nowDateNum=entry.nowDate;
    if((nowDateNum>=desiredStartNum) && (startIndex==0))
        startIndex=n;
        ab=1;
        dispstr=strcat('StartIndex=',num2str(startIndex));
        disp(dispstr)
    end
    if((nowDateNum>=desiredEndNum) && (endIndex==0) )
        endIndex=n;
        ab=2;
        dispstr=strcat('EndIndex=',num2str(endIndex));
        disp(dispstr)
    end


end
ab=3;
end