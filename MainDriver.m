% © 2025 National Technology & Engineering Solutions of Sandia, LLC
% (NTESS).  Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
% Government retains certain rights in this software.
%
% SPDX-License-Identifier: BSD-3-Clause

clear all; close all;clc

%vars used by GenerateErrorData and MainDriver
loadGlobVars;

Figure2_SteadyConditions
figure(1),print('SteadyPlot.eps','-depsc');pause(5)

Figure3_RealisticTrajects
figure(2),print('Trajects2DIA1A2Realistic.eps','-depsc');pause(5)
figure(3),print('Trajects3DIA1A2Realistic.eps','-depsc');pause(5)

Figure4_GlobalTrajects
figure(4),print('Trajects2DA1Global.eps','-depsc');pause(5)
figure(5),print('Trajects3DA1Global.eps','-depsc');pause(5)

Figure5_Phaseplots
figure(6),print('PhasePlotIT295.eps','-depsc');pause(5)
figure(7),print('PhasePlotA2T295.eps','-depsc');pause(5)
figure(8),print('PhasePlotA1T295.eps','-depsc');pause(5)

Figures6_7and8ErrorsinA1andA2

% Paper figure 7
ct=9;
figure(ct),print('A2vsIdealTo295mav.eps','-depsc');pause(5)
ct=ct+1;
figure(ct),print('A2vsIdealTo295Ta.eps','-depsc');pause(5)
ct=ct+1;
figure(ct),print('A2vsIdealTo295To.eps','-depsc');pause(5)
% Paper figure 6
ct=ct+1;
figure(ct),print('A1vseal To295mavLogAbs.eps','-depsc');pause(5)
ct=ct+1;
figure(ct),print('A1vsIdealTo295TaLogAbs.eps','-depsc');pause(5)
ct=ct+1;
figure(ct),print('A1vsIdealTo295ToLogAbs.eps','-depsc');pause(5)


% Paper figure 8
ct=ct+1;
figure(ct),print('LeakTa295A2withEA.eps','-depsc');pause(5)
ct=ct+1;
figure(ct),print('LeakEnergyPercent295A2withEA.eps','-depsc');pause(5)
