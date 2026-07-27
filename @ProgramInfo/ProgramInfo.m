classdef ProgramInfo
    % This class will hold data related to the code for a entire project
    % or a subset of the project. Statistics will be provided for the
    % toolboxes available on the user computer as well as toolboxes
    % required and much more,
    % Updated : Jul 10,2025
    properties
        FileNameInventory=cell(1,1);
        CodeFileName=[];
        AvailToolBoxList=[]
        AvailToolBoxTable1=[]
        AvailToolBoxTable2=[]
        ReqToolBoxList=[]
        ComputerMemoryList=[]
        totalLOC=0;
        ComputerMemoryTable=0;
        flist=[]
        plist=[]
        AT1=[]
        AT2=[]
        nowt=[];
        iCreatePDFReport=[]; 
        RptGenPresent=0; 
        pdffilename=[]; 
        rpt; 
        chapter ;
        tocc;
        icapture=1;
        startruntime=[];
        logfilename=[];
        widd=1080;
        widd2=1000;
        lend=[];
        lend2=[];
        hor1=[]
        vert1=[];
        hor2=[];
        vert2=[];
        Fz1=[];
        Fz2=[];
        machine=2;
        fid=[];
        fredpath=[];
        fredjpegpath='K:\Investing2\FRED_Data\FredJpeg\';
        jpegpath=[];
        tablepath=[];
        logfilepath=[];
        tiffpath=[];
        govjpegpath=[];
        pdfpath=[];
        excelpath=[];
        matpath=[];
        dataYear=[];
        MSpath=[];
        JpegCounter=0;
  
    end

    methods
        function obj = untitled(inputArg1,inputArg2)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end