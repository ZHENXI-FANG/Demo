function [d, q, t] = DQTCalculate(points, segmentStart, segmentEnd)
    % ����㼯points���߶������е����̾���d����̾����q
    %����Ϊ�㼯���߶����˵�
    pa = points - segmentStart;  % ����㼯���߶����֮�������
    seg = repmat(segmentEnd - segmentStart, size(pa,1), 1);  % �����߶ε���������չΪ��pa��ͬά�ȵľ���
    t = dot(pa, seg, 2) ./ dot(seg, seg, 2);  % ����㼯���߶ε���̾���λ�ñ���
    t(t < 0) = 0;  % ��С��0��λ�ñ�������Ϊ0
    t(t > 1) = 1;  % ������1��λ�ñ�������Ϊ1
    q = segmentStart + t.*seg;  % ����㼯ÿ���㵽�߶ε���̾����
    d = vecnorm(points - q, 2, 2);  % ����㼯ÿ���㵽��Ӧ��̾�����ŷ�Ͼ���
end
