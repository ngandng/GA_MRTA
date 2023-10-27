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

function y = Mutate(x, mu, m)

    % nVar = numel(x); % number of position dimension
    
    nmu = ceil(mu*m); % number of chromosome will be mutated
    
    y = x;
 
    nagent = length(x.agents);

    for i = 1:nmu
        a = randi([1 nagent]);
        b = randi([1 nagent]);

        len_a = length(x.agents(a).task);
        len_b = length(x.agents(b).task);

        if(len_a < 2 && len_b >= 2)

            pos = randi([1 len_b]);

            y.agents(a).task = [x.agents(a).task, x.agents(b).task(pos)];
            if pos == len_b
                y.agents(b).task = x.agents(b).task([1:pos-1, x.agents(a).task]);
            elseif pos == 1
                y.agents(b).task = x.agents(b).task([x.agents(a).task, pos+1:end]);
            else
                y.agents(b).task = x.agents(b).task([1:pos-1, x.agents(a).task, pos+1:end]);
            end
            
        elseif(len_b < 2 && len_a >= 2)

            pos = randi([1 len_a]);
            
            y.agents(b).task = [x.agents(b).task, x.agents(a).task(pos)];
            if pos == len_a
                y.agents(a).task = x.agents(a).task([1:pos-1, x.agents(b).task]);
            elseif pos == 1
                y.agents(a).task = x.agents(a).task([x.agents(b).task, pos+1:end]);
            else
                y.agents(a).task = x.agents(a).task([1:pos-1, x.agents(b).task, pos+1:end]);
            end
            
        elseif(len_a < 2 && len_b < 2)

            y.agents(a).task = x.agents(b).task(:);
            y.agents(b).task = x.agents(a).task(:);
        
        else
    
            pos1 = randi([1 len_a]);
            pos2 = randi([1 len_b]);
    
            y.agents(a).task(pos1) = x.agents(b).task(pos2);
            y.agents(b).task(pos2) = x.agents(a).task(pos1);
        end

    end

end