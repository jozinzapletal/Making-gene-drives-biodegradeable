function CRISPR5_1_Progression
     clear
     clc

     saveStr1 = 'CRISPR5-1 Progression.csv';
     saveStr2 = 'CRISPR5-1 Population Size.csv';
     saveStr3 = 'CRISPR5-1 Alleles.csv';

     % Reading and assigning values from Excel document
     M = xlsread('CRISPR5-1 Input Parameters.xlsx');
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
     a1 = M(19,1); a2 = M(20,1); a3 = M(21,1); a4 = M(22,1); a5 = M(23,1); a6 = M(24,1); a7 = M(25,1); a8 = M(26,1); a9 = M(27,1); a10 = M(28,1); a11 = M(29,1); a12 = M(30,1); a13 = M(31,1); a14 = M(32,1); a15 = M(33,1); a16 = M(34,1); a17 = M(35,1); a18 = M(36,1); a19 = M(37,1); a20 = M(38,1); a21 = M(39,1); a22 = M(40,1); a23 = M(41,1); a24 = M(42,1); a25 = M(43,1); a26 = M(44,1); a27 = M(45,1); a28 = M(46,1); a29 = M(47,1); a30 = M(48,1); a31 = M(49,1); a32 = M(50,1); a33 = M(51,1); a34 = M(52,1); a35 = M(53,1); a36 = M(54,1); a37 = M(55,1); a38 = M(56,1); a39 = M(57,1); a40 = M(58,1); a41 = M(59,1); a42 = M(60,1); a43 = M(61,1); a44 = M(62,1); a45 = M(63,1); a46 = M(64,1); a47 = M(65,1); a48 = M(66,1); a49 = M(67,1); a50 = M(68,1); a51 = M(69,1); a52 = M(70,1); a53 = M(71,1); a54 = M(72,1); a55 = M(73,1); a56 = M(74,1); a57 = M(75,1); a58 = M(76,1); a59 = M(77,1); a60 = M(78,1); a61 = M(79,1); a62 = M(80,1); a63 = M(81,1); a64 = M(82,1); a65 = M(83,1); a66 = M(84,1); a67 = M(85,1); a68 = M(86,1); a69 = M(87,1); a70 = M(88,1); a71 = M(89,1); a72 = M(90,1); a73 = M(91,1); a74 = M(92,1); a75 = M(93,1); a76 = M(94,1); a77 = M(95,1); a78 = M(96,1); a79 = M(97,1); a80 = M(98,1); a81 = M(99,1); a82 = M(100,1); a83 = M(101,1); a84 = M(102,1); a85 = M(103,1); a86 = M(104,1); a87 = M(105,1); a88 = M(106,1); a89 = M(107,1); a90 = M(108,1); a91 = M(109,1); a92 = M(110,1); a93 = M(111,1); a94 = M(112,1); a95 = M(113,1); a96 = M(114,1); a97 = M(115,1); a98 = M(116,1); a99 = M(117,1); a100 = M(118,1); a101 = M(119,1); a102 = M(120,1); a103 = M(121,1); a104 = M(122,1); a105 = M(123,1);	 
	 b1 = M(124,1); b2 = M(125,1); b3 = M(126,1); b4 = M(127,1); b5 = M(128,1); b6 = M(129,1); b7 = M(130,1); b8 = M(131,1); b9 = M(132,1); b10 = M(133,1); b11 = M(134,1); b12 = M(135,1); b13 = M(136,1); b14 = M(137,1); b15 = M(138,1); b16 = M(139,1); b17 = M(140,1); b18 = M(141,1); b19 = M(142,1); b20 = M(143,1); b21 = M(144,1); b22 = M(145,1); b23 = M(146,1); b24 = M(147,1); b25 = M(148,1); b26 = M(149,1); b27 = M(150,1); b28 = M(151,1); b29 = M(152,1); b30 = M(153,1); b31 = M(154,1); b32 = M(155,1); b33 = M(156,1); b34 = M(157,1); b35 = M(158,1); b36 = M(159,1); b37 = M(160,1); b38 = M(161,1); b39 = M(162,1); b40 = M(163,1); b41 = M(164,1); b42 = M(165,1); b43 = M(166,1); b44 = M(167,1); b45 = M(168,1); b46 = M(169,1); b47 = M(170,1); b48 = M(171,1); b49 = M(172,1); b50 = M(173,1); b51 = M(174,1); b52 = M(175,1); b53 = M(176,1); b54 = M(177,1); b55 = M(178,1); b56 = M(179,1); b57 = M(180,1); b58 = M(181,1); b59 = M(182,1); b60 = M(183,1); b61 = M(184,1); b62 = M(185,1); b63 = M(186,1); b64 = M(187,1); b65 = M(188,1); b66 = M(189,1); b67 = M(190,1); b68 = M(191,1); b69 = M(192,1); b70 = M(193,1); b71 = M(194,1); b72 = M(195,1); b73 = M(196,1); b74 = M(197,1); b75 = M(198,1); b76 = M(199,1); b77 = M(200,1); b78 = M(201,1); b79 = M(202,1); b80 = M(203,1); b81 = M(204,1); b82 = M(205,1); b83 = M(206,1); b84 = M(207,1); b85 = M(208,1); b86 = M(209,1); b87 = M(210,1); b88 = M(211,1); b89 = M(212,1); b90 = M(213,1); b91 = M(214,1); b92 = M(215,1); b93 = M(216,1); b94 = M(217,1); b95 = M(218,1); b96 = M(219,1); b97 = M(220,1); b98 = M(221,1); b99 = M(222,1); b100 = M(223,1); b101 = M(224,1); b102 = M(225,1); b103 = M(226,1); b104 = M(227,1); b105 = M(228,1); 
	 
     %     ww wv wg ws wr1 wr2 wr3 wr4 wr5 wu1 wu2 wu3 wu4 wu5 vv  vg  vs  vr1 vr2 vr3 vr4 vr5 vu1 vu2 vu3 vu4 vu5 gg  gs  gr1 gr2 gr3 gr4 gr5 gu1 gu2 gu3 gu4 gu5 ss  sr1 sr2 sr3 sr4 sr5 su1 su2 su3 su4 su5 r1r1 r1r2 r1r3 r1r4 r1r5 r1u1 r1u2 r1u3 r1u4 r1u5 r2r2 r2r3 r2r4 r2r5 r2u1 r2u2 r2u3 r2u4 r2u5 r3r3 r3r4 r3r5 r3u1 r3u2 r3u3 r3u4 r3u5 r4r4 r4r5 r4u1 r4u2 r4u3 r4u4 r4u5 r5r5 r5u1 r5u2 r5u3 r5u4 r5u5 u1u1 u1u2 u1u3 u1u4 u1u5 u2u2 u2u3 u2u4 u2u5 u3u3 u3u4 u3u5 u4u4 u4u5 u5u5                      
	 g0 = [b1 b2 b3 b4 b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51  b52  b53  b54  b55  b56  b57  b58  b59  b60  b61  b62  b63  b64  b65  b66  b67  b68  b69  b70  b71  b72  b73  b74  b75  b76  b77  b78  b79  b80  b81  b82  b83  b84  b85  b86  b87  b88  b89  b90  b91  b92  b93  b94  b95  b96  b97  b98  b99  b100 b101 b102 b103 b104 b105 ...  % MALE
	       a1 a2 a3 a4 a5  a6  a7  a8  a9  a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35 a36 a37 a38 a39 a40 a41 a42 a43 a44 a45 a46 a47 a48 a49 a50 a51  a52  a53  a54  a55  a56  a57  a58  a59  a60  a61  a62  a63  a64  a65  a66  a67  a68  a69  a70  a71  a72  a73  a74  a75  a76  a77  a78  a79  a80  a81  a82  a83  a84  a85  a86  a87  a88  a89  a90  a91  a92  a93  a94  a95  a96  a97  a98  a99  a100 a101 a102 a103 a104 a105  ]'; % FEMALE
    
     % Assignment of initial fitness costs
     a1 = M(19,7); a2 = M(20,7); a3 = M(21,7); a4 = M(22,7); a5 = M(23,7); a6 = M(24,7); a7 = M(25,7); a8 = M(26,7); a9 = M(27,7); a10 = M(28,7); a11 = M(29,7); a12 = M(30,7); a13 = M(31,7); a14 = M(32,7); a15 = M(33,7); a16 = M(34,7); a17 = M(35,7); a18 = M(36,7); a19 = M(37,7); a20 = M(38,7); a21 = M(39,7); a22 = M(40,7); a23 = M(41,7); a24 = M(42,7); a25 = M(43,7); a26 = M(44,7); a27 = M(45,7); a28 = M(46,7); a29 = M(47,7); a30 = M(48,7); a31 = M(49,7); a32 = M(50,7); a33 = M(51,7); a34 = M(52,7); a35 = M(53,7); a36 = M(54,7); a37 = M(55,7); a38 = M(56,7); a39 = M(57,7); a40 = M(58,7); a41 = M(59,7); a42 = M(60,7); a43 = M(61,7); a44 = M(62,7); a45 = M(63,7); a46 = M(64,7); a47 = M(65,7); a48 = M(66,7); a49 = M(67,7); a50 = M(68,7); a51 = M(69,7); a52 = M(70,7); a53 = M(71,7); a54 = M(72,7); a55 = M(73,7); a56 = M(74,7); a57 = M(75,7); a58 = M(76,7); a59 = M(77,7); a60 = M(78,7); a61 = M(79,7); a62 = M(80,7); a63 = M(81,7); a64 = M(82,7); a65 = M(83,7); a66 = M(84,7); a67 = M(85,7); a68 = M(86,7); a69 = M(87,7); a70 = M(88,7); a71 = M(89,7); a72 = M(90,7); a73 = M(91,7); a74 = M(92,7); a75 = M(93,7); a76 = M(94,7); a77 = M(95,7); a78 = M(96,7); a79 = M(97,7); a80 = M(98,7); a81 = M(99,7); a82 = M(100,7); a83 = M(101,7); a84 = M(102,7); a85 = M(103,7); a86 = M(104,7); a87 = M(105,7); a88 = M(106,7); a89 = M(107,7); a90 = M(108,7); a91 = M(109,7); a92 = M(110,7); a93 = M(111,7); a94 = M(112,7); a95 = M(113,7); a96 = M(114,7); a97 = M(115,7); a98 = M(116,7); a99 = M(117,7); a100 = M(118,7); a101 = M(119,7); a102 = M(120,7); a103 = M(121,7); a104 = M(122,7); a105 = M(123,7);	 
	 b1 = M(124,7); b2 = M(125,7); b3 = M(126,7); b4 = M(127,7); b5 = M(128,7); b6 = M(129,7); b7 = M(130,7); b8 = M(131,7); b9 = M(132,7); b10 = M(133,7); b11 = M(134,7); b12 = M(135,7); b13 = M(136,7); b14 = M(137,7); b15 = M(138,7); b16 = M(139,7); b17 = M(140,7); b18 = M(141,7); b19 = M(142,7); b20 = M(143,7); b21 = M(144,7); b22 = M(145,7); b23 = M(146,7); b24 = M(147,7); b25 = M(148,7); b26 = M(149,7); b27 = M(150,7); b28 = M(151,7); b29 = M(152,7); b30 = M(153,7); b31 = M(154,7); b32 = M(155,7); b33 = M(156,7); b34 = M(157,7); b35 = M(158,7); b36 = M(159,7); b37 = M(160,7); b38 = M(161,7); b39 = M(162,7); b40 = M(163,7); b41 = M(164,7); b42 = M(165,7); b43 = M(166,7); b44 = M(167,7); b45 = M(168,7); b46 = M(169,7); b47 = M(170,7); b48 = M(171,7); b49 = M(172,7); b50 = M(173,7); b51 = M(174,7); b52 = M(175,7); b53 = M(176,7); b54 = M(177,7); b55 = M(178,7); b56 = M(179,7); b57 = M(180,7); b58 = M(181,7); b59 = M(182,7); b60 = M(183,7); b61 = M(184,7); b62 = M(185,7); b63 = M(186,7); b64 = M(187,7); b65 = M(188,7); b66 = M(189,7); b67 = M(190,7); b68 = M(191,7); b69 = M(192,7); b70 = M(193,7); b71 = M(194,7); b72 = M(195,7); b73 = M(196,7); b74 = M(197,7); b75 = M(198,7); b76 = M(199,7); b77 = M(200,7); b78 = M(201,7); b79 = M(202,7); b80 = M(203,7); b81 = M(204,7); b82 = M(205,7); b83 = M(206,7); b84 = M(207,7); b85 = M(208,7); b86 = M(209,7); b87 = M(210,7); b88 = M(211,7); b89 = M(212,7); b90 = M(213,7); b91 = M(214,7); b92 = M(215,7); b93 = M(216,7); b94 = M(217,7); b95 = M(218,7); b96 = M(219,7); b97 = M(220,7); b98 = M(221,7); b99 = M(222,7); b100 = M(223,7); b101 = M(224,7); b102 = M(225,7); b103 = M(226,7); b104 = M(227,7); b105 = M(228,7); 
	 
     %           ww wv wg ws wr1 wr2 wr3 wr4 wr5 wu1 wu2 wu3 wu4 wu5 vv  vg  vs  vr1 vr2 vr3 vr4 vr5 vu1 vu2 vu3 vu4 vu5 gg  gs  gr1 gr2 gr3 gr4 gr5 gu1 gu2 gu3 gu4 gu5 ss  sr1 sr2 sr3 sr4 sr5 su1 su2 su3 su4 su5 r1r1 r1r2 r1r3 r1r4 r1r5 r1u1 r1u2 r1u3 r1u4 r1u5 r2r2 r2r3 r2r4 r2r5 r2u1 r2u2 r2u3 r2u4 r2u5 r3r3 r3r4 r3r5 r3u1 r3u2 r3u3 r3u4 r3u5 r4r4 r4r5 r4u1 r4u2 r4u3 r4u4 r4u5 r5r5 r5u1 r5u2 r5u3 r5u4 r5u5 u1u1 u1u2 u1u3 u1u4 u1u5 u2u2 u2u3 u2u4 u2u5 u3u3 u3u4 u3u5 u4u4 u4u5 u5u5                      
	  fitCost = [b1 b2 b3 b4 b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51  b52  b53  b54  b55  b56  b57  b58  b59  b60  b61  b62  b63  b64  b65  b66  b67  b68  b69  b70  b71  b72  b73  b74  b75  b76  b77  b78  b79  b80  b81  b82  b83  b84  b85  b86  b87  b88  b89  b90  b91  b92  b93  b94  b95  b96  b97  b98  b99  b100 b101 b102 b103 b104 b105 ...  % MALE
	             a1 a2 a3 a4 a5  a6  a7  a8  a9  a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35 a36 a37 a38 a39 a40 a41 a42 a43 a44 a45 a46 a47 a48 a49 a50 a51  a52  a53  a54  a55  a56  a57  a58  a59  a60  a61  a62  a63  a64  a65  a66  a67  a68  a69  a70  a71  a72  a73  a74  a75  a76  a77  a78  a79  a80  a81  a82  a83  a84  a85  a86  a87  a88  a89  a90  a91  a92  a93  a94  a95  a96  a97  a98  a99  a100 a101 a102 a103 a104 a105  ]'; % FEMALE      
            
     mortRateAdult = mortRateAdult./(1-fitCost);
     mortRateJuven = mortRateJuven./(1-fitCost);

     for i=1:210
         if (mortRateAdult(i) == Inf) || (mortRateAdult(i) > 1)
             mortRateAdult(i) = 1;
             mortRateJuven(i) = 1;
         end
     end
     
     clear b1 b2 b3 b4 b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51  b52  b53  b54  b55  b56  b57  b58  b59  b60  b61  b62  b63  b64  b65  b66  b67  b68  b69  b70  b71  b72  b73  b74  b75  b76  b77  b78  b79  b80  b81  b82  b83  b84  b85  b86  b87  b88  b89  b90  b91  b92  b93  b94  b95  b96  b97  b98  b99  b100 b101 b102 b103 b104 b105 ...
           a1 a2 a3 a4 a5  a6  a7  a8  a9  a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35 a36 a37 a38 a39 a40 a41 a42 a43 a44 a45 a46 a47 a48 a49 a50 a51  a52  a53  a54  a55  a56  a57  a58  a59  a60  a61  a62  a63  a64  a65  a66  a67  a68  a69  a70  a71  a72  a73  a74  a75  a76  a77  a78  a79  a80  a81  a82  a83  a84  a85  a86  a87  a88  a89  a90  a91  a92  a93  a94  a95  a96  a97  a98  a99  a100 a101 a102 a103 a104 a105 ...
           x y x2 y2 M gens;

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

             A = zeros(210,span);
             J = zeros(210,span);
             G = zeros(210,span);
             TotalPop = zeros(span,1);
             wildtypeSum = zeros(span,1);
             GP = zeros(105,span);

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

                JT = zeros(210,span);
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
                GP(:,T) = G(1:105,T)+G(106:210,T);

                wildtypeSum(T) = sum(GP(1:2,T))+sum(GP(5:15,T))+sum(GP(18:27,T))+sum(GP(51:105,T));
                W(i,j,T) = wildtypeSum(T)/TotalPop(T);
                P(i,j,T) = TotalPop(T);
                
                Wcount(i,j,T) = (2*GP(1,T) + sum(GP(2:14,T)))/(2*TotalPop(T));
                Vcount(i,j,T) = (GP(2,T) + 2*GP(15,T) + sum(GP(16:27,T)))/(2*TotalPop(T));
                Ucount(i,j,T) = (sum(GP(10:14,T)) + sum(GP(23:27,T)) + sum(GP(35:39,T)) + sum(GP(46:50,T)) + sum(GP(56:60,T)) + sum(GP(65:69,T)) + sum(GP(73:77,T)) + sum(GP(80:84,T)) + sum(GP(86:90,T)) + 2*sum(GP(91:105,T)))/(2*TotalPop(T));
                Rcount(i,j,T) = (sum(GP(5:9,T)) + sum(GP(18:22,T)) + sum(GP(30:34,T)) + sum(GP(41:45,T)) + 2*sum(GP(51:55,T)) + sum(GP(56:60,T)) + 2*sum(GP(61:64,T)) + sum(GP(65:69,T)) + 2*sum(GP(70:72,T)) + sum(GP(73:77,T)) + 2*sum(GP(78:79,T)) + sum(GP(80:84,T)) + 2*GP(85,T) + sum(GP(86:90,T)))/(2*TotalPop(T));
                Gcount(i,j,T) = (GP(3,T) + GP(16,T) + 2*GP(28,T) + sum(GP(29:39,T)))/(2*TotalPop(T));
                Scount(i,j,T) = (GP(4,T) + GP(17,T) + GP(29,T) + 2*GP(40,T) + sum(GP(41:50,T)))/(2*TotalPop(T));

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
                    x0(:) = g0(1:105)+g0(106:210);
                    Z(row,3)= (sum(x0(1:2))+sum(x0(5:15))+sum(x0(18:27))+sum(x0(51:105)))/(sum(x0(:)));  % inital conditions  
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
                 
                 x0(:) = g0(1:105)+g0(106:210); 
                 Z(row+1,4) = (2*x0(1) + sum(x0(2:14)))/(2*sum(x0(:)));
                 Z(row+2,4) = (x0(2) + 2*x0(15) + sum(x0(16:27)))/(2*sum(x0(:)));
                 Z(row+3,4) = (sum(x0(10:14)) + sum(x0(23:27)) + sum(x0(35:39)) + sum(x0(46:50)) + sum(x0(56:60)) + sum(x0(65:69)) + sum(x0(73:77)) + sum(x0(80:84)) + sum(x0(86:90)) + 2*sum(x0(91:105)))/(2*sum(x0(:)));
                 Z(row+4,4) = (sum(x0(5:9)) + sum(x0(18:22)) + sum(x0(30:34)) + sum(x0(41:45)) + 2*sum(x0(51:55)) + sum(x0(56:60)) + 2*sum(x0(61:64)) + sum(x0(65:69)) + 2*sum(x0(70:72)) + sum(x0(73:77)) + 2*sum(x0(78:79)) + sum(x0(80:84)) + 2*x0(85) + sum(x0(86:90)))/(2*sum(x0(:)));
                 Z(row+5,4) = (x0(3) + x0(16) + 2*x0(28) + sum(x0(29:39)))/(2*sum(x0(:)));
                 Z(row+6,4) = (x0(4) + x0(17) + x0(29) + 2*x0(40) + sum(x0(41:50)))/(2*sum(x0(:)));
                                 
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
    
    sum2 = sum(B(1:105));
         
    J2(106:210) = B(106:210);
    J2(1:105) = B(1:105)/sum2;

    bp1 = CRISPR5_1_Rates(J2,sigma,lambda,delta1,delta2,fitCost,q1,q2,P1,P2,alpha1,alpha2,beta1,beta2,gamma1,gamma2);

    gprime = bp1';         