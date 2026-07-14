% Create a List of Yahoo Cash Flow Variable Names to match a list of
% variables where they will be stored
%
% Written By: Stephen Forczyk
% Created: April 30,2025
% Revised: 

tablepath='K:\Investing2\Tables\';
codepath='K:\Investing2\Code\';
eval(['cd ' tablepath(1:length(tablepath)-1)]);
CashFlowFileName='CashFlowListRev0.mat';
CashFlowNames=cell(71,1);
CashFlowNames{1,1}='OperatingCashFlow';
CashFlowNames{2,1}='CashFlowFromContinuingOperatingActivities';
CashFlowNames{3,1}='NetIncomeFromContinuingOperations';
CashFlowNames{4,1}='OperatingGainsLosses';
CashFlowNames{5,1}='GainLossOnSaleOfBusiness';
CashFlowNames{6,1}='GainLossOnSaleOfPPE';
CashFlowNames{7,1}='GeneralAndAdministrativeExpense';
CashFlowNames{8,1}='GainLossOnInvestmentSecurities';
CashFlowNames{9,1}='DepreciationAmortizationDepletion';
CashFlowNames{10,1}='DeferredTax';
CashFlowNames{11,1}='DeferredIncomeTax';
CashFlowNames{12,1}='UnrealizedGainLossOnInvestmentSecurities';
CashFlowNames{13,1}='StockBasedCompensation';
CashFlowNames{14,1}='ExcessTaxBenefitFromStockBasedCompensation';
CashFlowNames{15,1}='OtherNonCashItems';
CashFlowNames{16,1}='ChangeInWorkingCapital';
CashFlowNames{17,1}='ChangeInReceivables';
CashFlowNames{18,1}='ChangesInAccountReceivables';
CashFlowNames{19,1}='ChangeInInventory';
CashFlowNames{20,1}='ChangeInPrepaidAssets';
CashFlowNames{21,1}='ChangeInPayablesAndAccruedExpense';
CashFlowNames{22,1}='ChangeInPayable';
CashFlowNames{23,1}='ChangeInTaxPayable';
CashFlowNames{24,1}='ChangeInIncomeTaxPayable';
CashFlowNames{25,1}='ChangeInAccountPayable';
CashFlowNames{26,1}='ChangeInAccruedExpense';
CashFlowNames{27,1}='ChangeInOtherCurrentAssets';
CashFlowNames{28,1}='ChangeInOtherCurrentLiabilities';
CashFlowNames{29,1}='ChangeInOtherWorkingCapital';
CashFlowNames{30,1}='InvestingCashFlow';
CashFlowNames{31,1}='CashFlowFromContinuingInvestingActivities';
CashFlowNames{32,1}='NetPPEPurchaseAndSale';
CashFlowNames{33,1}='PurchaseOfPPE';
CashFlowNames{34,1}='SaleOfPPE';
CashFlowNames{35,1}='NetIntangiblesPurchaseAndSale';
CashFlowNames{36,1}='PurchaseOfIntangibles';
CashFlowNames{37,1}='NetBusinessPurchaseAndSale';
CashFlowNames{38,1}='PurchaseOfBusiness';
CashFlowNames{39,1}='SaleOfBusiness';
CashFlowNames{40,1}='NetInvestmentPurchaseAndSale';
CashFlowNames{41,1}='PurchaseOfInvestment';
CashFlowNames{42,1}='SaleOfInvestment';
CashFlowNames{43,1}='NetOtherInvestingChanges';
CashFlowNames{44,1}='FinancingCashFlow';
CashFlowNames{45,1}='CashFlowFromContinuingFinancingActivities';
CashFlowNames{46,1}='NetIssuancePaymentsOfDebt';
CashFlowNames{47,1}='NetLongTermDebtIssuance';
CashFlowNames{48,1}='LongTermDebtIssuance';
CashFlowNames{49,1}='LongTermDebtPayments';
CashFlowNames{50,1}='NetShortTermDebtIssuance';
CashFlowNames{51,1}='ShortTermDebtIssuance';
CashFlowNames{52,1}='ShortTermDebtPayments';
CashFlowNames{53,1}='NetCommonStockIssuance';
CashFlowNames{54,1}='CommonStockIssuance';
CashFlowNames{55,1}='CommonStockPayments';
CashFlowNames{56,1}='CashDividendsPaid';
CashFlowNames{57,1}='CommonStockDividendPaid';
CashFlowNames{58,1}='ProceedsFromStockOptionExercised';
CashFlowNames{59,1}='NetOtherFinancingCharges';
CashFlowNames{60,1}='EndCashPosition';
CashFlowNames{61,1}='ChangesInCash';
CashFlowNames{62,1}='BeginningCashPosition';
CashFlowNames{63,1}='OtherCashAdjustmentOutsideChangeinCash';
CashFlowNames{64,1}='IncomeTaxPaidSupplementalData';
CashFlowNames{65,1}='InterestPaidSupplementalData';
CashFlowNames{66,1}='CapitalExpenditure';
CashFlowNames{67,1}='IssuanceOfCapitalStock';
CashFlowNames{68,1}='IssuanceOfDebt';
CashFlowNames{69,1}='RepaymentOfDebt';
CashFlowNames{70,1}='RepurchaseOfCapitalStock';
CashFlowNames{71,1}='FreeCashFlow';



% Now start bulding the list to associate variable names with assigned
% variables
numVars=71;
CashFlowAssignment=cell(numVars+1,7);
CashFlowAssignment{1,1}='Yahoo Label';
CashFlowAssignment{1,2}='Matlab Variable';
CashFlowAssignment{1,3}='Match Found';
CashFlowAssignment{1,4}='Match Variable Index';
CashFlowAssignment{1,5}='Retrieved String';
CashFlowAssignment{1,6}='Retrieved Value';
CashFlowAssignment{1,7}='#Variables Imported';
CashFlowAssignment{1,8}='Variable Alias';

