%% Decoded Financial Highlights Variables
    nowSheet=sheets(8);
    headerlinesIn=1;
    opts = detectImportOptions(EquityHistoricalFile,'Sheet','Financial_Highlights');
    A = readcell(EquityHistoricalFile,opts);
    numcells=height(A);
    highlightstr=strcat('Data from File-',EquityHistoricalFile,'-Financial-Highlights had-',num2str(numcells),'-data points on it');
    fprintf(fid,'\n');
    fprintf(fid,'%40s\n',highlightstr);
    disp(highlightstr)
    Stock.FiscalYearEnd=char(A{1,2});
    Stock.MostRecentQTR=char(A{2,2});
    Stock.ProfitMarginPct=1*A{4,2};
    Stock.TTMOpMarginPct=1*A{5,2};
    Stock.TTMReturnOnAssetsPct=1*A{7,2};
    FinanceS=struct('FiscalYearEnd',[],'MostRecentQTR',[],'ProfitMarginPct',[],'TTMOpMarginPct',[],'TTMReturnOnAssetsPct',[],...
        'TTMReturnOnEquityPct',[],'RevenueBTTM',[],'RevenuePerShareTTM',[],'QuartRevenueGrowthyoyPct',[],...
        'GrossProfitBttm',[],'EBITDABillions',[],'NetIncomeToCommonBTTM',[],'DilutedEPSttm',[],...
        'QtrEarnGrowthyoyPct',[],'TotalCashmrqB',[],'TotalCashPerShare',[],'TotalDebtEquityBmrq',[],...
        'TotalDebtEquityRatioPctmrq',[],'CurrentRatio',[],'BookValuePerSharemrq',[],'OperatingCashFlowBttm',[],...
        'LeveredFreeCashFlowBttm',[]);
    fprintf(fid,'%30s\n','Start Pulling out Financial Highlight Data');
    disp('Start Pulling out Financial Highlight Data');
    WorkFinS=FinanceS;
    WorkFinS.FiscalYearEnd=char(A{1,2});
    WorkFinS.MostRecentQTR=char(A{2,2});
    WorkFinS.ProfitMarginPct=1*A{4,2};
    WorkFinS.TTMOpMarginPct=1*A{5,2};
    WorkFinS.TTMReturnOnAssetsPct=1*A{7,2};
    WorkFinS.TTMReturnOnEquityPct=1*A{8,2};
    xval=A{10,2};
    WorkFinS.RevenueBTTM=xval;
    WorkFinS.RevenuePerShareTTM=A{11,2};
    WorkFinS.QuartRevenueGrowthyoyPct=1*A{12,2};
    xval=A{13,2};
    WorkFinS.GrossProfitBttm=xval;
    xval=A{14,2};
    WorkFinS.EBITDABillions=xval;
    xval=A{15,2};
    WorkFinS.NetIncomeToCommonBTTM=xval;
    WorkFinS.DilutedEPSttm=A{16,2};
    WorkFinS.QtrEarnGrowthyoyPct=100*A{17,2};
    xval=A{19,2};
    WorkFinS.TotalCashmrqB=xval;
    WorkFinS.TotalCashPerShare=A{20,2};
    xval=A{21,2};
    WorkFinS.TotalDebtEquityBmrq=xval;
    xval=A{22,2};
    WorkFinS.TotalDebtEquityRatioPctmrq=xval;
    WorkFinS.CurrentRatio=A{23,2};
    WorkFinS.BookValuePerSharemrq=A{24,2};
    xval=A{26,2};
    WorkFinS.OperatingCashFlowBttm=xval;
    xval=A{27,2};
    WorkFinS.LeveredFreeCashFlowBttm=xval;
    fprintf(fid,'%30s\n','End pulling out Financial Highlight Data');
    disp('End pulling out Financial Highlight Data');
    fprintf(fid,'\n');