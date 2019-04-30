function CRISPR1_1_Progression
     clear
     clc

     saveStr1 = 'CRISPR1-1 Progression.csv';
     saveStr2 = 'CRISPR1-1 Population Size.csv';
     saveStr3 = 'CRISPR1-1 Alleles.csv';

     % Reading and assigning values from Excel document
     M = xlsread('CRISPR1-1 Input Parameters.xlsx');
     sigma = M(4,1);
     lambda = M(5,1);
     q2 = M(7,1);
     q1 = M(8,1);
     P2 = M(9,1);
     P1 = M(10,1);
     delta2 = M(11,1);
     delta1 = M(12,1);    
     mortRateJuven = M(13,1);
     mortRateAdult = M(14,1);
     developTime = M(15,1);
     gens = M(16,1);
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
     a1 = M(19,1); a2 = M(20,1); a3 = M(21,1); a4 = M(22,1); a5 = M(23,1); a6 = M(24,1); a7 = M(25,1); a8 = M(26,1); a9 = M(27,1); a10 = M(28,1); a11 = M(29,1); a12 = M(30,1); a13 = M(31,1); a14 = M(32,1); a15 = M(33,1); a16 = M(34,1); a17 = M(35,1); a18 = M(36,1); a19 = M(37,1); a20 = M(38,1); a21 = M(39,1); 
     b1 = M(40,1); b2 = M(41,1); b3 = M(42,1); b4 = M(43,1); b5 = M(44,1); b6 = M(45,1); b7 = M(46,1); b8 = M(47,1); b9 = M(48,1); b10 = M(49,1); b11 = M(50,1); b12 = M(51,1); b13 = M(52,1); b14 = M(53,1); b15 = M(54,1); b16 = M(55,1); b17 = M(56,1); b18 = M(57,1); b19 = M(58,1); b20 = M(59,1); b21 = M(60,1); 

     %     ww wv wu wr wg ws vv vu vr vg  vs  uu  ur  ug  us  rr  rg  rs  gg  gs  ss    
     g0 = [a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21  ...  % FEMALE
           b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21  ]';  % MALE

     % Assignment of initial fitness costs
     a1 = M(19,7); a2 = M(20,7); a3 = M(21,7); a4 = M(22,7); a5 = M(23,7); a6 = M(24,7); a7 = M(25,7); a8 = M(26,7); a9 = M(27,7); a10 = M(28,7); a11 = M(29,7); a12 = M(30,7); a13 = M(31,7); a14 = M(32,7); a15 = M(33,7); a16 = M(34,7); a17 = M(35,7); a18 = M(36,7); a19 = M(37,7); a20 = M(38,7); a21 = M(39,7); 
     b1 = M(40,7); b2 = M(41,7); b3 = M(42,7); b4 = M(43,7); b5 = M(44,7); b6 = M(45,7); b7 = M(46,7); b8 = M(47,7); b9 = M(48,7); b10 = M(49,7); b11 = M(50,7); b12 = M(51,7); b13 = M(52,7); b14 = M(53,7); b15 = M(54,7); b16 = M(55,7); b17 = M(56,7); b18 = M(57,7); b19 = M(58,7); b20 = M(59,7); b21 = M(60,7); 

     %          ww wv wu wr wg ws vv vu vr vg  vs  uu  ur  ug  us  rr  rg  rs  gg  gs  ss 
     fitCost = [a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21  ...  % FEMALE
                b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21  ]';  % MALE

     mortRateAdult = mortRateAdult./(1-fitCost);
     mortRateJuven = mortRateJuven./(1-fitCost);

     for i=1:42
         if (mortRateAdult(i) == Inf) || (mortRateAdult(i) > 1)
             mortRateAdult(i) = 1;
             mortRateJuven(i) = 1;
         end
     end

     % RUNS THE MODEL
     W = zeros(i2,j2,span);
     P = zeros(i2,j2,span);
     Wcount = zeros(i2,j2,span);
     Vcount = zeros(i2,j2,span);
     Ucount = zeros(i2,j2,span);
     Rcount = zeros(i2,j2,span);
     Gcount = zeros(i2,j2,span);
     Scount = zeros(i2,j2,span);
     for i=1:i2
     tic    
        for j=1:j2

             A = zeros(42,span);
             G = zeros(42,span);
             J = zeros(42,span);
             TotalPop = zeros(span,1);
             wildtypeSum = zeros(span,1);
             GP = zeros(21,span);

             alpha1 = X(i);
             gamma1 = Y(j);
             beta1 = 1 - (alpha1 + gamma1);
             alpha2 = X(i);
             gamma2 = Y(j);
             beta2 = 1 - (alpha2 + gamma2);

             if alpha1 == 0
                 gamma1 = 0;
                 beta1 = 1;
             end
             if alpha2 == 0
                 gamma2 = 0;
                 beta2 = 1;
             end

             for T=1:span

                if (T == 1)
                    A(:,1) = g0;
                    J(:,1) = gprimeFUNCT(A(:,1),alpha1,alpha2,beta1,beta2,gamma1,gamma2,P1,q1,P2,q2,delta1,delta2,fitCost,sigma,lambda);
                elseif (T > 1) && (T <= developTime)
                    A(:,T) = A(:,T-1).*(1-mortRateAdult);
                    J(:,T) = gprimeFUNCT(A(:,T),alpha1,alpha2,beta1,beta2,gamma1,gamma2,P1,q1,P2,q2,delta1,delta2,fitCost,sigma,lambda);
                else
                    A(:,T) = A(:,T-1).*(1-mortRateAdult) + J(:,T-developTime).*((1-mortRateJuven).^developTime);
                    J(:,T) = gprimeFUNCT(A(:,T),alpha1,alpha2,beta1,beta2,gamma1,gamma2,P1,q1,P2,q2,delta1,delta2,fitCost,sigma,lambda);
                end    

                JT = zeros(42,span);
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
                GP(:,T) = G(1:21,T)+G(22:42,T);

                wildtypeSum(T) = sum(GP(1:4,T))+sum(GP(7:9,T))+sum(GP(12:13,T))+GP(16,T);
                W(i,j,T) = (wildtypeSum(T)/TotalPop(T));
                P(i,j,T) = TotalPop(T);
                
                Wcount(i,j,T) = (2*GP(1,T) + sum(GP(2:6,T)))/(2*TotalPop(T));
                Vcount(i,j,T) = (GP(2,T) + 2*GP(7,T) + sum(GP(8:11,T)))/(2*TotalPop(T));
                Ucount(i,j,T) = (GP(3,T) + GP(8,T) + 2*GP(12,T) + sum(GP(13:15,T)))/(2*TotalPop(T));
                Rcount(i,j,T) = (GP(4,T) + GP(9,T) + GP(13,T) + 2*GP(16,T) + sum(GP(17:18,T)))/(2*TotalPop(T));
                Gcount(i,j,T) = (GP(5,T) + GP(10,T) + GP(14,T) + GP(17,T) + 2*GP(19,T) + GP(20,T))/(2*TotalPop(T));
                Scount(i,j,T) = (GP(6,T) + GP(11,T) + GP(15,T) + GP(18,T) + GP(20,T) + 2*GP(21,T))/(2*TotalPop(T));

             end
         end

        mytime= toc;
        fprintf('Iteration %d , executed by worker %d finished in %f seconds\n',i,labindex,mytime);

     end

     % Outputs the wildtype proportion to .csv file
     Z = zeros((i2*j2+1),span+1);
     Z1 = zeros((i2*j2+1),span+1);
     for n=1:i2
         for m = 1:j2
             row = (m-1)*i2+n+1;
             Z(row,2) = X(n);
             Z(row,1) = Y(m);
             Z1(row,2) = X(n);
             Z1(row,1) = Y(m);

             for k=0:span
                 if k == 0
                    x0(:) = g0(1:21)+g0(22:42);
                    Z(row,3)= (sum(x0(1:4))+sum(x0(7:9))+sum(x0(12:13))+x0(16))/(sum(x0(:)));  % inital conditions  
                    Z1(row,3)= sum(x0(:));
                 else
                    Z(1,k+3) = k/developTime;
                    Z(row,k+3)= W(n,m,k);
                    Z1(1,k+3) = k/developTime;
                    Z1(row,k+3)= P(n,m,k);
                 end
             end
         end
     end     
     csvwrite(saveStr1, Z);
     csvwrite(saveStr2, Z1);
     
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
                 Z(row+5,1)= Y(m);
                 Z(row+6,1)= Y(m);

                 Z(row+1,2)= X(n);
                 Z(row+2,2)= X(n);
                 Z(row+3,2)= X(n);
                 Z(row+4,2)= X(n);
                 Z(row+5,2)= X(n);
                 Z(row+6,2)= X(n);

                 Z(row+1,3)= 1;
                 Z(row+2,3)= 2;
                 Z(row+3,3)= 3;
                 Z(row+4,3)= 4;
                 Z(row+5,3)= 5;
                 Z(row+6,3)= 6;
                 
                 x0(:) = g0(1:21)+g0(22:42); 
                 Z(row+1,4) = (2*x0(1) + sum(x0(2:6)))/(2*sum(x0(:)));
                 Z(row+2,4) = (x0(2) + 2*x0(7) + sum(x0(8:11)))/(2*sum(x0(:)));
                 Z(row+3,4) = (x0(3) + x0(8) + 2*x0(12) + sum(x0(13:15)))/(2*sum(x0(:)));
                 Z(row+4,4) = (x0(4) + x0(9) + x0(13) + 2*x0(16) + sum(x0(17:18)))/(2*sum(x0(:)));
                 Z(row+5,4) = (x0(5) + x0(10) + x0(14) + x0(17) + 2*x0(19) + x0(20))/(2*sum(x0(:)));
                 Z(row+6,4) = (x0(6) + x0(11) + x0(15) + x0(18) + x0(20) + 2*x0(21))/(2*sum(x0(:)));
                 
                 Z(row+1,p+4)= Wcount(n,m,p);
                 Z(row+2,p+4)= Vcount(n,m,p);
                 Z(row+3,p+4)= Ucount(n,m,p);
                 Z(row+4,p+4)= Rcount(n,m,p);
                 Z(row+5,p+4)= Gcount(n,m,p);
                 Z(row+6,p+4)= Scount(n,m,p);

             end
             row = row + 6;
         end
     end
     csvwrite(saveStr3, Z);
     
% EQUATION FUNCTIONS & CALCULATIONS     
function gprime = gprimeFUNCT(B,alpha1,alpha2,beta1,beta2,gamma1,gamma2,P1,q1,P2,q2,delta1,delta2,fitCost,sigma,lambda)
                 
         sum2 = sum(B(22:42));
         
         J2(1:21) = B(1:21);
         J2(22:42) = B(22:42)/sum2;
         
         bp1 = CRISPR1_1_Rates(J2,sigma,lambda,delta1,delta2,fitCost,q1,q2,P1,P2,alpha1,alpha2,beta1,beta2,gamma1,gamma2);

         gprime = bp1';