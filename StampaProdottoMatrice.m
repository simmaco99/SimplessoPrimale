function StampaProdottoMatrice(A,B,C)
% Date 3 matrici stampa A   B   C


nC=size(A,1);
nv=size(B,1);
nB=size(C,1);


for i=1:max([ nC nv nB])
    if( i<=nC)
        fprintf("|");fprintf("%d\t", A(i,1:end-1));
        fprintf("%d|",A(i,end));
    else
        fprintf("\t");
    end

    if (i<=nv)
        fprintf("\t");fprintf("|")
        if size(B,2)==1
           fprintf("%d", B(i,1:end-1)); 
        else
            fprintf("%d\t", B(i,1:end-1));
        end
        
            fprintf("%d|",B(i,end));%matric
    else 
        fprintf("\t")
    end

    if (i<=nB)
        fprintf("\t =\t");
        if size(nB,2)~=1
           fprintf("%d\t", C(i,1:end-1));
        end
        
         fprintf( "%d\n",C(i,end));
    else
        fprintf("\n");
    end
    
end
end
