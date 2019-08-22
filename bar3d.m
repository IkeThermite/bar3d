function h = bar3d( X, Y, Z )
%BAR3D Can create a 3D bar plot with irregular spacing.
%
% bar3d will create a 3D bar plot where the x- and y-coordinates of the
% center of the columns base are specified in X and Y and the corresponding
% height of the column is specified in Z. This extends the capabilities of
% the "bar3" function in MATLAB, as the width and length of the base of the
% is determined from the surrounding coordinates and does not need to be
% across both dimensions.
%

x = [X(:,1) - (X(:,2) - X(:,1)) X X(:,end) + (X(:,end) - X(:,end-1))];
y = [Y(1,:) - (Y(2,:) - Y(1,:)); Y; Y(end,:) + (Y(end,:) - Y(end-1,:))];   
x_b = 0.5.*(x(:,2:end) + x(:,1:end-1));
y_b = 0.5.*(y(2:end,:) + y(1:end-1,:));
widths_x = diff(x_b, 1, 2);
widths_y = diff(y_b, 1, 1);
Y_centers = 0.5.*(y_b(2:end,:) + y_b(1:end-1,:));
X_centers = 0.5.*(x_b(:,2:end) + x_b(:,1:end-1));

[x_len, y_len] = size(X);

for i = 1:x_len
    for j = 1:y_len
        draw_box(X_centers(i,j), Y_centers(i,j), Z(i,j), widths_x(i,j), widths_y(i,j))
    end    
end
h = gca;

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

end