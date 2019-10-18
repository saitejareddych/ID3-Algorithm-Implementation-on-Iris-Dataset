function [conf,rate]=confmat(Y,T)
if length(Y)~=length(T) 
   error('Outputs and targets are different lengths')
end
c = unique(T);
for i = 1:length(c)
   for j = 1:length(c)
      conf(i,j) = (sum ((Y==j).*(T==i))/sum(T == i))*100;
   end
end
correct = (Y == T);
rate=(sum(correct)/length(correct)) * 100;