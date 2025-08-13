% © 2025 National Technology & Engineering Solutions of Sandia, LLC
% (NTESS).  Under the terms of Contract DE-NA0003525 with NTESS, the U.S.
% Government retains certain rights in this software.
%
% SPDX-License-Identifier: BSD-3-Clause


function res = qsat(T)
    global p0 Lv Rv c1c2 Tfreeze;
    res = c1c2 / p0 * exp(-Lv / Rv * (1./T - 1/Tfreeze));
end
