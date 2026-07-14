function [status,errmsg] = AddTableToLogFile(WorkTableTT,logfilename)
% This function will add a selected TimeTable or Table to the log file
% 
% Written By: Stephen Forczyk
% Created: March 1,2024
% Revised:-------
global fid logfilepath ;

hdrstr1='     Date    Open    High    Low   Close   AdjClose  Volume     Mean10  Mean50  nowDate';
fprintf(fid,'%s\n',hdrstr1);
fpathname = fullfile(logfilepath,logfilename);
[status]=fclose(fid);
writetimetable(WorkTableTT,fpathname,'Delimiter','\t','WriteMode','append'); % This writes ti table to the text file
[fid,errmsg]=fopen(fpathname,'a');
fprintf(fid,'\n');
end