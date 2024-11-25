function [Eq] = EqCalculate(t, Ea, Eb, Eab, Eba)
%���ɴ�������Eq
% 
    W=[Ea, Eab; Eba, Eb];
    [m,n] = size(W);
    E1 = zeros(n/2 , m/2);
    E2 = zeros(n/2 , m/2);
    for i=1:length(n/2)
        E1(i,i) = 1-t;
        E2(i,i) = t;
    end
    E=[E1,E2];
    Eq=E* W* E.';

end

% test
% t=0.3;
% Ea=[1,1,0;0,1,0;0,0,1];
% Eb=[1,1,0;0,1,0;0,0,1];
% Eab=[0,0,0;0,1,0;0,0,1];
% Eba=[0,0,0;0,0,0;0,0,0];
% Eq=EqCalculate(t, Ea, Eb, Eab, Eba)