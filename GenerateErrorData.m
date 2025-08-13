clear all; clc; close all;

loadGlobVars;

% === Grid of initial conditions ===
nGrid = 50;
ma_init = linspace(0, 30, nGrid);
Ta_init = linspace(275, 325, nGrid);
[MA0, TA0] = meshgrid(ma_init, Ta_init);
tspan = [0 1e4];
opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);

nTo = 1; %nTo = length(To_vals);
To_idx = 1;
finals_case1 = zeros(nGrid, nGrid, 3, nTo);  % (ma, Ta, var, To)
finals_case2 = zeros(nGrid, nGrid, 3, nTo);
finals_case3 = zeros(nGrid, nGrid, 3, nTo);

% === Simulate all To values ===
% We will only simulate 295 K as that is what we ended up using in the end.
% But we had analyzed data for 285 before finalizing the figures
    % ii = 0;
    for i = 1:nGrid
        i
        for j = 1:nGrid
            % ii = ii + 1;
            % disp([num2str(ii), ' of ', num2str(nGrid^2), ' (T_o = ', num2str(Toinit), ')']);
            ma0 = MA0(i,j);
            Ta0 = TA0(i,j);
            x0 = [ma0, moinit, Ta0, Toinit];

            % --- Case 1: ideal
            ideal = 1; A1 = 0;
            [~, x] = ode45(@syst, tspan, x0, opts);
            finals_case1(i,j,:,To_idx) = x(end, [1, 3, 4]);  % ma, Ta, To

            % --- Case 2: A1 only
            ideal = 0; A1 = 1;
            [~, x] = ode45(@syst, tspan, x0, opts);
            finals_case2(i,j,:,To_idx) = x(end, [1, 3, 4]);

            % --- Case 3: full model
            ideal = 0; A1 = 0;
            [~, x] = ode45(@syst, tspan, x0, opts);
            finals_case3(i,j,:,To_idx) = x(end, [1, 3, 4]);
        end
    end
save('ErrorData.mat','finals_case1','finals_case2','finals_case3','MA0','TA0')
clear all; clc; close all;