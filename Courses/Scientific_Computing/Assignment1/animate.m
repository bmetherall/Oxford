%% Animate.m

% Brady Metherall
% Create an animated plot given x and y coordinates

function animate(x, y, plot_title)
    % animate takes two vectors as input, x and y coordinates
    % animate is a void function, nothing is returned
    
    % Plot axes
    hold off
    plot([],[],'bo','MarkerSize',15,'LineWidth',3);
    axis([-1.1 1.1 -1.1 1.1]); % Set plot range to be -1 to 1 in both x and y (with some tolerance)
    xlabel('x');
    ylabel('y');

    % Animate solution
    for i = 1:length(x) % Loop through each element of the vectors x and y
        if (i == 1)
            h = plot([0 x(i)],[0 y(i)],'bo-','MarkerSize',15,'LineWidth',3);
            axis([-1.1 1.1 -1.1 1.1]); % Set plot range to be -1 to 1 in both x and y (with some tolerance)
            xlabel('x');
            ylabel('y');
            if nargin < 3 % If the title is not passed from the function, assign a default value
                plot_title = 'Animation';
            end
            title(plot_title);
        else
            set(h,'XData',[0 x(i)],'YData',[0 y(i)]);
        end
        pause(0.02);
    end
end
