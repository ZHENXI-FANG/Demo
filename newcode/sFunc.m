function [Value] = sFunc(diff,m,E,u)   %diff=p-q
   
    %D=sum(diff,2);
    A= pinv(E) * diff';
    B=diff.*A';
    temp=sum(B,2);   %行数相加
    Value=m./power(temp,0.8);
    %Value=m./power(temp,0.9);
    % Value(D==0,:)=inf;

end