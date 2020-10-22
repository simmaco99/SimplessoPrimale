function [x,y,stato]=SimplessoPrimale(A,b,c,B)
%  Algoritmo del simplesso primale [x,y,stato]=SimplessoPrimale(A,b,c,B)
%  x,y sono le soluzioni ottime trovate se esistono, stato può essere o
%  ottimo oppure superiormente illimitato (poliedro illimitato)
% A matrice le cui righe sono i vincoli
% b vettore colonna dei coefficienti
% c vetore riga dei costi
% B vettore riga (elementi della base da cui iniziamo 
%
% Richiede la funzione StampaProdottoMatrice e Complementare


 clc;
 
format rat;
n=size(A,1);
stato=" ";
y=zeros(n,1);
it=1;
while (stato==" ")
    clc
    fprintf('Iterazione: %d\n',it);
    fprintf("Base: {");fprintf("%d, ",B(1:end-1)); fprintf("%d}\n\n",B(end));
    it=it+1;
    AB=A(B,:);
    fprintf('Matrice di base: \n');
    disp(AB);
    iAB=inv(AB);
    fprintf('Inversa della matrice di base \n');
    disp(iAB);
    
    bB=b(B,:);
    fprintf("Calcolo della soluzione BASE PRIMALE:  A^{-1}b_B=x\n")
     x=AB\bB;
    StampaProdottoMatrice(iAB,bB,x);
    I=find(A*x==b)';
    if ( size(I)==size(B))
        fprintf("Ammissibile\nNON degnere\n")
        
    else
        fprintf("Ammissibile\n")
        fprintf("Degenere. I vincoli attivi sono: ");fprintf("%d ",I);
    
    end

    %degnere o no, serve l'insieme dei vincoli attivi 
    N=Complementare(n,B);
    y(B,1)=c/AB;
    y(N,1)=0;
    fprintf("\n\n\nCalcolo della soluzione BASE DUALE (ristretta) : c^t A_B^{-1} \n")
    StampaProdottoMatrice(c,iAB,y(B,1)');

    if (y(B,1)>=0)
    fprintf("Ammissibile\n")
    else 
    fprintf("NON ammissibile\n")   
    end
    if (y(B,1)==0)
    fprintf("Degenere\n")
    else
    fprintf("NON degenere\n")
    end
    fprintf("\n\n")
  
    if (y(B,1)>=0)
        stato="ottimo";
        fprintf("Valore ottimo finito\n");
    else
        [~,h]=max(y<0); %in h c'e il minimo indice i di y tale che y_i<0 
        fprintf("Indice uscente: h=%d\n\n\n",h);
 
        Bh=find(B==h); 
        xi = -iAB(1:end,Bh);
        fprintf("Direzione di crescita: xi=[ ");fprintf("%d ",xi); fprintf("]\n\n");


        Anxi=A(N,:)*xi; 

        fprintf("Calcolo di A_n * xi : \n");
        
        StampaProdottoMatrice(A(N,:), xi, Anxi);
        if (Anxi<=0)
            stato="Illimitato";
            disp('Poliedro illimitato');
        else
%           J2=N(Maggiori0(Anxi)); l'istruzione dopo non ha bisogno di funzioni ausiliare e risulta + veloce
          J=N(Anxi>0);
         
          
          fprintf("\nJ={ i in N : A_i xi>0}= {"); 
          if size(J,2)==1
              fprintf("%d}\n\n",J(end));
          else
              fprintf("%d, ",J(1:end-1));
              fprintf("%d}\n\n",J(end));
          end
          lambda=(b(J,1)-A( J,:)*x)./(A(J,:)*xi); 
          
          [passo,kk]=min(lambda);
          k=J(1,kk);
          fprintf("lambda_%d = %d  ", [J ;lambda']);
          fprintf("\nPasso di spostamento: %d\n",passo);
          if (passo==0)
              fprintf("Cambio di base degenere\n");
          end
          
          fprintf("\nIndice entrante: k=%d",k);

          B(1,Bh)=k;
          B=sort(B);
           
        end
       
    end
     pause()
end
end

