function h = bar3d_prices(option_data)
unique_maturities = unique(option_data.maturities);
y = unique_maturities;
y = [y(1) - (y(2) - y(1)); y; y(end) + (y(end) - y(end - 1))];
y_b = 0.5.*(y(2:end) + y(1:end-1));
widths_y = diff(y_b);
y_centers = 0.5.*(y_b(2:end,:) + y_b(1:end-1,:));

for i = 1:length(unique_maturities)
    idx_set = option_data.maturities == unique_maturities(i);
    z = option_data.prices(idx_set);
    z = z(:).';
    x = option_data.strikes(idx_set);
    x = x(:).';
    num_strikes = length(x);
    x = [x(1) - (x(2) - x(1)) x x(end) + (x(end) - x(end - 1))];
    x_b = 0.5.*(x(2:end) + x(1:end-1));
    widths_x = diff(x_b);
    x_centers = 0.5.*(x_b(2:end) + x_b(1:end-1));


    for j = 1:num_strikes
        draw_box(x_centers(j), y_centers(i), z(j), widths_x(j), widths_y(i))
    end
end

end

function draw_box(x, y, z, width_x, width_y)
w_x = width_x./2;
w_y = width_y./2;
h = zeros(6,1);
h(1) = patch([-w_x -w_x w_x w_x] + x, [w_y -w_y -w_y w_y] + y, [0 0 0 0], 'b');
h(2) = patch([-w_x -w_x w_x w_x] + x, [w_y -w_y -w_y w_y] + y, [z z z z], 'b');
h(3) = patch([-w_x -w_x -w_x -w_x] + x, [w_y -w_y -w_y w_y] + y, [z z 0 0], 'b');
h(4) = patch([-w_x -w_x w_x w_x] + x, [-w_y -w_y -w_y -w_y] + y, [z 0 0 z], 'b');
h(5) = patch([w_x w_x w_x w_x] + x, [-w_y -w_y w_y w_y] + y, [z 0 0 z], 'b');
h(6) = patch([w_x w_x -w_x -w_x] + x, [w_y w_y w_y w_y] + y, [z 0 0 z], 'b');
set(h,'facecolor','flat','FaceVertexCData',z)
% set(h,'facecolor','flat','FaceVertexCData',z,...
%         'edgecolor', 'none')
% %     'facelighting', 'none',...
% %     'edgecolor', 'none',...

end