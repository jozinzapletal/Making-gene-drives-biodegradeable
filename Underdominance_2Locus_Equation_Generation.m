clear
clc

T0 = strings(41,41);       %stores the basics combinations and genotype references   
T1 = strings(41,41,36,5);  %stores for each genotype and iteration

% Populates the first gene string with a number
sum = 0;
for b = 3:-1:1
    for c = 1:b
        for a = 1:6
            T0(sum+6,2) = b;
            T0(2,sum+6) = b;
            sum = sum + 1;
        end
    end
end

% Populates the second gene string with a number
sum = 0;
for c = 3:-1:1
    for b = c:-1:1
        for a = 1:6
            T0(sum+6,3) = b;
            T0(3,sum+6) = b;
            sum = sum + 1;
        end
    end
end

% Changes numbers to correspond to letters
for i=1:41
    for j=1:41
        s1 = T0(i,j);
        if strcmp(s1, '3') == 1
            T0(i,j) = 'w';
        end
        if strcmp(s1, '2') == 1
            T0(i,j) = 'gA';
        end
        if strcmp(s1, '1') == 1
            T0(i,j) = 'sA';
        end
    end
end

% Populates the third gene string with a number
sum = 0;
for a = 1:6
    for b = 3:-1:1
        for c = 1:b
            T0(sum+6,4) = b;
            T0(4,sum+6) = b;
            sum = sum + 1;
        end
    end
end

% Populates the fourth gene string with a number
sum = 0;
for a = 1:6
    for c = 3:-1:1
        for b = c:-1:1
            T0(sum+6,5) = b;
            T0(5,sum+6) = b;
            sum = sum + 1;
        end
    end
end


% Changes numbers to correspond to letters
for i=1:41
    for j=1:41
        s1 = T0(i,j);
        if strcmp(s1, '3') == 1
            T0(i,j) = 'w';
        end
        if strcmp(s1, '2') == 1
            T0(i,j) = 'gB';
        end
        if strcmp(s1, '1') == 1
            T0(i,j) = 'sB';
        end
    end
end

% Populates the J() equation form
for i=1:36
    T0(1,i+5) = strcat('J(', num2str(i,'%d'), ')');
    T0(i+5,1) = strcat('J(', num2str(i+36,'%d'), ')');
end

