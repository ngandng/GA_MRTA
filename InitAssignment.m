
% Initialize some assignment

function pop = InitAssignment(model)
    
    %set of available tasks
    avai_tasks = [];

    for i = 1:model.M
        avai_tasks = [avai_tasks, model.tasks(i).id];
    end

    % avai_tasks

    for i=1:(model.N-1)  % for each agent

        pop.agents(i).task = [];
        if (length(avai_tasks) < 2)
            continue;
        end
        num_tasks = randi([1 (length(avai_tasks)-1)]);

        for j = 1:num_tasks
            pr = randi([1,length(avai_tasks)]);
            pop.agents(i).task = [pop.agents(i).task, avai_tasks(pr)];
            avai_tasks = avai_tasks([1:pr-1, pr+1:end]);
        end
    end

    % pop.agent[i] = task vector
    pop.agents(model.N).task = avai_tasks;

end