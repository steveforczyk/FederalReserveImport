function CreateInvestmentReportHeader(PStatsObj)
% This function will create the initial "boilerplate" header info
% for the stock investment report header
% Written By: Stephen Forczyk
% Created: Feb 1-,2025
% Revised: March 2025 added elements for Chapter 1
% Classification: Unclassified

global ActivityFile1 ActivityFile2 ActivityFile3;

global total_comissions divsum dataYear;
global RCoeff RCoeffNames;
global IRAStockList2024 TableList TableFileName BollingerList;
global EquityAAPL EquityABBV EquityALB EquityAMD EquityAMZN EquityCAT;
global EquityCCL EquityCDNS EquityCMI EquityDBX EquityDELL EquityDOCU;
global EquityENB EquityET EquityGE EquityGOOG EquityGSL EquityHII;
global EquityHWM EquityLMT EquityMSFT EquityNVDA EquityNVO EquityOC;
global EquityPAGP EquityPFE EquityPHM EquityPLTR EquityRCL EquityRIO;
global EquitySMCI EquityTHC EquityTOL EquityVZ EquityXOM EquityYOU;
global EquityAAPLTT EquityABBVTT EquityALBTT EquityAMDTT EquityAMZNTT EquityCATTT;
global EquityCCLTT EquityCDNSTT EquityCMITT EquityDBXTT EquityDELLTT EquityDOCUTT;
global EquityENBTT EquityETTT EquityGETT EquityGOOGTT EquityGSLTT EquityHIITT;
global EquityHWMTT EquityLMTTT EquityMSFTTT EquityNVDATT EquityNVOTT EquityOCTT;
global EquityPAGPTT EquityPFETT EquityPHMTT EquityPLTRTT EquityRCLTT EquityRIOTT;
global EquitySMCITT EquityTHCTT EquityTOLTT EquityVZTT EquityXOMTT EquityYOUTT;
global WorkBollTT BollAAPLTT BollABBVTT BollALBTT BollAMDTT BollAMZNTT;
global BollCATTT BollCCLTT BollCDNSTT BollCMITT BollDBXTT BollDELLTT BollDOCUTT;
global BollENBTT BollETTT BollGETT BollGOOGTT BollGSLTT BollHIITT BollNVOTT;
global BollHWMTT BollLMTTT BollMSFTTT BollNVDATT BollOCTT BollPAGPTT;
global BollPFETT BollPHMTT BollPLTRTT BollRCLTT BollRIOTT BollSMCITT;
global BollTHCTT BollTOLTT BollVZTT BollXOMTT BollYOUTT;
global RSIStats RSILowLimit RSIHighLimit;
global RSIAAPLTT RSIABBVTT RSIALBTT RSIAMDTT RSIAMZNTT RSICATTT RSICCLTT;
global RSICDNSTT RSICMITT RSIDBXTT RSIDELLTT RSIDOCUTT RSIENBTT RSIETTT;
global RSIGETT RSIGOOGTT RSIGSLTT RSIHIITT RSIHWMTT RSILMTTT ;
global RSIMSFTTT RSINVDATT RSINVOTT RSIOCTT RSIPAGPTT RSIPFETT;
global RSIPHMTT RSIPLTRTT RSIRCLTT RSIRIOTT RSISMCITT RSITHCTT;
global RSITOLTT RSIVZTT RSIXOMTT RSIYOUTT;
global RMonthAAPL RMonthABBV RMonthALB RMonthAMD RMonthAMZN RMonthCAT;
global RMonthCCL RMonthCDNS RMonthCMI RMonthDBX RMonthDELL RMonthDOCU;
global RMonthENB RMonthET RMonthGE RMonthGOOG RMonthGSL RMonthHII RMonthHWM;
global RMonthLMT RMonthMSFT RMonthNVDA RMonthNVO RMonthOC  RMonthPAGP;
global RMonthPFE RMonthPHM RMonthPLTR RMonthRCL RMonthRIO RMonthSMCI;
global RMonthTHC RMonthTOL RMonthVZ RMonthXOM RMonthYOU;
global StockStats StockHdrs SheetRecords sheets StockList StockSymbols;
global StockTable MeasurementDate StockNames RCoeff1D StockCorrTable SortedStockTable;
global Months HeatMapTable XCenters YCenters;
global TSeries1Hdrs TSeries1Table;


global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc;
global JpegCounter JpegFileList;


%global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath tiffpath;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath pdfpath;
global jpegpath northamericalakespath logpath pdfpath ;

global mappath gridpath countyshapepath nationalshapepath summarypath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
PStatsObj.govjpegpath=govjpegpath;
fid=PStatsObj.fid;
% Set Uo some tables
TSeries1Hdrs=cell(1,3);
TSeries1Hdrs{1,1}='Function Name';
TSeries1Hdrs{1,2}='Description';
TSeries1Hdrs{1,3}='Used In Script';
TSeries1Table{1,1}='adosc';
TSeries1Table{1,2}='Accumulation/Distribution oscillator';
TSeries1Table{1,3}='Yes';
TSeries1Table{2,1}='chaikosc';
TSeries1Table{2,2}='Chaikin oscillator';
TSeries1Table{2,3}='Yes';
TSeries1Table{3,1}='macd';
TSeries1Table{3,2}='Moving Average Convergence/Divergence (MACD)';
TSeries1Table{3,3}='Yes';
TSeries1Table{4,1}='stochosc';
TSeries1Table{4,2}='Stochastic oscillator';
TSeries1Table{4,3}='No';
TSeries1Table{5,1}='tsaccel';
TSeries1Table{5,2}='Acceleration between times';
TSeries1Table{5,3}='No';
TSeries1Table{6,1}='tsaccel';
TSeries1Table{6,2}='tsmom';
TSeries1Table{6,3}='Yes';

