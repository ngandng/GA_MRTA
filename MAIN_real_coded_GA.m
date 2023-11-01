
clc;
clear;
close all;

%% Problem Definition

% model = CreateModel();
load('Model4_A3T15.mat');

CostFunction = @(x) CostFunction(x, model);

%% GA Parameters

MaxIt = 500;     % Maximum Number of Iterations

nPop = 70;       % Population Size

pc = 0.7;                 % Crossover Percentage
nc = 2*round(pc*nPop/2);  % Number of Offsprings (also Parnets)...
gamma = 0.4;              % Extra Range Factor for Crossover

pm = 0.3;                 % Mutation Percentage
nm = round(pm*nPop);      % Number of Mutants
mu = 0.1;                 % Mutation Rate

UseRouletteWheelSelection = true;

if UseRouletteWheelSelection
    beta = 8;             % Selection Pressure: for exponential distribution
end

% pause(0.01); % Due to a bug in older versions of MATLAB

%% Initialization

empty_individual.Position = [];
% empty_individual.Cost = [];
empty_individual.Cost = inf;

pop = repmat(empty_individual, nPop, 1);

for i = 1:nPop

    % Initialize Position
    pop(i).Position = InitAssignment(model);
    % pop(i).Position = Feasibilization(pop(i).Position, model, beta);
    
    % Evaluation
    pop(i).Cost = CostFunction(pop(i).Position);

end

% Sort Population
Costs = [pop.Cost];
[Costs, SortOrder] = sort(Costs);
pop = pop(SortOrder);

% Store Best Solution
BestSol = pop(1);

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

% Store Cost
WorstCost = pop(end).Cost;

%% Main Loop

for it = 1:MaxIt

    % Calculate Selection Probabilities
    P = exp(-beta*Costs/WorstCost);
    P = P/sum(P);
    
    % Crossover
    popc = repmat(empty_individual, nc/2, 2);
    for k = 1:nc/2
        
        % Select Parents Indices
        i1 = RouletteWheelSelection(P);
        i2 = RouletteWheelSelection(P);
    
        % Select Parents
        p1 = pop(i1);
        p2 = pop(i2);
        
        % Apply Crossover
        [popc(k, 1).Position, popc(k, 2).Position] = Crossover(p1.Position, p2.Position, model);
        
        % Evaluate Offsprings
        popc(k, 1).Cost = CostFunction(popc(k, 1).Position);
        popc(k, 2).Cost = CostFunction(popc(k, 2).Position);
        
    end
    popc = popc(:); % convert a multi-dimensional array into one-dimensional vector
    
    
    % Mutation
    popm = repmat(empty_individual, nm, 1);
    for k = 1:nm

        % Select Parent
        i = randi([1 nPop]); % randi with value from 1 to nPop
        p = pop(i);

        % Apply Mutation
        popm(k).Position = Mutate(p.Position, mu, model.M);

        % Evaluate Mutant
        popm(k).Cost = CostFunction(popm(k).Position);

    end
    
    % Create Merged Population
    pop = [pop
         popc
         popm]; %#ok
     
    % Sort Population
    Costs = [pop.Cost];
    [Costs, SortOrder] = sort(Costs);
    pop = pop(SortOrder); % sort the pop base on index in SortOrder
    
    % Update Worst Cost
    WorstCost = max(WorstCost, pop(end).Cost);
    
    % Truncation
    pop = pop(1:nPop);
    Costs = Costs(1:nPop);
    
    % Store Best Solution Ever Found
    BestSol = pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);

end

%% Results
PlotAssignments(model, BestSol.Position, 1);

figure;
% semilogy(BestCost, 'LineWidth', 2);
plot(BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Cost');
grid on;


