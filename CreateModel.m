% Create model

function model = CreateModel()
    %---------------------------------------------------------------------%
    % Initialize global variables
    %---------------------------------------------------------------------%
    
    WORLD.CLR  = rand(100,3);
    
    WORLD.XMIN = -2.0;
    WORLD.XMAX =  2.5;
    WORLD.YMIN = -1.5;
    WORLD.YMAX =  5.5;
    WORLD.ZMIN =  0.0;
    WORLD.ZMAX =  2.0;
    WORLD.MAX_DISTANCE = sqrt((WORLD.XMAX - WORLD.XMIN)^2 + ...
                              (WORLD.YMAX - WORLD.YMIN)^2 + ...
                              (WORLD.ZMAX - WORLD.ZMIN)^2);
     
    %---------------------------------------------------------------------%
    % Define agents and tasks
    %---------------------------------------------------------------------%
    % Grab agent and task types from CBBA Parameter definitions
    
    % Initialize possible agent fields
    agent_default.id    = 0;            % agent id
    agent_default.type  = 0;            % agent type
    agent_default.avail = 0;            % agent availability (expected time in sec)
    agent_default.clr = [];             % for plotting
    
    agent_default.x       = 0;          % agent position (meters)
    agent_default.y       = 0;          % agent position (meters)
    agent_default.z       = 0;          % agent position (meters)
    agent_default.nom_vel = 0;          % agent cruise velocity (m/s)
    agent_default.fuel    = 0;          % agent fuel penalty (per meter)
    
    % FOR USER TO DO:  Set agent fields for specialized agents, for example:
    % agent_default.util = 0;
    
    % Initialize possible task fields
    task_default.id       = 0;          % task id
    task_default.type     = 0;          % task type
    task_default.value    = 0;          % task reward
    task_default.start    = 0;          % task start time (sec)
    task_default.end      = 0;          % task expiry time (sec)
    task_default.duration = 0;          % task default duration (sec)
    task_default.lambda   = 0.1;        % task exponential discount
    
    task_default.x        = 0;          % task position (meters)
    task_default.y        = 0;          % task position (meters)
    task_default.z        = 0;          % task position (meters)
    
    % FOR USER TO DO:  Set task fields for specialized tasks
    
    % List agent types 
    AGENT_TYPES.QUAD   = 1;
    AGENT_TYPES.CAR    = 2;
    
    % List task types
    TASK_TYPES.TRACK   = 1;
    TASK_TYPES.RESCUE  = 2;
    %---------------------------%
    
    % Create some default agents
    
    % QUAD
    agent_quad          = agent_default;
    agent_quad.type     = AGENT_TYPES.QUAD; % agent type
    agent_quad.nom_vel  = 2;         % agent cruise velocity (m/s)
    agent_quad.fuel     = 1;         % agent fuel penalty (per meter)
    
    % CAR
    agent_car           = agent_default;
    agent_car.type      = AGENT_TYPES.CAR;  % agent type
    agent_car.nom_vel   = 2;         % agent cruise velocity (m/s)
    agent_car.fuel      = 1;         % agent fuel penalty (per meter)
    
    % Create some default tasks
    
    % Track
    task_track          = task_default;
    task_track.type     = TASK_TYPES.TRACK;      % task type
    task_track.value    = 100;    % task reward
    % task_track.start    = 0;      % task start time (sec)
    % task_track.end      = 100;    % task expiry time (sec)
    task_track.duration = 5;      % task default duration (sec)
    
    % Rescue
    task_rescue          = task_default;
    task_rescue.type     = TASK_TYPES.RESCUE;      % task type
    task_rescue.value    = 100;    % task reward
    % task_rescue.start    = 0;      % task start time (sec)
    % task_rescue.end      = 100;    % task expiry time (sec)
    task_rescue.duration = 15;     % task default duration (sec)
    
    
    %---------------------------------------------------------------------%
    % Define sample scenario
    %---------------------------------------------------------------------%
    
    N = 3;      % number of agents
    M = 15;     % number of tasks

    % Create random agents and define parameters for each agents
    for n=1:N
    
        if(n/N <= 1/2)
            agents(n) = agent_quad;
        else
            agents(n) = agent_car;
        end

        agents(n).x    = rand(1)*(WORLD.XMAX - WORLD.XMIN) + WORLD.XMIN;
        agents(n).y    = rand(1)*(WORLD.YMAX - WORLD.YMIN) + WORLD.YMIN;
    
        % Init remaining agent parameters
        agents(n).id   = n;

        agents(n).clr  = WORLD.CLR(n,:);
    end
    
    % Create random tasks
    for m=1:M
        if(m/M <= 1/2)
            tasks(m) = task_track;
        else
            tasks(m) = task_rescue;
        end
        tasks(m).id       = m;
        % tasks(m).start    = rand(1)*100;
        % tasks(m).end      = tasks(m).start + 1*tasks(m).duration;
        tasks(m).x        = rand(1)*(WORLD.XMAX - WORLD.XMIN) + WORLD.XMIN;
        tasks(m).y        = rand(1)*(WORLD.YMAX - WORLD.YMIN) + WORLD.YMIN;
        tasks(m).z        = rand(1)*(WORLD.ZMAX - WORLD.ZMIN) + WORLD.ZMIN;
    end

    model = WORLD;
    model.tasks = tasks;
    model.agents = agents;
    model.N = N;
    model.M = M;
end
