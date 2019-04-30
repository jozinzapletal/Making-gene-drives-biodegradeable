clear
clc

T0 = strings(24,24);              %stores the basics combinations and genotype references   
T1 = strings(24,24,21);            %stores for each genotype and iteration

% Populates the first gene string with a number
a = 6; b = 6; c = 0;
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
a = 6; b = 6; c = 0;
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
for i=1:24
    for j=1:24
        s1 = T0(i,j);

        if strcmp(s1, '6') == 1
            T0(i,j) = 'w';
        end
        if strcmp(s1, '5') == 1
            T0(i,j) = 'v';
        end
        if strcmp(s1, '4') == 1
            T0(i,j) = 'u';
        end
        if strcmp(s1, '3') == 1
            T0(i,j) = 'r';
        end
        if strcmp(s1, '2') == 1
            T0(i,j) = 'g';
        end
        if strcmp(s1, '1') == 1
            T0(i,j) = 's';
        end
    end
end

% Populates the J() equation form
for i=1:21
    T0(1,i+3) = strcat('J(', num2str(i,'%d'), ')');
    T0(i+3,1) = strcat('J(', num2str(i+21,'%d'), ')');
end

% START GENERATION OF PROBABLITIES & GENOTYPES
for k=1:21
    for i=4:24
        for j=4:24
        
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
                geneMake = 'wg';
            elseif k == 6
                geneMake = 'ws';
            elseif k == 7
                geneMake = 'vv';
            elseif k == 8
                geneMake = 'vu';
            elseif k == 9
                geneMake = 'vr';
            elseif k == 10
                geneMake = 'vg';
            elseif k == 11
                geneMake = 'vs';
            elseif k == 12
                geneMake = 'uu';
            elseif k == 13
                geneMake = 'ur';
            elseif k == 14
                geneMake = 'ug';
            elseif k == 15
                geneMake = 'us';
            elseif k == 16
                geneMake = 'rr';
            elseif k == 17
                geneMake = 'rg';
            elseif k == 18
                geneMake = 'rs';
            elseif k == 19
                geneMake = 'gg';
            elseif k == 20
                geneMake = 'gs';
            elseif k == 21
                geneMake = 'ss';
            end
                      
            geneMALE = strcat(T0(2,i),T0(3,i));
            geneFEMALE = strcat(T0(j,2),T0(j,3));
                
            maleWcount = count(geneMALE, "w");
            maleVcount = count(geneMALE, "v");
            maleUcount = count(geneMALE, "u");
            maleRcount = count(geneMALE, "r");
            maleGcount = count(geneMALE, "g");
            maleScount = count(geneMALE, "s");
            
            femaleWcount = count(geneFEMALE, "w");
            femaleVcount = count(geneFEMALE, "v");
            femaleUcount = count(geneFEMALE, "u");
            femaleRcount = count(geneFEMALE, "r");
            femaleGcount = count(geneFEMALE, "g");
            femaleScount = count(geneFEMALE, "s");    
            
            % MALE PARENT
            			T2 = strings(6,2);
            if (maleWcount == 1) && (maleGcount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '((alpha1 + ((beta1+gamma1)*(1-q1)))/2)';
                T2(2,1) = 'v';
                T2(2,2) = '(alpha1/2)';
                T2(3,1) = 'u';
                T2(3,2) = '((delta1*(1-P1)*q1*(beta1+gamma1))/2)';
                T2(4,1) = 'r';
                T2(4,2) = '(((1-delta1)*(1-P1)*q1*(beta1+gamma1))/2)';
                T2(5,1) = 'g';
                T2(5,2) = '((beta1*(1+q1*P1))/2)';
                T2(6,1) = 's';
                T2(6,2) = '((gamma1*(1+q1*P1))/2)';
            elseif (maleWcount == 1) &&  (maleScount == 1)
                T2(1,1) = 'w';
                T2(1,2) = '((1-q1)/2)';
                T2(2,1) = 'u';
                T2(2,2) = '((q1*(1-P1)*delta1)/2)';
                T2(3,1) = 'r';
                T2(3,2) = '((q1*(1-P1)*(1-delta1))/2)';
                T2(4,1) = 's';
                T2(4,2) = '((1+q1*P1)/2)';
            elseif (maleVcount == 1) &&  (maleGcount == 1) 
                T2(1,1) = 'v';
                T2(1,2) = '((alpha1+1)/2)';
                T2(2,1) = 'g';
                T2(2,2) = '(beta1/2)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma1/2)';
            elseif (maleUcount == 1) &&  (maleGcount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'u';
                T2(2,2) = '(1/2)';
                T2(3,1) = 'g';
                T2(3,2) = '(beta1/2)';
                T2(4,1) = 's';
                T2(4,2) = '(gamma1/2)';
            elseif (maleRcount == 1) &&  (maleGcount == 1)
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'r';
                T2(2,2) = '(1/2)';
                T2(3,1) = 'g';
                T2(3,2) = '(beta1/2)';
                T2(4,1) = 's';
                T2(4,2) = '(gamma1/2)';    
            elseif (maleGcount == 1) &&  (maleScount == 1) 
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1/2)';
                T2(2,1) = 'g';
                T2(2,2) = '(beta1/2)';
                T2(3,1) = 's';
                T2(3,2) = '((gamma1+1)/2)';        
            elseif maleGcount == 2
                T2(1,1) = 'v';
                T2(1,2) = '(alpha1)';
                T2(2,1) = 'g';
                T2(2,2) = '(beta1)';
                T2(3,1) = 's';
                T2(3,2) = '(gamma1)'; 
            else
                T2(1,1) = T0(2,i); % initial reference
                T2(1,2) = '(1/2)';
                T2(2,1) = T0(3,i); % initial reference
                T2(2,2) = '(1/2)';
            end

            % FEMALE PARENT
            T3 = strings(6,2);
            if (femaleWcount == 1) && (femaleGcount == 1)
                T3(1,1) = 'w';
                T3(1,2) = '((alpha1 + ((beta1+gamma1)*(1-q1)))/2)';
                T3(2,1) = 'v';
                T3(2,2) = '(alpha1/2)';
                T3(3,1) = 'u';
                T3(3,2) = '((delta1*(1-P1)*q1*(beta1+gamma1))/2)';
                T3(4,1) = 'r';
                T3(4,2) = '(((1-delta1)*(1-P1)*q1*(beta1+gamma1))/2)';
                T3(5,1) = 'g';
                T3(5,2) = '((beta1*(1+q1*P1))/2)';
                T3(6,1) = 's';
                T3(6,2) = '((gamma1*(1+q1*P1))/2)';
            elseif (femaleWcount == 1) &&  (femaleScount == 1)
                T3(1,1) = 'w';
                T3(1,2) = '((1-q1)/2)';
                T3(2,1) = 'u';
                T3(2,2) = '((q1*(1-P1)*delta1)/2)';
                T3(3,1) = 'r';
                T3(3,2) = '((q1*(1-P1)*(1-delta1))/2)';
                T3(4,1) = 's';
                T3(4,2) = '((1+q1*P1)/2)';
            elseif (femaleVcount == 1) &&  (femaleGcount == 1) 
                T3(1,1) = 'v';
                T3(1,2) = '((alpha2+1)/2)';
                T3(2,1) = 'g';
                T3(2,2) = '(beta2/2)';
                T3(3,1) = 's';
                T3(3,2) = '(gamma2/2)';
            elseif (femaleUcount == 1) &&  (femaleGcount == 1)
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2/2)';
                T3(2,1) = 'u';
                T3(2,2) = '(1/2)';
                T3(3,1) = 'g';
                T3(3,2) = '(beta2/2)';
                T3(4,1) = 's';
                T3(4,2) = '(gamma2/2)';
            elseif (femaleRcount == 1) &&  (femaleGcount == 1)
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2/2)';
                T3(2,1) = 'r';
                T3(2,2) = '(1/2)';
                T3(3,1) = 'g';
                T3(3,2) = '(beta2/2)';
                T3(4,1) = 's';
                T3(4,2) = '(gamma2/2)';    
            elseif (femaleGcount == 1) &&  (femaleScount == 1) 
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2/2)';
                T3(2,1) = 'g';
                T3(2,2) = '(beta2/2)';
                T3(3,1) = 's';
                T3(3,2) = '((gamma2+1)/2)';        
            elseif femaleGcount == 2
                T3(1,1) = 'v';
                T3(1,2) = '(alpha2)';
                T3(2,1) = 'g';
                T3(2,2) = '(beta2)';
                T3(3,1) = 's';
                T3(3,2) = '(gamma2)'; 
            else
                T3(1,1) = T0(j,2); % initial reference
                T3(1,2) = '(1/2)';
                T3(2,1) = T0(j,3); % initial reference
                T3(2,2) = '(1/2)';
            end
            
            T4 = strings(6,6,2);
            for a = 1:6
                for b = 1:6
                    if (T2(a,1) ~= "") && (T3(b,1) ~= "")
                        T4(a,b,1) = strcat(T2(a,1),T3(b,1));
                        T4(a,b,2) = strcat(T2(a,2),'*',T3(b,2));
                
                        % RENAMING CREATED GENOTYPE

                        w = count(T4(a,b,1),"w");
                        v = count(T4(a,b,1),"v");
                        g = count(T4(a,b,1),"g");
                        s = count(T4(a,b,1),"s");
                        r = count(T4(a,b,1),"r");
                        u = count(T4(a,b,1),"u");
                        
                        if (w == 2)             
                            T4(a,b,1) = 'ww';
                        elseif (w == 1) && (v == 1)
                            T4(a,b,1) = 'wv';
                        elseif (w == 1) && (u == 1)
                            T4(a,b,1) = 'wu';
                        elseif (w == 1) && (r == 1)
                            T4(a,b,1) = 'wr';
                        elseif (w == 1) && (g == 1)
                            T4(a,b,1) = 'wg';
                        elseif (w == 1) && (s == 1)
                            T4(a,b,1) = 'ws';
                        elseif (v == 2)
                            T4(a,b,1) = 'vv';
                        elseif (v == 1) && (u == 1)
                            T4(a,b,1) = 'vu';
                        elseif (v == 1) && (r == 1)
                            T4(a,b,1) = 'vr';
                        elseif (v == 1) && (g == 1)
                            T4(a,b,1) = 'vg';
                        elseif (v == 1) && (s == 1)
                            T4(a,b,1) = 'vs';
                        elseif (u == 2)
                            T4(a,b,1) = 'uu';
                        elseif (u == 1) && (r == 1)
                            T4(a,b,1) = 'ur';
                        elseif (u == 1) && (g == 1)
                            T4(a,b,1) = 'ug';
                        elseif (u == 1) && (s == 1)
                            T4(a,b,1) = 'us';
                        elseif (r == 2)
                            T4(a,b,1) = 'rr';
                        elseif (r == 1) && (g == 1)
                            T4(a,b,1) = 'rg';
                        elseif (r == 1) && (s == 1)
                            T4(a,b,1) = 'rs';
                        elseif (g == 2)
                            T4(a,b,1) = 'gg';
                        elseif (g == 1) && (s == 1)
                            T4(a,b,1) = 'gs';
                        elseif (s == 2)
                            T4(a,b,1) = 'ss';
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
end
   
 % SIMPLIFIES THE PROBABILITIES
syms alpha1 alpha2 beta1 beta2 gamma1 gamma2 delta1 delta2 P1 P2 q1 q2
for k=1:21
    for i=4:24
        for j=4:24
            oldVal = T1(i,j,k);
            
            if oldVal ~= ''
                new1 = str2sym(oldVal);
                new2 = char(new1);
                T1(i,j,k) = strcat('(', new2, ')');
            end
        end
    end
end

% GENERATE THE EQUATION
gprime = strings(21);
for k=1:21
    for i=4:24
        for j=4:24                                                           
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
if exist('CRISPR1-1 Generated Equations.txt', 'file')==2      
  delete('CRISPR1-1 Generated Equations.txt');
end

% Outputs the equations in the form to be used in the models
diary('CRISPR1-1 Generated Equations.txt');
for i=1:2
    for k=1:21
        if i == 1
            disp(strcat('gprime(', num2str(k,'%d'), ') = (1-fitCost(', num2str(k,'%d'), '))*(sigma)*lambda*(', gprime(k), ');'))
        else
            disp(strcat('gprime(', num2str(k+21,'%d'), ') = (1-fitCost(', num2str(k+21,'%d'), '))*(1-sigma)*lambda*(', gprime(k), ');'))
        end
    end
end
diary off