% Set some flags
JpegCounter=0;
import mlreportgen.dom.*;
import mlreportgen.report.*;
import mlreportgen.utils.*
% Create the report
    eval(['cd ' pdfpath(1:length(pdfpath)-1)]);
    rpt = Report(pdffilename,"pdf");
    open(rpt);
    rptstr1=strcat('////PDF file created for this run is-',pdffilename,'.pdf ////');
    fprintf(fid,'%s\n',rptstr1);
    rptstr2=strcat('PDF report can be found at-',pdfpath);
    fprintf(fid,'%s\n',rptstr2);
    rpt.Layout.Landscape = true;
    pageLayoutObj = PDFPageLayout;
    pageLayoutObj.PageSize.Orientation = "landscape";
    pageLayoutObj.PageSize.Height = "8.5in";
    pageLayoutObj.PageSize.Width = "11in";
    pageLayoutObj.PageMargins.Top = "0.5in";
    pageLayoutObj.PageMargins.Bottom = "0.5in";
    pageLayoutObj.PageMargins.Left = "0.5in";
    pageLayoutObj.PageMargins.Right = "0.5in";
    pageLayoutObj.PageMargins.Header = "0.3in";
    pageLayoutObj.PageMargins.Footer = "0.3in";
    add(rpt,pageLayoutObj)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
% add a title page
    tp = TitlePage();
    tp.Title = 'PortfolioAnnualAnalysisReport';
    tp.Subtitle = strcat('User Selected Data Year-',num2str(dataYear));
   % tp.Image = which('GOES-Logo.jpg');
    tp.Author = 'Stephen Forczyk';
    tp.Publisher = 'FRC';
    tp.PubDate = date();
    add(rpt,tp);
% add a table of contents
    tocc = TableOfContents;
    tocc.Title = Text('Table of Contents');
    tocc.Title.Color = 'blue';
    tocc.TOCObj.NumberOfLevels = 2; 
    add(rpt,tocc);
% Create Chapter 1 with general program information
    chapter = Chapter("Title", "Investment Report Basics");
    chapter.Layout.Landscape = true;
    add(chapter,Section('Purpose'));
    parastr1='Matlab and the Finanacial toolbox were used to create a the first of a series of tools to analayze,plot stock market data';
    parastr2=' The primary source of data was historical stock market quotes and other financial data downloaded from Yahoo/Finance.';
    parastr3=' In order to download most of the data the user is required to have a paid subscription to this service';
    parastr4=' The software scripts that perform this analysis is meant to use downloaded historical data along with.';
    parastr5=' functions drawn from the Matlab Fiancial Tooxbox to perform a variety of tasks relating to the selected investment portfolio.';
    parastr6=' This series of scripts in not intended to be a finished package-instead it is a testbed for future concepts';
    parastr7=strcat(parastr1,parastr2,parastr3,parastr4,parastr5,parastr6);
    p1 = Paragraph(parastr7);
    p1.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p1);
    add(chapter,Section('Example Use of Yahoo Finance Website'));
    parastr11='A series of images follow which will provide the user with an initial idea how to use the Yahoo Finance Website';
    parastr12=' The user can try some of the feature out with a free account.';
    parastr13=' Note that if the user is desiring to obtain and download serious data a paid up Gold account is required';
    parastr14=' Matabl Central provides some scripts to call other datasites but in general these no longer work.';
    parastr15=' This is because most of these sites now require a paid subscription.';
    parastr16=' The first chart will show the login process for Yahoo Finance';
    parastr17=strcat(parastr11,parastr12,parastr13,parastr14,parastr15,parastr16);
    % Start with the Yahoo login screen
    p2 = Paragraph(parastr17);
    p2.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p2); %changed Mar 9,7 PM
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    % Load the image of the login screen
    imdata = imread('YahooLoginScreen.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('YahooLoginScreen.jpg');
    text = Text('Yahoo Login Screen');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    % Now display the opening page of the Yahoo Site
    parastr21='The following chart shows a typical opening page of the Yahoo finance site';
    parastr22=' Tabs at the top of the page show the subject areas which can be selected on them.';
    parastr23=' In order to get to the desired finanlcial data for stock the use must type in a stock code in a window at the extreme upper right edge.';
    parastr24=strcat(parastr21,parastr22,parastr23);
    p3 = Paragraph(parastr24);
    p3.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p3); %changed Mar 9,7 PM
    br = PageBreak();
    add(chapter,br);
    % Proceed to enter a stock symbol 
    imdata = imread('XOMDataLookup.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMDataLookup.jpg');
    text = Text('Stock Symbol Insertion');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(round(nhigh/2)),'px');
    widthstr=strcat(num2str(round(nwid/2)),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
    % Show stock Front Page
    imdata = imread('XOMStockFrontPageRev2.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMStockFrontPageRev2.jpg');
    text = Text('Intial View Of XOM Stock Data');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    % Now display the opening page of the add a paragraph to explain the
    % graphic
    parastr31='In this example the symbol for XOM or Exxon Mobil was inserted to the search box';
    parastr32=' The image shows to the typical page display on Yahoo when this is done.';
    parastr33=' A green arrow on the left side points out where the majority of data is stored.';
    parastr34=' The historical data is a good start point to view detailed data over a selected time period for the selected security.';
    parastr35=strcat(parastr31,parastr32,parastr33,parastr34);
    p4 = Paragraph(parastr35);
    p4.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};  
    add(chapter,p4); % added Mar 9,2025 9 7PM
