function MEDEA_Nonresistant_Progression
     clear
     clc

     saveStr1 = 'MEDEA_NR_Progression.csv';
     saveStr2 = 'MEDEA_NR_Alleles.csv';

     % Reading and assigning values from Excel document
     M = xlsread('MEDEA Nonresistant Input Parameters.xlsx');
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
     a1 = M(14,1); a2 = M(15,1); a3 = M(16,1); a4 = M(17,1); a5 = M(18,1); a6 = M(19,1);
     b1 = M(20,1); b2 = M(21,1); b3 = M(22,1); b4 = M(23,1); b5 = M(24,1); b6 = M(25,1);

     %          ww wg ws gg gs ss
     g0 =      [b1 b2 b3 b4 b5 b6  ...     %Male
                a1 a2 a3 a4 a5 a6  ]';     %Female

     % Assignment of initial fitness costs 
     c1 = M(14,7); c2 = M(15,7); c3 = M(16,7); c4 = M(17,7); c5 = M(18,7); c6 = M(19,7);
     d1 = M(20,7); d2 = M(21,7); d3 = M(22,7); d4 = M(23,7); d5 = M(24,7); d6 = M(25,7);

     %          ww wg ws gg gs ss
     fitCost = [d1 d2 d3 d4 d5 d6 ...      %Male
                c1 c2 c3 c4 c5 c6 ]';      %Female  

     mortRateAdult = mortRateAdult./(1-fitCost);
     mortRateJuven = mortRateJuven./(1-fitCost);

     % ensures the mortality rate cannot be more than 100% 
     for i=1:12
         if (mortRateAdult(i) == Inf) || (mortRateAdult(i) > 1)
             mortRateAdult(i) = 1;
             mortRateJuven(i) = 1;
         end
     end

     % RUNS THE MODEL
     W = zeros(i2,j2,span);
     Wcount = zeros(i2,j2,span);
     Gcount = zeros(i2,j2,span);
     Scount = zeros(i2,j2,span);
     for i=1:i2
         tic 
         for j=1:j2

             A = zeros(12,span);
             G = zeros(12,span);
             J2 = zeros(12,span);
             TotalPop = zeros(span,1);
             wildtypeSum = zeros(span,1);
             GP = zeros(6,span);
             
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

                JT = zeros(12,span);
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
                GP(:,T) = G(1:6,T) + G(7:12,T);

                wildtypeSum(T) = GP(1,T);
                W(i,j,T) = (wildtypeSum(T)/TotalPop(T));

                Wcount(i,j,T) = (2*GP(1,T) + GP(2,T) + GP(3,T))/(2*TotalPop(T));
                Gcount(i,j,T) = (GP(2,T) + 2*GP(4,T) + GP(5,T))/(2*TotalPop(T));
                Scount(i,j,T) = (GP(3,T) + GP(5,T) + 2*GP(6,T))/(2*TotalPop(T));

             end     
         end

        mytime= toc;
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
                    Z(row,3)= (g0(1)+g0(7))/(sum(g0(:)));  % inital conditions
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

                 Z(row+1,2)= X(n);
                 Z(row+2,2)= X(n);
                 Z(row+3,2)= X(n);

                 Z(row+1,3)= 1;
                 Z(row+2,3)= 2;
                 Z(row+3,3)= 3;

                 Z(row+1,4)= (2*g0(1)+g0(2)+g0(3)+2*g0(7)+g0(8)+g0(9))/(2*sum(g0(:)));    % inital conditions
                 Z(row+2,4)= (g0(2)+2*g0(4)+g0(5)+g0(8)+2*g0(10)+g0(11))/(2*sum(g0(:)));
                 Z(row+3,4)= (g0(3)+g0(5)+2*g0(6)+g0(9)+g0(11)+2*g0(12))/(2*sum(g0(:)));

                 Z(row+1,p+4)= Wcount(n,m,p);
                 Z(row+2,p+4)= Gcount(n,m,p);
                 Z(row+3,p+4)= Scount(n,m,p);

             end
             row = row + 3;
         end
     end
     csvwrite(saveStr2, Z);

% EQUATION FUNCTIONS & CALCULATIONS
function gprime = gprimeFUNCT(B, alpha, beta, gamma, sigma,lambda,fitCost,survivalRate)

    sum2 = sum(B(1:6));

    J2(7:12) = B(7:12);
    J2(1:6) = B(1:6)/sum2;

    bp1 = MEDEA_Nonresistant_Rates(J2, alpha, beta, gamma, sigma,lambda,fitCost,survivalRate);

    gprime = bp1';       
  