function [E] =ParseMatrix(Estr)
% Estr ��һ�����������Էֺŷָ����ַ���
% ����Estr = "1.0,2.0,0;0,5.0,0;0,1,9.0";
% ����ת��Ϊ������ʽ  

    % ��ÿ�а��ֺŷָ�
    rows = split(Estr, ';');
    % ��ʼ�� E ����
    E = [];
    % ����ÿ������
    for i = 1:numel(rows)
        % ��ÿ�а����ŷָ�����ת��Ϊ������
        values = strsplit(rows{i}, ',');
        row_values = cellfun(@str2double, values);
        % ��ӵ�ǰ�����ݵ� E ����
        E = [E; row_values];
   end

% �� E ת��Ϊ����
E=double(E);

end