%   Show Historical XOM stock data
    imdata = imread('XOMHistoricalDataRev1.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMHistoricalDataRev1.jpg');
    text = Text('Small Sample of Daily Stock Vales For XOM');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
 %   Now display the opening page of the add a paragraph to explain the
 %   graphic
    parastr41='The graphic above shows a small slice of XOM closing prices over the Jan 1990 to Dec 2024';
    parastr42=' On the right side of the display is a download button-only available on Gold plans.';
    parastr43=' Pressing this button will download a CSV file that can be easily imported in Excel.';
    parastr44=' The columns available provided are useful in calculating technical indicators for stocks.';
    parastr45=' Before the data will be used they will be imported in Excels native format and imported then into Matlab';
    parastr46=strcat(parastr41,parastr42,parastr43,parastr44,parastr45);
    p5 = Paragraph(parastr46);
    p5.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p5);
% Now show a blowup of the XOM Daily Prices
    imdata = imread('XOMDailyPrices.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMDailyPrices.jpg');
    text = Text('Downloaded Daily Prices');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
 %   Now describe the graphic
    parastr51='Shown above is a blowup of just a few days worth of XOM stock prices.';
    parastr52=' Red arrows highlight 3 settings that need to be made prior to any download.';
    parastr53=' The left most arrow is used to select the date range-in this case covering a span of 35 years.';
    parastr54=' Clicking on this element will bring up a calender time GUI element to select the start and end dates.';
    parastr55=' The middle arrow is used to select a few items-the default choice is sat to stock prices.';
    parastr56=' The right arrow array selects the reporting interval which by default is det to days.';
    parastr57=' Once the proper selections are made Gold member account holders can click the download symbol at the right.';
    parastr58=' It is possible without a Gold level member to selelect the data manually and paste intp Excel but this is tedious.';
    parastr59=strcat(parastr51,parastr52,parastr53,parastr54,parastr55,parastr56,parastr57,parastr58);
    p6 = Paragraph(parastr59);
    p6.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p6);
% Now add the section of the XOM Valuation Data
    imdata = imread('XOM_Valuation.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOM_Valuation.jpg');
    text = Text('Downloaded Quaterly Stock Valuations');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
%   Now describe the graphic
    parastr61='Shown above is data taken from the Statistics section of the Yahoo Financial Data.';
    parastr62=' On the left side of the chart the red arrow points to the option selected.';
    parastr63=' This provides a top level view of the financial status of XOM on a quarterly basis.';
    parastr64=' As the figure shows,key data such as P/E values,PEG rates as wll as metrics as Price to Book ratios are presented by quarter.';
    parastr65=' In order to get the data shown in the figure into Matlab the following workflow has been implimented.';
    parastr66=' First the CSV formatted file is downloaded and then imported into Excel. Each tab in the spreadsheet contains data from one section.';
    parastr67=' Next a Matlab script called Harvest Stock data is used to pull this data out of the spreadsheet and put the data into a timetable.';
    parastr68=' The timetable data is a very concise way for Matlab to make calculation and plot the data.';
    parastr69=strcat(parastr61,parastr62,parastr63,parastr64,parastr65,parastr66,parastr67,parastr68);
    p7 = Paragraph(parastr69);
    p7.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p7);
    % Now add the section of the XOM Income Data
    imdata = imread('XOM_Income.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOM_Income.jpg');
    text = Text('Downloaded Quaterly XOM Income');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
%   Now describe the graphic
    parastr71='Shown above is data taken from the Fiancials section of the Yahoo Financial Data.';
    parastr72=' On the left side of the chart the red arrow points to the option selected.';
    parastr73=' This provides a top level view of the income of XOM on a quarterly basis.';
    parastr74=' The dataset provides the values of 52 items on a quarterly basis and also for the precceding 12 months (TTM).';
    parastr75=' Many items do not have entries for every quarter as they occur only at irregular intervals.';
    parastr79=strcat(parastr71,parastr72,parastr73,parastr74,parastr75);
    p8 = Paragraph(parastr79);
    p8.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p8);
% Now add the section of the XOM Cash Flow Data
    imdata = imread('XOM_CashFlow.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOM_CashFlow.jpg');
    text = Text('Downloaded Quaterly XOM Cash Flow');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
