function [Value] = sFunc(diff,m,E,u)   %diff=p-q
   
    %D=sum(diff,2);
    A= pinv(E) * diff'; %这里是距离差与带宽矩阵相乘，下一步处理U/2,目前缺少这一环节，明天处理。
    B=diff.*A';
    temp=sum(B,2);   %行数相加
    Value=m./power(temp,0.8);
    %Value=m./power(temp,0.9);
    % Value(D==0,:)=inf;

end
