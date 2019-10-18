% Code taken from www.mathworks.com/matlabcentral/fileexchange/14996-entropy
function [BIG ind]=getBestEnt(classVec,allFeat)
	[maxR totNumFeat]=size(allFeat);
	for(i=1:totNumFeat)
        allFeat(:,i);
        n=normFeat(allFeat(:,i));
		IG(i)=Entropy(classVec)-entropyF(classVec,n);
    end
	[BIG ind]=max(IG);
end

% code taken from www.mathworks.com/matlabcentral/fileexchange/28692-entropy
function H = Entropy(X)
[n m] = size(X);
H = zeros(1,m);
for Column = 1:m,
    Alphabet = unique(X(:,Column));
    Frequency = zeros(size(Alphabet));
	
    for symbol = 1:length(Alphabet)
        Frequency(symbol) = sum(X(:,Column) == Alphabet(symbol));
    end
	
    P = Frequency / sum(Frequency);

    H(Column) = -sum(P .* log2(P));
end
end


% Code taken from www.mathworks.com/matlabcentral/fileexchange/14996-entropy
function bitVal=entropyF(classVec,featVec)
featTot=length(featVec);
ithEle=1;
sortClassVec=sort(classVec);
totClassTypes=sortClassVec(end);
subFeatInd=find(featVec==ithEle);
subFeatTot=length(subFeatInd);
size(featVec);
while(subFeatTot~=0)
	proportion=(subFeatTot)/featTot;

	classTot=zeros(totClassTypes,1);
	for(i=1:subFeatTot)
		classKind=classVec(subFeatInd(i));
		classTot(classKind)=classTot(classKind)+1;
	end
	
	for(i=1:totClassTypes)
        if(classTot(i)~=0)
            logVal(i)=-(classTot(i)/subFeatTot)*log2((classTot(i)/subFeatTot));
        else
            logVal(i)=0;
        end
    end
	ent(ithEle)=proportion*sum(logVal);
	ithEle=ithEle +1;
	subFeatInd=find(featVec==ithEle);
	subFeatTot=length(subFeatInd);
end
bitVal=sum(ent);
end


% code taken from www.mathworks.com/matlabcentral/fileexchange/28692-entropy
function norm=normFeat(featVec)
%hint height([2 6 7])=[1 1 1];
unq=unique(featVec);
totUnq=length(unq);
for(i=1:totUnq)
	inds=find(featVec==unq(i));
	norm(inds)=i;
end
end
    