%   Now describe the graphic
    parastr81='Shown above is a snippet of data taken from the Yahoo:Financials:Balance Sheet tab.';
    parastr82=' The focus of this data is reporting XOM income by quater from a variety of sources.';
    parastr83=' This provides a top level view of the cash from in and out of XOM on a quarterly basis.';
    parastr84=' The dataset provides the values of 16 items on a quarterly basis.';
    parastr85=' Some items do not have entries for every quarter as they occur  at irregular intervals.';
    parastr89=strcat(parastr81,parastr82,parastr83,parastr84,parastr85);
    p9 = Paragraph(parastr89);
    p9.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p9);
% Now add the section of the XOM Dividend Charts
    imdata = imread('XOM_Dividend_Charts.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOM_Dividend_Charts.jpg');
    text = Text('Dividend Charts');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
%   Now describe the graphic
    parastr91='Shown above is a snippet of data taken from the Yahoo:Financials:Dividend Charts tab.';
    parastr92=' This tab provides charts of divident income which is now downloadable.';
    parastr93=' Purpose of this data is to illustrate dividend income graphically.';
    parastr94=' The top section of the graphic compares the dividends offered for XOM to other stocks in this sector';
    parastr95=' Inspection of this chart shows that XOM dividend payout is less than the sector average.';
    parastr96=' The payout ratio is of great interest-for XOM this is 49% which good as this is a sustainable value';
    parastr99=strcat(parastr91,parastr92,parastr93,parastr94,parastr95,parastr96);
    p10 = Paragraph(parastr99);
    p10.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p10);
    br = PageBreak();
    add(chapter,br);
    add(rpt, chapter);
  % Create chapter 2 to provide a top level description of the
  % MatlabScripts
    chapter = Chapter("Title", "Matlab Script");
    chapter.Layout.Landscape = true;
    add(chapter,Section('Script Basic Layout'));
 %  Add an Intro Paragraph
    parastr101='This section is meant to provide a toplevel description of the Matlab scripts that were developed for this task.';
    parastr102=' Current scripts were developed using Matlab Release 2024b and the Financial Toolbox.';
    parastr103=' Many scripts are included in the code-there are a few analysis programs and a number of shorter helper programs.';
    parastr104=' An example of a helper program is a special purpose code used to import stock market data from Yahoo.';
    parastr109=strcat(parastr101,parastr102,parastr103,parastr104);
    p110 = Paragraph(parastr109);
    p110.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p110);
    % imdata = imread('ComputationalFinanceToolbox.jpg');
    % [nhigh,nwid,~]=size(imdata);
    % image = mlreportgen.report.FormalImage();
    % image.Image = which('ComputationalFinanceToolbox.jpg');
    % text = Text('Finance Toolbox Highlights');
    % text.Color = 'red';
    % image.Caption = text;
    % heightstr=strcat(num2str(nhigh/2),'px');
    % widthstr=strcat(num2str(nwid/2),'px');
    % image.Height = heightstr;
    % image.Width = widthstr;
    % image.ScaleToFit=0;
    % add(chapter,image); 
    add(rpt, chapter);

% Create chapter 3 to provide a description of technical indicators
    chapter = Chapter("Title", "Financial Calculations");
    chapter.Layout.Landscape = true;
    add(chapter,Section('Matlab Financial Toolbox'));
    imdata = imread('ComputationalFinanceToolbox.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('ComputationalFinanceToolbox.jpg');
    text = Text('Finance Toolbox Highlights');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
%   Now describe the graphic
    parastr201='This chart presents a capsule summary of the main features of the Financial ToolBox.';
    parastr202=' The version used 2024b.';
    parastr203=' Purpose is to highlight some of the capilities of this toolbox and supporting toolboxes.';
    parastr209=strcat(parastr201,parastr202,parastr203);
    p210 = Paragraph(parastr209);
    p210.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p210);
% Add graphic On Time Series Functions
    br = PageBreak();
    add(chapter,br);
    T1=[TSeries1Hdrs;TSeries1Table];
    tbl1=Table(T1);
    tbl1.Style = [tbl1.Style {Border('solid','black','3px')}];
    tbl1.TableEntriesHAlign = 'center';
    tbl1.HAlign='center';
    tbl1.ColSep = 'single';
    tbl1.RowSep = 'single';
    tb11.TableEntriesHAlign='middle';
    r = row(tbl1,1);
    r.Style = [r.Style {Color('red'),Bold(true)}];
    bt1 = BaseTable(tbl1);
    tabletitle = Text('Technical Indicators-Time Series Oscillations');
    tabletitle.Bold = false;
    bt1.Title = tabletitle;
    bt1.TableWidth="8in";
    add(chapter,bt1);

%   Now describe the graphic for time series oscilator indicators
    parastr211='This chart shows a list of time series oscillations functions.';
    parastr212=' The version used 2024b.';
    parastr213=' The functions used in the main script are marked as yes in column 3 of the table.';
    parastr219=strcat(parastr211,parastr212,parastr213);
    p220 = Paragraph(parastr219);
    p220.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p220);
