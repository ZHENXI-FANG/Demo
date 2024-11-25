function [Values] = PointsPotential(gridPoints,resoucePoints, m, u, E, FuncType)
    %UNTITLED2 �˴���ʾ�йش˺�����ժҪ
    %  gridPoints Ϊ����㣬��Сn��D��nΪ����������DΪά�ȣ�
    %  resourcePoints Ϊ��Դ�����
    % Values(i,j)��ʾ��Դ��j�ڴ���i���������ƺ���ֵ
    
    % X = table2array(gridPoints);
    X=gridPoints;
    [nX,p] = size(X);
    Y =resoucePoints(:,1:p);
    [nY,~] = size(Y);
    Values=zeros(nX, nY);
    
    if FuncType=='s'    
        % ���� (p-q) * pinv(E) * (p-q)' ����
         for i = 1:nY
                diff = zeros(nX,p);
                diff = diff + (X - Y(i,:));
                dsq=sFunc(diff,m,E,u);
                Values(:,i) = dsq;
         end
         
    elseif FuncType=='g'
        for i = 1:nY
                diff = zeros(nX,p);
                diff = diff + (X - Y(i,:));
                dsq=gFunc(diff,m,E,u);
                Values(:,i) = dsq;
        end
    end

end

