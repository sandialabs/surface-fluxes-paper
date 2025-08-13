% © 2025 National Technology & Engineering Solutions of Sandia, LLC
% (NTESS).  Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
% Government retains certain rights in this software.
%
% SPDX-License-Identifier: BSD-3-Clause

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

mo_fixed = moinit;
To_fixed = Toinit;
% Phase space grid
freq=40;
ma_vals = linspace(0, 25, freq);
Ta_vals = linspace(275, 320, freq);
[MA, TA] = meshgrid(ma_vals, Ta_vals);

% Neutral curve
macary = linspace(0, 1000, 1001);
Ta_steady_curve = Ta_func(macary);

% === Ideal Case ===
ideal = 1;
dMA_ideal = zeros(size(MA));
dTA_ideal = zeros(size(MA));
for i = 1:numel(MA)
    x = [MA(i), mo_fixed, TA(i), To_fixed];
    dxdt = syst(0, x);
    dMA_ideal(i) = dxdt(1);
    dTA_ideal(i) = dxdt(3);
end
% === A1 ===
ideal = 0;
A1 = 1;
dMA_A1 = zeros(size(MA));
dTA_A1 = zeros(size(MA));
for i = 1:numel(MA)
    x = [MA(i), mo_fixed, TA(i), To_fixed];
    dxdt = syst(0, x);
    dMA_A1(i) = dxdt(1);
    dTA_A1(i) = dxdt(3);
end
% === A2 ===
ideal = 0;
A1 = 0;
dMA_A2 = zeros(size(MA));
dTA_A2 = zeros(size(MA));
for i = 1:numel(MA)
    x = [MA(i), mo_fixed, TA(i), To_fixed];
    dxdt = syst(0, x);
    dMA_A2(i) = dxdt(1);
    dTA_A2(i) = dxdt(3);
end

% === Plotting Ideal ===
figure; hold on; box on; grid on;
xlabel('$m_a^v$[kg]'); ylabel('$T_a$[K]');
xlim([0 25]); ylim([275 320]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
% Streamlines
h1 = streamslice(MA, TA, dMA_ideal, dTA_ideal, 2);
set(h1, 'LineStyle','-','Color', [0.00,0.45,0.74], 'LineWidth', 2.0);  % blue
% Neutral curve
plot(macary, Ta_steady_curve, '--','Color',[.5 .5 .5],'LineWidth', 4);

% === Plotting A2 ===
figure; hold on; box on; grid on;
xlabel('$m_a^v$[kg]'); ylabel('$T_a$[K]');
xlim([0 25]); ylim([275 320]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
% Streamlines
h2 = streamslice(MA, TA, dMA_A2, dTA_A2, 2);
set(h2, 'LineStyle','-','Color', 'k', 'LineWidth', 2.0);  % blue
% Neutral curve
plot(macary, Ta_steady_curve, '--','Color',[.5 .5 .5],'LineWidth', 4);
% title(['System A2, $T_o$ = ', num2str(To_fixed), ' K']);

% === Plotting A1 ===
figure; hold on; box on; grid on;
xlabel('$m_a^v$[kg]'); ylabel('$T_a$[K]');
xlim([0 25]); ylim([275 320]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
% Streamlines
h3 = streamslice(MA, TA, dMA_A1, dTA_A1, 1.0);
set(h3, 'LineStyle','-','Color', [0.85,0.33,0.10], 'LineWidth', 2.0);  % red
% Neutral curve
plot(macary, Ta_steady_curve,'--','Color',[.5 .5 .5],'LineWidth', 4);
