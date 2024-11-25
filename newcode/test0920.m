f = uifigure;
t = uitree(f);
PointsNode = uitreenode(t,'Text','Points');
LinesNode = uitreenode(t,'Text','Lines');

filepath="E:\����_matlab\data\yizu\����ֵ��.xlsx";
folderpath="E:\����_matlab\data\yizu\yizu";
Data=readtable(filepath);
[~, folderName, ~] = fileparts(folderpath);
line_node = uitreenode(LinesNode, 'Text', folderName,'Tag','L','NodeData',Data, 'Icon', '');
files = dir(fullfile(folderpath, '*.txt'));  % ��ȡ�ļ����е������ļ�
for i = 1:length(files)
    filename = files(i).name;  % ��ȡ�ļ���
    fileFullPath = fullfile(folderpath, filename);
    data = readtable(fileFullPath);   %��ȡ�ļ�
    new_node = uitreenode(line_node, 'Text', filename, 'Tag','l', 'Icon', '','NodeData', data);
end

fullpath = "E:\����_matlab\data\test_resource_points.txt";
[~, name] = fileparts(fullpath);
data = readtable(fullpath);  % ��ȡ�ļ�����
new_node = uitreenode(PointsNode, 'Text', name,'Tag','p','NodeData',data);

PointsData=struct();
LinesData=struct();
[PointsData,LinesData]=test(t,PointsData,LinesData);
PointsData(1)=[];
LinesData(1)=[];
limit = GetDataLimit(PointsData, LinesData);
D=3;
gridPoints = GetGridPoints(limit,D);
fieldValue=GetFieldValue(PointsData, LinesData, [1000,1000,5],2,D,'s','Add'); 


