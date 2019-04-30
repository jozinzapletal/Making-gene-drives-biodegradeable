 function Underdominance_1Locus_Parameter_Spaces
     clear
     clc
 
     saveStr = 'Underdominance_1Locus_Parameter_Space.csv';

     % Reading and assigning values from Excel document
     M = xlsread('Underdominance 1Locus Input Parameters.xlsx');
     sigma = M(4,1);
     lambda = M(5,1);
     omegaA = M(7,1);
     omegaB = M(8,1);
     mortRateJuven = M(9,1);
     mortRateAdult = M(10,1);
     developTime = M(11,1);
     gens = M(12,1);
     span = gens*developTime;     
     
     % Assignment of initial conditions
     a1 = M(15,1); a2 = M(16,1); a3 = M(17,1); a4 = M(18,1); a5 = M(19,1); a6 = M(20,1); a7 = M(21,1); a8 = M(22,1); a9 = M(23,1); a10 = M(24,1); a11 = M(25,1); a12 = M(26,1); a13 = M(27,1); a14 = M(28,1); a15 = M(29,1);
     b1 = M(30,1); b2 = M(31,1); b3 = M(32,1); b4 = M(33,1); b5 = M(34,1); b6 = M(35,1); b7 = M(36,1); b8 = M(37,1); b9 = M(38,1); b10 = M(39,1); b11 = M(40,1); b12 = M(41,1); b13 = M(42,1); b14 = M(43,1); b15 = M(44,1);

     %     ww wgA wgB wsA wsB gAgA gAgB gAsA gAsB gBgB gBsA gBsB sAsA sAsB sBsB
     g0 = [a1 a2  a3  a4  a5  a6   a7   a8   a9   a10  a11  a12  a13  a14  a15  ...    %Female
           b1 b2  b3  b4  b5  b6   b7   b8   b9   b10  b11  b12  b13  b14  b15   ]';   %Male
                     
     % Assignment of initial fitness costs
     a1 = M(15,7); a2 = M(16,7); a3 = M(17,7); a4 = M(18,7); a5 = M(19,7); a6 = M(20,7); a7 = M(21,7); a8 = M(22,7); a9 = M(23,7); a10 = M(24,7); a11 = M(25,7); a12 = M(26,7); a13 = M(27,7); a14 = M(28,7); a15 = M(29,7);
     b1 = M(30,7); b2 = M(31,7); b3 = M(32,7); b4 = M(33,7); b5 = M(34,7); b6 = M(35,7); b7 = M(36,7); b8 = M(37,7); b9 = M(38,7); b10 = M(39,7); b11 = M(40,7); b12 = M(41,7); b13 = M(42,7); b14 = M(43,7); b15 = M(44,7);

     %           ww wgA wgB wsA wsB gAgA gAgB gAsA gAsB gBgB gBsA gBsB sAsA sAsB sBsB
     fitCost =  [a1 a2  a3  a4  a5  a6   a7   a8   a9   a10  a11  a12  a13  a14  a15  ...    %Female
                 b1 b2  b3  b4  b5  b6   b7   b8   b9   b10  b11  b12  b13  b14  b15   ]';   %Male      
            
     mortRateAdult = mortRateAdult./(1-fitCost);
     mortRateJuven = mortRateJuven./(1-fitCost);
     
     % ensures the mortality rate cannot be more than 100% 
     for i=1:30
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
     for i=1:i2  
         tic 
         for j=1:j2

             A = zeros(30,span);
             J = zeros(30,span);
             G = zeros(30,span);
             GP = zeros(15,span);
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
                    J(:,1) = gprimeFUNCT(A(:,1),alpha,beta,gamma,sigma, lambda, fitCost, omegaA, omegaB);
                elseif (T > 1) && (T <= developTime)
                    A(:,T) = A(:,T-1).*(1-mortRateAdult);
                    J(:,T) = gprimeFUNCT(A(:,T),alpha,beta,gamma,sigma, lambda, fitCost, omegaA, omegaB);
                else
                    A(:,T) = A(:,T-1).*(1-mortRateAdult) + J(:,T-developTime).*((1-mortRateJuven).^developTime);
                    J(:,T) = gprimeFUNCT(A(:,T),alpha,beta,gamma,sigma, lambda, fitCost, omegaA, omegaB);
                end    

                JT = zeros(30,span);
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
                
                GP(:,T) = G(1:15,T) + G(16:30,T);
                
                W(T) = (2*GP(1,T) + sum(GP(2:5,T)))/(2*TotalPop(T));
                Z(i,j) = W(T);
                
             end
         end

        mytime= toc;
        fprintf('parfor iteration %d , executed by worker %d finished in %f seconds\n',i,labindex,mytime);

     end
     csvwrite(saveStr, Z);
            
% EQUATION FUNCTIONS & CALCULATIONS
  function gprime = gprimeFUNCT(B,alpha,beta,gamma,sigma,lambda,fitCost,omegaA,omegaB)
        
         sum2 = sum(B(16:30));
          
         J2(1:15) = B(1:15);
         J2(16:30) = B(16:30)/sum2;
         
         bp1 = Underdominance_1Locus_Rates(J2,sigma,lambda,fitCost,omegaA,omegaB,alpha,beta,gamma);

         gprime = bp1';
         