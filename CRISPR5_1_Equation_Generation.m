clear
clc

%calculates the total number of combinations and stores in 'y'
n = 5; x = 2*n + 4; y = 0;
while x > 0
    y = y + x;
    x = x - 1;
end
x = 2*n + 4;

T0 = strings(y+3,y+3);              %stores the basics combinations and genotype references   
T1 = strings(y+3,y+3,y);            %stores for each genotype and iteration

% Populates the first gene string with a number
a = x; b = x; c = 0;                
while b >= 1
    while a >= 1
        T0(2,c+4) = a;
        T0(c+4,2) = a;
        a = a - 1;
        c = c + 1;
    end
    a = b - 1;
    b = b - 1;
end

% Populates the second gene string with a number
a = x; b = x; c = 0;                
while b >= 1
    while a >= 1
        T0(3,c+4) = b;
        T0(c+4,3) = b;
        a = a - 1;
        c = c + 1;
    end
    a = b - 1;
    b = b - 1;
end

%Changes numbers to correspond to letters
for i=1:y+3
    for j=1:y+3
        s1 = T0(i,j);

        if strcmp(s1, '14') == 1
            T0(i,j) = 'w';
        end
        if strcmp(s1, '13') == 1
            T0(i,j) = 'v';
        end
        if strcmp(s1, '12') == 1
            T0(i,j) = 'g';
        end
        if strcmp(s1, '11') == 1
            T0(i,j) = 's';
        end
        if strcmp(s1, '10') == 1
            T0(i,j) = 'r1';
        end
        if strcmp(s1, '9') == 1
            T0(i,j) = 'r2';
        end
        if strcmp(s1, '8') == 1
            T0(i,j) = 'r3';
        end
        if strcmp(s1, '7') == 1
            T0(i,j) = 'r4';
        end
        if strcmp(s1, '6') == 1
            T0(i,j) = 'r5';
        end
        if strcmp(s1, '5') == 1
            T0(i,j) = 'u1';
        end
        if strcmp(s1, '4') == 1
            T0(i,j) = 'u2';
        end
        if strcmp(s1, '3') == 1
            T0(i,j) = 'u3';
        end
        if strcmp(s1, '2') == 1
            T0(i,j) = 'u4';
        end
        if strcmp(s1, '1') == 1
            T0(i,j) = 'u5';
        end
    end
end

% Populates the J() equation form
for i=1:y
    T0(1,i+3) = strcat('J(', num2str(i,'%d'), ')');
    T0(i+3,1) = strcat('J(', num2str(i+y,'%d'), ')');
end

