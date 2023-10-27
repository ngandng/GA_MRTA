% Cost function

function cost = CostFunction(asg, model)
        
    N = length(asg.agents);
 
    % F1 total travel distance
    F1 = 0;

    for i = 1:N
        % Calculate traveling distance for each agent
        ntask = length(asg.agents(i).task);

        if(ntask == 0) % if no task assigned for that agent
            f_agent = 0;
            F1 = F1 +f_agent;
            continue;
        end

        vtask = asg.agents(i).task; % get the task vector
        
        taskID = vtask(1);

        f_agent = 0; % fitness function
        
        f_agent = f_agent + Distance(model.agents(i).x, model.agents(i).y, model.agents(i).z, ...
                                     model.tasks(taskID).x, model.tasks(taskID).y, model.tasks(taskID).z); % from robot position to task 1;
        for j = 1: ntask
            prePos = taskID;
            taskID = vtask(j);

            dis = Distance(model.tasks(prePos).x, model.tasks(prePos).y, model.tasks(prePos).z, ...
                           model.tasks(taskID).x, model.tasks(taskID).y, model.tasks(taskID).z); % distance from task to task
            f_agent = f_agent + dis;
        end
        F1 = F1 +f_agent;
    end
   
    cost  = F1;
end