 function Underdominance_2Locus_Parameter_Spaces
     clear
     clc

     saveStr = 'Underdominance_2Locus_Parameter_Space.csv';

     % Reading and assigning values from Excel document
     M = xlsread('Underdominance 2Locus Input Parameters.xlsx');
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
     a1 = M(15,1); a2 = M(16,1); a3 = M(17,1); a4 = M(18,1); a5 = M(19,1); a6 = M(20,1); a7 = M(21,1); a8 = M(22,1); a9 = M(23,1); a10 = M(24,1); a11 = M(25,1); a12 = M(26,1); a13 = M(27,1); a14 = M(28,1); a15 = M(29,1); a16 = M(30,1); a17 = M(31,1); a18 = M(32,1); a19 = M(33,1); a20 = M(34,1); a21 = M(35,1); a22 = M(36,1); a23 = M(37,1); a24 = M(38,1); a25 = M(39,1); a26 = M(40,1); a27 = M(41,1); a28 = M(42,1); a29 = M(43,1); a30 = M(44,1); a31 = M(45,1); a32 = M(46,1); a33 = M(47,1); a34 = M(48,1); a35 = M(49,1); a36 = M(50,1);
     b1 = M(51,1); b2 = M(52,1); b3 = M(53,1); b4 = M(54,1); b5 = M(55,1); b6 = M(56,1); b7 = M(57,1); b8 = M(58,1); b9 = M(59,1); b10 = M(60,1); b11 = M(61,1); b12 = M(62,1); b13 = M(63,1); b14 = M(64,1); b15 = M(65,1); b16 = M(66,1); b17 = M(67,1); b18 = M(68,1); b19 = M(69,1); b20 = M(70,1); b21 = M(71,1); b22 = M(72,1); b23 = M(73,1); b24 = M(74,1); b25 = M(75,1); b26 = M(76,1); b27 = M(77,1); b28 = M(78,1); b29 = M(79,1); b30 = M(80,1); b31 = M(81,1); b32 = M(82,1); b33 = M(83,1); b34 = M(84,1); b35 = M(85,1); b36 = M(86,1);

     %     ww ww  ww  ww   ww   ww   wgA wgA wgA wgA  wgA  wgA  wsA wsA wsA wsA  wsA  wsA  gAgA gAgA gAgA gAgA gAgA gAgA gAsA gAsA gAsA gAsA gAsA gAsA sAsA sAsA sAsA sAsA sAsA sAsA 
     %     ww wgB wsB gBgB gBsB sBsB ww  wgB wsB gBgB gBsB sBsB ww  wgB wsB gBgB gBsB sBsB ww   wgB  wsB  gBgB gBsB sBsB ww   wgB  wsB  gBgB gBsB sBsB ww   wgB  wsB  gBgB gBsB sBsB 
     g0 = [a1 a2  a3  a4   a5   a6   a7  a8  a9  a10  a11  a12  a13 a14 a15 a16  a17  a18  a19  a20  a21  a22  a23  a24  a25  a26  a27  a28  a29  a30  a31  a32  a33  a34  a35  a36   ...  %Female
           b1 b2  b3  b4   b5   b6   b7  b8  b9  b10  b11  b12  b13 b14 b15 b16  b17  b18  b19  b20  b21  b22  b23  b24  b25  b26  b27  b28  b29  b30  b31  b32  b33  b34  b35  b36   ]';  %Male

     % Assignment of initial fitness costs
     a1 = M(15,7); a2 = M(16,7); a3 = M(17,7); a4 = M(18,7); a5 = M(19,7); a6 = M(20,7); a7 = M(21,7); a8 = M(22,7); a9 = M(23,7); a10 = M(24,7); a11 = M(25,7); a12 = M(26,7); a13 = M(27,7); a14 = M(28,7); a15 = M(29,7); a16 = M(30,7); a17 = M(31,7); a18 = M(32,7); a19 = M(33,7); a20 = M(34,7); a21 = M(35,7); a22 = M(36,7); a23 = M(37,7); a24 = M(38,7); a25 = M(39,7); a26 = M(40,7); a27 = M(41,7); a28 = M(42,7); a29 = M(43,7); a30 = M(44,7); a31 = M(45,7); a32 = M(46,7); a33 = M(47,7); a34 = M(48,7); a35 = M(49,7); a36 = M(50,7);
     b1 = M(51,7); b2 = M(52,7); b3 = M(53,7); b4 = M(54,7); b5 = M(55,7); b6 = M(56,7); b7 = M(57,7); b8 = M(58,7); b9 = M(59,7); b10 = M(60,7); b11 = M(61,7); b12 = M(62,7); b13 = M(63,7); b14 = M(64,7); b15 = M(65,7); b16 = M(66,7); b17 = M(67,7); b18 = M(68,7); b19 = M(69,7); b20 = M(70,7); b21 = M(71,7); b22 = M(72,7); b23 = M(73,7); b24 = M(74,7); b25 = M(75,7); b26 = M(76,7); b27 = M(77,7); b28 = M(78,7); b29 = M(79,7); b30 = M(80,7); b31 = M(81,7); b32 = M(82,7); b33 = M(83,7); b34 = M(84,7); b35 = M(85,7); b36 = M(86,7);

     %          ww ww  ww  ww   ww   ww   wgA wgA wgA wgA  wgA  wgA  wsA wsA wsA wsA  wsA  wsA  gAgA gAgA gAgA gAgA gAgA gAgA gAsA gAsA gAsA gAsA gAsA gAsA sAsA sAsA sAsA sAsA sAsA sAsA 
     %          ww wgB wsB gBgB gBsB sBsB ww  wgB wsB gBgB gBsB sBsB ww  wgB wsB gBgB gBsB sBsB ww   wgB  wsB  gBgB gBsB sBsB ww   wgB  wsB  gBgB gBsB sBsB ww   wgB  wsB  gBgB gBsB sBsB 
     fitCost = [a1 a2  a3  a4   a5   a6   a7  a8  a9  a10  a11  a12  a13 a14 a15 a16  a17  a18  a19  a20  a21  a22  a23  a24  a25  a26  a27  a28  a29  a30  a31  a32  a33  a34  a35  a36   ...  %Female
                b1 b2  b3  b4   b5   b6   b7  b8  b9  b10  b11  b12  b13 b14 b15 b16  b17  b18  b19  b20  b21  b22  b23  b24  b25  b26  b27  b28  b29  b30  b31  b32  b33  b34  b35  b36   ]';  %Male

     mortRateAdult = mortRateAdult./(1-fitCost);
     mortRateJuven = mortRateJuven./(1-fitCost);
     
     % ensures the mortality rate cannot be more than 100% 
     for i=1:72
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
     parfor i=1:i2  
         tic 
         for j=1:j2

             A = zeros(72,span);
             J = zeros(72,span);
             G = zeros(72,span);
             GP = zeros(36,span);
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

                JT = zeros(72,span);
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

                GP(:,T) = G(1:36,T) + G(37:72,T);       
                W(T) = (4*GP(1,T)+3*sum(GP(2:3,T))+2*sum(GP(4:6,T))+3*GP(7,T)+2*sum(GP(8:9,T))+sum(GP(10:12,T))+3*GP(13,T)+2*sum(GP(14:15,T))+sum(GP(16:18,T))+2*GP(19,T)+sum(GP(20:21,T))+2*GP(25,T)+sum(GP(26:27,T))+2*GP(31,T)+sum(GP(32:33,T)))/(4*TotalPop(T));
                Z(i,j) = W(T);  
                
             end
         end

        mytime= toc;
        fprintf('parfor iteration %d , executed by worker %d finished in %f seconds\n',i,labindex,mytime);

     end
     csvwrite(saveStr, Z);
            
 % EQUATION FUNCTIONS & CALCULATIONS            
 function gprime = gprimeFUNCT(B, alpha, beta, gamma, sigma, lambda, fitCost, omegaA, omegaB)

         sum1 = sum(B(37:72));
         
         J2(1:36) = B(1:36);
         J2(37:72) = B(37:72)/sum1;
         
         bp1 = Underdominance_2Locus_Rates(J2,sigma,lambda,fitCost,omegaA,omegaB,alpha,beta,gamma);

         gprime = bp1';     
  