% Show Sample Data for one or more stocks
    add(chapter,Section('Sample Stock Data'));
    parastr7811='Before going into a more detailed description it is useful to show some sample stock data.';
    parastr7812=' For this purpose the plot of Apple stock data (AAPL) is shown for 2024.';
    parastr7813=' The closing values for this equity are plotted at the close of each trading day in 2024.';
    parastr7814=' Most years have 252 trading days.';
    parastr7815=' A glance at this chart reveals that the stock mostly gained value during the course of the year.';
    parastr7816=' In the May timeframe the stock gained value rapidly and continued rising until the end of the year.';
    parastr7817=' At the bottom of the chart is information of the stock change during the course of 2024.';
    parastr7818=' AAPL stock enjoyed a gain of almost 35% in share price during the year in question.';
    parastr7819=strcat(parastr7811,parastr7812,parastr7813,parastr7814,parastr7815,parastr7816,parastr7817,parastr7818);
    p7820 = Paragraph(parastr7819);
    p7820.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p7820);
% Add a graphic for the APPL Stock Price
    imdata = imread('AAPL-Closing-Stock-prices.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-Closing-Stock-prices.png');
    text = Text('AAPL Closing Stock Prices in 2024');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
    br = PageBreak();
    add(chapter,br);
    % Add a graphic for the APPL Stock Price with Bollinger Bounds
    imdata = imread('AAPL-Closing-Stock-with-bounds.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-Closing-Stock-with-bounds.png');
    text = Text('AAPL Closing Stock Prices With Bollinger Bounds');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
    % Show Sample Data for one or more stocks
    parastr7831='Another way of looking at the variability of a equity is to plot it with Bollinger Bounds.';
    parastr7832=' These bounds are drawn showing the mean value of a stock on one line an two lines showing the standard deviation.';
    parastr7833=' The predictive power is based on the time when the stock rises above or falls below the bounds.';
    parastr7834=' A moving average is calculated usually for a period of 10 20 and 50 days-the standard deviations taken over the same period.';
    parastr7839=strcat(parastr7831,parastr7832,parastr7833,parastr7834,parastr7815);
    p7840 = Paragraph(parastr7839);
    p7840.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p7840);
  % Add a graphic for the APPL Stock Daily Trade Volume
    imdata = imread('AAPL-Daily-Trade-Volume.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-Daily-Trade-Volume.png');
    text = Text('AAPL Stock Daily Trade Volume in Shares');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
    parastr7821='Most days the total shares traded averaged about 50 million with a few days more than 150 million.';
    parastr7822=' Unlike the share price shown on the preeceding chart,the share volume remained steady .';
    parastr7823=' The trade volume is a vital component in calculating many of the technical indicators .';
    parastr7824=' This is because the volume of money moved around is proportional to the number of shares times the strike price.';
    parastr7825=' Some indicators are baded on total shares traded and others separately record bought and sold shares separately.';
    parastr7829=strcat(parastr7821,parastr7822,parastr7823,parastr7824,parastr7825);
    p7830 = Paragraph(parastr7829);
    p7830.Style = {OuterMargin("0pt", "0pt","20pt","10pt")}; 
    add(chapter,p7830);
    %add(rpt,chapter);
% More details of the ADOSC indicator
    add(chapter,Section('ADOSC Technical Indicator'));
% Basic description of ADOSC indicator
    parastr8211='Some basic facts of the ADOSC metric are provided here for context.';
    parastr8212=' Developed by Mark Chakin the concept involves compsring price changes in a stock compataed to the trade volumn.';
    parastr8213=' When the stock is being acquired in larger than normal volumes the price usually goes up.';
    parastr8214=' In similar fashion the price will tend to decline when selling volume is lsrger than buying volume.';
    parastr8215=' The basic idea is to track the flow of money into and out of the security.';
    parastr8219=strcat(parastr8211,parastr8212,parastr8213,parastr8214,parastr8215);
    p8220 = Paragraph(parastr8219);
    p8220.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p8220);
% Add a graphic for the ADOSC Formula
    imdata = imread('ADOSCFormula.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('ADOSCFormula.jpg');
    text = Text('ADOSC Calculation Steps');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
    parastr8221='The graphic above provides additonal data on how the the ADOSC Metric is computed.';
    parastr8222=' Computation of this metric relies on two factors-the first is the MFM or money flow multiplier .';
    parastr8223=' The next step is to get the accumulation Distribution line or ADL .';
    parastr8224=' Both of these factors ate computed using the Matlab Toolbox function ADOSC.';
    parastr8229=strcat(parastr8221,parastr8222,parastr8223,parastr8224);
    p8230 = Paragraph(parastr8229);
    p8230.Style = {OuterMargin("0pt", "0pt","100pt","10pt")}; 
    add(chapter,p8230);
    parastr221='Accumulation/Distribution Oscillator is basically a momentum indicator for a stock.';
    parastr222=' For this reason not only the losing price is important but also the volume of trades.';
    parastr223=' ADOSC above0 show periods of buying pressure-values below zero show net selling pressure.';
    parastr224=' Examination of the Plot of AAPL stock in 2024 shows the ADOSC indicator above zero for most of the year.';
    parastr225=' This means that Apple stock was under buying pressure most of the year.';
    parastr229=strcat(parastr221,parastr222,parastr223,parastr224,parastr225);
    p230 = Paragraph(parastr229);
    p230.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p230);
    imdata = imread('AAPL-ADO-Metric.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-ADO-Metric.png');
    text = Text('Example ADOSC Metric of AAPL Stock');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
