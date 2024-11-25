function [FieldValue,total_P] = GetFieldValue( gridPoints, PointsData, LinesData, u, FuncType, FusionFunc)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

    [P, F] = GetPFData(gridPoints, u, FuncType, PointsData, LinesData);
    
    fig=waitbar(0,'��ֵ��...');

    if FusionFunc=="Add"
        total_P=sum(P,2);
        FieldValue=sum(P.*F./total_P,2);
        
    elseif FusionFunc=="ExpAdd"
        P=exp(P);
        total_P=sum(P,2);
        FieldValue=sum(P.*F./total_P,2);
    end
    
    waitbar(1,fig,'��ֵ���');
    close(fig)

end



function [P, F] = GetPFData(gridPoints, u, FuncType, PointsData, LinesData)
%�õ������ƺ���ֵ�Ͷ�Ӧ����ֵ���е�����
% gridPointsΪ����ֵ�㣻
% PointsDataΪ�ṹ���ݣ�����name��data�����꣬F����E��
% LinesDataΪ�ṹ���ݣ�����name��data�����꣩��E, Fdata��linesName,F��
        P=[];     
        F=[];
        N=size(gridPoints,1);
        nL=length(LinesData);
        nP=0;
        fig=waitbar(0,'��ʼ����');
        for i =1:length(PointsData)
            T= PointsData(i).data;   
            n=size(T,1);
            nP=nP+n;
            f=T.F;
            E = PointsData(i).E;
            m=1;
            T=table2array(T);
            points_Potential = PointsPotential(gridPoints,T, m, u, E, FuncType);
            P=[P,points_Potential];
            F=[F,repmat(f',N,1)]; 
            waitbar(i/length(PointsData),fig,'�������...')
        end
        
        L_P=zeros(N,nL);
        L_F=zeros(N,nL);
       for i=1:nL
            name=LinesData(i).name;
            Data=LinesData(i).Fdata;
            linesName=Data.linesName;
            ind=find(ismember(linesName,name)) ;              
            f=Data(ind,:).F; 
            data=LinesData(i).data;
            [~,n]=size(data);
            if n==2||n==3         
                E = LinesData(i).E;
                num=size(data,1);
                if num==1
                    data=table2array(data);
                    L_Potential = PointsPotential(gridPoints,data, 1, u, E, FuncType);
                elseif num>1
                    L_Potential = LinePotential(gridPoints, data, u,FuncType, E);
                end  
                
            elseif n==5||n==6                                                  
                L_Potential =LinePotential(gridPoints, data, u, E);    
                
            end            
            L_P(:,i)=L_Potential; 
            f=repmat(f,N,1);
            L_F(:,i)=f;
            waitbar(i/nL,fig,'�߼�����...')
        end
        P=[P,L_P];                     
        F=[F,L_F];
        waitbar(1,fig,'�������');
        close(fig);
end
