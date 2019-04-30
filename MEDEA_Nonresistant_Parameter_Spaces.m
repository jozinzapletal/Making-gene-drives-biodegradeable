 function MEDEA_Nonresistant_Parameter_Spaces
     clear
     clc

     saveStr = 'MEDEA_NR_Parameter_Space.csv';

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

     X = (0:0.008:0.8);
     Y = (0:0.002:0.2);
     i2 = numel(X);
     j2 = numel(Y);

     % RUNS THE MODEL
     Z = zeros(i2,j2);
     tic
     for i=1:i2
         tic 
         for j=1:j2

             A = zeros(12,span);
             G = zeros(12,span);
             J = zeros(12,span);
             TotalPop = zeros(span,1);
             GP = zeros(6,span);
             W = zeros(span);

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
                    J(:,1) = gprimeFUNCT(A(:,1),alpha,beta,gamma,sigma,lambda,fitCost,survivalRate);
                elseif (T > 1) && (T <= developTime)
                    A(:,T) = A(:,T-1).*(1-mortRateAdult);
                    J(:,T) = gprimeFUNCT(A(:,T),alpha,beta,gamma,sigma,lambda,fitCost,survivalRate);
                else
                    A(:,T) = A(:,T-1).*(1-mortRateAdult) + J(:,T-developTime).*((1-mortRateJuven).^developTime);
                    J(:,T) = gprimeFUNCT(A(:,T),alpha,beta,gamma,sigma,lambda,fitCost,survivalRate);
                end    

                JT = zeros(12,span);
                if T > developTime
                    for T2=(T-developTime+1):T
                        JT(:,T) = JT(:,T) + J(:,T2);
                    end
                else
                    for T2=1:T
                        JT(:,T) = JT(:,T) + J(:,T2);
                    end
                end

                G(:,T) = A(:,T) + JT(:,T);
                TotalPop(T) = sum(G(:,T));

                GP(:,T) = G(1:6,T)+G(7:12,T);
                W(T) = (2*GP(1,T) + GP(2,T) + GP(3,T))/(2*TotalPop(T));
                Z(i,j) = W(T);   

             end
         end

         mytime= toc;
         fprintf('parfor iteration %d , executed by worker %d finished in %f seconds\n',i,labindex,mytime);      
     end     
     csvwrite(saveStr, Z);
 
% EQUATION FUNCTIONS & CALCULATIONS
function gprime = gprimeFUNCT(B, alpha, beta, gamma, sigma,lambda,fitCost,survivalRate)

    sum2 = sum(B(1:6));

    J2(7:12) = B(7:12);
    J2(1:6) = B(1:6)/sum2;

    bp1 = MEDEA_Nonresistant_Rates(J2, alpha, beta, gamma, sigma,lambda,fitCost,survivalRate);

    gprime = bp1';        
  