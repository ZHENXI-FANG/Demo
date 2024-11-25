function [Limit,dataMax,dataMin] = GetDataLimit(fileData, D)
%�������������������ֵ
%��������fileDataΪ���У��ڶ���Ϊ���ݴ洢·��
    
    n=size(fileData,1);
    
    % if D==3
    %     dataMax=zeros(n,3);%��ʼ������n*3
    %     dataMin=zeros(n,3);
    %     for i =1:n
    %         filename=fileData{i,2};
    %         T=readtable(filename);              %��ȡ�ļ�����
    %         XYZdata=[T.X,T.Y,T.Z];
    %         dataMax(i,:)=max(XYZdata,[],1); %ȡ�е���ֵ
    %         dataMin(i,:)=min(XYZdata,[],1);
    %     end
    % 
    % elseif D==2
    %     dataMax=zeros(n,2);%��ʼ������n*2
    %     dataMin=zeros(n,2);
    %     for i =1:n
    %         filename=fileData{i,2};
    %         T=readtable(filename);   %��ȡ�ļ�����
    %         XYdata=[T.X,T.Y];
    %         dataMax(i,:)=max(XYdata,[],1); %ȡ�е���ֵ
    %         dataMin(i,:)=min(XYdata,[],1);
    %     end 
    % 
    % end   2024/11/25�޸ģ�7-29��

    parfor i = 1:n
    filename = fileData{i,2};
    T = readtable(filename);
        if D == 3
            XYZdata = [T.X, T.Y, T.Z];
            dataMax(i,:) = max(XYZdata,[],1);
            dataMin(i,:) = min(XYZdata,[],1);
        elseif D == 2
            XYdata = [T.X, T.Y];
            dataMax(i,:) = max(XYdata,[],1);
            dataMin(i,:) = min(XYdata,[],1);
        end
    end

    dataMax=max(dataMax,[],1);
    dataMin=min(dataMin,[],1);
    Limit=[dataMin;dataMax];

    % B=(dataMax-dataMin).*0.2;               %���߽�����20%
    % Limit = [dataMin-B;dataMax+B];      
end

