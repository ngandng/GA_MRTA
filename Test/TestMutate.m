clc; clear; close all;

x.agents = [];

x.agents(1).task = [1 2 3];
x.agents(2).task = [4];
x.agents(3).task = [5 6];
x.agents(4).task = [7 8 9 10];

nmu = 3;
y = x;

nagent = length(x.agents);

for i = 1:nmu
    a = randi([1 nagent]);
    b = randi([1 nagent]);
    % disp("A: "+ a+ " B: "+b);

    len_a = length(x.agents(a).task);
    len_b = length(x.agents(b).task);
    % disp("LengthA =  "+len_a+ " lengthB =  "+len_b);

    if(len_a < 2 && len_b >= 2)
        % disp("len_b: "+len_b);

        pos = randi([1 len_b]);
        % disp("pos: "+pos);
        
        % add or change new task for agent a
        y.agents(a).task = x.agents(b).task(pos);

        % modify task for agent b
        if pos == len_b
            y.agents(b).task = [x.agents(b).task(1:(pos-1)), x.agents(a).task];
        elseif pos == 1
            y.agents(b).task = [x.agents(a).task, x.agents(b).task((pos+1):end)];
        else
            y.agents(b).task = [x.agents(b).task(1:(pos-1)), x.agents(a).task, x.agents(b).task((pos+1):end)];
        end
        
    elseif(len_b < 2 && len_a >= 2)
        % disp("len_a: "+len_a);

        pos = randi([1 len_a]);
        % disp("pos: "+pos);
        
        % add or change new task for agent b
        y.agents(b).task = x.agents(a).task(pos);

        % modify task for agent a
        if pos == len_a
            y.agents(a).task = [x.agents(a).task(1:(pos-1)), x.agents(b).task];
        elseif pos == 1
            y.agents(a).task = [x.agents(b).task, x.agents(a).task((pos+1):end)];
        else
            y.agents(a).task = [x.agents(a).task(1:(pos-1)), x.agents(b).task, x.agents(a).task((pos+1):end)];
        end
        
    elseif(len_a < 2 && len_b < 2)

        y.agents(a).task = x.agents(b).task;
        y.agents(b).task = x.agents(a).task;
    
    else

        pos1 = randi([1 len_a]);
        pos2 = randi([1 len_b]);
        % disp("Pos1 = "+pos1+" pos2 = "+pos2);

        y.agents(a).task(pos1) = x.agents(b).task(pos2);
        y.agents(b).task(pos2) = x.agents(a).task(pos1);
    end

    x = y;

end