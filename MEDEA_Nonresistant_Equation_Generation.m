clear
clc

T0 = strings(10,10);       %stores the basics combinations and genotype references   
T1 = strings(10,10,6,5);   %stores for each genotype and iteration

% Populates the first gene string with a number
a = 3; b = 3; c = 0;                
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
a = 3; b = 3; c = 0;                
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
for i=1:10
    for j=1:10
        s1 = T0(i,j);

        if strcmp(s1, '3') == 1
            T0(i,j) = 'w';
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
for i=1:6
    T0(1,i+3) = strcat('J(', num2str(i,'%d'), ')');
    T0(i+3,1) = strcat('J(', num2str(i+6,'%d'), ')');
end

% START GENERATION OF PROBABLITIES & GENOTYPES
for k=1:6
    for i=4:9
        for j=4:9
            % IDENTIFY WHICH GENOTYPE TO MAKE        
            geneMake = '';
            if k == 1
                geneMake = 'ww';
            elseif k == 2
                geneMake = 'wg';
            elseif k == 3
                geneMake = 'ws';
            elseif k == 4
                geneMake = 'gg';
            elseif k == 5
                geneMake = 'gs';
            elseif k == 6
                geneMake = 'ss';
            end
            
            femaleGene = strcat(T0(2,j),T0(3,j));
            
            if (count(femaleGene, "g") + count(femaleGene, "s")) >= 1
                femalePoison = true;
            else
                femalePoison = false;
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

                %Make separate matrices for each probability and begin probability generation

                T2 = strings(13,2);
                gTotCount = count(newGene,"g");
                g1Count = count(gene1, "g");
                g2Count = count(gene2, "g");
                
                if gTotCount == 0
                    T2(1,1) = newGene;
                    T2(1,2) = '(1/4)';
                elseif gTotCount == 1
                    if g1Count == 1
                        T2(2,1) = strcat('w', gene2);
                        T2(2,2) = '(alpha/4)';
                        T2(3,1) = strcat('g',gene2);
                        T2(3,2) = '(beta/4)';
                        T2(4,1) = strcat('s',gene2);
                        T2(4,2) = '(gamma/4)';
                    else
                        T2(2,1) = strcat(gene1, 'w');
                        T2(2,2) = '(alpha/4)';
                        T2(3,1) = strcat(gene1, 'g');
                        T2(3,2) = '(beta/4)';
                        T2(4,1) = strcat(gene1, 's');
                        T2(4,2) = '(gamma/4)';
                    end
                elseif gTotCount == 2
                    T2(5,1) = 'ww';
                    T2(5,2) = '(alpha^2/4)';
                    T2(6,1) = 'wg';
                    T2(6,2) = '(alpha*beta/4)';
                    T2(7,1) = 'ws';
                    T2(7,2) = '(alpha*gamma/4)';
                    T2(8,1) = 'wg';
                    T2(8,2) = '(beta*alpha/4)';
                    T2(9,1) = 'gg';
                    T2(9,2) = '(beta^2/4)';
                    T2(10,1) = 'gs';
                    T2(10,2) = '(beta*gamma/4)';
                    T2(11,1) = 'ws';
                    T2(11,2) = '(gamma*alpha/4)';
                    T2(12,1) = 'gs';
                    T2(12,2) = '(gamma*beta/4)';
                    T2(13,1) = 'ss';
                    T2(13,2) = '(gamma^2/4)';
                end
                
                T3 = strings(13,2,13);
                for a=1:13
                    if T2(a,1) ~= ""
                        
                        prob = T2(a,2);
                        w = count(T2(a,1),"w");
                        g = count(T2(a,1),"g");
                        s = count(T2(a,1),"s");
                        %determines the gene that is formed otherwise for renaming purposes
                        
                        if g == 2
                            T3(13,1,a) = 'gg';
                            T3(13,2,a) = prob;
                        elseif (g == 1) && (w == 1)
                            T3(13,1,a) = 'wg';
                            T3(13,2,a) = prob;
                        elseif (g == 1) && (s == 1)
                            T3(13,1,a) = 'gs';
                            T3(13,2,a) = prob;
                        elseif s == 2
                            T3(13,1,a) = 'ss';
                            T3(13,2,a) = prob;
                        elseif (s == 1) && (w == 1)
                            T3(13,1,a) = 'ws';
                            T3(13,2,a) = prob;
                        elseif w == 2
                            if femalePoison
                                T3(13,1,a) = 'ww';
                                T3(13,2,a) = strcat('(',prob,'*survivalRate)');
                            else
                                T3(13,1,a) = 'ww';
                                T3(13,2,a) = prob;
                            end
                        end
                    end
                end
                % COMPILES PROBABILITIES
                for b=1:13                              
                    for c=1:13
                        if strcmp(geneMake, T3(b,1,c)) == 1
                            if T1(i,j,k,5) == ""
                                T1(i,j,k,5) = T3(b,2,c);
                            else
                                storeSTR = T1(i,j,k,5);
                                T1(i,j,k,5) = strcat(storeSTR, '+', T3(b,2,c));
                            end
                        end
                    end
                end
                    
            end
        end
    end
end

% SIMPLIFIES THE PROBABILITIES
syms alpha beta gamma survivalRate
for k=1:6
    for i=4:9
        for j=4:9
            oldVal = T1(i,j,k,5);
            
            if oldVal ~= ''
                new1 = str2sym(oldVal);
                new2 = char(new1);
                T1(i,j,k,5) = strcat('(', new2, ')');
            end
        end
    end
end

% GENERATES THE EQUATION
gprime = strings(6);
for k=1:6
    for i=4:9
        for j=4:9                                                           
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
if exist('MEDEA Nonresistant Generated Equations.txt', 'file')==2      
  delete('MEDEA Nonresistant Generated Equations.txt');
end

% Outputs the equations in the form to be used in the models
diary('MEDEA Nonresistant Generated Equations.txt');
for i=1:2
    for k=1:6
        if i == 1
            disp(strcat('gprime(', num2str(k,'%d'), ') = (1-fitCost(', num2str(k,'%d'), '))*(1-sigma)*lambda*(', gprime(k), ');'))
        else
            disp(strcat('gprime(', num2str(k+6,'%d'), ') = (1-fitCost(', num2str(k+6,'%d'), '))*(sigma)*lambda*(', gprime(k), ');'))
        end
    end
end
diary off