% Create a lead in for the bulleted for the pros and cons for the ADO
% Technical indicator
   parastr231='The bullet list that follows enumerates the pros and cons for the ADO Tech Indicator. ';
   parastr232=' The Tech indicator is intended to aid the decision process of buying and selling stocks.'; 
   parastr233=' However the user should not use it as a stand alone buy sell decision maker.'; 
   parastr239=strcat(parastr231,parastr232,parastr233);
   p240 = Paragraph(parastr239);
   p240.Style = {OuterMargin("0pt", "0pt","30pt","10pt")};
   add(chapter,p240);
% Now create a short list of key qualifiers
    liststr1='PRO-Can help imvestors by spotting divergences between stock price and volume';
    liststr2='PRO-Can be used with other technical indicators to confirm market trends';
    liststr3='PRO-Can be applied to anytime frame so it is a verstile tool';
    liststr4='CON-Can generate false signals during high volitity or low luquidity periods';
    liststr5='CON-It is a lagging indicator so generated signals may be untimely';
    liststr6='CON-Not foolproof and should not be used as a sole source in decision maker';
    Lists=cell(6,1);
    Lists{1,1}=liststr1;
    Lists{2,1}=liststr2;
    Lists{3,1}=liststr3;
    Lists{4,1}=liststr4;
    Lists{5,1}=liststr5;
    Lists{6,1}=liststr6;
    ul = UnorderedList(Lists);
    add(chapter,ul);
% Add Section on the relative Strength Indicator
    add(chapter,Section('RSI '));
% Basic description of RSI Indicator
    parastr291='The RSI or relative strength indicator is another widely used technical metric.';
    parastr292=' Developed by J Wells Wilder in 1978 it purpose is to measure the momentum and strength ofprice movements.';
    parastr293=' Output from the algorithm results in the declartion of time periods where the stock is overbought or oversold.';
    parastr294=' This metric is useful in defining entry and exit points from stock positions.';
    parastr295=' The returned value typically ranges between 0 and 100.';
    parastr296=' As such,this indicator is classed as a momentum oscillator.';
    parastr299=strcat(parastr291,parastr292,parastr293,parastr294,parastr295,parastr296);
    p300 = Paragraph(parastr299);
    p300.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p300);
    imdata = imread('RSICalculation.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('RSICalculation.jpg');
    text = Text('Method Of Calculation');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
% Basic More details of RSI Indicator
    parastr301='The RSI metric is calculated with Matlab by using the "rsindex" function .';
    parastr302=' There is one significant user adjustable parameter-this is the number of periods used to calculate the result.';
    parastr303=' This has a default value set to `14 as specified in the literature.';
    parastr304=' Shown below is a image of caculating this metric using Matlab.';
    parastr309=strcat(parastr301,parastr302,parastr303,parastr304);
    p310 = Paragraph(parastr309);
    p310.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p310);
% Add image of RSI metric from Matlab
    imdata = imread('AAPL-RSI-Metric.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-RSI-Metric.png');
    text = Text('Matlab RSI Example For Apple Stock');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
    % More details of RSI Indicator Chart
    parastr311='As expected the RSI index is contained within a region of 0 to 100 .';
    parastr312=' Two limits are plotted on the chart along with the raw values-these were set to 30 and 70.';
    parastr313=' If the value dips below 30 the stock is considered to be oversold-while 70 defines the overbought limit.';
    parastr314=' These limits are arbitary but are frequenctly used.';
    parastr315=' At the bottom of the chart is is summary of overbought days(when the value is oversold and neutral days with values for 30 to 70).';
    parastr316=' Finally the overbought days are shown to be 55 out of 252 trading days.';
    parastr317=' No one technical indicator is decisive but the RSI metric can be combined to the ADOSC metric to provide a more robust result.';
    parastr319=strcat(parastr311,parastr312,parastr313,parastr314,parastr315,parastr316,parastr317);
    p320 = Paragraph(parastr319);
    p320.Style = {OuterMargin("0pt", "0pt","30pt","10pt")}; 
    add(chapter,p320);
% Add a section the Chaikin Oscillator
    add(chapter,Section('Chaikin Oscillator '));
