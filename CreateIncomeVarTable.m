% Create a List of Yahoo Income Variable Names to match a list of
% variables where they will be stored
%
% Written By: Stephen Forczyk
% Created: April 26,2025
% Revised: 

tablepath='K:\Investing2\Tables\';
eval(['cd ' tablepath(1:length(tablepath)-1)]);
IncomeVarFileName='IncomeVarListRev0.mat';
IncomeVarNames=cell(63,1);
IncomeVarNames{1,1}='TotalRevenue';
IncomeVarNames{2,1}='OperatingRevenue';
IncomeVarNames{3,1}='CostOfRevenue';
IncomeVarNames{4,1}='GrossProfit';
IncomeVarNames{5,1}='OperatingExpense';
IncomeVarNames{6,1}='SellingGeneralAndAdministration';
IncomeVarNames{7,1}='GeneralAndAdministrativeExpense';
IncomeVarNames{8,1}='SalariesAndWages';
IncomeVarNames{9,1}='DepreciationAmortizationDepletionIncomeStatement';
IncomeVarNames{10,1}='DepreciationAndAmortizationInIncomeStatement';
IncomeVarNames{11,1}='DepreciationIncomeStatement';
IncomeVarNames{12,1}='Amortization';
IncomeVarNames{13,1}='AmortizationOfIntangiblesIncomeStatement';
IncomeVarNames{14,1}='ProvisionForDoubtfulAccounts';
IncomeVarNames{15,1}='OtherOperatingExpenses';
IncomeVarNames{16,1}='OperatingIncome';
IncomeVarNames{17,1}='NetNonOperatingInterestIncomeExpense';
IncomeVarNames{18,1}='InterestIncomeNonOperating';
IncomeVarNames{19,1}='InterestExpenseNonOperating';
IncomeVarNames{20,1}='OtherIncomeExpense';
IncomeVarNames{21,1}='GainOnSaleOfSecurity';
IncomeVarNames{22,1}='EarningsFromEquityInterest';
IncomeVarNames{23,1}='SpecialIncomeCharges';
IncomeVarNames{24,1}='RestructuringAndMergernAcquisition';
IncomeVarNames{25,1}='ImpairmentOfCapitalAssets';
IncomeVarNames{26,1}='WriteOff';
IncomeVarNames{27,1}='OtherSpecialCharges';
IncomeVarNames{28,1}='GainOnSaleOfBusiness';
IncomeVarNames{29,1}='OtherNonOperatingIncomeExpenses';
IncomeVarNames{30,1}='PretaxIncome';
IncomeVarNames{31,1}='TaxProvision';
IncomeVarNames{32,1}='NetIncomeCommonStockholders';
IncomeVarNames{33,1}='NetIncome';
IncomeVarNames{34,1}='NetIncomeIncludingNoncontrollingInterests';
IncomeVarNames{35,1}='NetIncomeContinuousOperations';
IncomeVarNames{36,1}='NetIncomeDiscontinuousOperations';
IncomeVarNames{37,1}='NetIncomeExtraordinary';
IncomeVarNames{38,1}='NetIncomeFromTaxLossCarryforward';
IncomeVarNames{39,1}='MinorityInterests';
IncomeVarNames{40,1}='PreferredStockDividends';
IncomeVarNames{41,1}='AverageDilutionEarnings';
IncomeVarNames{42,1}='DilutedNIAvailtoComStockholders';
IncomeVarNames{43,1}='BasicEPS';
IncomeVarNames{44,1}='DilutedEPS';
IncomeVarNames{45,1}='BasicAverageShares';
IncomeVarNames{46,1}='DilutedAverageShares';
IncomeVarNames{47,1}='TotalOperatingIncomeAsReported';
IncomeVarNames{48,1}='TotalExpenses';
IncomeVarNames{49,1}='NetIncomeFromContinuingAndDiscontinuedOperation';
IncomeVarNames{50,1}='NormalizedIncome';
IncomeVarNames{51,1}='InterestIncome';
IncomeVarNames{52,1}='InterestExpense';
IncomeVarNames{53,1}='NetInterestIncome';
IncomeVarNames{54,1}='EBIT';
IncomeVarNames{55,1}='EBITDA';
IncomeVarNames{56,1}='ReconciledCostOfRevenue';
IncomeVarNames{57,1}='ReconciledDepreciation';
IncomeVarNames{58,1}='NetIncomeFromContinuingOperationNetMinorityInterest';
IncomeVarNames{59,1}='TotalUnusualItemsExcludingGoodwill';
IncomeVarNames{60,1}='TotalUnusualItems';
IncomeVarNames{61,1}='NormalizedEBITDA';
IncomeVarNames{62,1}='TaxRateForCalcs';
IncomeVarNames{63,1}='TaxEffectOfUnusualItems';
% save 'IncomeVarList.mat' IncomeVarNames
% ab=1;
% 
% eval(['cd ' tablepath(1:length(tablepath)-1)]);
% load(IncomeVarFileName);
% numVars=length(IncomeVarNames);
% dispstr=strcat('A total of-',num2str(numVars),'-variable names were loaded from the file-',...
%     IncomeVarFileName);
% disp(dispstr)