% START GENERATION OF PROBABLITIES & GENOTYPES
for k=1:y 
    tic
    for i=4:y+3
        for j=4:y+3
           
            % IDENTIFY WHICH GENOTYPE TO MAKE
            geneMake = '';                                  
            if k == 1
                geneMake = 'ww';
            elseif k == 2
                geneMake = 'wv';
            elseif k == 3
                geneMake = 'wg';
            elseif k == 4
                geneMake = 'ws';
            elseif k == 5
                geneMake = 'wr1';
            elseif k == 6
                geneMake = 'wr2';
            elseif k == 7
                geneMake = 'wr3';
            elseif k == 8
                geneMake = 'wr4';
            elseif k == 9
                geneMake = 'wr5';
            elseif k == 10
                geneMake = 'wu1';
            elseif k == 11
                geneMake = 'wu2';
            elseif k == 12
                geneMake = 'wu3';
            elseif k == 13
                geneMake = 'wu4';
            elseif k == 14
                geneMake = 'wu5';
            elseif k == 15
                geneMake = 'vv';
            elseif k == 16
                geneMake = 'vg';
            elseif k == 17
                geneMake = 'vs';
            elseif k == 18
                geneMake = 'vr1';
            elseif k == 19
                geneMake = 'vr2';
            elseif k == 20
                geneMake = 'vr3';
            elseif k == 21
                geneMake = 'vr4';
            elseif k == 22 
                geneMake = 'vr5';
            elseif k == 23
                geneMake = 'vu1';
            elseif k == 24
                geneMake = 'vu2';
            elseif k == 25
                geneMake = 'vu3';
            elseif k == 26
                geneMake = 'vu4';
            elseif k == 27
                geneMake = 'vu5';
            elseif k == 28
                geneMake = 'gg';
            elseif k == 29
                geneMake = 'gs';
            elseif k == 30
                geneMake = 'gr1';
            elseif k == 31
                geneMake = 'gr2';
            elseif k == 32
                geneMake = 'gr3';
            elseif k == 33
                geneMake = 'gr4';
            elseif k == 34
                geneMake = 'gr5';
            elseif k == 35
                geneMake = 'gu1';
            elseif k == 36
                geneMake = 'gu2';
            elseif k == 37
                geneMake = 'gu3';
            elseif k == 38
                geneMake = 'gu4';
            elseif k == 39
                geneMake = 'gu5';
            elseif k == 40
                geneMake = 'ss';
            elseif k == 41
                geneMake = 'sr1';
            elseif k == 42
                geneMake = 'sr2';
            elseif k == 43
                geneMake = 'sr3';
            elseif k == 44
                geneMake = 'sr4';
            elseif k == 45
                geneMake = 'sr5';
            elseif k == 46
                geneMake = 'su1';
            elseif k == 47
                geneMake = 'su2';
            elseif k == 48
                geneMake = 'su3';
            elseif k == 49
                geneMake = 'su4';
            elseif k == 50
                geneMake = 'su5';
            elseif k == 51
                geneMake = 'r1r1';
            elseif k == 52
                geneMake = 'r1r2';
            elseif k == 53
                geneMake = 'r1r3';
            elseif k == 54
                geneMake = 'r1r4';
            elseif k == 55
                geneMake = 'r1r5';
            elseif k == 56
                geneMake = 'u1r1';
            elseif k == 57
                geneMake = 'u2r1';
            elseif k == 58
                geneMake = 'u3r1';
            elseif k == 59
                geneMake = 'u4r1';
            elseif k == 60
                geneMake = 'u5r1';
            elseif k == 61
                geneMake = 'r2r2';
            elseif k == 62
                geneMake = 'r2r3';
            elseif k == 63
                geneMake = 'r2r4';
            elseif k == 64
                geneMake = 'r2r5';
            elseif k == 65
                geneMake = 'u1r2';
            elseif k == 66
                geneMake = 'u2r2';
            elseif k == 67
                geneMake = 'u3r2';
            elseif k == 68
                geneMake = 'u4r2';
            elseif k == 69
                geneMake = 'u5r2';
            elseif k == 70
                geneMake = 'r3r3';
            elseif k == 71
                geneMake = 'r3r4';
            elseif k == 72
                geneMake = 'r3r5';
            elseif k == 73
                geneMake = 'u1r3';
            elseif k == 74
                geneMake = 'u2r3';
            elseif k == 75
                geneMake = 'u3r3';
            elseif k == 76
                geneMake = 'u4r3';
            elseif k == 77
                geneMake = 'u5r3';
            elseif k == 78
                geneMake = 'r4r4';
            elseif k == 79
                geneMake = 'r4r5';
            elseif k == 80
                geneMake = 'u1r4';
            elseif k == 81
                geneMake = 'u2r4';
            elseif k == 82
                geneMake = 'u3r4';
            elseif k == 83
                geneMake = 'u4r4';
            elseif k == 84
                geneMake = 'u5r4';
            elseif k == 85
                geneMake = 'r5r5';
            elseif k == 86
                geneMake = 'u1r5';
            elseif k == 87
                geneMake = 'u2r5';
            elseif k == 88
                geneMake = 'u3r5';
            elseif k == 89
                geneMake = 'u4r5';
            elseif k == 90
                geneMake = 'u5r5';
            elseif k == 91
                geneMake = 'u1u1';
            elseif k == 92
                geneMake = 'u1u2';
            elseif k == 93
                geneMake = 'u1u3';
            elseif k == 94
                geneMake = 'u1u4';
            elseif k == 95
                geneMake = 'u1u5';
            elseif k == 96
                geneMake = 'u2u2';
            elseif k == 97
                geneMake = 'u2u3';
            elseif k == 98
                geneMake = 'u2u4';
            elseif k == 99
                geneMake = 'u2u5';
            elseif k == 100
                geneMake = 'u3u3';
            elseif k == 101
                geneMake = 'u3u4';
            elseif k == 102
                geneMake = 'u3u5';
            elseif k == 103
                geneMake = 'u4u4';
            elseif k == 104
                geneMake = 'u4u5';
            elseif k == 105
                geneMake = 'u5u5';
            end

            geneMALE = strcat(T0(2,i),T0(3,i));
            geneFEMALE = strcat(T0(j,2),T0(j,3));
            
            maleWcount = count(geneMALE, "w");
            maleVcount = count(geneMALE, "v");
            maleGcount = count(geneMALE, "g");
            maleScount = count(geneMALE, "s");
            maleU1count = count(geneMALE, "u1");
            maleU2count = count(geneMALE, "u2");
            maleU3count = count(geneMALE, "u3");
            maleU4count = count(geneMALE, "u4");
            maleU5count = count(geneMALE, "u5");
            maleR1count = count(geneMALE, "r1");
            maleR2count = count(geneMALE, "r2");
            maleR3count = count(geneMALE, "r3");
            maleR4count = count(geneMALE, "r4");
            maleR5count = count(geneMALE, "r5");
            
            femaleWcount = count(geneFEMALE, "w");
            femaleVcount = count(geneFEMALE, "v");
            femaleGcount = count(geneFEMALE, "g");
            femaleScount = count(geneFEMALE, "s");
            femaleU1count = count(geneFEMALE, "u1");
            femaleU2count = count(geneFEMALE, "u2");
            femaleU3count = count(geneFEMALE, "u3");
            femaleU4count = count(geneFEMALE, "u4");
            femaleU5count = count(geneFEMALE, "u5");
            femaleR1count = count(geneFEMALE, "r1");
            femaleR2count = count(geneFEMALE, "r2");
            femaleR3count = count(geneFEMALE, "r3");
            femaleR4count = count(geneFEMALE, "r4");
            femaleR5count = count(geneFEMALE, "r5");
            
    %MALE PARENT
            T2 = strings(10,2);
            if (maleGcount == 2)
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1)';
                T2(2,1) = 'g';
                T2(2,2) = '(beta1)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma1)';
            elseif (maleGcount == 1) && (maleScount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'g';
                T2(2,2) = '(beta1/2)';
                T2(3,1) = 's';
                T2(3,2) = '((gamma1+1)/2)';
            elseif (maleGcount == 1) && (maleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '(((beta1+gamma1)*((1-q1)^5)/2)+(alpha1/2))';
                T2(2,1) = 'v';
                T2(2,2) = '(alpha1/2)';
                T2(3,1) = 'g';
                T2(3,2) = '((1+P1*(1-(1-q1)^5))*(beta1/2))';
                T2(4,1) = 'u1';            
                T2(4,2) = '(((1-P1)*5*q1*((1-q1)^4)*delta1)*((beta1+gamma1)/2))';
                % does not make  u2, u3, u4, u5
                T2(5,1) = 'r1';
                T2(5,2) = '(((1-P1)*5*q1*((1-q1)^4)*(1-delta1))*((beta1+gamma1)/2))';
                T2(6,1) = 'r2';            
                T2(6,2) = '(((1-P1)*4*(q1^2)*((1-q1)^3))*((beta1+gamma1)/2))';
                T2(7,1) = 'r3';
                T2(7,2) = '(((1-P1)*(3*(q1^2)*((1-q1)^3) + 3*(q1^3)*((1-q1)^2)))*((beta1+gamma1)/2))';
                T2(8,1) = 'r4';
                T2(8,2) = '(((1-P1)*(2*q1^2*(1-q1)^3 + 4*q1^3*(1-q1)^2 + 2*q1^4*(1-q1)))*((beta1+gamma1)/2))';
                T2(9,1) = 'r5';
                T2(9,2) = '(((1-P1)*((q1^2)*((1-q1)^3) + 3*(q1^3)*((1-q1)^2) + 3*(q1^4)*(1-q1) + (q1^5)))*((beta1+gamma1)/2))';
                T2(10,1) = 's';
                T2(10,2) = '((1+P1*(1-(1-q1)^5))*(gamma1/2))';
            elseif (maleGcount == 1) && (maleU1count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'g';
                T2(2,2) = '((1+P1*(1-((1-q1)^4)))*(beta1/2))';
                %does not make w
                T2(3,1) = 'u1';
                T2(3,2) = '(((beta1+gamma1)/2)*((1-q1)^4)+(alpha1/2))';
                T2(4,1) = 'u2';
                T2(4,2) = '(((1-P1)*4*q1*((1-q1)^3)*delta1)*((beta1+gamma1)/2))';
                %does not make u3, u4, u5, r1
                T2(5,1) = 'r2';
                T2(5,2) = '(((1-P1)*4*q1*((1-q1)^3)*(1-delta1))*((beta1+gamma1)/2))';
                T2(6,1) = 'r3';
                T2(6,2) = '(((1-P1)*3*(q1^2)*((1-q1)^2))*((beta1+gamma1)/2))';
                T2(7,1) = 'r4';
                T2(7,2) = '(((1-P1)*(2*(q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1)))*((beta1+gamma1)/2))';
                T2(8,1) = 'r5';
                T2(8,2) = '(((1-P1)*((q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1) + (q1^4)))*((beta1+gamma1)/2))';
                T2(9,1) = 's';
                T2(9,2) = '((1+P1*(1-((1-q1)^4)))*(gamma1/2))';
            elseif (maleGcount == 1) && (maleU2count == 1)     
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'g';
                T2(2,2) = '((1+P1*(1-((1-q1)^3)))*(beta1/2))';
                %does not make w, u1
                T2(3,1) = 'u2';
                T2(3,2) = '(((beta1+gamma1)/2)*((1-q1)^3)+(alpha1/2))';
                T2(4,1) = 'u3';
                T2(4,2) = '((1-P1)*3*q1*((1-q1)^2)*delta1*((beta1+gamma1)/2))';
                %does not make u4, u5, r1, r2
                T2(5,1) = 'r3';
                T2(5,2) = '(((1-P1)*(3*q1*((1-q1)^2)*(1-delta1)))*((beta1+gamma1)/2))';
                T2(6,1) = 'r4';
                T2(6,2) = '(((1-P1)*(2*(q1^2)*(1-q1)))*((beta1+gamma1)/2))';
                T2(7,1) = 'r5'; 
                T2(7,2) = '(((1-P1)*((q1^2)*(1-q1) + (q1^3)))*((beta1+gamma1)/2))';
                T2(8,1) = 's';
                T2(8,2) = '((1+P1*(1-((1-q1)^3)))*(gamma1/2))';
            elseif (maleGcount == 1) && (maleU3count == 1)       
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'g';
                T2(2,2) = '(((1+P1*(1-((1-q1)^2)))*beta1)/2)';
                %does not make w, u1, u2
                T2(3,1) = 'u3';
                T2(3,2) = '((alpha1+(beta1+gamma1)*((1-q1)^2))/2)';
                T2(4,1) = 'u4';
                T2(4,2) = '((((1-P1)*2*q1*(1-q1)*delta1)*(beta1+gamma1))/2)';
                %does not make u5, r1, r2, r3
                T2(5,1) = 'r4';
                T2(5,2) = '(((1-P1)*(2*q1*(1-q1)*(1-delta1)))*((beta1+gamma1)/2))';
                T2(6,1) = 'r5';
                T2(6,2) = '((((1-P1)*(q1^2))*(beta1+gamma1))/2)';
                T2(7,1) = 's';
                T2(7,2) = '(((1+P1*(1-((1-q1)^2)))*gamma1)/2)';
            elseif (maleGcount == 1) && (maleU4count == 1)    
                 T2(1,1) = 'v';
                 T2(1,2) = '(alpha1/2)';
                 T2(2,1) = 'g';
                 T2(2,2) = '(((1+P1*(1-(1-q1)))*beta1)/2)';
                 %does not make w, u1, u2, u3
                 T2(3,1) = 'u4';
                 T2(3,2) = '((alpha1+(1-q1)*(beta1+gamma1))/2)';
                 T2(4,1) = 'u5';
                 T2(4,2) = '((((1-P1)*q1*delta1)*(beta1+gamma1))/2)';
                 %does not make r1, r2, r3, r4
                 T2(5,1) = 'r5';
                 T2(5,2) = '((((1-P1)*(q1*(1-delta1)))*(beta1+gamma1))/2)';
                 T2(6,1) = 's';
                 T2(6,2) = '(((1+P1*(1-(1-q1)))*gamma1)/2)';
            elseif (maleGcount == 1) && (maleU5count == 1)
                 T2(1,1) = 'v';
                 T2(1,2) = '(alpha1/2)';
                 T2(2,1) = 'g';
                 T2(2,2) = '(beta1/2)';
                 T2(3,1) = 's';
                 T2(3,2) = '(gamma1/2)';
                 T2(4,1) = 'u5';
                 T2(4,2) = '(1/2)';
            elseif (maleGcount == 1) && (maleR1count == 1)       
                 T2(1,1) = 'v';
                 T2(1,2) = '(alpha1/2)';
                 T2(2,1) = 'g';
                 T2(2,2) = '((1+P1*(1-((1-q1)^4)))*(beta1/2))';
                 %does not make w, u1, u2, u3, u4, u5
                 T2(3,1) = 'r1';
                 T2(3,2) = '((alpha1+((1-q1)^4)*(beta1+gamma1))/2)';
                 T2(4,1) = 'r2';
                 T2(4,2) = '(((1-P1)*4*q1*((1-q1)^3))*((beta1+gamma1)/2))';
                 T2(5,1) = 'r3';
                 T2(5,2) = '(((1-P1)*3*(q1^2)*((1-q1)^2))*((beta1+gamma1)/2))';
                 T2(6,1) = 'r4';
                 T2(6,2) = '(((1-P1)*(2*(q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1)))*((beta1+gamma1)/2))';
                 T2(7,1) = 'r5';
                 T2(7,2) = '(((1-P1)*((q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1) + (q1^4)))*((beta1+gamma1)/2))';
                 T2(8,1) = 's';
                 T2(8,2) = '((1+P1*(1-((1-q1)^4)))*(gamma1/2))';
            elseif (maleGcount == 1) && (maleR2count == 1) 
                 T2(1,1) = 'v';
                 T2(1,2) = '(alpha1/2)';
                 T2(2,1) = 'g';
                 T2(2,2) = '((1+P1*(1-((1-q1)^3)))*(beta1/2))';
                %does not make w, u1, u2, u3, u4, u5, r1
                 T2(3,1) = 'r2';
                 T2(3,2) = '((alpha1+((1-q1)^3)*(beta1+gamma1))/2)';
                 T2(4,1) = 'r3';
                 T2(4,2) = '(((1-P1)*3*q1*((1-q1)^2))*((beta1+gamma1)/2))';
                 T2(5,1) = 'r4';
                 T2(5,2) = '(((1-P1)*(2*(q1^2)*(1-q1)))*((beta1+gamma1)/2))';
                 T2(6,1) = 'r5';
                 T2(6,2) = '(((1-P1)*((q1^2)*(1-q1) + (q1^3)))*((beta1+gamma1)/2))';
                 T2(7,1) = 's';
                 T2(7,2) = '((1+P1*(1-((1-q1)^3)))*(gamma1/2))';
            elseif (maleGcount == 1) && (maleR3count == 1)
                 T2(1,1) = 'v';
                 T2(1,2) = '(alpha1/2)';
                 T2(2,1) = 'g'; 
                 T2(2,2) = '((1+P1*(1-((1-q1)^2)))*(beta1/2))';
                 %does not make w, u1, u2, u3, u4, u5, r1, r2
                 T2(3,1) = 'r3';
                 T2(3,2) = '((alpha1+((1-q1)^2)*(beta1+gamma1))/2)';
                 T2(4,1) = 'r4';
                 T2(4,2) = '(((1-P1)*2*q1*(1-q1))*((beta1+gamma1)/2))';
                 T2(5,1) = 'r5';
                 T2(5,2) = '(((1-P1)*(q1^2))*((beta1+gamma1)/2))'; 
                 T2(6,1) = 's';
                 T2(6,2) = '((1+P1*(1-((1-q1)^2)))*(gamma1/2))';
             elseif (maleGcount == 1) && (maleR4count == 1)
                 T2(1,1) = 'v';
                 T2(1,2) = '(alpha1/2)';
                 T2(2,1) = 'g';
                 T2(2,2) = '((1+P1*(1-(1-q1)))*(beta1/2))';
                 %does not make w, u1, u2, u3, u4, u5, r1, r2, r3
                 T2(3,1) = 'r4';
                 T2(3,2) = '((alpha1+((1-q1))*(beta1+gamma1))/2)';
                 T2(4,1) = 'r5';
                 T2(4,2) = '(((1-P1)*q1)*((beta1+gamma1)/2))';
                 T2(5,1) = 's';
                 T2(5,2) = '((1+P1*(1-(1-q1)))*(gamma1/2))';
            elseif (maleGcount == 1) && (maleR5count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'g';
                T2(2,2) = '(beta1/2)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma1/2)';
                T2(4,1) = 'r5';
                T2(4,2) = '(1/2)';   
            elseif (maleScount == 1) && (maleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '(((1-q1)^5)/2)';
                T2(2,1) = 'u1';            
                T2(2,2) = '(((1-P1)*5*q1*((1-q1)^4)*delta1)/2)';
                % does not make  u2, u3, u4, u5
                T2(3,1) = 'r1';
                T2(3,2) = '(((1-P1)*5*q1*((1-q1)^4)*(1-delta1))/2)';
                T2(4,1) = 'r2';            
                T2(4,2) = '(((1-P1)*4*(q1^2)*((1-q1)^3))/2)';
                T2(5,1) = 'r3';
                T2(5,2) = '(((1-P1)*(3*(q1^2)*((1-q1)^3) + 3*(q1^3)*((1-q1)^2)))/2)';
                T2(6,1) = 'r4';
                T2(6,2) = '(((1-P1)*(2*(q1^2)*((1-q1)^3) + 4*(q1^3)*((1-q1)^2) + 2*(q1^4)*(1-q1)))/2)';
                T2(7,1) = 'r5';
                T2(7,2) = '(((1-P1)*((q1^2)*((1-q1)^3) + 3*(q1^3)*(1-q1)^2 + 3*(q1^4)*(1-q1) + (q1^5)))/2)';
                T2(8,1) = 's';
                T2(8,2) = '((1+P1*(1-((1-q1)^5)))/2)';
            elseif (maleScount == 1) && (maleU1count == 1)
                T2(1,1) = 'u1';
                T2(1,2) = '((1/2)*((1-q1)^4))';
                T2(2,1) = 'u2';
                T2(2,2) = '(((1-P1)*4*q1*((1-q1)^3)*delta1)/2)';
                %does not make u3, u4, u5, r1
                T2(3,1) = 'r2';
                T2(3,2) = '(((1-P1)*4*q1*((1-q1)^3)*(1-delta1))/2)';
                T2(4,1) = 'r3';
                T2(4,2) = '(((1-P1)*3*(q1^2)*((1-q1)^2))/2)';
                T2(5,1) = 'r4';
                T2(5,2) = '(((1-P1)*(2*(q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1)))/2)';
                T2(6,1) = 'r5';
                T2(6,2) = '(((1-P1)*((q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1) + (q1^4)))/2)';
                T2(7,1) = 's';
                T2(7,2) = '((1+P1*(1-((1-q1)^4)))/2)';                
            elseif (maleScount == 1) && (maleU2count == 1)
                 T2(1,1) = 'u2';
                 T2(1,2) = '(((1-q1)^3)/2)';
                 T2(2,1) = 'u3';
                 T2(2,2) = '(((1-P1)*3*q1*((1-q1)^2)*delta1)/2)';
                 %does not make u4, u5, r1, r2
                 T2(3,1) = 'r3';
                 T2(3,2) = '(((1-P1)*(3*q1*((1-q1)^2)*(1-delta1)))/2)';
                 T2(4,1) = 'r4';
                 T2(4,2) = '(((1-P1)*(2*(q1^2)*(1-q1)))/2)';
                 T2(5,1) = 'r5'; 
                 T2(5,2) = '(((1-P1)*((q1^2)*(1-q1) + (q1^3)))/2)';
                 T2(6,1) = 's';
                 T2(6,2) = '((1+P1*(1-((1-q1)^3)))/2)';
            elseif (maleScount == 1) && (maleU3count == 1)
                T2(3,1) = 'u3';
                T2(3,2) = '((1/2)*((1-q1)^2))';
                T2(4,1) = 'u4';
                T2(4,2) = '(((1-P1)*2*q1*(1-q1)*delta1)/2)';
                %does not make u5, r1, r2, r3
                T2(5,1) = 'r4';
                T2(5,2) = '(((1-P1)*(2*q1*(1-q1)*(1-delta1)))/2)';
                T2(6,1) = 'r5';
                T2(6,2) = '(((1-P1)*(q1^2))/2)';
                T2(7,1) = 's';
                T2(7,2) = '((1+P1*(1-((1-q1)^2)))/2)';
            elseif (maleScount == 1) && (maleU4count == 1)
                T2(1,1) = 'u4';
                T2(1,2) = '((1-q1)/2)';
                T2(2,1) = 'u5';
                T2(2,2) = '(((1-P1)*q1*delta1)/2)';
                %does not make r1, r2, r3, r4
                T2(3,1) = 'r5';
                T2(3,2) = '(((1-P1)*(q1*(1-delta1)))/2)';
                T2(4,1) = 's';
                T2(4,2) = '((1+P1*(1-(1-q1)))/2)';
            elseif (maleScount == 1) && (maleR1count == 1)
                T2(1,1) = 'r1';
                T2(1,2) = '(((1-q1)^4)/2)';
                T2(2,1) = 'r2';
                T2(2,2) = '(((1-P1)*4*q1*((1-q1)^3))/2)';
                T2(3,1) = 'r3';
                T2(3,2) = '(((1-P1)*3*(q1^2)*((1-q1)^2))/2)';
                T2(4,1) = 'r4';
                T2(4,2) = '(((1-P1)*(2*(q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1)))/2)';
                T2(5,1) = 'r5';
                T2(5,2) = '(((1-P1)*((q1^2)*((1-q1)^2) + 2*(q1^3)*(1-q1) + (q1^4)))/2)';
                T2(6,1) = 's';
                T2(6,2) = '((1+P1*(1-((1-q1)^4)))/2)';
            elseif (maleScount == 1) && (maleR2count == 1)
                T2(1,1) = 'r2';
                T2(1,2) = '(((1-q1)^3)/2)';
                T2(2,1) = 'r3';
                T2(2,2) = '(((1-P1)*3*q1*((1-q1)^2))/2)';
                T2(3,1) = 'r4';
                T2(3,2) = '(((1-P1)*(2*(q1^2)*(1-q1)))/2)';
                T2(4,1) = 'r5';
                T2(4,2) = '(((1-P1)*((q1^2)*(1-q1) + q1^3))/2)';
                T2(5,1) = 's';
                T2(5,2) = '((1+P1*(1-((1-q1)^3)))/2)';
            elseif (maleScount == 1) && (maleR3count == 1)
                T2(1,1) = 'r3';
                T2(1,2) = '(((1-q1)^2)/2)';
                T2(2,1) = 'r4';
                T2(2,2) = '(((1-P1)*2*q1*(1-q1))/2)';
                T2(3,1) = 'r5';
                T2(3,2) = '(((1-P1)*(q1^2))/2)'; 
                T2(4,1) = 's';
                T2(4,2) = '((1+P1*(1-((1-q1)^2)))/2)';
            elseif (maleScount == 1) && (maleR4count == 1)
                T2(1,1) = 'r4';
                T2(1,2) = '(((1-q1))/2)';
                T2(2,1) = 'r5';
                T2(2,2) = '(((1-P1)*q1)/2)';
                T2(3,1) = 's';
                T2(3,2) = '((1+P1*(1-(1-q1)))/2)';
            else
                T2(1,1) = T0(2,i); % initial reference
                T2(1,2) = '(1/2)';
                T2(2,1) = T0(3,i); % initial reference
                T2(2,2) = '(1/2)';
            end
      
      %FEMALE PARENT
            T3 = strings(10,2);
            if (femaleGcount == 2)
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2)';
                T3(2,1) = 'g';
                T3(2,2) = '(beta2)';
                T3(3,1) = 's';
                T3(3,2) = '(gamma2)';
            elseif (femaleGcount == 1) && (femaleScount == 1)
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2/2)';
                T3(2,1) = 'g';
                T3(2,2) = '(beta2/2)';
                T3(3,1) = 's';
                T3(3,2) = '((gamma2+1)/2)';
            elseif (femaleGcount == 1) && (femaleWcount == 1)
                T3(1,1) = 'w';
                T3(1,2) = '(((beta2+gamma2)*((1-q2)^5)/2)+(alpha2/2))';
                T3(2,1) = 'v';
                T3(2,2) = '(alpha2/2)';
                T3(3,1) = 'g';
                T3(3,2) = '((1+P2*(1-(1-q2)^5))*(beta2/2))';
                T3(4,1) = 'u1';            
                T3(4,2) = '(((1-P2)*5*q2*((1-q2)^4)*delta2)*((beta2+gamma2)/2))';
                % does not make  u2, u3, u4, u5
                T3(5,1) = 'r1';
                T3(5,2) = '(((1-P2)*5*q2*((1-q2)^4)*(1-delta2))*((beta2+gamma2)/2))';
                T3(6,1) = 'r2';            
                T3(6,2) = '(((1-P2)*4*(q2^2)*((1-q2)^3))*((beta2+gamma2)/2))';
                T3(7,1) = 'r3';
                T3(7,2) = '(((1-P2)*(3*(q2^2)*((1-q2)^3) + 3*(q2^3)*((1-q2)^2)))*((beta2+gamma2)/2))';
                T3(8,1) = 'r4';
                T3(8,2) = '(((1-P2)*(2*q2^2*(1-q2)^3 + 4*q2^3*(1-q2)^2 + 2*q2^4*(1-q2)))*((beta2+gamma2)/2))';
                T3(9,1) = 'r5';
                T3(9,2) = '(((1-P2)*((q2^2)*((1-q2)^3) + 3*(q2^3)*((1-q2)^2) + 3*(q2^4)*(1-q2) + (q2^5)))*((beta2+gamma2)/2))';
                T3(10,1) = 's';
                T3(10,2) = '((1+P2*(1-(1-q2)^5))*(gamma2/2))';
            elseif (femaleGcount == 1) && (femaleU1count == 1)
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2/2)';
                T3(2,1) = 'g';
                T3(2,2) = '((1+P2*(1-((1-q2)^4)))*(beta2/2))';
                %does not make w
                T3(3,1) = 'u1';
                T3(3,2) = '(((beta2+gamma2)/2)*((1-q2)^4)+(alpha2/2))';
                T3(4,1) = 'u2';
                T3(4,2) = '(((1-P2)*4*q2*((1-q2)^3)*delta2)*((beta2+gamma2)/2))';
                %does not make u3, u4, u5, r1
                T3(5,1) = 'r2';
                T3(5,2) = '(((1-P2)*4*q2*((1-q2)^3)*(1-delta2))*((beta2+gamma2)/2))';
                T3(6,1) = 'r3';
                T3(6,2) = '(((1-P2)*3*(q2^2)*((1-q2)^2))*((beta2+gamma2)/2))';
                T3(7,1) = 'r4';
                T3(7,2) = '(((1-P2)*(2*(q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2)))*((beta2+gamma2)/2))';
                T3(8,1) = 'r5';
                T3(8,2) = '(((1-P2)*((q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2) + (q2^4)))*((beta2+gamma2)/2))';
                T3(9,1) = 's';
                T3(9,2) = '((1+P2*(1-((1-q2)^4)))*(gamma2/2))';
            elseif (femaleGcount == 1) && (femaleU2count == 1)     
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2/2)';
                T3(2,1) = 'g';
                T3(2,2) = '((1+P2*(1-((1-q2)^3)))*(beta2/2))';
                %does not make w, u1
                T3(3,1) = 'u2';
                T3(3,2) = '(((beta2+gamma2)/2)*((1-q2)^3)+(alpha2/2))';
                T3(4,1) = 'u3';
                T3(4,2) = '((1-P2)*3*q2*((1-q2)^2)*delta2*((beta2+gamma2)/2))';
                %does not make u4, u5, r1, r2
                T3(5,1) = 'r3';
                T3(5,2) = '(((1-P2)*(3*q2*((1-q2)^2)*(1-delta2)))*((beta2+gamma2)/2))';
                T3(6,1) = 'r4';
                T3(6,2) = '(((1-P2)*(2*(q2^2)*(1-q2)))*((beta2+gamma2)/2))';
                T3(7,1) = 'r5'; 
                T3(7,2) = '(((1-P2)*((q2^2)*(1-q2) + (q2^3)))*((beta2+gamma2)/2))';
                T3(8,1) = 's';
                T3(8,2) = '((1+P2*(1-((1-q2)^3)))*(gamma2/2))';
            elseif (femaleGcount == 1) && (femaleU3count == 1)       
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2/2)';
                T3(2,1) = 'g';
                T3(2,2) = '(((1+P2*(1-((1-q2)^2)))*beta2)/2)';
                %does not make w, u1, u2
                T3(3,1) = 'u3';
                T3(3,2) = '((alpha2+(beta2+gamma2)*((1-q2)^2))/2)';
                T3(4,1) = 'u4';
                T3(4,2) = '((((1-P2)*2*q2*(1-q2)*delta2)*(beta2+gamma2))/2)';
                %does not make u5, r1, r2, r3
                T3(5,1) = 'r4';
                T3(5,2) = '(((1-P2)*(2*q2*(1-q2)*(1-delta2)))*((beta2+gamma2)/2))';
                T3(6,1) = 'r5';
                T3(6,2) = '((((1-P2)*(q2^2))*(beta2+gamma2))/2)';
                T3(7,1) = 's';
                T3(7,2) = '(((1+P2*(1-((1-q2)^2)))*gamma2)/2)';
            elseif (femaleGcount == 1) && (femaleU4count == 1)    
                 T3(1,1) = 'v';
                 T3(1,2) = '(alpha2/2)';
                 T3(2,1) = 'g';
                 T3(2,2) = '(((1+P2*(1-(1-q2)))*beta2)/2)';
                 %does not make w, u1, u2, u3
                 T3(3,1) = 'u4';
                 T3(3,2) = '((alpha2+(1-q2)*(beta2+gamma2))/2)';
                 T3(4,1) = 'u5';
                 T3(4,2) = '((((1-P2)*q2*delta2)*(beta2+gamma2))/2)';
                 %does not make r1, r2, r3, r4
                 T3(5,1) = 'r5';
                 T3(5,2) = '((((1-P2)*(q2*(1-delta2)))*(beta2+gamma2))/2)';
                 T3(6,1) = 's';
                 T3(6,2) = '(((1+P2*(1-(1-q2)))*gamma2)/2)';
            elseif (femaleGcount == 1) && (femaleU5count == 1)
                 T3(1,1) = 'v';
                 T3(1,2) = '(alpha2/2)';
                 T3(2,1) = 'g';
                 T3(2,2) = '(beta2/2)';
                 T3(3,1) = 's';
                 T3(3,2) = '(gamma2/2)';
                 T3(4,1) = 'u5';
                 T3(4,2) = '(1/2)';
            elseif (femaleGcount == 1) && (femaleR1count == 1)       
                 T3(1,1) = 'v';
                 T3(1,2) = '(alpha2/2)';
                 T3(2,1) = 'g';
                 T3(2,2) = '((1+P2*(1-((1-q2)^4)))*(beta2/2))';
                 %does not make w, u1, u2, u3, u4, u5
                 T3(3,1) = 'r1';
                 T3(3,2) = '((alpha2+((1-q2)^4)*(beta2+gamma2))/2)';
                 T3(4,1) = 'r2';
                 T3(4,2) = '(((1-P2)*4*q2*((1-q2)^3))*((beta2+gamma2)/2))';
                 T3(5,1) = 'r3';
                 T3(5,2) = '(((1-P2)*3*(q2^2)*((1-q2)^2))*((beta2+gamma2)/2))';
                 T3(6,1) = 'r4';
                 T3(6,2) = '(((1-P2)*(2*(q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2)))*((beta2+gamma2)/2))';
                 T3(7,1) = 'r5';
                 T3(7,2) = '(((1-P2)*((q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2) + (q2^4)))*((beta2+gamma2)/2))';
                 T3(8,1) = 's';
                 T3(8,2) = '((1+P2*(1-((1-q2)^4)))*(gamma2/2))';
            elseif (femaleGcount == 1) && (femaleR2count == 1) 
                 T3(1,1) = 'v';
                 T3(1,2) = '(alpha2/2)';
                 T3(2,1) = 'g';
                 T3(2,2) = '((1+P2*(1-((1-q2)^3)))*(beta2/2))';
                %does not make w, u1, u2, u3, u4, u5, r1
                 T3(3,1) = 'r2';
                 T3(3,2) = '((alpha2+((1-q2)^3)*(beta2+gamma2))/2)';
                 T3(4,1) = 'r3';
                 T3(4,2) = '(((1-P2)*3*q2*((1-q2)^2))*((beta2+gamma2)/2))';
                 T3(5,1) = 'r4';
                 T3(5,2) = '(((1-P2)*(2*(q2^2)*(1-q2)))*((beta2+gamma2)/2))';
                 T3(6,1) = 'r5';
                 T3(6,2) = '(((1-P2)*((q2^2)*(1-q2) + (q2^3)))*((beta2+gamma2)/2))';
                 T3(7,1) = 's';
                 T3(7,2) = '((1+P2*(1-((1-q2)^3)))*(gamma2/2))';
            elseif (femaleGcount == 1) && (femaleR3count == 1)
                 T3(1,1) = 'v';
                 T3(1,2) = '(alpha2/2)';
                 T3(2,1) = 'g'; 
                 T3(2,2) = '((1+P2*(1-((1-q2)^2)))*(beta2/2))';
                 %does not make w, u1, u2, u3, u4, u5, r1, r2
                 T3(3,1) = 'r3';
                 T3(3,2) = '((alpha2+((1-q2)^2)*(beta2+gamma2))/2)';
                 T3(4,1) = 'r4';
                 T3(4,2) = '(((1-P2)*2*q2*(1-q2))*((beta2+gamma2)/2))';
                 T3(5,1) = 'r5';
                 T3(5,2) = '(((1-P2)*(q2^2))*((beta2+gamma2)/2))'; 
                 T3(6,1) = 's';
                 T3(6,2) = '((1+P2*(1-((1-q2)^2)))*(gamma2/2))';
             elseif (femaleGcount == 1) && (femaleR4count == 1)
                 T3(1,1) = 'v';
                 T3(1,2) = '(alpha2/2)';
                 T3(2,1) = 'g';
                 T3(2,2) = '((1+P2*(1-(1-q2)))*(beta2/2))';
                 %does not make w, u1, u2, u3, u4, u5, r1, r2, r3
                 T3(3,1) = 'r4';
                 T3(3,2) = '((alpha2+((1-q2))*(beta2+gamma2))/2)';
                 T3(4,1) = 'r5';
                 T3(4,2) = '(((1-P2)*q2)*((beta2+gamma2)/2))';
                 T3(5,1) = 's';
                 T3(5,2) = '((1+P2*(1-(1-q2)))*(gamma2/2))';
            elseif (femaleGcount == 1) && (femaleR5count == 1)
                 T3(1,1) = 'v';
                 T3(1,2) = '(alpha2/2)';
                 T3(2,1) = 'g';
                 T3(2,2) = '(beta2/2)';
                 T3(3,1) = 's';
                 T3(3,2) = '(gamma2/2)';
                 T3(4,1) = 'r5';
                 T3(4,2) = '(1/2)';   
            elseif (femaleScount == 1) && (femaleWcount == 1)
                 T3(1,1) = 'w';
                 T3(1,2) = '(((1-q2)^5)/2)';
                 T3(2,1) = 'u1';            
                 T3(2,2) = '(((1-P2)*5*q2*((1-q2)^4)*delta2)/2)';
                 % does not make  u2, u3, u4, u5
                 T3(3,1) = 'r1';
                 T3(3,2) = '(((1-P2)*5*q2*((1-q2)^4)*(1-delta2))/2)';
                 T3(4,1) = 'r2';            
                 T3(4,2) = '(((1-P2)*4*(q2^2)*((1-q2)^3))/2)';
                 T3(5,1) = 'r3';
                 T3(5,2) = '(((1-P2)*(3*(q2^2)*((1-q2)^3) + 3*(q2^3)*((1-q2)^2)))/2)';
                 T3(6,1) = 'r4';
                 T3(6,2) = '(((1-P2)*(2*(q2^2)*((1-q2)^3) + 4*(q2^3)*((1-q2)^2) + 2*(q2^4)*(1-q2)))/2)';
                 T3(7,1) = 'r5';
                 T3(7,2) = '(((1-P2)*((q2^2)*((1-q2)^3) + 3*(q2^3)*(1-q2)^2 + 3*(q2^4)*(1-q2) + (q2^5)))/2)';
                 T3(8,1) = 's';
                 T3(8,2) = '((1+P2*(1-((1-q2)^5)))/2)';
            elseif (femaleScount == 1) && (femaleU1count == 1)
                 T3(1,1) = 'u1';
                 T3(1,2) = '((1/2)*((1-q2)^4))';
                 T3(2,1) = 'u2';
                 T3(2,2) = '(((1-P2)*4*q2*((1-q2)^3)*delta2)/2)';
                 %does not make u3, u4, u5, r1
                 T3(3,1) = 'r2';
                 T3(3,2) = '(((1-P2)*4*q2*((1-q2)^3)*(1-delta2))/2)';
                 T3(4,1) = 'r3';
                 T3(4,2) = '(((1-P2)*3*(q2^2)*((1-q2)^2))/2)';
                 T3(5,1) = 'r4';
                 T3(5,2) = '(((1-P2)*(2*(q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2)))/2)';
                 T3(6,1) = 'r5';
                 T3(6,2) = '(((1-P2)*((q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2) + (q2^4)))/2)';
                 T3(7,1) = 's';
                 T3(7,2) = '((1+P2*(1-((1-q2)^4)))/2)';                
            elseif (femaleScount == 1) && (femaleU2count == 1)
                 T3(1,1) = 'u2';
                 T3(1,2) = '(((1-q2)^3)/2)';
                 T3(2,1) = 'u3';
                 T3(2,2) = '(((1-P2)*3*q2*((1-q2)^2)*delta2)/2)';
                 %does not make u4, u5, r1, r2
                 T3(3,1) = 'r3';
                 T3(3,2) = '(((1-P2)*(3*q2*((1-q2)^2)*(1-delta2)))/2)';
                 T3(4,1) = 'r4';
                 T3(4,2) = '(((1-P2)*(2*(q2^2)*(1-q2)))/2)';
                 T3(5,1) = 'r5'; 
                 T3(5,2) = '(((1-P2)*((q2^2)*(1-q2) + (q2^3)))/2)';
                 T3(6,1) = 's';
                 T3(6,2) = '((1+P2*(1-((1-q2)^3)))/2)';
            elseif (femaleScount == 1) && (femaleU3count == 1)
                 T3(1,1) = 'u3';
                 T3(1,2) = '((1/2)*((1-q2)^2))';
                 T3(2,1) = 'u4';
                 T3(2,2) = '(((1-P2)*2*q2*(1-q2)*delta2)/2)';
                 %does not make u5, r1, r2, r3
                 T3(3,1) = 'r4';
                 T3(3,2) = '(((1-P2)*(2*q2*(1-q2)*(1-delta2)))/2)';
                 T3(4,1) = 'r5';
                 T3(4,2) = '(((1-P2)*(q2^2))/2)';
                 T3(5,1) = 's';
                 T3(5,2) = '((1+P2*(1-((1-q2)^2)))/2)';
            elseif (femaleScount == 1) && (femaleU4count == 1)
                 T3(1,1) = 'u4';
                 T3(1,2) = '((1-q2)/2)';
                 T3(2,1) = 'u5';
                 T3(2,2) = '(((1-P2)*q2*delta2)/2)';
                 %does not make r1, r2, r3, r4
                 T3(3,1) = 'r5';
                 T3(3,2) = '(((1-P2)*(q2*(1-delta2)))/2)';
                 T3(4,1) = 's';
                 T3(4,2) = '((1+P2*(1-(1-q2)))/2)';
            elseif (femaleScount == 1) && (femaleR1count == 1)
                 T3(1,1) = 'r1';
                 T3(1,2) = '(((1-q2)^4)/2)';
                 T3(2,1) = 'r2';
                 T3(2,2) = '(((1-P2)*4*q2*((1-q2)^3))/2)';
                 T3(3,1) = 'r3';
                 T3(3,2) = '(((1-P2)*3*(q2^2)*((1-q2)^2))/2)';
                 T3(4,1) = 'r4';
                 T3(4,2) = '(((1-P2)*(2*(q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2)))/2)';
                 T3(5,1) = 'r5';
                 T3(5,2) = '(((1-P2)*((q2^2)*((1-q2)^2) + 2*(q2^3)*(1-q2) + (q2^4)))/2)';
                 T3(6,1) = 's';
                 T3(6,2) = '((1+P2*(1-((1-q2)^4)))/2)';
            elseif (femaleScount == 1) && (femaleR2count == 1)
                 T3(1,1) = 'r2';
                 T3(1,2) = '(((1-q2)^3)/2)';
                 T3(2,1) = 'r3';
                 T3(2,2) = '(((1-P2)*3*q2*((1-q2)^2))/2)';
                 T3(3,1) = 'r4';
                 T3(3,2) = '(((1-P2)*(2*(q2^2)*(1-q2)))/2)';
                 T3(4,1) = 'r5';
                 T3(4,2) = '(((1-P2)*((q2^2)*(1-q2) + q2^3))/2)';
                 T3(5,1) = 's';
                 T3(5,2) = '((1+P2*(1-((1-q2)^3)))/2)';
            elseif (femaleScount == 1) && (femaleR3count == 1)
                 T3(1,1) = 'r3';
                 T3(1,2) = '(((1-q2)^2)/2)';
                 T3(2,1) = 'r4';
                 T3(2,2) = '(((1-P2)*2*q2*(1-q2))/2)';
                 T3(3,1) = 'r5';
                 T3(3,2) = '(((1-P2)*(q2^2))/2)'; 
                 T3(4,1) = 's';
                 T3(4,2) = '((1+P2*(1-((1-q2)^2)))/2)';
            elseif (femaleScount == 1) && (femaleR4count == 1)
                 T3(1,1) = 'r4';
                 T3(1,2) = '(((1-q2))/2)';
                 T3(2,1) = 'r5';
                 T3(2,2) = '(((1-P2)*q2)/2)';
                 T3(3,1) = 's';
                 T3(3,2) = '((1+P2*(1-(1-q2)))/2)';
            else
                 T3(1,1) = T0(j,2); % initial reference
                 T3(1,2) = '(1/2)';
                 T3(2,1) = T0(j,3); % initial reference
                 T3(2,2) = '(1/2)';
            end          
                 
            %Combine probabilities
            T4 = strings(10,10,2);
            for a = 1:10
                for b = 1:10
                    if (T2(a,1) ~= "") && (T3(b,1) ~= "")
                        T4(a,b,1) = strcat(T2(a,1),T3(b,1));
                        T4(a,b,2) = strcat(T2(a,2),'*',T3(b,2));
                     
                        w = count(T4(a,b,1),"w");
                        v = count(T4(a,b,1),"v");
                        g = count(T4(a,b,1),"g");
                        s = count(T4(a,b,1),"s");
                        u1 = count(T4(a,b,1),"u1");
                        u2 = count(T4(a,b,1),"u2");
                        u3 = count(T4(a,b,1),"u3");
                        u4 = count(T4(a,b,1),"u4");
                        u5 = count(T4(a,b,1),"u5");
                        r1 = count(T4(a,b,1),"r1");
                        r2 = count(T4(a,b,1),"r2");
                        r3 = count(T4(a,b,1),"r3");
                        r4 = count(T4(a,b,1),"r4");
                        r5 = count(T4(a,b,1),"r5");
                        
                        if (w == 2)             
                            T4(a,b,1) = 'ww';
                        elseif (w == 1) && (v == 1)
                            T4(a,b,1) = 'wv';
                        elseif (w == 1) && (g == 1)
                            T4(a,b,1) = 'wg';
                        elseif (w == 1) && (s == 1)
                            T4(a,b,1) = 'ws';
                        elseif (w == 1) && (u1 == 1)
                            T4(a,b,1) = 'wu1';
                        elseif (w == 1) && (u2 == 1)
                            T4(a,b,1) = 'wu2';
                        elseif (w == 1) && (u3 == 1)
                            T4(a,b,1) = 'wu3';
                        elseif (w == 1) && (u4 == 1)
                            T4(a,b,1) = 'wu4';
                        elseif (w == 1) && (u5 == 1)
                            T4(a,b,1) = 'wu5';
                        elseif (w == 1) && (r1 == 1)
                            T4(a,b,1) = 'wr1';
                        elseif (w == 1) && (r2 == 1)
                            T4(a,b,1) = 'wr2';
                        elseif (w == 1) && (r3 == 1)
                            T4(a,b,1) = 'wr3';
                        elseif (w == 1) && (r4 == 1)
                            T4(a,b,1) = 'wr4';
                        elseif (w == 1) && (r5 == 1)
                            T4(a,b,1) = 'wr5';
                        elseif (v == 2)
                            T4(a,b,1) = 'vv';
                        elseif (v == 1) && (g == 1)
                            T4(a,b,1) = 'vg';
                        elseif (v == 1) && (s == 1)
                            T4(a,b,1) = 'vs';
                        elseif (v == 1) && (u1 == 1)
                            T4(a,b,1) = 'vu1';    
                        elseif (v == 1) && (u2 == 1)
                            T4(a,b,1) = 'vu2';
                        elseif (v == 1) && (u3 == 1)
                            T4(a,b,1) = 'vu3';
                        elseif (v == 1) && (u4 == 1)
                            T4(a,b,1) = 'vu4';
                        elseif (v == 1) && (u5 == 1)
                            T4(a,b,1) = 'vu5';
                        elseif (v == 1) && (r1 == 1)
                            T4(a,b,1) = 'vr1';
                        elseif (v == 1) && (r2 == 1)
                            T4(a,b,1) = 'vr2';    
                        elseif (v == 1) && (r3 == 1)
                            T4(a,b,1) = 'vr3';
                        elseif (v == 1) && (r4 == 1)
                            T4(a,b,1) = 'vr4';
                        elseif (v == 1) && (r5 == 1)
                            T4(a,b,1) = 'vr5';
                        elseif (g == 2)
                            T4(a,b,1) = 'gg';
                        elseif (g == 1) && (s == 1)
                            T4(a,b,1) = 'gs';
                        elseif (g == 1) && (u1 == 1)
                            T4(a,b,1) = 'gu1';    
                        elseif (g == 1) && (u2 == 1)
                            T4(a,b,1) = 'gu2';
                        elseif (g == 1) && (u3 == 1)
                            T4(a,b,1) = 'gu3';
                        elseif (g == 1) && (u4 == 1)
                            T4(a,b,1) = 'gu4';
                        elseif (g == 1) && (u5 == 1)
                            T4(a,b,1) = 'gu5';
                        elseif (g == 1) && (r1 == 1)
                            T4(a,b,1) = 'gr1';
                        elseif (g == 1) && (r2 == 1)
                            T4(a,b,1) = 'gr2';    
                        elseif (g == 1) && (r3 == 1)
                            T4(a,b,1) = 'gr3';
                        elseif (g == 1) && (r4 == 1)
                            T4(a,b,1) = 'gr4';
                        elseif (g == 1) && (r5 == 1)
                            T4(a,b,1) = 'gr5';
                        elseif (s == 2) 
                            T4(a,b,1) = 'ss';
                        elseif (s == 1) && (u1 == 1)
                            T4(a,b,1) = 'su1';    
                        elseif (s == 1) && (u2 == 1)
                            T4(a,b,1) = 'su2';
                        elseif (s == 1) && (u3 == 1)
                            T4(a,b,1) = 'su3';
                        elseif (s == 1) && (u4 == 1)
                            T4(a,b,1) = 'su4';
                        elseif (s == 1) && (u5 == 1)
                            T4(a,b,1) = 'su5';
                        elseif (s == 1) && (r1 == 1)
                            T4(a,b,1) = 'sr1';
                        elseif (s == 1) && (r2 == 1)
                            T4(a,b,1) = 'sr2';    
                        elseif (s == 1) && (r3 == 1)
                            T4(a,b,1) = 'sr3';
                        elseif (s == 1) && (r4 == 1)
                            T4(a,b,1) = 'sr4';
                        elseif (s == 1) && (r5 == 1)
                            T4(a,b,1) = 'sr5';    
                        elseif (u1 == 2)
                            T4(a,b,1) = 'u1u1';
                        elseif (u1 == 1) && (u2 == 1)
                            T4(a,b,1) = 'u1u2';
                        elseif (u1 == 1) && (u3 == 1)
                            T4(a,b,1) = 'u1u3';
                        elseif (u1 == 1) && (u4 == 1)
                            T4(a,b,1) = 'u1u4';
                        elseif (u1 == 1) && (u5 == 1)
                            T4(a,b,1) = 'u1u5';
                        elseif (u1 == 1) && (r1 == 1)
                            T4(a,b,1) = 'u1r1';
                        elseif (u1 == 1) && (r2 == 1)
                            T4(a,b,1) = 'u1r2';    
                        elseif (u1 == 1) && (r3 == 1)
                            T4(a,b,1) = 'u1r3';
                        elseif (u1 == 1) && (r4 == 1)
                            T4(a,b,1) = 'u1r4';
                        elseif (u1 == 1) && (r5 == 1)
                            T4(a,b,1) = 'u1r5';
                        elseif (u2 == 2)
                            T4(a,b,1) = 'u2u2';
                        elseif (u2 == 1) && (u3 == 1)
                            T4(a,b,1) = 'u2u3';
                        elseif (u2 == 1) && (u4 == 1)
                            T4(a,b,1) = 'u2u4';
                        elseif (u2 == 1) && (u5 == 1)
                            T4(a,b,1) = 'u2u5';
                        elseif (u2 == 1) && (r1 == 1)
                            T4(a,b,1) = 'u2r1';
                        elseif (u2 == 1) && (r2 == 1)
                            T4(a,b,1) = 'u2r2';    
                        elseif (u2 == 1) && (r3 == 1)
                            T4(a,b,1) = 'u2r3';
                        elseif (u2 == 1) && (r4 == 1)
                            T4(a,b,1) = 'u2r4';
                        elseif (u2 == 1) && (r5 == 1)
                            T4(a,b,1) = 'u2r5';
                        elseif (u3 == 2)
                            T4(a,b,1) = 'u3u3';    
                        elseif (u3 == 1) && (u4 == 1)
                            T4(a,b,1) = 'u3u4';
                        elseif (u3 == 1) && (u5 == 1)
                            T4(a,b,1) = 'u3u5';
                        elseif (u3 == 1) && (r1 == 1)
                            T4(a,b,1) = 'u3r1';
                        elseif (u3 == 1) && (r2 == 1)
                            T4(a,b,1) = 'u3r2';    
                        elseif (u3 == 1) && (r3 == 1)
                            T4(a,b,1) = 'u3r3';
                        elseif (u3 == 1) && (r4 == 1)
                            T4(a,b,1) = 'u3r4';
                        elseif (u3 == 1) && (r5 == 1)
                            T4(a,b,1) = 'u3r5';
                        elseif (u4 == 2)
                            T4(a,b,1) = 'u4u4';    
                        elseif (u4 == 1) && (u5 == 1)
                            T4(a,b,1) = 'u4u5';
                        elseif (u4 == 1) && (r1 == 1)
                            T4(a,b,1) = 'u4r1';
                        elseif (u4 == 1) && (r2 == 1)
                            T4(a,b,1) = 'u4r2';    
                        elseif (u4 == 1) && (r3 == 1)
                            T4(a,b,1) = 'u4r3';
                        elseif (u4 == 1) && (r4 == 1)
                            T4(a,b,1) = 'u4r4';
                        elseif (u4 == 1) && (r5 == 1)
                            T4(a,b,1) = 'u4r5';
                        elseif (u5 == 2)
                            T4(a,b,1) = 'u5u5';    
                        elseif (u5 == 1) && (r1 == 1)
                            T4(a,b,1) = 'u5r1';
                        elseif (u5 == 1) && (r2 == 1)
                            T4(a,b,1) = 'u5r2';    
                        elseif (u5 == 1) && (r3 == 1)
                            T4(a,b,1) = 'u5r3';
                        elseif (u5 == 1) && (r4 == 1)
                            T4(a,b,1) = 'u5r4';
                        elseif (u5 == 1) && (r5 == 1)
                            T4(a,b,1) = 'u5r5';    
                        elseif (r1 == 2)
                            T4(a,b,1) = 'r1r1'; 
                        elseif (r1 == 1) && (r2 == 1)
                            T4(a,b,1) = 'r1r2';    
                        elseif (r1 == 1) && (r3 == 1)
                            T4(a,b,1) = 'r1r3';
                        elseif (r1 == 1) && (r4 == 1)
                            T4(a,b,1) = 'r1r4';
                        elseif (r1 == 1) && (r5 == 1)
                            T4(a,b,1) = 'r1r5';
                        elseif (r2 == 2)
                            T4(a,b,1) = 'r2r2';    
                        elseif (r2 == 1) && (r3 == 1)
                            T4(a,b,1) = 'r2r3';
                        elseif (r2 == 1) && (r4 == 1)
                            T4(a,b,1) = 'r2r4';
                        elseif (r2 == 1) && (r5 == 1)
                            T4(a,b,1) = 'r2r5';
                        elseif (r3 == 2)
                            T4(a,b,1) = 'r3r3';
                        elseif (r3 == 1) && (r4 == 1)
                            T4(a,b,1) = 'r3r4';
                        elseif (r3 == 1) && (r5 == 1)
                            T4(a,b,1) = 'r3r5';
                        elseif (r4 == 2)
                            T4(a,b,1) = 'r4r4';
                        elseif (r4 == 1) && (r5 == 1)
                            T4(a,b,1) = 'r4r5';
                        elseif (r5 == 2)
                            T4(a,b,1) = 'r5r5';
                        else
                            ERROR = 1;
                        end
                        
                        % COMPILES PROBABILITIES            
                        if strcmp(geneMake, T4(a,b,1)) == 1
                            if T1(i,j,k) == ""
                                T1(i,j,k) = T4(a,b,2);
                            else
                                storeSTR = T1(i,j,k);
                                T1(i,j,k) = strcat(storeSTR, '+', T4(a,b,2));
                            end
                        end
                    end
                end
            end
        end
    end      
    mytime= toc;
    fprintf('parfor iteration %d , executed by worker %d finished in %f seconds\n',k,labindex,mytime);  
