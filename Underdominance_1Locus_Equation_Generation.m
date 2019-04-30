clear
clc

T0 = strings(18,18);       %stores the basics combinations and genotype references   
T1 = strings(18,18,15,5);  %stores for each genotype and iteration

% Populates the first gene string with a number
a = 5; b = 5; c = 0;                
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
a = 5; b = 5; c = 0;                
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
for i=1:18
    for j=1:18
        s1 = T0(i,j);

        if strcmp(s1, '5') == 1
            T0(i,j) = 'w';
        end
        if strcmp(s1, '4') == 1
            T0(i,j) = 'gA';
        end
        if strcmp(s1, '3') == 1
            T0(i,j) = 'gB';
        end
        if strcmp(s1, '2') == 1
            T0(i,j) = 'sA';
        end
        if strcmp(s1, '1') == 1
            T0(i,j) = 'sB';
        end
    end
end

% Populates the J() equation form
for i=1:15
    T0(1,i+3) = strcat('J(', num2str(i,'%d'), ')');
    T0(i+3,1) = strcat('J(', num2str(i+15,'%d'), ')');
end

% START GENERATION OF PROBABLITIES & GENOTYPES
for k=1:15 
    for i=4:18
        for j=4:18
            % IDENTIFY WHICH GENOTYPE TO MAKE
                    
            geneMake = '';
            if k == 1
                geneMake = 'ww';
            elseif k == 2
                geneMake = 'wgA';
            elseif k == 3
                geneMake = 'wgB';
            elseif k == 4
                geneMake = 'wsA';
            elseif k == 5
                geneMake = 'wsB';
            elseif k == 6
                geneMake = 'gAgA';
            elseif k == 7
                geneMake = 'gAgB';
            elseif k == 8
                geneMake = 'gAsA';
            elseif k == 9
                geneMake = 'gAsB';
            elseif k == 10
                geneMake = 'gBgB';
            elseif k == 11
                geneMake = 'gBsA';
            elseif k == 12
                geneMake = 'gBsB';
            elseif k == 13
                geneMake = 'sAsA';
            elseif k == 14
                geneMake = 'sAsB';
            elseif k == 15
                geneMake = 'sBsB';
            end
            
            maleGene = strcat(T0(i,2),T0(i,3));
            femaleGene = strcat(T0(2,j),T0(3,j));
            
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
                newGene = '';

                if l==1
                    gene1 = T0(2,j);
                    gene2 = T0(i,2);
                    newGene = strcat(gene1,gene2);
                elseif l==2
                    gene1 = T0(3,j);
                    gene2 = T0(i,2);
                    newGene = strcat(gene1,gene2);
                elseif l==3
                    gene1 = T0(2,j);
                    gene2 = T0(i,3);
                    newGene = strcat(gene1,gene2);
                elseif l==4
                    gene1 = T0(3,j);
                    gene2 = T0(i,3);
                    newGene = strcat(gene1,gene2);
                end

                %Make separte matrices for each probability and begin
                %probability generation

                gTotCount = count(newGene,"g");
                gA1Count = count(gene1, "gA");
                gB1Count = count(gene1, "gB");
                gA2Count = count(gene2, "gA");
                gB2Count = count(gene2, "gB");
                
                T2 = strings(9,2);
                if gTotCount == 0
                    T2(1,1) = newGene;
                    T2(1,2) = '(1/4)';
                elseif gTotCount == 1
                    if gA1Count == 1
                        T2(1,1) = strcat('w', gene2);
                        T2(1,2) = '(alpha/4)';
                        T2(2,1) = strcat('gA',gene2);
                        T2(2,2) = '(beta/4)';
                        T2(3,1) = strcat('sA',gene2);
                        T2(3,2) = '(gamma/4)';
                    elseif gB1Count == 1
                        T2(1,1) = strcat('w', gene2);
                        T2(1,2) = '(alpha/4)';
                        T2(2,1) = strcat('gB',gene2);
                        T2(2,2) = '(beta/4)';
                        T2(3,1) = strcat('sB',gene2);
                        T2(3,2) = '(gamma/4)';
                    elseif gA2Count == 1
                        T2(1,1) = strcat(gene1, 'w');
                        T2(1,2) = '(alpha/4)';
                        T2(2,1) = strcat(gene1, 'gA');
                        T2(2,2) = '(beta/4)';
                        T2(3,1) = strcat(gene1, 'sA');
                        T2(3,2) = '(gamma/4)';
                    elseif gB2Count == 1
                        T2(1,1) = strcat(gene1, 'w');
                        T2(1,2) = '(alpha/4)';
                        T2(2,1) = strcat(gene1, 'gB');
                        T2(2,2) = '(beta/4)';
                        T2(3,1) = strcat(gene1, 'sB');
                        T2(3,2) = '(gamma/4)';
                    end
                elseif gTotCount == 2
                    if gA1Count == 1 && gA2Count == 1
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
                    elseif gA1Count == 1 && gB2Count == 1
                        T2(1,1) = 'ww';
                        T2(1,2) = '(alpha^2/4)';
                        T2(2,1) = 'wgA';
                        T2(2,2) = '(alpha*beta/4)';
                        T2(3,1) = 'wsA';
                        T2(3,2) = '(alpha*gamma/4)';
                        T2(4,1) = 'wgB';
                        T2(4,2) = '(beta*alpha/4)';
                        T2(5,1) = 'gAgB';
                        T2(5,2) = '(beta^2/4)';
                        T2(6,1) = 'sAgB';
                        T2(6,2) = '(beta*gamma/4)';
                        T2(7,1) = 'wsB';
                        T2(7,2) = '(gamma*alpha/4)';
                        T2(8,1) = 'gAsB';
                        T2(8,2) = '(gamma*beta/4)';
                        T2(9,1) = 'sAsB';
                        T2(9,2) = '(gamma^2/4)';
                    elseif gB1Count == 1 && gA2Count == 1
                        T2(1,1) = 'ww';
                        T2(1,2) = '(alpha^2/4)';
                        T2(2,1) = 'wgA';
                        T2(2,2) = '(alpha*beta/4)';
                        T2(3,1) = 'wsA';
                        T2(3,2) = '(alpha*gamma/4)';
                        T2(4,1) = 'wgB';
                        T2(4,2) = '(beta*alpha/4)';
                        T2(5,1) = 'gAgB';
                        T2(5,2) = '(beta^2/4)';
                        T2(6,1) = 'sAgB';
                        T2(6,2) = '(beta*gamma/4)';
                        T2(7,1) = 'wsB';
                        T2(7,2) = '(gamma*alpha/4)';
                        T2(8,1) = 'gAsB';
                        T2(8,2) = '(gamma*beta/4)';
                        T2(9,1) = 'sAsB';
                        T2(9,2) = '(gamma^2/4)';
                    elseif gB1Count == 1 && gB2Count == 1
                        T2(1,1) = 'ww';
                        T2(1,2) = '(alpha^2/4)';
                        T2(2,1) = 'wgB';
                        T2(2,2) = '(alpha*beta/4)';
                        T2(3,1) = 'wsB';
                        T2(3,2) = '(alpha*gamma/4)';
                        T2(4,1) = 'wgB';
                        T2(4,2) = '(beta*alpha/4)';
                        T2(5,1) = 'gBgB';
                        T2(5,2) = '(beta^2/4)';
                        T2(6,1) = 'gBsB';
                        T2(6,2) = '(beta*gamma/4)';
                        T2(7,1) = 'wsB';
                        T2(7,2) = '(gamma*alpha/4)';
                        T2(8,1) = 'gBsB';
                        T2(8,2) = '(gamma*beta/4)';
                        T2(9,1) = 'sBsB';
                        T2(9,2) = '(gamma^2/4)';
                    end
                end
                
                for a=1:9
                    if T2(a,1) ~= ""
                        
                        prob = T2(a,2);
                        w = count(T2(a,1),"w");
                        gA = count(T2(a,1),"gA");
                        gB = count(T2(a,1),"gB");
                        sA = count(T2(a,1),"sA");
                        sB = count(T2(a,1),"sB");
                        A = count(T2(a,1), "A");
                        B = count(T2(a,1), "B");
                        
                        %determines the gene that is formed otherwise for renaming purposes
                        
                        if w == 2  
                            T2(a,1) = 'ww';
                        elseif w == 1 && gA == 1
                            T2(a,1) = 'wgA';
                        elseif w == 1 && gB == 1
                            T2(a,1) = 'wgB';
                        elseif w == 1 && sA == 1
                            T2(a,1) = 'wsA';
                        elseif w == 1 && sB == 1
                            T2(a,1) = 'wsB';
                        elseif gA == 2
                            T2(a,1) = 'gAgA';
                        elseif gA == 1 && gB == 1
                            T2(a,1) = 'gAgB';
                        elseif gA == 1 && sA == 1
                            T2(a,1) = 'gAsA';
                        elseif gA == 1 && sB == 1
                            T2(a,1) = 'gAsB';
                        elseif gB == 2
                            T2(a,1) = 'gBgB';
                        elseif gB == 1 && sA == 1
                            T2(a,1) = 'gBsA';
                        elseif gB == 1 && sB == 1
                            T2(a,1) = 'gBsB';
                        elseif sA == 2
                            T2(a,1) = 'sAsA';
                        elseif sA == 1 && sB == 1
                            T2(a,1) = 'sAsB';
                        elseif sB == 2
                            T2(a,1) = 'sBsB';
                        end
                        
                        if femalePoisonA && femalePoisonB
                            if A ~= 1 && B ~= 1
                                T2(a,2) = strcat('(',T2(a,2),'*omegaA*omegaB)');
                            elseif A ~= 1
                                T2(a,2) = strcat('(',T2(a,2),'*omegaA)');
                            elseif B ~= 1
                                T2(a,2) = strcat('(',T2(a,2),'*omegaB)');
                            end
                        elseif femalePoisonA
                            if B < 1
                                T2(a,2) = strcat('(',T2(a,2),'*omegaA)');
                            end
                        elseif femalePoisonB
                            if A < 1
                                T2(a,2) = strcat('(',T2(a,2),'*omegaB)');
                            end
                        end
                    end
                    
                    % COMPILES PROBABILITIES
                    if strcmp(geneMake, T2(a,1)) == 1
                        if T1(i,j,k,5) == ""
                            T1(i,j,k,5) = T2(a,2);
                        else
                            storeSTR = T1(i,j,k,5);
                            T1(i,j,k,5) = strcat(storeSTR, '+', T2(a,2));
                        end
                    end
                end
            end
        end
    end
end
                       
% SIMPLIFIES THE PROBABILITIES
syms alpha beta gamma omegaA omegaB
for k=1:15
    for i=4:18
        for j=4:18
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
for k=1:15
    for i=4:18
        for j=4:18                                                           
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
if exist('Underdominance 1 Locus Generated Equations.txt', 'file')==2      
  delete('Underdominance 1 Locus Generated Equations.txt');
end

% Outputs the equations in the form to be used in the models
diary('Underdominance 1 Locus Generated Equations.txt');
for i=1:2
    for k=1:15
        if i == 1
            disp(strcat('gprime(', num2str(k,'%d'), ') = (1-fitCost(', num2str(k,'%d'), '))*(sigma)*lambda*(', gprime(k), ');'))
        else
            disp(strcat('gprime(', num2str(k+15,'%d'), ') = (1-fitCost(', num2str(k+15,'%d'), '))*(1-sigma)*lambda*(', gprime(k), ');'))
        end
    end
end
diary off