% Now start bulding the list to associate variable names with assigned
% variables
numVars=63;
IncomeVarAssignment=cell(numVars+1,7);
IncomeVarAssignment{1,1}='Yahoo Label';
IncomeVarAssignment{1,2}='Matlab Variable';
IncomeVarAssignment{1,3}='Match Found';
IncomeVarAssignment{1,4}='Match Variable Index';
IncomeVarAssignment{1,5}='Retrieved String';
IncomeVarAssignment{1,6}='Retrieved Value';
IncomeVarAssignment{1,7}='#Variables Imported';
IncomeVarAssignment{1,8}='Variable Alias';

% Add the Yahoo variable names to the list
for n=2:numVars+1
    IncomeVarAssignment{n,1}=IncomeVarNames{n-1,1};
    IncomeVarAssignment{n,2}=IncomeVarNames{n-1,1};
    IncomeVarAssignment{n,3}=0;
    IncomeVarAssignment{n,4}=0;
    IncomeVarAssignment{n,5}=[];
    IncomeVarAssignment{n,6}=0;
    IncomeVarAssignment{n,7}=0;
    IncomeVarAssignment{n,8}=[];
end
% Add the corresponding Matlab Variables
IncomeVarAssignment{2,8}='TotRevenue';
IncomeVarAssignment{3,8}='OperRevenue';
IncomeVarAssignment{4,8}='CostRevenue';
IncomeVarAssignment{5,8}='GProfit';
IncomeVarAssignment{6,8}='OpExpense';
IncomeVarAssignment{7,8}='GenAdmin';
IncomeVarAssignment{8,8}='AdminExpense';
IncomeVarAssignment{9,8}='Salaries';
IncomeVarAssignment{10,8}='DeprecAmortDepletion';
IncomeVarAssignment{11,8}='DeprecAmort';
IncomeVarAssignment{12,8}='DeprecIncome';
IncomeVarAssignment{13,8}='Amort';
IncomeVarAssignment{14,8}='AmortIntang';
IncomeVarAssignment{15,8}='ProvDoubtAccts';
IncomeVarAssignment{16,8}='OtherOpExp';
IncomeVarAssignment{17,8}='OpIncome';
IncomeVarAssignment{18,8}='NetNonOpInterIncExpen';
IncomeVarAssignment{19,8}='IntIncNonOp';
IncomeVarAssignment{20,8}='IntExpNonOp';
IncomeVarAssignment{21,8}='OtherIncExp';
IncomeVarAssignment{22,8}='GainSaleOfSecurity';
IncomeVarAssignment{23,8}='EarnEquityInterest';
IncomeVarAssignment{24,8}='SpecialIncCharges';
IncomeVarAssignment{25,8}='Restructuring';
IncomeVarAssignment{26,8}='ImpairmentCapAssets';
IncomeVarAssignment{27,8}='WriteOff';
IncomeVarAssignment{28,8}='OtherSpecCharges';
IncomeVarAssignment{29,8}='GainSaleOfBusiness';
IncomeVarAssignment{30,8}='OtherNonOpIncExp';
IncomeVarAssignment{31,8}='PreTaxIncome';
IncomeVarAssignment{32,8}='TaxProvision';
IncomeVarAssignment{33,8}='NetIncCStockholders';
IncomeVarAssignment{34,8}='NetIncome';
IncomeVarAssignment{35,8}='NetIncomeNoncInterests';
IncomeVarAssignment{36,8}='NetIncomeCOps';
IncomeVarAssignment{37,8}='NetIncomeDisconOps';
IncomeVarAssignment{38,8}='NetIncomeExtraordinary';
IncomeVarAssignment{39,8}='NetIncomeTaxLossCF';
IncomeVarAssignment{40,8}='MinorityInterests';
IncomeVarAssignment{41,8}='PrefStockDividends';
IncomeVarAssignment{42,8}='AverDiluEarnings';
IncomeVarAssignment{43,8}='DiluNIComStockhold';
IncomeVarAssignment{44,8}='BasicEPS';
IncomeVarAssignment{45,8}='DilutedEPS';
IncomeVarAssignment{46,8}='BasicAvgShares';
IncomeVarAssignment{47,8}='DilutedAvgShares';
IncomeVarAssignment{48,8}='TotOpReportedIncome';
IncomeVarAssignment{49,8}='TotalExpenses';
IncomeVarAssignment{50,8}='NetIncOperations';
IncomeVarAssignment{51,8}='NormIncome';
IncomeVarAssignment{52,8}='InterestIncome';
IncomeVarAssignment{53,8}='InterestExpense';
IncomeVarAssignment{54,8}='NetInterestInc';
IncomeVarAssignment{55,8}='EBIT';
IncomeVarAssignment{56,8}='EBITDA';
IncomeVarAssignment{57,8}='ReconciledCOR';
IncomeVarAssignment{58,8}='ReconciledDepre';
IncomeVarAssignment{59,8}='NetIncomeMinorityInt';
IncomeVarAssignment{60,8}='TotalUnusualItemsExGoodwill';
IncomeVarAssignment{61,8}='TotalUnusualItems';
IncomeVarAssignment{62,8}='NormalizedEBITDA';
IncomeVarAssignment{63,8}='TaxRateForCalcs';
IncomeVarAssignment{64,8}='TaxEffUnusualItems';

save IncomeVarListRev3.mat IncomeVarAssignment IncomeVarNames
disp('all done')