end

% SIMPLIFIES THE PROBABILITIES
syms alpha1 beta1 gamma1 delta1 P1 q1 alpha2 beta2 gamma2 delta2 P2 q2
for k = 1:y 
    for i=4:y+3
        for j=4:y+3
            oldVal = T1(i,j,k);  
            if oldVal ~= ''
                new1 = str2sym(oldVal);
                new2 = char(new1);
                T1(i,j,k) = strcat('(', new2, ')');
            end
        end
    end
end

%GENERATE THE EQUATION
gprime = strings(y);
for k = 1:y
    for i=4:y+3
        for j=4:y+3                                                           
            if T1(i,j,k) ~= ''
                if gprime(k) == ''
                    gprime(k) = strcat(T0(1,j), '*', T1(i,j,k), '*', T0(i,1));
                else
                    gStore = gprime(k);
                    gprime(k) = strcat(gStore, '+', T0(1,j), '*', T1(i,j,k), '*', T0(i,1));
                end
            end
        end
    end
end

% Clears previous text file if available
if exist('CRISPR5-1 Generated Equations.txt', 'file')==2      
  delete('CRISPR5-1 Generated Equations.txt');
end

% Outputs the equations in the form to be used in the models
diary('CRISPR5-1 Generated Equations.txt');
for i=1:2
    for k=1:105
        if i == 1
            disp(strcat('gprime(', num2str(k,'%d'), ') = (1-fitCost(', num2str(k,'%d'), '))*(1-sigma)*lambda*(', gprime(k), ');'))
        else
            disp(strcat('gprime(', num2str(k+105,'%d'), ') = (1-fitCost(', num2str(k+105,'%d'), '))*(sigma)*lambda*(', gprime(k), ');'))
        end
    end
end
diary off