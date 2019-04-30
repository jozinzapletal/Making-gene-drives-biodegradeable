function CRISPR1_5_Progression
     clear
     clc

     saveStr1 = 'CRISPR1-5 Progression.csv';
     saveStr2 = 'CRISPR1-5 Population Size.csv';
     saveStr3 = 'CRISPR1-5 Alleles.csv';

     % Reading and assigning values from Excel document
     M = xlsread('CRISPR1-5 Input Parameters.xlsx');
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
     a1 = M(19,1); a2 = M(20,1); a3 = M(21,1); a4 = M(22,1); a5 = M(23,1); a6 = M(24,1); a7 = M(25,1); a8 = M(26,1); a9 = M(27,1); a10 = M(28,1); a11 = M(29,1); a12 = M(30,1); a13 = M(31,1); a14 = M(32,1); a15 = M(33,1); a16 = M(34,1); a17 = M(35,1); a18 = M(36,1); a19 = M(37,1); a20 = M(38,1); a21 = M(39,1); a22 = M(40,1); a23 = M(41,1); a24 = M(42,1); a25 = M(43,1); a26 = M(44,1); a27 = M(45,1); a28 = M(46,1); a29 = M(47,1); a30 = M(48,1); a31 = M(49,1); a32 = M(50,1); a33 = M(51,1); a34 = M(52,1); a35 = M(53,1); a36 = M(54,1); a37 = M(55,1); a38 = M(56,1); a39 = M(57,1); a40 = M(58,1); a41 = M(59,1); a42 = M(60,1); a43 = M(61,1); a44 = M(62,1); a45 = M(63,1); a46 = M(64,1); a47 = M(65,1); a48 = M(66,1); a49 = M(67,1); a50 = M(68,1); a51 = M(69,1); a52 = M(70,1); a53 = M(71,1); a54 = M(72,1); a55 = M(73,1); 
	 b1 = M(74,1); b2 = M(75,1); b3 = M(76,1); b4 = M(77,1); b5 = M(78,1); b6 = M(79,1); b7 = M(80,1); b8 = M(81,1); b9 = M(82,1); b10 = M(83,1); b11 = M(84,1); b12 = M(85,1); b13 = M(86,1); b14 = M(87,1); b15 = M(88,1); b16 = M(89,1); b17 = M(90,1); b18 = M(91,1); b19 = M(92,1); b20 = M(93,1); b21 = M(94,1); b22 = M(95,1); b23 = M(96,1); b24 = M(97,1); b25 = M(98,1); b26 = M(99,1); b27 = M(100,1); b28 = M(101,1); b29 = M(102,1); b30 = M(103,1); b31 = M(104,1); b32 = M(105,1); b33 = M(106,1); b34 = M(107,1); b35 = M(108,1); b36 = M(109,1); b37 = M(110,1); b38 = M(111,1); b39 = M(112,1); b40 = M(113,1); b41 = M(114,1); b42 = M(115,1); b43 = M(116,1); b44 = M(117,1); b45 = M(118,1); b46 = M(119,1); b47 = M(120,1); b48 = M(121,1); b49 = M(122,1); b50 = M(123,1); b51 = M(124,1); b52 = M(125,1); b53 = M(126,1); b54 = M(127,1); b55 = M(128,1); 

      %     ww wv wu wr wg1 wg2 wg3 wg4 wg5 ws  vv  vu  vr  vg1 vg2 vg3 vg4 vg5 vs  uu  ur  ug1 ug2 ug3 ug4 ug5 us  rr  rg1 rg2 rg3 rg4 rg5 rs  g1g1 g1g2 g1g3 g1g4 g1g5 g1s g2g2 g2g3 g2g4 g2g5 g2s g3g3 g3g4 g3g5 g3s g4g4 g4g5 g4s  g5g5 g5s ss   
      g0 = [b1 b2 b3 b4 b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35  b36  b37  b38  b39  b40 b41  b42  b43  b44  b45 b46  b47  b48  b49 b50  b51  b52  b53  b54 b55   ...  % FEMALE
		    a1 a2 a3 a4 a5  a6  a7  a8  a9  a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35  a36  a37  a38  a39  a40 a41  a42  a43  a44  a45 a46  a47  a48  a49 a50  a51  a52  a53  a54 a55   ]';  % MALE

     % Assignment of initial fitness costs
     a1 = M(19,7); a2 = M(20,7); a3 = M(21,7); a4 = M(22,7); a5 = M(23,7); a6 = M(24,7); a7 = M(25,7); a8 = M(26,7); a9 = M(27,7); a10 = M(28,7); a11 = M(29,7); a12 = M(30,7); a13 = M(31,7); a14 = M(32,7); a15 = M(33,7); a16 = M(34,7); a17 = M(35,7); a18 = M(36,7); a19 = M(37,7); a20 = M(38,7); a21 = M(39,7); a22 = M(40,7); a23 = M(41,7); a24 = M(42,7); a25 = M(43,7); a26 = M(44,7); a27 = M(45,7); a28 = M(46,7); a29 = M(47,7); a30 = M(48,7); a31 = M(49,7); a32 = M(50,7); a33 = M(51,7); a34 = M(52,7); a35 = M(53,7); a36 = M(54,7); a37 = M(55,7); a38 = M(56,7); a39 = M(57,7); a40 = M(58,7); a41 = M(59,7); a42 = M(60,7); a43 = M(61,7); a44 = M(62,7); a45 = M(63,7); a46 = M(64,7); a47 = M(65,7); a48 = M(66,7); a49 = M(67,7); a50 = M(68,7); a51 = M(69,7); a52 = M(70,7); a53 = M(71,7); a54 = M(72,7); a55 = M(73,7); 
	 b1 = M(74,7); b2 = M(75,7); b3 = M(76,7); b4 = M(77,7); b5 = M(78,7); b6 = M(79,7); b7 = M(80,7); b8 = M(81,7); b9 = M(82,7); b10 = M(83,7); b11 = M(84,7); b12 = M(85,7); b13 = M(86,7); b14 = M(87,7); b15 = M(88,7); b16 = M(89,7); b17 = M(90,7); b18 = M(91,7); b19 = M(92,7); b20 = M(93,7); b21 = M(94,7); b22 = M(95,7); b23 = M(96,7); b24 = M(97,7); b25 = M(98,7); b26 = M(99,7); b27 = M(100,7); b28 = M(101,7); b29 = M(102,7); b30 = M(103,7); b31 = M(104,7); b32 = M(105,7); b33 = M(106,7); b34 = M(107,7); b35 = M(108,7); b36 = M(109,7); b37 = M(110,7); b38 = M(111,7); b39 = M(112,7); b40 = M(113,7); b41 = M(114,7); b42 = M(115,7); b43 = M(116,7); b44 = M(117,7); b45 = M(118,7); b46 = M(119,7); b47 = M(120,7); b48 = M(121,7); b49 = M(122,7); b50 = M(123,7); b51 = M(124,7); b52 = M(125,7); b53 = M(126,7); b54 = M(127,7); b55 = M(128,7); 

          %     ww wv wu wr wg1 wg2 wg3 wg4 wg5 ws  vv  vu  vr  vg1 vg2 vg3 vg4 vg5 vs  uu  ur  ug1 ug2 ug3 ug4 ug5 us  rr  rg1 rg2 rg3 rg4 rg5 rs  g1g1 g1g2 g1g3 g1g4 g1g5 g1s g2g2 g2g3 g2g4 g2g5 g2s g3g3 g3g4 g3g5 g3s g4g4 g4g5 g4s  g5g5 g5s ss   
     fitCost = [b1 b2 b3 b4 b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35  b36  b37  b38  b39  b40 b41  b42  b43  b44  b45 b46  b47  b48  b49 b50  b51  b52  b53  b54 b55   ...  % FEMALE
		        a1 a2 a3 a4 a5  a6  a7  a8  a9  a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35  a36  a37  a38  a39  a40 a41  a42  a43  a44  a45 a46  a47  a48  a49 a50  a51  a52  a53  a54 a55   ]';  % MALE

     mortRateAdult = mortRateAdult./(1-fitCost);
     mortRateJuven = mortRateJuven./(1-fitCost);

     for i=1:110
         if (mortRateAdult(i) == Inf) || (mortRateAdult(i) > 1)
             mortRateAdult(i) = 1;
             mortRateJuven(i) = 1;
         end
     end

     clear b1 b2 b3 b4 b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51  b52  b53  b54  b55  ...
           a1 a2 a3 a4 a5  a6  a7  a8  a9  a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35 a36 a37 a38 a39 a40 a41 a42 a43 a44 a45 a46 a47 a48 a49 a50 a51  a52  a53  a54  a55  ;       

     
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

             A = zeros(110,span);
             J = zeros(110,span);
             G = zeros(110,span);
             TotalPop = zeros(span,1);
             wildtypeSum = zeros(span,1);
             GP = zeros(55,span);

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

                JT = zeros(110,span);
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
                GP(:,T) = G(1:55,T)+G(56:110,T);

                wildtypeSum(T) = sum(GP(1:4,T))+sum(GP(11:13,T))+sum(GP(20:21,T))+GP(28,T);
                W(i,j,T) = wildtypeSum(T)/TotalPop(T);
                P(i,j,T) = TotalPop(T);
                
                Wcount(i,j,T) = (2*GP(1,T) + sum(GP(2:10,T)))/(2*TotalPop(T));
                Vcount(i,j,T) = (GP(2,T) + 2*GP(11,T) + sum(GP(12:19,T)))/(2*TotalPop(T));
                Ucount(i,j,T) = (GP(3,T) + GP(12,T) + 2*GP(20,T) + sum(GP(21:27,T)))/(2*TotalPop(T));
                Rcount(i,j,T) = (GP(4,T) + GP(13,T) + GP(21,T) + 2*GP(28,T) + sum(GP(29:34,T)))/(2*TotalPop(T));
                Gcount(i,j,T) = (sum(GP(5:9,T)) + sum(GP(14:18,T)) + sum(GP(22:26,T)) + sum(GP(29:33,T)) + 2*sum(GP(35:39,T)) + GP(40,T) + 2*sum(GP(41:44,T)) + GP(45,T) + 2*sum(GP(46:48,T)) + GP(49,T) + 2*sum(GP(50:51,T)) + GP(52,T) + 2*GP(53,T) + GP(54,T))/(2*TotalPop(T));
                Scount(i,j,T) = (GP(10,T) + GP(19,T) + GP(27,T) + GP(34,T) + GP(40,T) + GP(45,T) + GP(49,T) + GP(52,T) + GP(54,T) + 2*GP(55,T))/(2*TotalPop(T));

             end
        end
        mytime= toc;
        fprintf('parfor iteration %d , executed by worker %d finished in %f seconds\n',i,labindex,mytime);
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
                    x0(:) = g0(1:55)+g0(56:110);
                    Z(row,3)= (sum(x0(1:4))+sum(x0(11:13))+sum(x0(20:21))+x0(28))/(sum(x0(:)));  % inital conditions  
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
                 
                 x0(:) = g0(1:55)+g0(56:110); 
                 Z(row+1,4) = ((2*x0(1) + sum(x0(2:10))))/(2*sum(x0(:)));
                 Z(row+2,4) = (x0(2) + 2*x0(11) + sum(x0(12:19)))/(2*sum(x0(:)));
                 Z(row+3,4) = (x0(3) + x0(12) + 2*x0(20) + sum(x0(21:27)))/(2*sum(x0(:)));
                 Z(row+4,4) = (x0(4) + x0(13) + x0(21) + 2*x0(28) + sum(x0(29:34)))/(2*sum(x0(:)));
                 Z(row+5,4) = (sum(x0(5:9)) + sum(x0(14:18)) + sum(x0(22:26)) + sum(x0(29:33)) + 2*sum(x0(35:39)) + x0(40) + 2*sum(x0(41:44)) + x0(45) + 2*sum(x0(46:48)) + x0(49) + 2*sum(x0(50:51)) + x0(52) + 2*x0(53) + x0(54))/(2*sum(x0(:)));
                 Z(row+6,4) = (x0(10) + x0(19) + x0(27) + x0(34) + x0(40) + x0(45) + x0(49) + x0(52) + x0(54) + 2*x0(55))/(2*sum(x0(:)));
                                 
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
                 
         sum2 = sum(B(1:55));
         
         J2(56:110) = B(56:110);
         J2(1:55) = B(1:55)/sum2;
         
         bp1 = CRISPR1_5_Rates(J2,sigma,lambda,delta1,delta2,fitCost,q1,q2,P1,P2,alpha1,alpha2,beta1,beta2,gamma1,gamma2);

         gprime = bp1';                