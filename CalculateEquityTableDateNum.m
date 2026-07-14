function [outTableTT] = CalculateEquityTableDateNum(WorkTable,Meandays10,Meandays50,numprices)
% This routine is designed to  calculate the datenum value for each entry
% in the original table.Note the datenum function is being phased out in
% Matlab but still works.This may have to be changed later
% Written By: Stephen Forczyk
% Created: Feb 15,2025
% Revised:---
% 
nowDate=zeros(numprices,1);
for n=1:numprices
    temp=char(WorkTable.Date(n));
    nowDate(n,1)=datenum(temp);
end
T2 = addvars(WorkTable,Meandays10,Meandays50,nowDate);
outTableTT = table2timetable(T2,'RowTimes','Date');
ab=1;
end