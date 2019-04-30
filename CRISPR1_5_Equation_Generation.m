clear
clc

T0 = strings(58,58);              %stores the basics combinations and genotype references   
Table1 = strings(58,58,55);            %stores for each genotype and iteration

% Populates the first gene string with a number
a = 10; b = 10; c = 0;
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
a = 10; b = 10; c = 0;
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

% Changes numbers to correspond to letters
for i=1:58
    for j=1:58
        s1 = T0(i,j);

        if strcmp(s1, '10') == 1
            T0(i,j) = 'w';
        end
        if strcmp(s1, '9') == 1
            T0(i,j) = 'v';
        end
        if strcmp(s1, '8') == 1
            T0(i,j) = 'u';
        end
        if strcmp(s1, '7') == 1
            T0(i,j) = 'r';
        end
        if strcmp(s1, '6') == 1
            T0(i,j) = 'g1';
        end
        if strcmp(s1, '5') == 1
            T0(i,j) = 'g2';
        end
        if strcmp(s1, '4') == 1
            T0(i,j) = 'g3';
        end
        if strcmp(s1, '3') == 1
            T0(i,j) = 'g4';
        end
        if strcmp(s1, '2') == 1
            T0(i,j) = 'g5';
        end
        if strcmp(s1, '1') == 1
            T0(i,j) = 's';
        end
    end
end

% Populates the J() equation form
for i=1:55
    T0(1,i+3) = strcat('J(', num2str(i,'%d'), ')');
    T0(i+3,1) = strcat('J(', num2str(i+55,'%d'), ')');
end

