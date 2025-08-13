% © 2025 National Technology & Engineering Solutions of Sandia, LLC
% (NTESS).  Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
% Government retains certain rights in this software.
%
% SPDX-License-Identifier: BSD-3-Clause

% Steady-State Ta vs mav Plot

% --- Define range of steady-state vapor masses [kg] ---
mav = linspace(1e-3, 50, 500);   % Adjust range as needed
Ta = Ta_func(mav);

% --- Plot ---
figure;
% plot(mav./(mav+mad)*1000, Ta, 'LineWidth', 2);
plot(mav, Ta, 'k','LineWidth', 3);
xlabel('Steady state atmospheric vapor mass, $m_{a,steady}^v$ [kg]','Interpreter','latex');
ylabel('Steady-state air temperature $T_{a,steady}$ [K]','Interpreter','latex');
% title('Steady-state T_a vs m_{a,steady}^v','Interpreter','latex');
grid on;
set(gca, 'TickLabelInterpreter','latex', 'FontSize', 20);
ylim([275 320])
% --- Add annotation text boxes ---

dim1 = [0.3 0.7 0.22 0.1];  % Evaporation: moved up and left
dim2 = [0.5  0.3 0.22 0.1];  % Condensation: moved up and right

annotation('textbox', dim1, 'String', '\textbf{Evaporation}', ...
    'Interpreter','latex', 'FontSize', 24, ...
    'EdgeColor','none', 'LineWidth', 1.5, 'HorizontalAlignment', 'center');

annotation('textbox', dim2, 'String', '\textbf{Condensation}', ...
    'Interpreter','latex', 'FontSize', 24, ...
    'EdgeColor','none', 'LineWidth', 1.5, 'HorizontalAlignment', 'center');
