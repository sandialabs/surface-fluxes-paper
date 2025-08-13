% © 2025 National Technology & Engineering Solutions of Sandia, LLC
% (NTESS).  Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
% Government retains certain rights in this software.
%
% SPDX-License-Identifier: BSD-3-Clause


set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

% === Neutral Surface ===
macary = linspace(0, 100, 1001);
Ta_steady_curve = Ta_func(macary);

% === Case Definitions ===
cases = {
    struct('ideal', 1, 'A1', 0, 'style', '-',   'label', 'System I'),
    struct('ideal', 0, 'A1', 1, 'style', ':',   'label', 'System A1'),
    struct('ideal', 0, 'A1', 0, 'style', '-.',  'label', 'Full')
};

tspan = [0, 1e6];
opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);

% === Plot Setup ===
figure(2); clf; hold on; box on; grid on;
xlabel('$m_a^v$[kg]'); ylabel('$T_a$[K]'); set(gca, 'FontSize', 20);

figure(3); clf; hold on; box on; grid on;
xlabel('$m_a^v$[kg]'); ylabel('$T_a$[K]'); zlabel('$T_o$[K]'); view(3); set(gca, 'FontSize', 20);

figure(2);
plot(macary, Ta_steady_curve, '--', 'Color', [0.5, 0.5, 0.5], 'LineWidth', 4); hold on;  % Neutral Surface
xlim([0 25]);ylim([273 320]);


for evapcond=[1,2]
    if evapcond==1
    ma_vals_fixed = [1, 2.5, 4];
    color = [0.85, 0.33, 0.10];
    else
    ma_vals_fixed = [10, 15, 18];
    color = [0.00,0.45,0.74];

    end
for k = 1:length(cases)
    ideal = cases{k}.ideal;
    A1 = cases{k}.A1;
    style = cases{k}.style;

    for j = 1:length(ma_vals_fixed)
        mainit = ma_vals_fixed(j);

        % Compute Ta_steady
        Ta_steady = Ta_func(mainit);
        % Start slightly perturbed from steady state
        if evapcond==1
        Ta0 = Ta_steady * 1.1;
        else
        Ta0 = Ta_steady * 0.96;
        end
        x0 = [mainit, moinit, Ta0, Toinit];
        [t, x] = ode45(@syst, tspan, x0, opts);

        ma_traj = x(:,1);
        Ta_traj = x(:,3);
        To_traj = x(:,4);


        % === 2D Plot ===
        figure(2);
        plot(ma_traj, Ta_traj, style, 'LineWidth', 4, 'Color', color);
        plot(ma_traj(1), Ta_traj(1), 'o', 'MarkerSize', 12, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k', 'LineWidth',3);
        plot(ma_traj(end), Ta_traj(end), 'd', 'MarkerSize', 12, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k', 'LineWidth',3);

        % === 3D Plot ===
        figure(3);
        plot3(ma_traj, Ta_traj, To_traj, style, 'LineWidth', 4, 'Color', color);
        plot3(ma_traj(1), Ta_traj(1), To_traj(1), 'o', 'MarkerSize', 12, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k', 'LineWidth',3);
        plot3(ma_traj(end), Ta_traj(end), To_traj(end), 'd', 'MarkerSize', 12, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k', 'LineWidth',3);
    end
end

end

% === Add simple legend for line styles only ===
figure(2);hold on;
h1 = plot(nan, nan, '-',  'Color', 'k', 'LineWidth', 4);
h2 = plot(nan, nan, ':',  'Color', 'k', 'LineWidth', 4);
h3 = plot(nan, nan, '-.', 'Color', 'k', 'LineWidth', 4);

legend([h1, h2, h3], {'System I', 'System A1', 'System A2'}, ...
    'Interpreter', 'latex', 'Location', 'best');

% === 3D Neutral Surface ===
To_range = linspace(-200, 300, 20);
[Mac_grid, To_grid] = meshgrid(macary, To_range);
Ta_grid = repmat(Ta_steady_curve, length(To_range), 1);
figure(3);
surf(Mac_grid, Ta_grid, To_grid, ...
     'FaceAlpha', 0.3, 'EdgeColor', 'none', 'FaceColor', [0.5, 0.5, 0.5]);
xlim([0 25])
ylim([273 320])
zlim([292 295.1])
