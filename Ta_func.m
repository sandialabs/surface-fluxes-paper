function res = Ta_func(ma) 
global Tfreeze Rv Lv p0 c1c2 md;
res = 1./((1 / Tfreeze) - (Rv / Lv) * log((p0 / (c1c2)) .* ma ./ (md + ma)));
end