% Basic description of Chaikin Oscillator
    parastr351='The Chaikin Oscillator is another useful technical metric.';
    parastr352=' Developed by Mark Chaikin for task of identifying buying and selling pressure on the market.';
    parastr353=' There are two main components used in this tool.';
    parastr354=' First of these is the Accumilation Distribution Line (ADL).';
    parastr355=' The second component is the Moving Averge Convergence Divergence or (MACD).';
    parastr359=strcat(parastr351,parastr352,parastr353,parastr354,parastr355);
    p360 = Paragraph(parastr359);
    p360.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p360);
    imdata = imread('AAPL-ChaikinOSC-Metric.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-ChaikinOSC-Metric.png');
    text = Text('Sample Chaikin Oscillator Chart');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
    parastr361='An example of the Chaikin Oscillator output is shown in the chart above.';
    parastr362=' This was created by calling the Financial Toolbox function "chsilosc".';
    parastr363=' In order to work, this function expects to see input data in a speciiic way which will be shown later.';
    parastr364=' Note that as currently delivered,this Matlab Financial Toolbox has virtually no user defineable parameters.';
    parastr365=' The reader should keep this limitation in mind.';
    parastr369=strcat(parastr361,parastr362,parastr363,parastr364,parastr365);
    p370 = Paragraph(parastr369);
    p370.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p370);
 % Image of sample data input to ChaikinOsclator
    imdata = imread('DataForChaikinOscillator.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('DataForChaikinOscillator.png');
    text = Text('Sample Data input for Chaikin Oscillator');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/1),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
 % Data Input Explanation
    parastr371='An example of the Chaikin Oscillator input is shown in the chart above.';
    parastr372=' This is the data to be used as input to the Financial Toolbox function "chakinosc".';
    parastr373=' The data is stored in a 6 column timetable which can be easily plotted.';
    parastr374=' Examination of the chart reveals the required input data format.';
    parastr375=' Basically,for the function to work it needs the date and time in datetime format for the X axis.';
    parastr376=' For computation of the technical indicator the stock price is needed at market open and closing along with the daily volume.';
    parastr379=strcat(parastr371,parastr372,parastr373,parastr374,parastr375,parastr376);
    p380 = Paragraph(parastr379);
    p380.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p380); 
    parastr381='Calculation of the metric is a two step procees.';
    parastr382=' The first step is the calculation of the Accumilation/Distribution line (ADL).';
    parastr383=' Examination of the ADL measure indicates the money flow into and out of the security.';
    parastr384=' MACD is the moving average conversion diversion typically this is done using two periods of 13 cyles and 26 cycles.';
    parastr385=' These two cycles are Exponential moving averages(EMA).';
    parastr386=' The prediction power of this technique is based on a divergence between these two periods .';
    parastr387=' Should a small difference occur between these two EMAs thhis is a confirmation of the trend .';
    parastr388=' If these two signals differ between bullish and bearing this could signal a stock reversal.';
    parastr389=strcat(parastr381,parastr382,parastr383,parastr384,parastr385,parastr386,parastr387,parastr388);
    p390 = Paragraph(parastr389);
    p390.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p390);
    br = PageBreak();
    add(chapter,br);
    % Now create a list of the pros and cons
    liststr1='PRO-Versatility: The Chaikin Oscillator can be applied to various financial instruments,';
    liststr2='PRO-Trend can help traders confirm the strength and direction of existing trends.';
    liststr3='PRO-Early signals: The oscillator can provide early buy and sell signals';
    liststr4='CON-Lagging indicator: may not provide timely signals';
    liststr5='CON-False signals: The oscillator can generate false signals during market consolidation';
    liststr6='CON-Limited effectiveness: The Chaikin Oscillator may be less effective in strongly trending markets';
    Lists=cell(6,1);
    Lists{1,1}=liststr1;
    Lists{2,1}=liststr2;
    Lists{3,1}=liststr3;
    Lists{4,1}=liststr4;
    Lists{5,1}=liststr5;
    Lists{6,1}=liststr6;
    ul = UnorderedList(Lists);
    add(chapter,ul);
% Add a section the On Balance Volume
    add(chapter,Section('On Balance Volume Indicator '));
% Basic description of On Balance Volume Metric
    parastr401='The On Balance Volume metric was introduced by the famous investor Joseph Granvile in 1963.';
    parastr402=' He observed that major moves in stock price were preeceded by changes in share volumes in both buy and sell directions.';
    parastr403=' Another version of this indicator is in use is called the Anchored On Balance Volume or AOBV.';
    parastr404=' In this series of scripts the desired function is "onbalvol".';
    parastr405=' Time anchoring is not explicit but is inherent to the data supplied to the function call.';
    parastr409=strcat(parastr401,parastr402,parastr403,parastr404,parastr405);
    p410 = Paragraph(parastr409);
    p410.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p410);
    imdata = imread('OnBalanceVolumeFormula.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('OnBalanceVolumeFormula.jpg');
    text = Text('OBV Calculation Formula');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
    parastr411='The formula used to calculate the On Balanve Volume or OBV is quite simple.';
    parastr412=' Basically the daily changes are either for rising stocks,falling stocks or unchanging stocks.';
    parastr413=' In order to work, this function expects to see input data in a speciiic way which will be shown later.';
    parastr414=' On the figure, OBV is a sum which goes up if the stock close is higher than the preceeding day.';
    parastr415=' Therefore the OBV line shpild be inspected to see if it is rising or falling ina consistent fashion.';
    parastr416=' The dignostic power of this metric if the volume is increasing while share prices are rising for a bullish trend.';
    parastr417=' Similarly if the volume is increasing while share prices are falling then a bearing trend is likely.';
    parastr419=strcat(parastr411,parastr412,parastr413,parastr414,parastr415,parastr416,parastr417);
    p420 = Paragraph(parastr419);
    p420.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p420);
  % Now create a list of the pros and cons
    liststr1='PRO-Versatility: OBV is easy to calculate and understand';
    liststr2='PRO-Trend can help traders confirm the strength and direction of existing trends.';
    liststr3='PRO-Helpful to identify price breakouts';
    liststr4='CON-there is a lack of standardized data which can affect results';
    liststr5='CON-note not always reliable in isolation';
    liststr6='CON-susceptible to sudden volume changes';
    Lists=cell(6,1);
    Lists{1,1}=liststr1;
    Lists{2,1}=liststr2;
    Lists{3,1}=liststr3;
    Lists{4,1}=liststr4;
    Lists{5,1}=liststr5;
    Lists{6,1}=liststr6;
    ul = UnorderedList(Lists);
    add(chapter,ul);
 % Image of example On Balance Volume
    br = PageBreak();
    add(chapter,br)
    imdata = imread('AAPL-OnBalanceVolume.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-OnBalanceVolume.png');
    text = Text('On Balance Volume Example Metric');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/1),'px');
    widthstr=strcat(num2str(nwid/1),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image); 
 % On Balance Volume comments
    parastr421='An example On Balance Volume for AAPL stock is shown in the chart above.';
    parastr422=' Examination of the graphic shows that during the first half of the year there was a mild sell-off of this equity.';
    parastr423=' During the second half of the year stock purchases exceeded sales.';
    parastr424=' The metric shows no rapid changes so the changes were slow paced.';
    parastr429=strcat(parastr421,parastr422,parastr423,parastr424);
    p430 = Paragraph(parastr429);
    p430.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p430); 
