function N=complementare(n,B)
%dato un vettore B (orizzontale) ed un numero n restituisce un vettore che
%contiene tutti i numeri da 1 a 2 ad esclusione di quelli presenti in B 
%N = { 1,...,n} / B come insieme
%Non si assume che B sia ordinato 
m=n-size(B,2);
N=zeros(1,m);
j=1;
for i=1:n
    if(find(B==i))
    else
        N(1,j)=i;
        j=j+1;
    end
end
end