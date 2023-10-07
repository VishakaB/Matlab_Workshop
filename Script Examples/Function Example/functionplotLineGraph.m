function y = plotLineGraph(x, y, xLabel, yLabel, titleText)
    % Create a line plot
    plot(x, y, 'b-', 'LineWidth', 2);
    
    % Add labels and title
    xlabel(xLabel);
    ylabel(yLabel);
    title(titleText);
    
    % Add grid
    grid on;
    
    % Customize other plot properties as needed
    % For example, you can add legend, change axis limits, etc.
    
    % Save or display the plot
    % saveas(gcf, 'line_plot.png'); % Uncomment to save the plot as an image
end





