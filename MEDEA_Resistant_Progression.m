 function MEDEA_Resistant_Progression
     clear
     clc
 
     saveStr1 = 'MEDEA_R_Progression.csv';
     saveStr2 = 'MEDEA_R_Alleles.csv';

     % Reading and assigning values from Excel document
     M = xlsread('MEDEA Resistant Input Parameters.xlsx');
     sigma = M(4,1);
     lambda = M(5,1);
     survivalRate = M(7,1);
     mortRateJuven = M(8,1);
     mortRateAdult = M(9,1);
     developTime = M(10,1);
     gens = M(11,1);
     span = gens*developTime; 
     X = M(1,1:end);
     Y = M(2,1:end);
     x2 = numel(X);
     y2 = numel(Y);
 
     % Checks for numeric values in the cells for alpha and gamma assignments
     i2 = 0;
     for x=1:x2
         if ~isnan(M(1,x))
             i2 = i2 +1;
         end
     end

     j2 = 0;
     for y=1:y2
         if ~isnan(M(2,y))
             j2 = j2 +1;
         end
     end
     
     % Assignment of initial conditions
     a1 = M(14,1); a2 = M(15,1); a3 = M(16,1); a4 = M(17,1); a5 = M(18,1); a6 = M(19,1); a7 = M(20,1); a8 = M(21,1); a9 = M(22,1); a10 = M(23,1);
     b1 = M(24,1); b2 = M(25,1); b3 = M(26,1); b4 = M(27,1); b5 = M(28,1); b6 = M(29,1); b7 = M(30,1); b8 = M(31,1); b9 = M(32,1); b10 = M(33,1);
 
     %          ww wv wg ws vv vg vs gg gs ss
     g0 =      [b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 ...     %Male
                a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 ]';     %Female
 
     % Assignment of initial fitness costs 
     c1 = M(14,7); c2 = M(15,7); c3 = M(16,7); c4 = M(17,7); c5 = M(18,7); c6 = M(19,7); c7 = M(20,7); c8 = M(21,7); c9 = M(22,7); c10 = M(23,7);
     d1 = M(24,7); d2 = M(25,7); d3 = M(26,7); d4 = M(27,7); d5 = M(28,7); d6 = M(29,7); d7 = M(30,7); d8 = M(31,7); d9 = M(32,7); d10 = M(33,7);  
 
     %          ww wv wg ws vv vg vs gg gs ss
     fitCost = [d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 ...     %Male
                c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 ]';     %Female 

     mortRateAdult = mortRateAdult./(1-fitCost);
     mortRateJuven = mortRateJuven./(1-fitCost);
     
     % ensures the mortality rate cannot be more than 100% 
     for i=1:20
         if (mortRateAdult(i) == Inf) || (mortRateAdult(i) > 1)
             mortRateAdult(i) = 1;
             mortRateJuven(i) = 1;
         end
     end

     % RUNS THE MODEL
     W = zeros(i2,j2,span);
     Wcount = zeros(i2,j2,span);
     Vcount = zeros(i2,j2,span);
     Gcount = zeros(i2,j2,span);
     Scount = zeros(i2,j2,span);
     for i=1:i2  
         tic 
         for j=1:j2

             A = zeros(20,span);
             G = zeros(20,span);
             J2 = zeros(20,span);
             TotalPop = zeros(span,1);
             wildtypeSum = zeros(span,1);
             GP = zeros(10,span);
             
             alpha = X(i);
             gamma = Y(j);
             beta = 1 - (alpha + gamma);

             if alpha == 0
                 gamma = 0;
                 beta = 1;
             end

             for T=1:span

                if (T == 1)
                    A(:,1) = g0;
                    J2(:,1) = gprimeFUNCT(A(:,1),alpha,beta,gamma,sigma,lambda,fitCost,survivalRate);
                elseif (T > 1) && (T <= developTime)
                    A(:,T) = A(:,T-1).*(1-mortRateAdult);
                    J2(:,T) = gprimeFUNCT(A(:,T),alpha,beta,gamma,sigma,lambda,fitCost,survivalRate);
                else
                    A(:,T) = A(:,T-1).*(1-mortRateAdult) + J2(:,T-developTime).*((1-mortRateJuven).^developTime);
                    J2(:,T) = gprimeFUNCT(A(:,T),alpha,beta,gamma,sigma,lambda,fitCost,survivalRate);
                end    

                JT = zeros(20,span);
                if T > developTime
                    for T2=(T-developTime+1):T
                        JT(:,T) = JT(:,T) + J2(:,T2);
                    end
                else
                    for T2=1:T
                        JT(:,T) = JT(:,T) + J2(:,T2);
                    end
                end

                G(:,T) = A(:,T) + JT(:,T);
                TotalPop(T) = sum(G(:,T));
                GP(:,T) = G(1:10,T) + G(11:20,T);

                wildtypeSum(T) = GP(1,T) + GP(2,T) + GP(5,T);
                W(i,j,T) = (wildtypeSum(T)/TotalPop(T));

                Wcount(i,j,T) = (2*GP(1,T) + sum(GP(2:4,T)))/(2*TotalPop(T));
                Vcount(i,j,T) = (GP(2,T) + 2*GP(5,T) + sum(GP(6:7,T)))/(2*TotalPop(T));
                Gcount(i,j,T) = (GP(3,T) + GP(6,T) + 2*GP(8,T) + GP(9,T))/(2*TotalPop(T));
                Scount(i,j,T) = (GP(4,T) + GP(7,T) + GP(9,T) + 2*GP(10,T))/(2*TotalPop(T));
                
             end     
         end

        mytime = toc;
        fprintf('parfor iteration %d , executed by worker %d finished in %f seconds\n',i,labindex,mytime); 
     end

     % Outputs the wildtype proportion to .csv file
     Z = zeros((i2*j2+1),span+1);
     for n=1:i2
         for m = 1:j2
             row = (m-1)*i2+n+1;
             Z(row,2) = X(n);
             Z(row,1) = Y(m);

             for k=0:span
                 if k == 0
                    Z(row,3)= (g0(1)+g0(2)+g0(5)+g0(11)+g0(12)+g0(15))/(sum(g0(:)));  % inital conditions
                 else
                    Z(1,k+3) = k/developTime;
                    Z(row,k+3)= W(n,m,k);
                 end
             end
         end
     end              
     csvwrite(saveStr1, Z);
     
     % Outputs the allele frequencies to .csv file
     Z = zeros((i2*j2+1),span+1);
     row = 1;
     for n=1:i2
         for m = 1:j2
             for p=1:span

                 Z(1,p+4) = p;

                 Z(row+1,1)= Y(m);
                 Z(row+2,1)= Y(m);
                 Z(row+3,1)= Y(m);
                 Z(row+4,1)= Y(m);

                 Z(row+1,2)= X(n);
                 Z(row+2,2)= X(n);
                 Z(row+3,2)= X(n);
                 Z(row+4,2)= X(n);

                 Z(row+1,3)= 1;
                 Z(row+2,3)= 2;
                 Z(row+3,3)= 3;
                 Z(row+4,3)= 4;

                 Z(row+1,4)= (2*g0(1)+g0(2)+g0(3)+g0(4)+2*g0(11)+g0(12)+g0(13)+g0(14))/(2*sum(g0(:)));
                 Z(row+2,4)= (g0(2)+2*g0(5)+g0(6)+g0(7)+g0(12)+2*g0(15)+g0(16)+g0(17))/(2*sum(g0(:)));
                 Z(row+3,4)= (g0(3)+g0(6)+2*g0(8)+g0(9)+g0(13)+g0(16)+2*g0(18)+g0(19))/(2*sum(g0(:)));
                 Z(row+4,4)= (g0(4)+g0(7)+g0(9)+2*g0(10)+g0(14)+g0(17)+g0(19)+2*g0(20))/(2*sum(g0(:)));
                 
                 Z(row+1,p+4)= Wcount(n,m,p);
                 Z(row+2,p+4)= Vcount(n,m,p);
                 Z(row+3,p+4)= Gcount(n,m,p);
                 Z(row+4,p+4)= Scount(n,m,p);

             end
             row = row + 4;
         end
     end
     csvwrite(saveStr2, Z);

            
% EQUATION FUNCTIONS & CALCULATIONS
function gprime = gprimeFUNCT(B,alpha,beta,gamma,sigma,lambda,fitCost,survivalRate)

    sum2 = sum(B(1:10));

    J2(11:20) = B(11:20);
    J2(1:10) = B(1:10)/sum2;

    bp1 = MEDEA_Resistant_Rates(J2, alpha, beta, gamma, sigma,lambda,fitCost,survivalRate);

    gprime = bp1';      
  