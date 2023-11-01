
function PlotAssignments(model, sol, figureID)

% Set plotting parameters
figure(figureID);

offset = (model.XMAX - model.XMIN)/100; 

Cmap   = colormap(lines);

m_tasks = model.tasks;

% Plot tasks
hold on;
% for m = 1:length(m_tasks)
%     plot3(m_tasks(m).x + [0 0], m_tasks(m).y + [0 0], [m_tasks(m).start m_tasks(m).end],'x:','color',Cmap(m_tasks(m).type,:),'LineWidth',3);
% end

% Plot agents
for n=1:length(model.agents)

    plot3(model.agents(n).x, model.agents(n).y, 0,'o','color',Cmap(model.agents(n).id,:),'MarkerSize',10,'MarkerFaceColor',Cmap(model.agents(n).id,:));

    text(model.agents(n).x+offset, model.agents(n).y+offset, 0.1, ['A' num2str(n)]);

    % Check if path has something in it
    if(~isempty(sol.agents(n).task))

        taskPrev = lookupTask(model.tasks, sol.agents(n).task(1)); % get the task information

        X = [model.agents(n).x, taskPrev.x];
        Y = [model.agents(n).y, taskPrev.y];
        Z = zeros(length(X));

        plot3(X,Y,Z,'-','color',Cmap(model.agents(n).id,:),'LineWidth',2);

        plot3(X(end)+[0 0], Y(end)+[0 0], Z(end)+[0 0], '^','color',Cmap(model.agents(n).id,:),'MarkerSize',10,'MarkerFaceColor',Cmap(model.agents(n).id,:));
        text(model.agents(n).x+offset, model.agents(n).y+offset, 0.1, ['A' num2str(n)]);

        for m = 2:length(sol.agents(n).task)
            if( ~isempty(sol.agents(n).task(m)) && m > 1 )

                taskNext = lookupTask(model.tasks, sol.agents(n).task(m));
                X = [taskPrev.x, taskNext.x];
                Y = [taskPrev.y, taskNext.y];
                Z = zeros(length(X));

                plot3(X,Y,Z,'-','color',Cmap(model.agents(n).id,:),'LineWidth',2);

                plot3(X(end)+[0 0], Y(end)+[0 0], Z(end)+[0 0], '^','color',Cmap(model.agents(n).id,:),'MarkerSize',10,'MarkerFaceColor',Cmap(model.agents(n).id,:));

                taskPrev = taskNext;

            else
                break;
            end
        end
    end
end

% legend([agent_quad, agent_car, tasks_track, tasks_rescue], {'Quadrotors', 'Cars', 'Tracking tasks', 'Rescue tasks'}, 'Location', 'southwest');
hold off;
title('Agent Paths')
xlabel('X');
ylabel('Y');
zlabel('Time');
grid on;

return

function task = lookupTask(tasks, taskID)

    for mi=1:length(tasks)
        if(tasks(mi).id == taskID)
            task = tasks(mi);
            return;
        end
    end
    
    task = [];
    disp(['Task with index=' num2str(taskID) ' not found'])

return

end

end

    