% START GENERATION OF PROBABLITIES & GENOTYPES
for k=1:55
    tic
    for i=4:58
        for j=4:58
        
            % IDENTIFY WHICH GENOTYPE TO MAKE
            geneMake = '';              
            if k == 1
                geneMake = 'ww';
            elseif k == 2
                geneMake = 'wv';
            elseif k == 3
                geneMake = 'wu';
            elseif k == 4
                geneMake = 'wr';
            elseif k == 5
                geneMake = 'wg1';
            elseif k == 6
                geneMake = 'wg2';
            elseif k == 7
                geneMake = 'wg3';
            elseif k == 8
                geneMake = 'wg4';
            elseif k == 9
                geneMake = 'wg5';
            elseif k == 10
                geneMake = 'ws';
            elseif k == 11
                geneMake = 'vv';
            elseif k == 12
                geneMake = 'vu';
            elseif k == 13
                geneMake = 'vr';
            elseif k == 14
                geneMake = 'vg1';
            elseif k == 15
                geneMake = 'vg2';
            elseif k == 16
                geneMake = 'vg3';
            elseif k == 17
                geneMake = 'vg4';
            elseif k == 18
                geneMake = 'vg5';
            elseif k == 19
                geneMake = 'vs';
            elseif k == 20
                geneMake = 'uu';
            elseif k == 21
                geneMake = 'ur';
            elseif k == 22
                geneMake = 'ug1';
            elseif k == 23
                geneMake = 'ug2';
            elseif k == 24
                geneMake = 'ug3';
            elseif k == 25
                geneMake = 'ug4';
            elseif k == 26
                geneMake = 'ug5';
            elseif k == 27
                geneMake = 'us';
            elseif k == 28
                geneMake = 'rr';
            elseif k == 29
                geneMake = 'rg1';
            elseif k == 30
                geneMake = 'rg2';
            elseif k == 31
                geneMake = 'rg3';
            elseif k == 32
                geneMake = 'rg4';
            elseif k == 33
                geneMake = 'rg5';
            elseif k == 34
                geneMake = 'rs';
            elseif k == 35
                geneMake = 'g1g1';
            elseif k == 36
                geneMake = 'g1g2';
            elseif k == 37
                geneMake = 'g1g3';
            elseif k == 38
                geneMake = 'g1g4';
            elseif k == 39
                geneMake = 'g1g5';
            elseif k == 40
                geneMake = 'g1s';
            elseif k == 41
                geneMake = 'g2g2';
            elseif k == 42
                geneMake = 'g2g3';
            elseif k == 43
                geneMake = 'g2g4';
            elseif k == 44
                geneMake = 'g2g5';
            elseif k == 45
                geneMake = 'g2s';
            elseif k == 46
                geneMake = 'g3g3';
            elseif k == 47
                geneMake = 'g3g4';
            elseif k == 48
                geneMake = 'g3g5';
            elseif k == 49
                geneMake = 'g3s';
            elseif k == 50
                geneMake = 'g4g4';
            elseif k == 51
                geneMake = 'g4g5';
            elseif k == 52
                geneMake = 'g4s';
            elseif k == 53
                geneMake = 'g5g5';
            elseif k == 54
                geneMake = 'g5s';
            elseif k == 55
                geneMake = 'ss';
            end
                      
            geneMALE = strcat(T0(2,i),T0(3,i));
            geneFEMALE = strcat(T0(j,2),T0(j,3));
                
            maleWcount = count(geneMALE, "w");
            maleVcount = count(geneMALE, "v");
            maleUcount = count(geneMALE, "u");
            maleRcount = count(geneMALE, "r");
            maleG1count = count(geneMALE, "g1");
            maleG2count = count(geneMALE, "g2");
            maleG3count = count(geneMALE, "g3");
            maleG4count = count(geneMALE, "g4");
            maleG5count = count(geneMALE, "g5");
            maleScount = count(geneMALE, "s");
            
            femaleWcount = count(geneFEMALE, "w");
            femaleVcount = count(geneFEMALE, "v");
            femaleUcount = count(geneFEMALE, "u");
            femaleRcount = count(geneFEMALE, "r");
            femaleG1count = count(geneFEMALE, "g1");
            femaleG2count = count(geneFEMALE, "g2");
            femaleG3count = count(geneFEMALE, "g3");
            femaleG4count = count(geneFEMALE, "g4");
            femaleG5count = count(geneFEMALE, "g5");
            femaleScount = count(geneFEMALE, "s");    
            
            % MALE PARENT
            T1 = strings(10,2);        
       
            if (maleG1count == 2)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^5))';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5))';
                T1(3,1) = 'g2';
                T1(3,2) = '(5*gamma1*(beta1^4))';
                T1(4,1) = 'g3';
                T1(4,2) = '(10*(gamma1^2)*(beta1^3))';
                T1(5,1) = 'g4';
                T1(5,2) = '(10*(gamma1^3)*(beta1^2))';
                T1(6,1) = 'g5';
                T1(6,2) = '(5*(gamma1^4)*beta1)';
                T1(7,1) = 's';
                T1(7,2) = '(gamma1^5)';
            elseif (maleG1count == 1) && (maleG2count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^5)/2) + ((1-(1-alpha1)^4)/2))';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '((5*gamma1*(beta1^4)/2) + ((beta1^4)/2))';
                T1(4,1) = 'g3';
                T1(4,2) = '((10*(gamma1^2)*(beta1^3)/2) + (4*gamma1*(beta1^3)/2))';
                T1(5,1) = 'g4';
                T1(5,2) = '((10*(gamma1^3)*(beta1^2)/2) + (6*(gamma1^2)*(beta1^2)/2))';
                T1(6,1) = 'g5';
                T1(6,2) = '((5*(gamma1^4)*beta1/2) + (5*(gamma1^4)*beta1/2))';
                T1(7,1) = 's';
                T1(7,2) = '(((gamma1^5)/2) + ((gamma1^4)/2))';
            elseif (maleG1count == 1) && (maleG3count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((((1-(1-alpha1)^5)/2) + ((1-(1-alpha1)^3))/2))';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '(5*gamma1*(beta1^4)/2)';
                T1(4,1) = 'g3';
                T1(4,2) = '((10*(gamma1^2)*(beta1^3)/2) + ((beta1^3)/2))';
                T1(5,1) = 'g4';
                T1(5,2) = '((10*(gamma1^3)*(beta1^2)/2) + (3*gamma1*(beta1^2)/2))';
                T1(6,1) = 'g5';
                T1(6,2) = '((5*(gamma1^4)*beta1/2) + (3*(gamma1^2)*beta1/2))';
                T1(7,1) = 's';
                T1(7,2) = '(((gamma1^5)/2) + ((gamma1^3)/2))';
            elseif (maleG1count == 1) && (maleG4count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^5)/2) + ((1-(1-alpha1)^2)/2))';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '(5*gamma1*(beta1^4)/2)';
                T1(4,1) = 'g3';
                T1(4,2) = '(10*(gamma1^2)*(beta1^3)/2)';
                T1(5,1) = 'g4';
                T1(5,2) = '((10*(gamma1^3)*(beta1^2)/2) + ((beta1^2)/2))';
                T1(6,1) = 'g5';
                T1(6,2) = '((5*(gamma1^4)*beta1/2) + (2*gamma1*beta1/2))';
                T1(7,1) = 's';
                T1(7,2) = '(((gamma1^5)/2) + ((gamma1^2)/2))';    
             elseif (maleG1count == 1) && (maleG5count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^5)/2) + (alpha1/2))';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '(5*gamma1*(beta1^4)/2)';
                T1(4,1) = 'g3';
                T1(4,2) = '(10*(gamma1^2)*(beta1^3)/2)';
                T1(5,1) = 'g4';
                T1(5,2) = '(10*(gamma1^3)*(beta1^2)/2)';
                T1(6,1) = 'g5';
                T1(6,2) = '((5*(gamma1^4)*beta1/2) + (beta1/2))';
                T1(7,1) = 's';
                T1(7,2) = '(((gamma1^5)/2) + (gamma1/2))';
            elseif (maleG1count == 1) && (maleScount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^5)/2)';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '(5*gamma1*(beta1^4)/2)';
                T1(4,1) = 'g3';
                T1(4,2) = '(10*(gamma1^2)*(beta1^3)/2)';
                T1(5,1) = 'g4';
                T1(5,2) = '(10*(gamma1^3)*(beta1^2)/2)';
                T1(6,1) = 'g5';
                T1(6,2) = '(5*(gamma1^4)*beta1/2)';
                T1(7,1) = 's';
                T1(7,2) = '((1+gamma1^5)/2)';
            elseif (maleG1count == 1) && (maleWcount == 1)
                T1(1,1) = 'w';
                T1(1,2) = '(((1-(1-alpha1)^5)/2) + (((1-alpha1)^5)*(1-q1)/2))';
                T1(2,1) = 'v';
                T1(2,2) = '((1-(1-alpha1)^5)/2)';
                T1(3,1) = 'u';
                T1(3,2) = '(((1-alpha1)^5)*q1*(1-P1)*delta1/2)';
                T1(4,1) = 'r';
                T1(4,2) = '(((1-alpha1)^5)*q1*(1-P1)*(1-delta1)/2)';
                T1(5,1) = 'g1';
                T1(5,2) = '(((1+P1*q1))*((beta1^5)/2))';
                T1(6,1) = 'g2';
                T1(6,2) = '(((1+P1*q1))*((5*gamma1*(beta1^4))/2))';
                T1(7,1) = 'g3';
                T1(7,2) = '(((1+P1*q1))*((10*(gamma1^2)*(beta1^3))/2))';
                T1(8,1) = 'g4';
                T1(8,2) = '(((1+P1*q1))*((10*(gamma1^3)*(beta1^2))/2))';
                T1(9,1) = 'g5';
                T1(9,2) = '(((1+P1*q1))*((5*(gamma1^4)*beta1)/2))';
                T1(10,1) = 's';
                T1(10,2) = '(((1+P1*q1))*((gamma1^5)/2))';                
            elseif (maleG1count == 1) && (maleVcount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1+(1-(1-alpha1)^5))/2)';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '((5*gamma1*(beta1^4))/2)';
                T1(4,1) = 'g3';
                T1(4,2) = '((10*(gamma1^2)*(beta1^3))/2)';
                T1(5,1) = 'g4';
                T1(5,2) = '((10*(gamma1^3)*(beta1^2))/2)';
                T1(6,1) = 'g5';
                T1(6,2) = '((5*(gamma1^4)*beta1)/2)';
                T1(7,1) = 's';
                T1(7,2) = '((gamma1^5)/2)';      
            elseif (maleG1count == 1) && (maleUcount == 1)
                T1(1,1) = 'u';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '((5*gamma1*(beta1^4))/2)';
                T1(4,1) = 'g3';
                T1(4,2) = '((10*(gamma1^2)*(beta1^3))/2)';
                T1(5,1) = 'g4';
                T1(5,2) = '((10*(gamma1^3)*(beta1^2))/2)';
                T1(6,1) = 'g5';
                T1(6,2) = '((5*(gamma1^4)*beta1)/2)';
                T1(7,1) = 's';
                T1(7,2) = '((gamma1^5)/2)'; 
                T1(8,1) = 'v';
                T1(8,2) = '((1-(1-alpha1)^5)/2)';
            elseif (maleG1count == 1) && (maleRcount == 1)    
                T1(1,1) = 'r';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g1';
                T1(2,2) = '((beta1^5)/2)';
                T1(3,1) = 'g2';
                T1(3,2) = '((5*gamma1*(beta1^4))/2)';
                T1(4,1) = 'g3';
                T1(4,2) = '((10*(gamma1^2)*(beta1^3))/2)';
                T1(5,1) = 'g4';
                T1(5,2) = '((10*(gamma1^3)*(beta1^2))/2)';
                T1(6,1) = 'g5';
                T1(6,2) = '((5*(gamma1^4)*beta1)/2)';
                T1(7,1) = 's';
                T1(7,2) = '((gamma1^5)/2)';  
                T1(8,1) = 'v';
                T1(8,2) = '((1-(1-alpha1)^5)/2)';
            elseif (maleG2count == 2)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^4))';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4))';
                T1(3,1) = 'g3';
                T1(3,2) = '((4*gamma1*(beta1^3)))';
                T1(4,1) = 'g4';
                T1(4,2) = '((6*(gamma1^2)*(beta1^2)))';
                T1(5,1) = 'g5';
                T1(5,2) = '((4*(gamma1^3)*beta1))';
                T1(6,1) = 's';
                T1(6,2) = '((gamma1^4))';
            elseif (maleG2count == 1) && (maleG3count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^4)/2) + ((1-(1-alpha1)^3)/2))';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4)/2)';
                T1(3,1) = 'g3';
                T1(3,2) = '(((4*gamma1*(beta1^3))/2) + ((beta1^3)/2))';
                T1(4,1) = 'g4';
                T1(4,2) = '(((6*(gamma1^2)*(beta1^2))/2) + ((3*gamma1*(beta1^2))/2))';
                T1(5,1) = 'g5';
                T1(5,2) = '(((4*(gamma1^3)*beta1)/2) + ((3*(gamma1^2)*beta1)/2))';
                T1(6,1) = 's';
                T1(6,2) = '(((gamma1^4)/2) + ((gamma1^3)/2))';
            elseif (maleG2count == 1) && (maleG4count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^4)/2) + ((1-(1-alpha1)^2)/2))';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4)/2)';
                T1(3,1) = 'g3';
                T1(3,2) = '(((4*gamma1*(beta1^3))/2))';
                T1(4,1) = 'g4';
                T1(4,2) = '(((6*(gamma1^2)*(beta1^2))/2) + ((beta1^2)/2))';
                T1(5,1) = 'g5';
                T1(5,2) = '(((4*(gamma1^3)*beta1)/2) + ((2*gamma1*beta1)/2))';
                T1(6,1) = 's';
                T1(6,2) = '(((gamma1^4)/2) + ((gamma1^2)/2))';      
            elseif (maleG2count == 1) && (maleG5count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^4)/2) + ((alpha1)/2))';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4)/2)';
                T1(3,1) = 'g3';
                T1(3,2) = '(((4*gamma1*(beta1^3))/2))';
                T1(4,1) = 'g4';
                T1(4,2) = '(((6*(gamma1^2)*(beta1^2))/2))';
                T1(5,1) = 'g5';
                T1(5,2) = '(((4*(gamma1^3)*beta1)/2) + ((beta1)/2))';
                T1(6,1) = 's';
                T1(6,2) = '(((gamma1^4)/2) + ((gamma1)/2))';
            elseif (maleG2count == 1) && (maleScount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^4)/2)';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4)/2)';
                T1(3,1) = 'g3';
                T1(3,2) = '((4*gamma1*(beta1^3)/2))';
                T1(4,1) = 'g4';
                T1(4,2) = '((6*(gamma1^2)*(beta1^2)/2))';
                T1(5,1) = 'g5';
                T1(5,2) = '((4*(gamma1^3)*beta1)/2)';
                T1(6,1) = 's';
                T1(6,2) = '((1+gamma1^4)/2)';
            elseif (maleG2count == 1) && (maleWcount == 1)
                T1(1,1) = 'w';
                T1(1,2) = '(((1-(1-alpha1)^4)/2) + (((1-alpha1)^4)*(1-q1)/2))';
                T1(2,1) = 'v';
                T1(2,2) = '((1-(1-alpha1)^4)/2)';
                T1(3,1) = 'u';
                T1(3,2) = '(((1-alpha1)^4)*q1*(1-P1)*delta1/2)';
                T1(4,1) = 'r';
                T1(4,2) = '(((1-alpha1)^4)*q1*(1-P1)*(1-delta1)/2)';
                T1(5,1) = 'g2';
                T1(5,2) = '(((1+P1*q1))*((beta1^4))/2)';
                T1(6,1) = 'g3';
                T1(6,2) = '(((1+P1*q1))*((4*gamma1*(beta1^3)))/2)';
                T1(7,1) = 'g4';
                T1(7,2) = '(((1+P1*q1))*((6*(gamma1^2)*(beta1^2)))/2)';
                T1(8,1) = 'g5';
                T1(8,2) = '(((1+P1*q1))*((4*(gamma1^3)*beta1))/2)';
                T1(9,1) = 's';
                T1(9,2) = '(((1+P1*q1))*((gamma1^4)/2))'; 
            elseif (maleG2count == 1) && (maleVcount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1+((1-(1-alpha1)^4)))/2)';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4)/2)';
                T1(3,1) = 'g3';
                T1(3,2) = '(4*gamma1*(beta1^3)/2)';
                T1(4,1) = 'g4';
                T1(4,2) = '((6*(gamma1^2)*(beta1^2))/2)';
                T1(5,1) = 'g5';
                T1(5,2) = '((4*(gamma1^3)*beta1)/2)';
                T1(6,1) = 's';
                T1(6,2) = '((gamma1^4)/2)'; 
            elseif (maleG2count == 1) && (maleUcount == 1)
                T1(1,1) = 'u';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4)/2)';
                T1(3,1) = 'g3';
                T1(3,2) = '(4*gamma1*(beta1^3)/2)';
                T1(4,1) = 'g4';
                T1(4,2) = '((6*(gamma1^2)*(beta1^2))/2)';
                T1(5,1) = 'g5';
                T1(5,2) = '((4*(gamma1^3)*beta1)/2)';
                T1(6,1) = 's';
                T1(6,2) = '((gamma1^4)/2)';
                T1(7,1) = 'v';
                T1(7,2) = '(((1-(1-alpha1)^4))/2)';
            elseif (maleG2count == 1) && (maleRcount == 1)
                T1(1,1) = 'r';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g2';
                T1(2,2) = '((beta1^4)/2)';
                T1(3,1) = 'g3';
                T1(3,2) = '(4*gamma1*(beta1^3)/2)';
                T1(4,1) = 'g4';
                T1(4,2) = '((6*(gamma1^2)*(beta1^2))/2)';
                T1(5,1) = 'g5';
                T1(5,2) = '((4*(gamma1^3)*beta1)/2)';
                T1(6,1) = 's';
                T1(6,2) = '((gamma1^4)/2)';
                T1(7,1) = 'v';
                T1(7,2) = '(((1-(1-alpha1)^4))/2)';
            elseif (maleG3count == 2)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^3))';
                T1(2,1) = 'g3';
                T1(2,2) = '(beta1^3)';
                T1(3,1) = 'g4';
                T1(3,2) = '(3*gamma1*(beta1^2))';
                T1(4,1) = 'g5';
                T1(4,2) = '(3*(gamma1^2)*beta1)';
                T1(5,1) = 's';
                T1(5,2) = '((gamma1^3))';
            elseif (maleG3count == 1) && (maleG4count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^3)/2) + ((1-(1-alpha1)^2)/2))';
                T1(2,1) = 'g3';
                T1(2,2) = '((beta1^3)/2)';
                T1(3,1) = 'g4';
                T1(3,2) = '(((3*gamma1*(beta1^2))/2) + ((beta1^2)/2))';
                T1(4,1) = 'g5';
                T1(4,2) = '(((3*(gamma1^2)*beta1)/2) + ((2*gamma1*beta1)/2))';
                T1(5,1) = 's';
                T1(5,2) = '(((gamma1^3)/2) + ((gamma1^2)/2))';
            elseif (maleG3count == 1) && (maleG5count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^3)/2) + (alpha1/2))';
                T1(2,1) = 'g3';
                T1(2,2) = '((beta1^3)/2)';
                T1(3,1) = 'g4';
                T1(3,2) = '((3*gamma1*(beta1^2))/2)';
                T1(4,1) = 'g5';
                T1(4,2) = '(((3*(gamma1^2)*beta1)/2) + (beta1/2))';
                T1(5,1) = 's';
                T1(5,2) = '(((gamma1^3)/2) + (gamma1/2))';
            elseif (maleG3count == 1) && (maleScount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^3)/2)';
                T1(2,1) = 'g3';
                T1(2,2) = '((beta1^3)/2)';
                T1(3,1) = 'g4';
                T1(3,2) = '(3*gamma1*(beta1^2)/2)';
                T1(4,1) = 'g5';
                T1(4,2) = '(3*(gamma1^2)*beta1/2)';
                T1(5,1) = 's';
                T1(5,2) = '((1+gamma1^3)/2)';
            elseif (maleG3count == 1) && (maleWcount == 1)
                T1(1,1) = 'w';
                T1(1,2) = '(((1-(1-alpha1)^3)/2) + (((1-alpha1)^3)*(1-q1)/2))';
                T1(2,1) = 'v';
                T1(2,2) = '((1-(1-alpha1)^3)/2)';
                T1(3,1) = 'u';
                T1(3,2) = '(((1-alpha1)^3)*q1*(1-P1)*delta1/2)';
                T1(4,1) = 'r';
                T1(4,2) = '(((1-alpha1)^3)*q1*(1-P1)*(1-delta1)/2)';
                T1(5,1) = 'g3';
                T1(5,2) = '(((1+P1*q1))*(beta1^3)/2)';
                T1(6,1) = 'g4';
                T1(6,2) = '(((1+P1*q1))*(3*gamma1*(beta1^2))/2)';
                T1(7,1) = 'g5';
                T1(7,2) = '(((1+P1*q1))*(3*(gamma1^2)*beta1)/2)';
                T1(8,1) = 's';
                T1(8,2) = '(((1+P1*q1))*((gamma1^3)/2))';
            elseif (maleG3count == 1) && (maleVcount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1+(1-(1-alpha1)^3))/2)';
                T1(2,1) = 'g3';
                T1(2,2) = '((beta1^3)/2)';
                T1(3,1) = 'g4';
                T1(3,2) = '((3*gamma1*(beta1^2))/2)';
                T1(4,1) = 'g5';
                T1(4,2) = '((3*(gamma1^2)*beta1)/2)';
                T1(5,1) = 's';
                T1(5,2) = '((gamma1^3)/2)';
            elseif (maleG3count == 1) && (maleUcount == 1)
                T1(1,1) = 'u';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g3';
                T1(2,2) = '((beta1^3)/2)';
                T1(3,1) = 'g4';
                T1(3,2) = '((3*gamma1*(beta1^2))/2)';
                T1(4,1) = 'g5';
                T1(4,2) = '((3*(gamma1^2)*beta1)/2)';
                T1(5,1) = 's';
                T1(5,2) = '((gamma1^3)/2)';
                T1(6,1) = 'v';
                T1(6,2) = '((1-(1-alpha1)^3)/2)';
            elseif (maleG3count == 1) && (maleRcount == 1)
                T1(1,1) = 'r';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g3';
                T1(2,2) = '((beta1^3)/2)';
                T1(3,1) = 'g4';
                T1(3,2) = '((3*gamma1*(beta1^2))/2)';
                T1(4,1) = 'g5';
                T1(4,2) = '((3*(gamma1^2)*beta1)/2)';
                T1(5,1) = 's';
                T1(5,2) = '((gamma1^3)/2)';
                T1(6,1) = 'v';
                T1(6,2) = '((1-(1-alpha1)^3)/2)';
            elseif (maleG4count == 2)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^2))';
                T1(2,1) = 'g4';
                T1(2,2) = '((beta1^2))';
                T1(3,1) = 'g5';
                T1(3,2) = '((2*gamma1*beta1))';
                T1(4,1) = 's';
                T1(4,2) = '((gamma1^2))'; 
            elseif (maleG4count == 1) && (maleG5count == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(((1-(1-alpha1)^2)/2) + (alpha1/2))';
                T1(2,1) = 'g4';
                T1(2,2) = '((beta1^2)/2)';
                T1(3,1) = 'g5';
                T1(3,2) = '(((2*gamma1*beta1)/2) + (beta1/2))';
                T1(4,1) = 's';
                T1(4,2) = '(((gamma1^2)/2) + (gamma1/2))'; 
            elseif (maleG4count == 1) && (maleScount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1-(1-alpha1)^2)/2)';
                T1(2,1) = 'g4';
                T1(2,2) = '((beta1^2)/2)';
                T1(3,1) = 'g5';
                T1(3,2) = '((2*gamma1*beta1)/2)';
                T1(4,1) = 's';
                T1(4,2) = '((1+gamma1^2)/2)';
            elseif (maleG4count == 1) && (maleWcount == 1)
                T1(1,1) = 'w';
                T1(1,2) = '((((1-(1-alpha1)^2)) + ((1-alpha1)^2)*(1-q1))/2)';
                T1(2,1) = 'v';
                T1(2,2) = '((1-(1-alpha1)^2)/2)';
                T1(3,1) = 'u';
                T1(3,2) = '(((1-alpha1)^2)*q1*(1-P1)*delta1/2)';
                T1(4,1) = 'r';
                T1(4,2) = '(((1-alpha1)^2)*q1*(1-P1)*(1-delta1)/2)';
                T1(5,1) = 'g4';
                T1(5,2) = '(((1+P1*q1))*((beta1^2)/2))';
                T1(6,1) = 'g5';
                T1(6,2) = '((((1+P1*q1))*(2*gamma1*beta1)/2))';
                T1(7,1) = 's';
                T1(7,2) = '(((1+P1*q1)*(gamma1^2))/2)';         
            elseif (maleG4count == 1) && (maleVcount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1+(1-(1-alpha1)^2))/2)';
                T1(2,1) = 'g4';
                T1(2,2) = '((beta1^2)/2)';
                T1(3,1) = 'g5';
                T1(3,2) = '((2*gamma1*beta1)/2)';
                T1(4,1) = 's';
                T1(4,2) = '((gamma1^2)/2)';
            elseif (maleG4count == 1) && (maleUcount == 1)
                T1(1,1) = 'u';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g4';
                T1(2,2) = '((beta1^2)/2)';
                T1(3,1) = 'g5';
                T1(3,2) = '((2*gamma1*beta1)/2)';
                T1(4,1) = 's';
                T1(4,2) = '((gamma1^2)/2)';
                T1(5,1) = 'v';
                T1(5,2) = '((1-(1-alpha1)^2)/2)';
            elseif (maleG4count == 1) && (maleRcount == 1)
                T1(1,1) = 'r';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g4';
                T1(2,2) = '((beta1^2)/2)';
                T1(3,1) = 'g5';
                T1(3,2) = '((2*gamma1*beta1)/2)';
                T1(4,1) = 's';
                T1(4,2) = '((gamma1^2)/2)';
                T1(5,1) = 'v';
                T1(5,2) = '((1-(1-alpha1)^2)/2)';
            elseif maleG5count == 2
                T1(1,1) = 'v';
                T1(1,2) = '(alpha1)';
                T1(2,1) = 'g5';
                T1(2,2) = '(beta1)';
                T1(3,1) = 's';
                T1(3,2) = '(gamma1)';
            elseif (maleG5count == 1) && (maleScount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '(alpha1/2)';
                T1(2,1) = 'g5';
                T1(2,2) = '(beta1/2)';
                T1(3,1) = 's';
                T1(3,2) = '((1+gamma1)/2)';
            elseif (maleG5count == 1) && (maleWcount == 1)
                T1(1,1) = 'w';
                T1(1,2) = '((alpha1/2) + (((1-alpha1))*(1-q1)/2))';
                T1(2,1) = 'v';
                T1(2,2) = '(alpha1/2)';
                T1(3,1) = 'u';
                T1(3,2) = '((1-alpha1)*q1*(1-P1)*delta1/2)';
                T1(4,1) = 'r';
                T1(4,2) = '((1-alpha1)*q1*(1-P1)*(1-delta1)/2)';
                T1(5,1) = 'g5';
                T1(5,2) = '(((1+P1*q1))*beta1/2)';
                T1(6,1) = 's';
                T1(6,2) = '(((1+P1*q1))*gamma1/2)';
            elseif (maleG5count == 1) && (maleVcount == 1)
                T1(1,1) = 'v';
                T1(1,2) = '((1+alpha1)/2)';
                T1(2,1) = 'g5';
                T1(2,2) = '(beta1/2)';
                T1(3,1) = 's';
                T1(3,2) = '(gamma1/2)';
            elseif (maleG5count == 1) && (maleUcount == 1)
                T1(1,1) = 'u';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g5';
                T1(2,2) = '(beta1/2)';
                T1(3,1) = 's';
                T1(3,2) = '(gamma1/2)';
                T1(4,1) = 'v';
                T1(4,2) = '(alpha1/2)';
            elseif (maleG5count == 1) && (maleRcount == 1)
                T1(1,1) = 'r';
                T1(1,2) = '(1/2)';
                T1(2,1) = 'g5';
                T1(2,2) = '(beta1/2)';
                T1(3,1) = 's';
                T1(3,2) = '(gamma1/2)';
                T1(4,1) = 'v';
                T1(4,2) = '(alpha1/2)';
            elseif (maleScount == 1) && (maleWcount == 1)
                T1(1,1) = 'w';
                T1(1,2) = '((1-q1)/2)';
                T1(2,1) = 'u';
                T1(2,2) = '(q1*(1-P1)*delta1/2)';
                T1(3,1) = 'r';
                T1(3,2) = '(q1*(1-P1)*(1-delta1)/2)';
                T1(4,1) = 's';
                T1(4,2) = '((1+P1*q1)/2)';
            else
                T1(1,1) = T0(2,i); % initial reference
                T1(1,2) = '(1/2)';
                T1(2,1) = T0(3,i); % initial reference
                T1(2,2) = '(1/2)';
            end            

            % FEMALE PARENT                   
            T2 = strings(10,2);        
       
            if (femaleG1count == 2)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^5))';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5))';
                T2(3,1) = 'g2';
                T2(3,2) = '(5*gamma2*(beta2^4))';
                T2(4,1) = 'g3';
                T2(4,2) = '(10*(gamma2^2)*(beta2^3))';
                T2(5,1) = 'g4';
                T2(5,2) = '(10*(gamma2^3)*(beta2^2))';
                T2(6,1) = 'g5';
                T2(6,2) = '(5*(gamma2^4)*beta2)';
                T2(7,1) = 's';
                T2(7,2) = '(gamma2^5)';
            elseif (femaleG1count == 1) && (femaleG2count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^5)/2) + ((1-(1-alpha2)^4)/2))';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '((5*gamma2*(beta2^4)/2) + ((beta2^4)/2))';
                T2(4,1) = 'g3';
                T2(4,2) = '((10*(gamma2^2)*(beta2^3)/2) + (4*gamma2*(beta2^3)/2))';
                T2(5,1) = 'g4';
                T2(5,2) = '((10*(gamma2^3)*(beta2^2)/2) + (6*(gamma2^2)*(beta2^2)/2))';
                T2(6,1) = 'g5';
                T2(6,2) = '((5*(gamma2^4)*beta2/2) + (5*(gamma2^4)*beta2/2))';
                T2(7,1) = 's';
                T2(7,2) = '(((gamma2^5)/2) + ((gamma2^4)/2))';
            elseif (femaleG1count == 1) && (femaleG3count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((((1-(1-alpha2)^5)/2) + ((1-(1-alpha2)^3))/2))';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '(5*gamma2*(beta2^4)/2)';
                T2(4,1) = 'g3';
                T2(4,2) = '((10*(gamma2^2)*(beta2^3)/2) + ((beta2^3)/2))';
                T2(5,1) = 'g4';
                T2(5,2) = '((10*(gamma2^3)*(beta2^2)/2) + (3*gamma2*(beta2^2)/2))';
                T2(6,1) = 'g5';
                T2(6,2) = '((5*(gamma2^4)*beta2/2) + (3*(gamma2^2)*beta2/2))';
                T2(7,1) = 's';
                T2(7,2) = '(((gamma2^5)/2) + ((gamma2^3)/2))';
            elseif (femaleG1count == 1) && (femaleG4count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^5)/2) + ((1-(1-alpha2)^2)/2))';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '(5*gamma2*(beta2^4)/2)';
                T2(4,1) = 'g3';
                T2(4,2) = '(10*(gamma2^2)*(beta2^3)/2)';
                T2(5,1) = 'g4';
                T2(5,2) = '((10*(gamma2^3)*(beta2^2)/2) + ((beta2^2)/2))';
                T2(6,1) = 'g5';
                T2(6,2) = '((5*(gamma2^4)*beta2/2) + (2*gamma2*beta2/2))';
                T2(7,1) = 's';
                T2(7,2) = '(((gamma2^5)/2) + ((gamma2^2)/2))';    
             elseif (femaleG1count == 1) && (femaleG5count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^5)/2) + (alpha2/2))';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '(5*gamma2*(beta2^4)/2)';
                T2(4,1) = 'g3';
                T2(4,2) = '(10*(gamma2^2)*(beta2^3)/2)';
                T2(5,1) = 'g4';
                T2(5,2) = '(10*(gamma2^3)*(beta2^2)/2)';
                T2(6,1) = 'g5';
                T2(6,2) = '((5*(gamma2^4)*beta2/2) + (beta2/2))';
                T2(7,1) = 's';
                T2(7,2) = '(((gamma2^5)/2) + (gamma2/2))';
            elseif (femaleG1count == 1) && (femaleScount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^5)/2)';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '(5*gamma2*(beta2^4)/2)';
                T2(4,1) = 'g3';
                T2(4,2) = '(10*(gamma2^2)*(beta2^3)/2)';
                T2(5,1) = 'g4';
                T2(5,2) = '(10*(gamma2^3)*(beta2^2)/2)';
                T2(6,1) = 'g5';
                T2(6,2) = '(5*(gamma2^4)*beta2/2)';
                T2(7,1) = 's';
                T2(7,2) = '((1+gamma2^5)/2)';
            elseif (femaleG1count == 1) && (femaleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '(((1-(1-alpha2)^5)/2) + (((1-alpha2)^5)*(1-q2)/2))';
                T2(2,1) = 'v';
                T2(2,2) = '((1-(1-alpha2)^5)/2)';
                T2(3,1) = 'u';
                T2(3,2) = '(((1-alpha2)^5)*q2*(1-P2)*delta2/2)';
                T2(4,1) = 'r';
                T2(4,2) = '(((1-alpha2)^5)*q2*(1-P2)*(1-delta2)/2)';
                T2(5,1) = 'g1';
                T2(5,2) = '(((1+P2*q2))*((beta2^5)/2))';
                T2(6,1) = 'g2';
                T2(6,2) = '(((1+P2*q2))*((5*gamma2*(beta2^4))/2))';
                T2(7,1) = 'g3';
                T2(7,2) = '(((1+P2*q2))*((10*(gamma2^2)*(beta2^3))/2))';
                T2(8,1) = 'g4';
                T2(8,2) = '(((1+P2*q2))*((10*(gamma2^3)*(beta2^2))/2))';
                T2(9,1) = 'g5';
                T2(9,2) = '(((1+P2*q2))*((5*(gamma2^4)*beta2)/2))';
                T2(10,1) = 's';
                T2(10,2) = '(((1+P2*q2))*((gamma2^5)/2))';                
            elseif (femaleG1count == 1) && (femaleVcount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1+(1-(1-alpha2)^5))/2)';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '((5*gamma2*(beta2^4))/2)';
                T2(4,1) = 'g3';
                T2(4,2) = '((10*(gamma2^2)*(beta2^3))/2)';
                T2(5,1) = 'g4';
                T2(5,2) = '((10*(gamma2^3)*(beta2^2))/2)';
                T2(6,1) = 'g5';
                T2(6,2) = '((5*(gamma2^4)*beta2)/2)';
                T2(7,1) = 's';
                T2(7,2) = '((gamma2^5)/2)';      
            elseif (femaleG1count == 1) && (femaleUcount == 1)
                T2(1,1) = 'u';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '((5*gamma2*(beta2^4))/2)';
                T2(4,1) = 'g3';
                T2(4,2) = '((10*(gamma2^2)*(beta2^3))/2)';
                T2(5,1) = 'g4';
                T2(5,2) = '((10*(gamma2^3)*(beta2^2))/2)';
                T2(6,1) = 'g5';
                T2(6,2) = '((5*(gamma2^4)*beta2)/2)';
                T2(7,1) = 's';
                T2(7,2) = '((gamma2^5)/2)'; 
                T2(8,1) = 'v';
                T2(8,2) = '((1-(1-alpha2)^5)/2)';
            elseif (femaleG1count == 1) && (femaleRcount == 1)    
                T2(1,1) = 'r';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g1';
                T2(2,2) = '((beta2^5)/2)';
                T2(3,1) = 'g2';
                T2(3,2) = '((5*gamma2*(beta2^4))/2)';
                T2(4,1) = 'g3';
                T2(4,2) = '((10*(gamma2^2)*(beta2^3))/2)';
                T2(5,1) = 'g4';
                T2(5,2) = '((10*(gamma2^3)*(beta2^2))/2)';
                T2(6,1) = 'g5';
                T2(6,2) = '((5*(gamma2^4)*beta2)/2)';
                T2(7,1) = 's';
                T2(7,2) = '((gamma2^5)/2)';  
                T2(8,1) = 'v';
                T2(8,2) = '((1-(1-alpha2)^5)/2)';
            elseif (femaleG2count == 2)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^4))';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4))';
                T2(3,1) = 'g3';
                T2(3,2) = '((4*gamma2*(beta2^3)))';
                T2(4,1) = 'g4';
                T2(4,2) = '((6*(gamma2^2)*(beta2^2)))';
                T2(5,1) = 'g5';
                T2(5,2) = '((4*(gamma2^3)*beta2))';
                T2(6,1) = 's';
                T2(6,2) = '((gamma2^4))';
            elseif (femaleG2count == 1) && (femaleG3count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^4)/2) + ((1-(1-alpha2)^3)/2))';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4)/2)';
                T2(3,1) = 'g3';
                T2(3,2) = '(((4*gamma2*(beta2^3))/2) + ((beta2^3)/2))';
                T2(4,1) = 'g4';
                T2(4,2) = '(((6*(gamma2^2)*(beta2^2))/2) + ((3*gamma2*(beta2^2))/2))';
                T2(5,1) = 'g5';
                T2(5,2) = '(((4*(gamma2^3)*beta2)/2) + ((3*(gamma2^2)*beta2)/2))';
                T2(6,1) = 's';
                T2(6,2) = '(((gamma2^4)/2) + ((gamma2^3)/2))';
            elseif (femaleG2count == 1) && (femaleG4count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^4)/2) + ((1-(1-alpha2)^2)/2))';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4)/2)';
                T2(3,1) = 'g3';
                T2(3,2) = '(((4*gamma2*(beta2^3))/2))';
                T2(4,1) = 'g4';
                T2(4,2) = '(((6*(gamma2^2)*(beta2^2))/2) + ((beta2^2)/2))';
                T2(5,1) = 'g5';
                T2(5,2) = '(((4*(gamma2^3)*beta2)/2) + ((2*gamma2*beta2)/2))';
                T2(6,1) = 's';
                T2(6,2) = '(((gamma2^4)/2) + ((gamma2^2)/2))';      
            elseif (femaleG2count == 1) && (femaleG5count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^4)/2) + ((alpha2)/2))';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4)/2)';
                T2(3,1) = 'g3';
                T2(3,2) = '(((4*gamma2*(beta2^3))/2))';
                T2(4,1) = 'g4';
                T2(4,2) = '(((6*(gamma2^2)*(beta2^2))/2))';
                T2(5,1) = 'g5';
                T2(5,2) = '(((4*(gamma2^3)*beta2)/2) + ((beta2)/2))';
                T2(6,1) = 's';
                T2(6,2) = '(((gamma2^4)/2) + ((gamma2)/2))';
            elseif (femaleG2count == 1) && (femaleScount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^4)/2)';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4)/2)';
                T2(3,1) = 'g3';
                T2(3,2) = '((4*gamma2*(beta2^3)/2))';
                T2(4,1) = 'g4';
                T2(4,2) = '((6*(gamma2^2)*(beta2^2)/2))';
                T2(5,1) = 'g5';
                T2(5,2) = '((4*(gamma2^3)*beta2)/2)';
                T2(6,1) = 's';
                T2(6,2) = '((1+gamma2^4)/2)';
            elseif (femaleG2count == 1) && (femaleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '(((1-(1-alpha2)^4)/2) + (((1-alpha2)^4)*(1-q2)/2))';
                T2(2,1) = 'v';
                T2(2,2) = '((1-(1-alpha2)^4)/2)';
                T2(3,1) = 'u';
                T2(3,2) = '(((1-alpha2)^4)*q2*(1-P2)*delta2/2)';
                T2(4,1) = 'r';
                T2(4,2) = '(((1-alpha2)^4)*q2*(1-P2)*(1-delta2)/2)';
                T2(5,1) = 'g2';
                T2(5,2) = '(((1+P2*q2))*((beta2^4))/2)';
                T2(6,1) = 'g3';
                T2(6,2) = '(((1+P2*q2))*((4*gamma2*(beta2^3)))/2)';
                T2(7,1) = 'g4';
                T2(7,2) = '(((1+P2*q2))*((6*(gamma2^2)*(beta2^2)))/2)';
                T2(8,1) = 'g5';
                T2(8,2) = '(((1+P2*q2))*((4*(gamma2^3)*beta2))/2)';
                T2(9,1) = 's';
                T2(9,2) = '(((1+P2*q2))*((gamma2^4)/2))'; 
            elseif (femaleG2count == 1) && (femaleVcount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1+((1-(1-alpha2)^4)))/2)';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4)/2)';
                T2(3,1) = 'g3';
                T2(3,2) = '(4*gamma2*(beta2^3)/2)';
                T2(4,1) = 'g4';
                T2(4,2) = '((6*(gamma2^2)*(beta2^2))/2)';
                T2(5,1) = 'g5';
                T2(5,2) = '((4*(gamma2^3)*beta2)/2)';
                T2(6,1) = 's';
                T2(6,2) = '((gamma2^4)/2)'; 
            elseif (femaleG2count == 1) && (femaleUcount == 1)
                T2(1,1) = 'u';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4)/2)';
                T2(3,1) = 'g3';
                T2(3,2) = '(4*gamma2*(beta2^3)/2)';
                T2(4,1) = 'g4';
                T2(4,2) = '((6*(gamma2^2)*(beta2^2))/2)';
                T2(5,1) = 'g5';
                T2(5,2) = '((4*(gamma2^3)*beta2)/2)';
                T2(6,1) = 's';
                T2(6,2) = '((gamma2^4)/2)';
                T2(7,1) = 'v';
                T2(7,2) = '(((1-(1-alpha2)^4))/2)';
            elseif (femaleG2count == 1) && (femaleRcount == 1)
                T2(1,1) = 'r';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g2';
                T2(2,2) = '((beta2^4)/2)';
                T2(3,1) = 'g3';
                T2(3,2) = '(4*gamma2*(beta2^3)/2)';
                T2(4,1) = 'g4';
                T2(4,2) = '((6*(gamma2^2)*(beta2^2))/2)';
                T2(5,1) = 'g5';
                T2(5,2) = '((4*(gamma2^3)*beta2)/2)';
                T2(6,1) = 's';
                T2(6,2) = '((gamma2^4)/2)';
                T2(7,1) = 'v';
                T2(7,2) = '(((1-(1-alpha2)^4))/2)';
            elseif (femaleG3count == 2)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^3))';
                T2(2,1) = 'g3';
                T2(2,2) = '(beta2^3)';
                T2(3,1) = 'g4';
                T2(3,2) = '(3*gamma2*(beta2^2))';
                T2(4,1) = 'g5';
                T2(4,2) = '(3*(gamma2^2)*beta2)';
                T2(5,1) = 's';
                T2(5,2) = '((gamma2^3))';
            elseif (femaleG3count == 1) && (femaleG4count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^3)/2) + ((1-(1-alpha2)^2)/2))';
                T2(2,1) = 'g3';
                T2(2,2) = '((beta2^3)/2)';
                T2(3,1) = 'g4';
                T2(3,2) = '(((3*gamma2*(beta2^2))/2) + ((beta2^2)/2))';
                T2(4,1) = 'g5';
                T2(4,2) = '(((3*(gamma2^2)*beta2)/2) + ((2*gamma2*beta2)/2))';
                T2(5,1) = 's';
                T2(5,2) = '(((gamma2^3)/2) + ((gamma2^2)/2))';
            elseif (femaleG3count == 1) && (femaleG5count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^3)/2) + (alpha2/2))';
                T2(2,1) = 'g3';
                T2(2,2) = '((beta2^3)/2)';
                T2(3,1) = 'g4';
                T2(3,2) = '((3*gamma2*(beta2^2))/2)';
                T2(4,1) = 'g5';
                T2(4,2) = '(((3*(gamma2^2)*beta2)/2) + (beta2/2))';
                T2(5,1) = 's';
                T2(5,2) = '(((gamma2^3)/2) + (gamma2/2))';
            elseif (femaleG3count == 1) && (femaleScount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^3)/2)';
                T2(2,1) = 'g3';
                T2(2,2) = '((beta2^3)/2)';
                T2(3,1) = 'g4';
                T2(3,2) = '(3*gamma2*(beta2^2)/2)';
                T2(4,1) = 'g5';
                T2(4,2) = '(3*(gamma2^2)*beta2/2)';
                T2(5,1) = 's';
                T2(5,2) = '((1+gamma2^3)/2)';
            elseif (femaleG3count == 1) && (femaleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '(((1-(1-alpha2)^3)/2) + (((1-alpha2)^3)*(1-q2)/2))';
                T2(2,1) = 'v';
                T2(2,2) = '((1-(1-alpha2)^3)/2)';
                T2(3,1) = 'u';
                T2(3,2) = '(((1-alpha2)^3)*q2*(1-P2)*delta2/2)';
                T2(4,1) = 'r';
                T2(4,2) = '(((1-alpha2)^3)*q2*(1-P2)*(1-delta2)/2)';
                T2(5,1) = 'g3';
                T2(5,2) = '(((1+P2*q2))*(beta2^3)/2)';
                T2(6,1) = 'g4';
                T2(6,2) = '(((1+P2*q2))*(3*gamma2*(beta2^2))/2)';
                T2(7,1) = 'g5';
                T2(7,2) = '(((1+P2*q2))*(3*(gamma2^2)*beta2)/2)';
                T2(8,1) = 's';
                T2(8,2) = '(((1+P2*q2))*((gamma2^3)/2))';
            elseif (femaleG3count == 1) && (femaleVcount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1+(1-(1-alpha2)^3))/2)';
                T2(2,1) = 'g3';
                T2(2,2) = '((beta2^3)/2)';
                T2(3,1) = 'g4';
                T2(3,2) = '((3*gamma2*(beta2^2))/2)';
                T2(4,1) = 'g5';
                T2(4,2) = '((3*(gamma2^2)*beta2)/2)';
                T2(5,1) = 's';
                T2(5,2) = '((gamma2^3)/2)';
            elseif (femaleG3count == 1) && (femaleUcount == 1)
                T2(1,1) = 'u';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g3';
                T2(2,2) = '((beta2^3)/2)';
                T2(3,1) = 'g4';
                T2(3,2) = '((3*gamma2*(beta2^2))/2)';
                T2(4,1) = 'g5';
                T2(4,2) = '((3*(gamma2^2)*beta2)/2)';
                T2(5,1) = 's';
                T2(5,2) = '((gamma2^3)/2)';
                T2(6,1) = 'v';
                T2(6,2) = '((1-(1-alpha2)^3)/2)';
            elseif (femaleG3count == 1) && (femaleRcount == 1)
                T2(1,1) = 'r';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g3';
                T2(2,2) = '((beta2^3)/2)';
                T2(3,1) = 'g4';
                T2(3,2) = '((3*gamma2*(beta2^2))/2)';
                T2(4,1) = 'g5';
                T2(4,2) = '((3*(gamma2^2)*beta2)/2)';
                T2(5,1) = 's';
                T2(5,2) = '((gamma2^3)/2)';
                T2(6,1) = 'v';
                T2(6,2) = '((1-(1-alpha2)^3)/2)';
            elseif (femaleG4count == 2)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^2))';
                T2(2,1) = 'g4';
                T2(2,2) = '((beta2^2))';
                T2(3,1) = 'g5';
                T2(3,2) = '((2*gamma2*beta2))';
                T2(4,1) = 's';
                T2(4,2) = '((gamma2^2))'; 
            elseif (femaleG4count == 1) && (femaleG5count == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(((1-(1-alpha2)^2)/2) + (alpha2/2))';
                T2(2,1) = 'g4';
                T2(2,2) = '((beta2^2)/2)';
                T2(3,1) = 'g5';
                T2(3,2) = '(((2*gamma2*beta2)/2) + (beta2/2))';
                T2(4,1) = 's';
                T2(4,2) = '(((gamma2^2)/2) + (gamma2/2))'; 
            elseif (femaleG4count == 1) && (femaleScount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1-(1-alpha2)^2)/2)';
                T2(2,1) = 'g4';
                T2(2,2) = '((beta2^2)/2)';
                T2(3,1) = 'g5';
                T2(3,2) = '((2*gamma2*beta2)/2)';
                T2(4,1) = 's';
                T2(4,2) = '((1+gamma2^2)/2)';
            elseif (femaleG4count == 1) && (femaleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '((((1-(1-alpha2)^2)) + ((1-alpha2)^2)*(1-q2))/2)';
                T2(2,1) = 'v';
                T2(2,2) = '((1-(1-alpha2)^2)/2)';
                T2(3,1) = 'u';
                T2(3,2) = '(((1-alpha2)^2)*q2*(1-P2)*delta2/2)';
                T2(4,1) = 'r';
                T2(4,2) = '(((1-alpha2)^2)*q2*(1-P2)*(1-delta2)/2)';
                T2(5,1) = 'g4';
                T2(5,2) = '(((1+P2*q2))*((beta2^2)/2))';
                T2(6,1) = 'g5';
                T2(6,2) = '((((1+P2*q2))*(2*gamma2*beta2)/2))';
                T2(7,1) = 's';
                T2(7,2) = '(((1+P2*q2)*(gamma2^2))/2)';         
            elseif (femaleG4count == 1) && (femaleVcount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1+(1-(1-alpha2)^2))/2)';
                T2(2,1) = 'g4';
                T2(2,2) = '((beta2^2)/2)';
                T2(3,1) = 'g5';
                T2(3,2) = '((2*gamma2*beta2)/2)';
                T2(4,1) = 's';
                T2(4,2) = '((gamma2^2)/2)';
            elseif (femaleG4count == 1) && (femaleUcount == 1)
                T2(1,1) = 'u';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g4';
                T2(2,2) = '((beta2^2)/2)';
                T2(3,1) = 'g5';
                T2(3,2) = '((2*gamma2*beta2)/2)';
                T2(4,1) = 's';
                T2(4,2) = '((gamma2^2)/2)';
                T2(5,1) = 'v';
                T2(5,2) = '((1-(1-alpha2)^2)/2)';
            elseif (femaleG4count == 1) && (femaleRcount == 1)
                T2(1,1) = 'r';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g4';
                T2(2,2) = '((beta2^2)/2)';
                T2(3,1) = 'g5';
                T2(3,2) = '((2*gamma2*beta2)/2)';
                T2(4,1) = 's';
                T2(4,2) = '((gamma2^2)/2)';
                T2(5,1) = 'v';
                T2(5,2) = '((1-(1-alpha2)^2)/2)';
            elseif femaleG5count == 2
                T2(1,1) = 'v';
                T2(1,2) = '(alpha2)';
                T2(2,1) = 'g5';
                T2(2,2) = '(beta2)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma2)';
            elseif (femaleG5count == 1) && (femaleScount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(alpha2/2)';
                T2(2,1) = 'g5';
                T2(2,2) = '(beta2/2)';
                T2(3,1) = 's';
                T2(3,2) = '((1+gamma2)/2)';
            elseif (femaleG5count == 1) && (femaleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '((alpha2/2) + (((1-alpha2))*(1-q2)/2))';
                T2(2,1) = 'v';
                T2(2,2) = '(alpha2/2)';
                T2(3,1) = 'u';
                T2(3,2) = '((1-alpha2)*q2*(1-P2)*delta2/2)';
                T2(4,1) = 'r';
                T2(4,2) = '((1-alpha2)*q2*(1-P2)*(1-delta2)/2)';
                T2(5,1) = 'g5';
                T2(5,2) = '(((1+P2*q2))*beta2/2)';
                T2(6,1) = 's';
                T2(6,2) = '(((1+P2*q2))*gamma2/2)';
            elseif (femaleG5count == 1) && (femaleVcount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '((1+alpha2)/2)';
                T2(2,1) = 'g5';
                T2(2,2) = '(beta2/2)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma2/2)';
            elseif (femaleG5count == 1) && (femaleUcount == 1)
                T2(1,1) = 'u';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g5';
                T2(2,2) = '(beta2/2)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma2/2)';
                T2(4,1) = 'v';
                T2(4,2) = '(alpha2/2)';
            elseif (femaleG5count == 1) && (femaleRcount == 1)
                T2(1,1) = 'r';
                T2(1,2) = '(1/2)';
                T2(2,1) = 'g5';
                T2(2,2) = '(beta2/2)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma2/2)';
                T2(4,1) = 'v';
                T2(4,2) = '(alpha2/2)';
            elseif (femaleScount == 1) && (femaleWcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '((1-q2)/2)';
                T2(2,1) = 'u';
                T2(2,2) = '(q2*(1-P2)*delta2/2)';
                T2(3,1) = 'r';
                T2(3,2) = '(q2*(1-P2)*(1-delta2)/2)';
                T2(4,1) = 's';
                T2(4,2) = '((1+P2*q2)/2)';
            else
                T2(1,1) = T0(j,2); % initial reference
                T2(1,2) = '(1/2)';
                T2(2,1) = T0(j,3); % initial reference
                T2(2,2) = '(1/2)';
            end  

            T3 = strings(10,10,2);
            for a = 1:10
                for b = 1:10
                    if (T1(a,1) ~= "") && (T2(b,1) ~= "")
                        T3(a,b,1) = strcat(T1(a,1),T2(b,1));
                        T3(a,b,2) = strcat('(',T1(a,2),'*',T2(b,2),')');
        
                        % RENAMING CREATED GENOTYPE

                        w = count(T3(a,b,1),"w");
                        v = count(T3(a,b,1),"v");
                        u = count(T3(a,b,1),"u");
                        r = count(T3(a,b,1),"r");
                        g1 = count(T3(a,b,1),"g1");
                        g2 = count(T3(a,b,1),"g2");
                        g3 = count(T3(a,b,1),"g3");
                        g4 = count(T3(a,b,1),"g4");
                        g5 = count(T3(a,b,1),"g5");
                        s = count(T3(a,b,1),"s");

                        if (w == 2)
                            T3(a,b,1) = 'ww';
                        elseif (w == 1) && (v == 1)
                            T3(a,b,1) = 'wv';
                        elseif (w == 1) && (u == 1)
                            T3(a,b,1) = 'wu';
                        elseif (w == 1) && (r == 1)
                            T3(a,b,1) = 'wr';
                        elseif (w == 1) && (g1 == 1)
                            T3(a,b,1) = 'wg1';
                        elseif (w == 1) && (g2 == 1)
                            T3(a,b,1) = 'wg2';
                        elseif (w == 1) && (g3 == 1)
                            T3(a,b,1) = 'wg3';
                        elseif (w == 1) && (g4 == 1)
                            T3(a,b,1) = 'wg4';
                        elseif (w == 1) && (g5 == 1)
                            T3(a,b,1) = 'wg5';
                        elseif (w == 1) && (s == 1)
                            T3(a,b,1) = 'ws';
                        elseif (v == 2)
                            T3(a,b,1) = 'vv';
                        elseif (v == 1) && (u == 1)
                            T3(a,b,1) = 'vu';
                        elseif (v == 1) && (r == 1)
                            T3(a,b,1) = 'vr';
                        elseif (v == 1) && (g1 == 1)
                            T3(a,b,1) = 'vg1';
                        elseif (v == 1) && (g2 == 1)
                            T3(a,b,1) = 'vg2';
                        elseif (v == 1) && (g3 == 1) 
                            T3(a,b,1) = 'vg3';
                        elseif (v == 1) && (g4 == 1)
                            T3(a,b,1) = 'vg4';
                        elseif (v == 1) && (g5 == 1)
                            T3(a,b,1) = 'vg5';
                        elseif (v == 1) && (s == 1)
                            T3(a,b,1) = 'vs';
                        elseif (u == 2)
                            T3(a,b,1) = 'uu';
                        elseif (u == 1) && (r == 1)
                            T3(a,b,1) = 'ur';
                        elseif (u == 1) && (g1 == 1)
                            T3(a,b,1) = 'ug1';
                        elseif (u == 1) && (g2 == 1)
                            T3(a,b,1) = 'ug2';
                        elseif (u == 1) && (g3 == 1) 
                            T3(a,b,1) = 'ug3';
                        elseif (u == 1) && (g4 == 1)
                            T3(a,b,1) = 'ug4';
                        elseif (u == 1) && (g5 == 1)
                            T3(a,b,1) = 'ug5';
                        elseif (u == 1) && (s == 1)
                            T3(a,b,1) = 'us';  
                        elseif (r == 2)
                            T3(a,b,1) = 'rr';
                        elseif (r == 1) && (g1 == 1)
                            T3(a,b,1) = 'rg1';
                        elseif (r == 1) && (g2 == 1)
                            T3(a,b,1) = 'rg2';
                        elseif (r == 1) && (g3 == 1) 
                            T3(a,b,1) = 'rg3';
                        elseif (r == 1) && (g4 == 1)
                            T3(a,b,1) = 'rg4';
                        elseif (r == 1) && (g5 == 1)
                            T3(a,b,1) = 'rg5';
                        elseif (r == 1) && (s == 1)
                            T3(a,b,1) = 'rs';   
                        elseif (g1 == 2)
                            T3(a,b,1) = 'g1g1';
                        elseif (g1 == 1) && (g2 == 1)
                            T3(a,b,1) = 'g1g2';
                        elseif (g1 == 1) && (g3 == 1)
                            T3(a,b,1) = 'g1g3';
                        elseif (g1 == 1) && (g4 == 1)
                            T3(a,b,1) = 'g1g4';
                        elseif (g1 == 1) && (g5 == 1)
                            T3(a,b,1) = 'g1g5';
                        elseif (g1 == 1) && (s == 1)
                            T3(a,b,1) = 'g1s';
                        elseif (g2 == 2)
                            T3(a,b,1) = 'g2g2';
                        elseif (g2 == 1) && (g3 == 1)
                            T3(a,b,1) = 'g2g3';
                        elseif (g2 == 1) && (g4 == 1)
                            T3(a,b,1) = 'g2g4';
                        elseif (g2 == 1) && (g5 == 1)
                            T3(a,b,1) = 'g2g5';
                        elseif (g2 == 1) && (s == 1)
                            T3(a,b,1) = 'g2s';
                        elseif (g3 == 2)
                            T3(a,b,1) = 'g3g3';
                        elseif (g3 == 1) && (g4 == 1)
                            T3(a,b,1) = 'g3g4';
                        elseif (g3 == 1) && (g5 == 1)
                            T3(a,b,1) = 'g3g5';
                        elseif (g3 == 1) && (s == 1)
                            T3(a,b,1) = 'g3s';
                        elseif (g4 == 2)
                            T3(a,b,1) = 'g4g4';
                        elseif (g4 == 1) && (g5 == 1)
                            T3(a,b,1) = 'g4g5';
                        elseif (g4 == 1) && (s == 1)
                            T3(a,b,1) = 'g4s';
                        elseif (g5 == 2)
                            T3(a,b,1) = 'g5g5';
                        elseif (g5 == 1) && (s == 1)
                            T3(a,b,1) = 'g5s';
                        elseif (s == 2)
                            T3(a,b,1) = 'ss';
                        else
                            ERROR = 1;
                        end
                    
                        % COMPILES PROBABILITIES   
                        if strcmp(geneMake, T3(a,b,1)) == 1
                            if Table1(i,j,k) == ""
                                Table1(i,j,k) = T3(a,b,2);
                            else
                                storeSTR = Table1(i,j,k);
                                Table1(i,j,k) = strcat(storeSTR, '+', T3(a,b,2));
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
syms alpha1 alpha2 beta1 beta2 gamma1 gamma2 delta1 delta2 P1 P2 q1 q2
for k=1:55
    for i=4:58                              
        for j=4:58
            oldVal = Table1(i,j,k);
            
            if oldVal ~= ''
                new1 = str2sym(oldVal);
                new2 = char(new1);
                Table1(i,j,k) = strcat('(', new2, ')');
            end
        end
    end
end

%GENERATE THE EQUATION
gprime = strings(55);
 for k=1:55
    for i=4:58
        for j=4:58                                                           
            if Table1(i,j,k) ~= ''
                if gprime(k) == ''
                    gprime(k) = strcat(T0(1,j), '*', Table1(i,j,k), '*', T0(i,1));
                else
                    gStore = gprime(k);
                    gprime(k) = strcat(gStore, '+', T0(1,j), '*', Table1(i,j,k), '*', T0(i,1));
                end
            end
        end
    end
 end

% Clears previous text file if available
if exist('CRISPR1-5 Generated Equations.txt', 'file')==2      
  delete('CRISPR1-5 Generated Equations.txt');
end

% Outputs the equations in the form to be used in the models
diary('CRISPR1-5 Generated Equations.txt');
for i=1:2
    for k=1:55
        if i == 1
            disp(strcat('gprime(', num2str(k,'%d'), ') = (1-fitCost(', num2str(k,'%d'), '))*(1-sigma)*lambda*(', gprime(k), ');'))
        else
            disp(strcat('gprime(', num2str(k+55,'%d'), ') = (1-fitCost(', num2str(k+55,'%d'), '))*(sigma)*lambda*(', gprime(k), ');'))
        end
    end
end
diary off
 
 