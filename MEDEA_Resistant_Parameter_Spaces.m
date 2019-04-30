 function MEDEA_Resistant_Parameter_Spaces
     clear
     clc
     
     saveStr = 'MEDEA_R_Parameter_Space.csv';
     
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

             A = zeros(20,span);
             J = zeros(20,span);
             G = zeros(20,span);
             GP = zeros(10,span);
             TotalPop = zeros(span,1);
             W = zeros(span,1);

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

                JT = zeros(20,span);
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

                GP(:,T) = G(1:10,T) + G(11:20,T);
                W(T) = (2*GP(1,T) + GP(2,T) + GP(3,T) + GP(4,T) + 2*GP(5,T) + GP(6,T) + GP(7,T))/(2*TotalPop(T));
                Z(i,j) = W(T);   

             end
         end

        mytime= toc;
        fprintf('parfor iteration %d , executed by worker %d finished in %f seconds\n',i,labindex,mytime);

     end
     csvwrite(saveStr, Z);

% EQUATION FUNCTIONS & CALCULATIONS            
function gprime = gprimeFUNCT(B,alpha,beta,gamma,sigma,lambda,fitCost,survivalRate)

    sum2 = sum(B(1:10));

    J2(11:20) = B(11:20);
    J2(1:10) = B(1:10)/sum2;

    bp1 = MEDEA_Resistant_Rates(J2,alpha,beta,gamma,sigma,lambda,fitCost,survivalRate);

    gprime = bp1';        