% START GENERATION OF PROBABLITIES & GENOTYPES
for k=1:36
    for i=6:41
        for j=6:41
            % IDENTIFY WHICH GENOTYPE TO MAKE
                    
            geneMake = '';
            if k == 1
                geneMake = 'wwww';
            elseif k == 2
                geneMake = 'wwwgB';
            elseif k == 3
                geneMake = 'wwwsB';
            elseif k == 4
                geneMake = 'wwgBgB';
            elseif k == 5
                geneMake = 'wwgBsB';
            elseif k == 6
                geneMake = 'wwsBsB';
            elseif k == 7
                geneMake = 'wgAww';
            elseif k == 8
                geneMake = 'wgAwgB';
            elseif k == 9
                geneMake = 'wgAwsB';
            elseif k == 10
                geneMake = 'wgAgBgB';
            elseif k == 11
                geneMake = 'wgAgBsB';
            elseif k == 12
                geneMake = 'wgAsBsB';
            elseif k == 13
                geneMake = 'wsAww';
            elseif k == 14
                geneMake = 'wsAwgB';
            elseif k == 15
                geneMake = 'wsAwsB';
            elseif k == 16
                geneMake = 'wsAgBgB';
            elseif k == 17
                geneMake = 'wsAgBsB';
            elseif k == 18
                geneMake = 'wsAsBsB';
            elseif k == 19
                geneMake = 'gAgAww';
            elseif k == 20
                geneMake = 'gAgAwgB';
            elseif k == 21
                geneMake = 'gAgAwsB';
            elseif k == 22
                geneMake = 'gAgAgBgB';
            elseif k == 23
                geneMake = 'gAgAgBsB';
            elseif k == 24
                geneMake = 'gAgAsBsB';
            elseif k == 25
                geneMake = 'gAsAww';
            elseif k == 26
                geneMake = 'gAsAwgB';
            elseif k == 27
                geneMake = 'gAsAwsB';
            elseif k == 28
                geneMake = 'gAsAgBgB';
            elseif k == 29
                geneMake = 'gAsAgBsB';
            elseif k == 30
                geneMake = 'gAsAsBsB';
            elseif k == 31
                geneMake = 'sAsAww';
            elseif k == 32
                geneMake = 'sAsAwgB';
            elseif k == 33
                geneMake = 'sAsAwsB';
            elseif k == 34
                geneMake = 'sAsAgBgB';
            elseif k == 35
                geneMake = 'sAsAgBsB';
            elseif k == 36
                geneMake = 'sAsAsBsB';
            end
            
            femaleGene = strcat(T0(2,j),T0(3,j),T0(4,j),T0(5,j));
            
            if count(femaleGene, "A") >= 1
                femalePoisonA = true;
            else
                femalePoisonA = false;
            end 
            
            if count(femaleGene, "B") >= 1
                femalePoisonB = true;
            else
                femalePoisonB = false;
            end
                   
            for l=1:4
                gene1 = '';
                gene2 = '';
                gene3 = '';
                gene4 = '';
                newGene1 = '';
                newGene2 = '';

                if l==1
                    gene1 = T0(2,j);
                    gene2 = T0(4,j);
                    gene3 = T0(i,2);
                    gene4 = T0(i,4);
                    newGene1 = strcat(gene1,gene3);
                    newGene2 = strcat(gene2,gene4);
                elseif l==2
                    gene1 = T0(3,j);
                    gene2 = T0(5,j);
                    gene3 = T0(i,2);
                    gene4 = T0(i,4);
                    newGene1 = strcat(gene1,gene3);
                    newGene2 = strcat(gene2,gene4);
                elseif l==3
                    gene1 = T0(2,j);
                    gene2 = T0(4,j);
                    gene3 = T0(i,3);
                    gene4 = T0(i,5);
                    newGene1 = strcat(gene1,gene3);
                    newGene2 = strcat(gene2,gene4);
                elseif l==4
                    gene1 = T0(3,j);
                    gene2 = T0(5,j);
                    gene3 = T0(i,3);
                    gene4 = T0(i,5);
                    newGene1 = strcat(gene1,gene3);
                    newGene2 = strcat(gene2,gene4);
                end

                %Make separte matrices for each probability and begin
                %probability generation

                g1TotCount = count(newGene1,"g");
                g2TotCount = count(newGene2,"g");
                gene1Gcount = count(gene1,"g");
                gene2Gcount = count(gene2,"g");
                gene3Gcount = count(gene3,"g");
                gene4Gcount = count(gene4,"g");
                
                T2 = strings(9,2);
                if g1TotCount == 0
                    T2(1,1) = newGene1;
                    T2(1,2) = '(1/4)';
                elseif g1TotCount == 1
                    if gene1Gcount == 1
                        T2(1,1) = strcat('w', gene3);
                        T2(1,2) = '(alpha/4)';
                        T2(2,1) = strcat('gA',gene3);
                        T2(2,2) = '(beta/4)';
                        T2(3,1) = strcat('sA',gene3);
                        T2(3,2) = '(gamma/4)';
                    elseif gene3Gcount == 1
                        T2(1,1) = strcat('w', gene1);
                        T2(1,2) = '(alpha/4)';
                        T2(2,1) = strcat('gA',gene1);
                        T2(2,2) = '(beta/4)';
                        T2(3,1) = strcat('sA',gene1);
                        T2(3,2) = '(gamma/4)';
                    end
                elseif g1TotCount == 2
                    T2(1,1) = 'ww';
                    T2(1,2) = '(alpha^2/4)';
                    T2(2,1) = 'wgA';
                    T2(2,2) = '(alpha*beta/4)';
                    T2(3,1) = 'wsA';
                    T2(3,2) = '(alpha*gamma/4)';
                    T2(4,1) = 'wgA';
                    T2(4,2) = '(beta*alpha/4)';
                    T2(5,1) = 'gAgA';
                    T2(5,2) = '(beta^2/4)';
                    T2(6,1) = 'gAsA';
                    T2(6,2) = '(beta*gamma/4)';
                    T2(7,1) = 'wsA';
                    T2(7,2) = '(gamma*alpha/4)';
                    T2(8,1) = 'gAsA';
                    T2(8,2) = '(gamma*beta/4)';
                    T2(9,1) = 'sAsA';
                    T2(9,2) = '(gamma^2/4)';  
                end
                
                T3 = strings(9,2);
                if g2TotCount == 0
                    T3(1,1) = newGene2;
                    T3(1,2) = '(1/4)';
                elseif g2TotCount == 1
                    if gene2Gcount == 1
                        T3(1,1) = strcat('w', gene4);
                        T3(1,2) = '(alpha/4)';
                        T3(2,1) = strcat('gB',gene4);
                        T3(2,2) = '(beta/4)';
                        T3(3,1) = strcat('sB',gene4);
                        T3(3,2) = '(gamma/4)';
                    elseif gene4Gcount == 1
                        T3(1,1) = strcat('w', gene2);
                        T3(1,2) = '(alpha/4)';
                        T3(2,1) = strcat('gB',gene2);
                        T3(2,2) = '(beta/4)';
                        T3(3,1) = strcat('sB',gene2);
                        T3(3,2) = '(gamma/4)';
                    end
                elseif g2TotCount == 2
                    T3(1,1) = 'ww';
                    T3(1,2) = '(alpha^2/4)';
                    T3(2,1) = 'wgB';
                    T3(2,2) = '(alpha*beta/4)';
                    T3(3,1) = 'wsB';
                    T3(3,2) = '(alpha*gamma/4)';
                    T3(4,1) = 'wgB';
                    T3(4,2) = '(beta*alpha/4)';
                    T3(5,1) = 'gBgB';
                    T3(5,2) = '(beta^2/4)';
                    T3(6,1) = 'gBsB';
                    T3(6,2) = '(beta*gamma/4)';
                    T3(7,1) = 'wsB';
                    T3(7,2) = '(gamma*alpha/4)';
                    T3(8,1) = 'gBsB';
                    T3(8,2) = '(gamma*beta/4)';
                    T3(9,1) = 'sBsB';
                    T3(9,2) = '(gamma^2/4)';  
                end
                
                Tf = strings(9,9,2);
                for a=1:9
                    for b=1:9
                        if (T2(a,1) ~= "" && T3(b,1) ~= "")
                            Tf(a,b,1) = strcat(T2(a,1),T3(b,1));
                            Tf(a,b,2) = strcat('(',T2(a,2),'*',T3(b,2),')');
                            
                            w1 = count(T2(a,1),"w");
                            w2 = count(T3(b,1),"w");
                            gA = count(T2(a,1),"gA");
                            gB = count(T3(b,1),"gB");
                            sA = count(T2(a,1),"sA");
                            sB = count(T3(b,1),"sB");
                            A = count(T2(a,1),"A");
                            B = count(T3(b,1),"B");
                        
                            % determines the gene that is formed otherwise for renaming purposes
                
                            if w1 == 2
                                if w2 == 2
                                    Tf(a,b,1) = 'wwww';
                                elseif w2 == 1 && gB == 1
                                    Tf(a,b,1) = 'wwwgB';
                                elseif w2 == 1 && sB == 1
                                    Tf(a,b,1) = 'wwwsB';
                                elseif gB == 2
                                    Tf(a,b,1) = 'wwgBgB';
                                elseif gB == 1 && sB == 1
                                    Tf(a,b,1) = 'wwgBsB';
                                elseif sB == 2
                                    Tf(a,b,1) = 'wwsBsB';
                                end
                            elseif w1 == 1 && gA == 1
                                if w2 == 2
                                    Tf(a,b,1) = 'wgAww';
                                elseif w2 == 1 && gB == 1
                                    Tf(a,b,1) = 'wgAwgB';
                                elseif w2 == 1 && sB == 1
                                    Tf(a,b,1) = 'wgAwsB';
                                elseif gB == 2
                                    Tf(a,b,1) = 'wgAgBgB';
                                elseif gB == 1 && sB == 1
                                    Tf(a,b,1) = 'wgAgBsB';
                                elseif sB == 2
                                    Tf(a,b,1) = 'wgAsBsB';
                                end
                            elseif w1 == 1 && sA == 1
                                if w2 == 2
                                    Tf(a,b,1) = 'wsAww';
                                elseif w2 == 1 && gB == 1
                                    Tf(a,b,1) = 'wsAwgB';
                                elseif w2 == 1 && sB == 1
                                    Tf(a,b,1) = 'wsAwsB';
                                elseif gB == 2
                                    Tf(a,b,1) = 'wsAgBgB';
                                elseif gB == 1 && sB == 1
                                    Tf(a,b,1) = 'wsAgBsB';
                                elseif sB == 2
                                    Tf(a,b,1) = 'wsAsBsB';
                                end
                            elseif gA == 2
                                if w2 == 2
                                    Tf(a,b,1) = 'gAgAww';
                                elseif w2 == 1 && gB == 1
                                    Tf(a,b,1) = 'gAgAwgB';
                                elseif w2 == 1 && sB == 1
                                    Tf(a,b,1) = 'gAgAwsB';
                                elseif gB == 2
                                    Tf(a,b,1) = 'gAgAgBgB';
                                elseif gB == 1 && sB == 1
                                    Tf(a,b,1) = 'gAgAgBsB';
                                elseif sB == 2
                                    Tf(a,b,1) = 'gAgAsBsB';
                                end
                            elseif gA == 1 && sA == 1
                                if w2 == 2
                                    Tf(a,b,1) = 'gAsAww';
                                elseif w2 == 1 && gB == 1
                                    Tf(a,b,1) = 'gAsAwgB';
                                elseif w2 == 1 && sB == 1
                                    Tf(a,b,1) = 'gAsAwsB';
                                elseif gB == 2
                                    Tf(a,b,1) = 'gAsAgBgB';
                                elseif gB == 1 && sB == 1
                                    Tf(a,b,1) = 'gAsAgBsB';
                                elseif sB == 2
                                    Tf(a,b,1) = 'gAsAsBsB';
                                end
                            elseif sA == 2
                                if w2 == 2
                                    Tf(a,b,1) = 'sAsAww';
                                elseif w2 == 1 && gB == 1
                                    Tf(a,b,1) = 'sAsAwgB';
                                elseif w2 == 1 && sB == 1
                                    Tf(a,b,1) = 'sAsAwsB';
                                elseif gB == 2
                                    Tf(a,b,1) = 'sAsAgBgB';
                                elseif gB == 1 && sB == 1
                                    Tf(a,b,1) = 'sAsAgBsB';
                                elseif sB == 2
                                    Tf(a,b,1) = 'sAsAsBsB';
                                end
                            end
                            
                            if femalePoisonA && femalePoisonB
                                if A < 1 && B < 1
                                    Tf(a,b,2) = strcat('(',Tf(a,b,2),'*omegaA*omegaB)');
                                elseif A < 1
                                    Tf(a,b,2) = strcat('(',Tf(a,b,2),'*omegaA)');
                                elseif B < 1
                                    Tf(a,b,2) = strcat('(',Tf(a,b,2),'*omegaB)');
                                end    
                            elseif femalePoisonA
                                if B < 1
                                    Tf(a,b,2) = strcat('(',Tf(a,b,2),'*omegaA)');
                                end
                            elseif femalePoisonB
                                if A < 1
                                    Tf(a,b,2) = strcat('(',Tf(a,b,2),'*omegaB)');
                                end
                            end
            
                            % COMPILES PROBABILITIES
                            if strcmp(geneMake, Tf(a,b,1)) == 1
                                if T1(i,j,k,5) == ""
                                    T1(i,j,k,5) = Tf(a,b,2);
                                else
                                    storeSTR = T1(i,j,k,5);
                                    T1(i,j,k,5) = strcat(storeSTR, '+', Tf(a,b,2));
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