% Add the Yahoo variable names to the list
for n=2:numVars+1
    CashFlowAssignment{n,1}=CashFlowNames{n-1,1};
    CashFlowAssignment{n,2}=CashFlowNames{n-1,1};
    CashFlowAssignment{n,3}=0;
    CashFlowAssignment{n,4}=0;
    CashFlowAssignment{n,5}=[];
    CashFlowAssignment{n,6}=0;
    CashFlowAssignment{n,7}=0;
    CashFlowAssignment{n,8}=[];
end
% Add the corresponding Matlab Variables
CashFlowAssignment{2,8}='OpCashFlow';
CashFlowAssignment{3,8}='CashFlowContOps';
CashFlowAssignment{4,8}='NetIncomeConOps';
CashFlowAssignment{5,8}='OpGainsLosses';
CashFlowAssignment{6,8}='GLSaleOfBusiness';
CashFlowAssignment{7,8}='GainLossOnSaleOfPPE';
CashFlowAssignment{8,8}='AdminExpense';
CashFlowAssignment{9,8}='GLInvestSecurities';
CashFlowAssignment{10,8}='DeprecAmortDepletion';
CashFlowAssignment{11,8}='DeferTax';
CashFlowAssignment{12,8}='DeferIncTax';
CashFlowAssignment{13,8}='UnrealGLInvestSecurities';
CashFlowAssignment{14,8}='StockBasedCompen';
CashFlowAssignment{15,8}='ExcessTaxBenefit';
CashFlowAssignment{16,8}='OtherNonCashItems';
CashFlowAssignment{17,8}='ChngInWorkCapital';
CashFlowAssignment{18,8}='ChngInReceivables';
CashFlowAssignment{19,8}='ChangAcctReceivables';
CashFlowAssignment{20,8}='ChngInventory';
CashFlowAssignment{21,8}='ChngPrepaidAssets';
CashFlowAssignment{22,8}='ChngAccruedExpense';
CashFlowAssignment{23,8}='ChngPayable';
CashFlowAssignment{24,8}='ChngeTaxPayable';
CashFlowAssignment{25,8}='ChngeIncomeTaxPayable';
CashFlowAssignment{26,8}='ChngeAccountPayable';
CashFlowAssignment{27,8}='ChngeAccruedExpense';
CashFlowAssignment{28,8}='ChngeOtherCAssets';
CashFlowAssignment{29,8}='ChngeOtherCLiabilities';
CashFlowAssignment{30,8}='ChngeOtherWorkCapital';
CashFlowAssignment{31,8}='InvestCashFlow';
CashFlowAssignment{32,8}='CashFlowContInvesting';
CashFlowAssignment{33,8}='NetPPEPAndS';
CashFlowAssignment{34,8}='PurchasePPE';
CashFlowAssignment{35,8}='SalePPE';
CashFlowAssignment{36,8}='NetIntangPAndS';
CashFlowAssignment{37,8}='PurchOfIntang';
CashFlowAssignment{38,8}='NetBusPAndS';
CashFlowAssignment{39,8}='PurchOfBusin';
CashFlowAssignment{40,8}='SaleOfBusin';
CashFlowAssignment{41,8}='NetInvestPAndS';
CashFlowAssignment{42,8}='PurchaseOfInvest';
CashFlowAssignment{43,8}='SaleOfInvestment';
CashFlowAssignment{44,8}='NetOtherInvesyChngs';
CashFlowAssignment{45,8}='FinanCashFlow';
CashFlowAssignment{46,8}='CashFlowContFinancing';
CashFlowAssignment{47,8}='NetIssPaymentOfDebt';
CashFlowAssignment{48,8}='NetLTDebtIssuance';
CashFlowAssignment{49,8}='LTDebtIssuance';
CashFlowAssignment{50,8}='LongTermDebtPayments';
CashFlowAssignment{51,8}='NetSTermDebtIssuance';
CashFlowAssignment{52,8}='STDebtIssuance';
CashFlowAssignment{53,8}='STDebtPayments';
CashFlowAssignment{54,8}='NetCommonStockIss';
CashFlowAssignment{55,8}='CommonStockIss';
CashFlowAssignment{56,8}='CommonStockPay';
CashFlowAssignment{57,8}='CashDividendsPaid';
CashFlowAssignment{58,8}='CommonStockDividendPaid';
CashFlowAssignment{59,8}='ProceedsStockOptions';
CashFlowAssignment{60,8}='NetOtherFinCharges';
CashFlowAssignment{61,8}='EndCashPosition';
CashFlowAssignment{62,8}='ChangesInCash';
CashFlowAssignment{63,8}='BeginCashPosition';
CashFlowAssignment{64,8}='OtherCashAdjustment';
CashFlowAssignment{65,8}='IncTaxPaidSupData';
CashFlowAssignment{66,8}='InterestPaidSupData';
CashFlowAssignment{67,8}='CapitalExpend';
CashFlowAssignment{68,8}='IssuanceCapStock';
CashFlowAssignment{69,8}='IssuanceOfDebt';
CashFlowAssignment{70,8}='RepaymentOfDebt';
CashFlowAssignment{71,8}='RepurchaseCapStock';
CashFlowAssignment{72,8}='FreeCashFlow';
save CashFlowListRev0.mat CashFlowAssignment CashFlowNames
disp('all done')
eval(['cd ' codepath(1:length(codepath)-1)]);


