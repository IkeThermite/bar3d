
x = linspace(-3, 3, 20);
y = linspace(-3, 3, 20);
[X, Y] = meshgrid(x, y);
Z = peaks(X, Y);

figure('Units', 'centimeters', 'Position', [5 6 25 12])
subplot(1, 2, 1)
surf(X, Y, Z)
title('surf - Regular Grid');
subplot(1, 2, 2)

X_skew = [repmat(linspace(-1.2, 1.8, 20), 5, 1);
    repmat(linspace(-2.7, 2.2, 20), 10, 1);
    repmat(linspace(-1.5, 1.5, 20), 5, 1)];
Z_skew = peaks(X_skew, Y);
bar3d(X_skew, Y, Z_skew);
title('bar3d - Irregular X-spacing');
view(-40, 30)
grid on
set(gcf, 'Color', 'white');