% Add a section the On Balance Volume
    add(chapter,Section('WilliamsPctR Indicator'));
% Basic description of On Balance Volume Metric
    parastr431='The Williams R Indicator or the Pct Range is a momentum indicator which can be invoked in matlab using the "willpctr" function .';
    parastr432=' This was developed by Lary Williams and is sometimes called an upside down metric.';
    parastr433=' Values in the -100 to -80 range are indicative of an oversold condition.';
    parastr434=' Overbought situations usually have o value in the -20 to 0 range.';
    parastr435=' Fundamentally the stock closing price is compared to specific trading period-often this is 14 days.';
    parastr436=' The matlab function that calculates this metric using 14 days as the default value.';
    parastr439=strcat(parastr431,parastr432,parastr433,parastr434,parastr435,parastr436);
    p440 = Paragraph(parastr439);
    p440.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p440);
 % Image of example WilliamPctR Indicator
    br = PageBreak();
    add(chapter,br)
    imdata = imread('AAPL-Williams-Volatility.png');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('AAPL-Williams-Volatility.png');
    text = Text('Sample Williams PctR Metric');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/1),'px');
    widthstr=strcat(num2str(nwid/1),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=1;
    add(chapter,image);  
   
% Basic description of Explanation of William Pct Range indicator
    parastr441='The chart shown above shows and example of the William Pct Range metric based on AAPL stock in 2024 .';
    parastr442=' Depicted in red is the actual output for the indicator.';
    parastr443=' On the lower portion of the graph the yellow line set at -80 is the limit for the over sold condition.';
    parastr444=' An Upper boundary for the overbought condition is plotted in cyanamid.';
    parastr445=' Referring to the text drawn on the bottom of the chart,reveals that the oversold contidition occurred on 39 days.';
    parastr446=' In contrast the overbought condition was more frequent covering 82 days.';
    parastr447=' For the remainder of the trading year the metric was greater than -80 and less than -20.';
    parastr448=' This period is labelled as neutral.';
    parastr449=strcat(parastr441,parastr442,parastr443,parastr444,parastr445,parastr446,parastr447,parastr448);
    p450 = Paragraph(parastr449);
    p450.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p450);
 % Use of William Pct Range indicator
    parastr451='This metric is best used in concert with other technical metrics to plan stock purchase/sales .';
    parastr452=' When the indicator rises above -80 this is an indication that the stock may no longer be oversold.';
    parastr453=' On the other hand when the value go dips below -20 into neutral territory do it is no longer overbought.';
    parastr454=' Generally it isa good strategy to combine this with moving averages or support/resistance level data in making decisions.';
    parastr459=strcat(parastr451,parastr452,parastr453,parastr454);
    p460 = Paragraph(parastr459);
    p460.Style = {OuterMargin("0pt", "0pt","10pt","10pt")}; 
    add(chapter,p460);
    add(rpt, chapter);
% Create chapter 3 with more specific data on GOES sensors
    % chapter = Chapter("Title", "GOES-16 Detailed Description");
    % chapter.Layout.Landscape = true;
    % add(chapter,Section('GOES Details'));
    % imdata = imread('GOES-16.jpg');
    % [nhigh,nwid,ndepth]=size(imdata);
    % image = mlreportgen.report.FormalImage();
    % image.Image = which('GOES-16.jpg');
    % text = Text('GOES-16 Satellite Image');
    % text.Color = 'red';
    % image.Caption = text;
    % heightstr=strcat(num2str(nhigh/2),'px');
    % widthstr=strcat(num2str(nwid/2),'px');
    % image.Height = heightstr;
    % image.Width = widthstr;
    % image.ScaleToFit=0;
    % add(chapter,image); 
    % imdata = imread('ABI-Description.jpg');
    % [nhigh,nwid,ndepth]=size(imdata);
    % image = mlreportgen.report.FormalImage();
    % image.Image = which('ABI-Description.jpg');
    % text = Text('GOES-16 ABI Basic Description');
    % text.Color = 'red';
    % image.Caption = text;
    % heightstr=strcat(num2str(nhigh/2),'px');
    % widthstr=strcat(num2str(nwid/2),'px');
    % image.Height = heightstr;
    % image.Width = widthstr;
    % image.ScaleToFit=1;
    % add(chapter,image); 
    % add(rpt,chapter);

end

