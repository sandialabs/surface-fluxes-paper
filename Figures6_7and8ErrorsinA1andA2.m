% © 2025 National Technology & Engineering Solutions of Sandia, LLC
% (NTESS).  Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
% Government retains certain rights in this software.
%
% SPDX-License-Identifier: BSD-3-Clause


global MA0 TA0
load('ErrorData.mat')

macary = linspace(0, 30, 1001);
Ta_steady_curve = Ta_func(macary);

% === Plot results ===
labels = {'$m_a^v$', '$T_a$', '$T_o$'};
a=[10,1,1];

    t = 1;
    To_val = Toinit;
    diff31 = 100 * (finals_case3(:,:,:,t) - finals_case1(:,:,:,t)) ./ finals_case1(:,:,:,t);
    diff21 = 100 * (finals_case2(:,:,:,t) - finals_case1(:,:,:,t)) ./ finals_case1(:,:,:,t);
    for k = 1:3
        plot_field(MA0,TA0,diff31(:,:,k), macary,Ta_steady_curve, [-a(k) a(k)]);
    end
    for k = 1:3
        plot_field(MA0,TA0,log(abs(diff21(:,:,k))), macary,Ta_steady_curve, [-10 10]);
    end

    To_init = Toinit;
    ma0 = MA0;
    Ta0 = TA0;
    To0 = To_init;

    for caseIdx = 1:3
        finals = eval(sprintf('finals_case%d(:,:,:,t)', caseIdx));
        ma_f = finals(:,:,1);
        Ta_f = finals(:,:,2);
        To_f = finals(:,:,3);
        % Reconstruct mo_f
        mo_f = moinit + ma0 - ma_f;
        % Final Energy
        Ef = Ta_f .* (cpd*md + cpv .* ma_f) + ...
            (Lv + Ll) .* ma_f + ...
            To_f .* cl .* mo_f + ...
            Ll .* mo_f;
        % Initial Energy
        Ei = Ta0 .* (cpd*md + cpv .* ma0) + ...
            (Lv + Ll) .* ma0 + ...
            To0 .* cl .* moinit + ...
            Ll .* moinit;
        denom = (cpd*md + cpv*ma_f);  % constant denominator for clarity
        if caseIdx >=2
            % Final Energy
            Ef = Ta_f .* (cpd*md + cpd .* ma_f) + ...
                (Lv + Ll) .* ma_f + ...
                To_f .* cl .* mo_f + ...
                Ll .* mo_f;
            % Initial Energy
            Ei = Ta0 .* (cpd*md + cpd .* ma0) + ...
                (Lv + Ll) .* ma0 + ...
                To0 .* cl .* moinit + ...
                Ll .* moinit;
            denom = (cpd*md + cpd*ma_f);  % constant denominator for clarity
        end
        % Delta T_leak
        dTleak = (Ef - Ei)./denom;
        EnergyError = (Ef - Ei)./Ei*100;
        % Store
        eval(sprintf('DeltaT_leak_case%d(:,:,t) = dTleak;', caseIdx));
        eval(sprintf('EnergyError_leak_case%d(:,:,t) = EnergyError;', caseIdx));
    end

caseLabels = {'Ideal', 'A1', 'A2'};

    To_val = Toinit;
    for caseIdx = 3
        leak = eval(sprintf('DeltaT_leak_case%d(:,:,t)', caseIdx));
        plot_field(MA0,TA0,leak, macary,Ta_steady_curve, [-30 30]);
    end

    To_val = Toinit;
    for caseIdx = 3
        leak = eval(sprintf('EnergyError_leak_case%d(:,:,t)', caseIdx));
        plot_field(MA0,TA0,leak, macary,Ta_steady_curve, [-1 1]);
    end




function plot_field(MA0,TA0,field,macary,Ta_ss,clims)
figure;
contourf(MA0, TA0, field, 20, 'LineColor','none');
hold on
plot(macary, Ta_ss, 'k--', 'LineWidth', 3);
xlim([0 30]); ylim([275 325]);
colorbar;
colormap(bluewhitered(10000))
clim(clims)
colormap(bluewhitered(10000))
xlabel('$m_a^v$[kg]'); ylabel('$T_a$[K]');
set(gca, 'FontSize', 24);
end
