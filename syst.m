% © 2025 National Technology & Engineering Solutions of Sandia, LLC
% (NTESS).  Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
% Government retains certain rights in this software.
%
% SPDX-License-Identifier: BSD-3-Clause


%% ========== System ODE ==========
function res = syst(~, x)
    global cpd cpv cl Lv ch absu za lam md ideal smooth A1;

    ma = x(1); mo = x(2); Ta = x(3); To = x(4);
    ff = (ma + md) * qsat(Ta) - ma;

    if smooth
        evap = ch * absu / za * 0.5 * ff .* (1 + tanh(100 * ff));
        condens = lam * -0.5 * ff .* (1 + tanh(-100 * ff));
    else
        evap = ch * absu / za * max(ff, 0);
        condens = lam * max(-ff, 0);

    end

    mixingi = 0;
    mixingc = 0;

    if ideal
        res = [
            -condens + evap;
             condens - evap;
            -evap * cpv*(Ta - To)/(cpd*md + cpv*ma) ...
            - condens*(cl*Ta - cpv*Ta - Lv)/(cpd*md + cpv*ma) ...
            - mixingi/(cpd*md + cpv*ma);
            -evap * (cpv*To + Lv - cl*To)/cl/mo ...
            - condens*(To - Ta)/mo ...
            + mixingi/cl/mo
        ];
    elseif A1
        res = [
            -condens + evap;
             condens - evap;
            -evap * (cpd*Ta - cl*To)/(cpd*md + cpd*ma) ...
            - condens*(cl*Ta - cpd*Ta - Lv)/cpd/(md + ma) ...
            - mixingc/(cpd*md + cpd*ma);
            -evap * Lv/cl/mo ...
            - condens*(To - Ta)/mo ...
            + mixingc/cl/mo
        ];
    else
        res = [
            -condens + evap;
             condens - evap;
            -condens * (-cpd*Ta - Lv)/cpd/(md + ma) ...
            - mixingc/(cpd*md + cpd*ma);
            -evap * Lv/cl/mo ...
            - condens*(To - Ta)/mo ...
            + mixingc/cl/mo
        ];
    end
end

