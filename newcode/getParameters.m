function [m,q,t,ind] = getParameters(points, polyline)
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    

    [nP,D]=size(points);
    [n,d]=size(polyline);
    if D~=d
        errordlg('����ά�Ȳ�һ��','error');   %��������
        return
    end
    
    [dmin, q, t, ind] = MinDistance(points, polyline);
    
    Points(:,1,:)=points;
    Points=repmat(Points,1,n,1);
    Polyline(1,:,:) = polyline;
    Polyline=repmat(Polyline,nP,1,1);
    
    Distance = vecnorm(Points - Polyline, 2, 3);  % ����㼯ÿ���㵽�۵��ŷ�Ͼ��� 
    % m=dmin.*sum(1./Distance,2);  
    % m(find(isnan(m))) = n;  %�����۵��غϵ������DistanceΪ0��mΪNaN
    m=1;
end



function [dmin, q, t, ind] = MinDistance(points, polyline)
    % ����㼯points��ÿ���㵽���������е����̾������̾����
    
    [nP,D]=size(points);
    [n,d]=size(polyline);
    % if D~=d
    %     return
    % end
    
    %ת��ά�Ȳ���չ
    Points(:,1,:)=points;
    Points=repmat(Points,1,n-1,1);
 
    seg_Start(1,:,:) = polyline(1:end-1, :);
    seg_End (1,:,:)= polyline(2:end, :);
    seg_Start=repmat(seg_Start,nP,1,1);
    seg_End=repmat(seg_End,nP,1,1);

    % ����㼯���߶����֮�������
    pa = Points - seg_Start ;  
    seg = seg_End - seg_Start ;  % �����߶ε�����
    T = dot(pa, seg, 3) ./ dot(seg, seg, 3);  % ����㼯���߶ε���̾���λ�ñ���
    T(T < 0) = 0;  % ��С��0��λ�ñ�������Ϊ0
    T(find(T > 1)) = 1;  % ������1��λ�ñ�������Ϊ1
    
    Q = seg_Start + T.*seg;  % ����㼯ÿ���㵽�߶ε���̾����
    distance = vecnorm(Points - Q, 2, 3);  % ����㼯ÿ���㵽��Ӧ��̾�����ŷ�Ͼ���
    [dmin, I ] = min(distance,[],2);
    ind=sub2ind(size(Q), (1:size(Q,1))', I);
    t=T(ind);
    q=zeros(nP,D);
    for i=1:D
        q(:,i)=Q(ind+nP*(n-1)*(i-1));
    end
end
    