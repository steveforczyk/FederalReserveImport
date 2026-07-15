function [momentum] = CreateTMOMTable(WorkTT)
% Create and Array in the Proper format to input to the tsmom
% function
% Written By: Stephen Forczyk
% Created: Feb 15,2025
% Revised:-----

momentum=[];
TMOM=WorkTT;
TMOM.Volume = [];
TMOM.AdjClose = [];
TMOM.Meandays10 = [];
TMOM.Meandays50 = [];
TMOM.nowDate = [];
momentum = tsmom(TMOM); 
ab=1;
end