% SIMPLIFIES THE PROBABILITIES
syms alpha beta gamma omegaA omegaB
for k=1:36
    for i=6:41
        for j=6:41
            oldVal = T1(i,j,k,5);
            
            if oldVal ~= ''
                new1 = str2sym(oldVal);
                new2 = char(new1);
                T1(i,j,k,5) = strcat('(', new2, ')');
            end
        end
    end
end

%GENERATE THE EQUATION
gprime = strings(15);
for k=1:36
    for i=6:41
        for j=6:41                                                           
            if T1(i,j,k,5) ~= ''
                if gprime(k) == ''
                    gprime(k) = strcat(T0(1,j), '*', T1(i,j,k,5), '*', T0(i,1));
                else
                    gStore = gprime(k);
                    gprime(k) = strcat(gStore, '+', T0(1,j), '*', T1(i,j,k,5), '*', T0(i,1));
                end
            end
        end
    end
end

% Clears previous text file if available
if exist('Underdominance 2 Locus Generated Equations.txt', 'file')==2      
  delete('Underdominance 2 Locus Generated Equations.txt');
end

% Outputs the equations in the form to be used in the models
diary('Underdominance 2 Locus Generated Equations.txt');
for i=1:2
    for k=1:36
        if i == 1
            disp(strcat('gprime(', num2str(k,'%d'), ') = (1-fitCost(', num2str(k,'%d'), '))*(sigma)*lambda*(', gprime(k), ');'))
        else
            disp(strcat('gprime(', num2str(k+36,'%d'), ') = (1-fitCost(', num2str(k+36,'%d'), '))*(1-sigma)*lambda*(', gprime(k), ');'))
        end
    end
end
diary off
