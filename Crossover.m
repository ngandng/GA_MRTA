%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA101
% Project Title: Implementation of Real-Coded Genetic Algorithm in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Binary and Real-Coded Genetic Algorithms in MATLAB (URL: https://yarpiz.com/23/ypea101-genetic-algorithms), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [y1, y2] = Crossover(x1, x2, model)

    n = length(x1.agents);
    
    taskList = [];
    for i=1:n
        taskList = [taskList, x1.agents(i).task];
    end
    % alpha = unifrnd(-gamma, 1+gamma, length(x1));
    
    % y1 = alpha.*x1+(1-alpha).*x2;
    % y2 = alpha.*x2+(1-alpha).*x1;
    
    alpha = randi([1 n]); % crossover point

    % generate new solutions
    y1 = x1;
    y2 = x2;

    for i = alpha:n
        y1.agents(i) = x2.agents(i);
        y2.agents(i) = x1.agents(i);
    end
    
    % y1 = max(y1, VarMin);
    % y1 = min(y1, VarMax);
    % 
    % y2 = max(y2, VarMin);
    % y2 = min(y2, VarMax);

    % Delete duplicate tasks and add missing tasks

    % %% Test bug
    % disp("Before feasible:_________ ");
    % disp("for solution y1 ")
    % for i = 1:length(y1.agents)
    %     disp("agent "+ i +" : " + num2str(y1.agents(i).task(:)));
    % end
    % disp("for solution y2 ")
    % for i = 1:length(y2.agents)
    %     disp("agent "+ i +" : " + num2str(y2.agents(i).task(:)));
    % end

    % %% End test bug
    y1 = Feasibilization(y1,model, 8);
    y2 = Feasibilization(y2,model, 8);
    % 
    % disp("After feasible:_________ ");
    % disp("for solution y1 ")
    % for i = 1:length(y1.agents)
    %     disp("agent "+ i +" : " + num2str(y1.agents(i).task(:)));
    % end
    % disp("for solution y2 ")
    % for i = 1:length(y2.agents)
    %     disp("agent "+ i +" : " + num2str(y2.agents(i).task(:)));
    % end
end