%--------------------------------------------------------------------------
% FILENAME: display_spectrogram
% DISCRIPTION: Plots the spectrogram based on the given inputs
%
% AUHTOR: Kananelo Chabeli
% DATEp: 05-11-2024
%
%--------------------------------------------------------------------------


function display_spectrogram(xaxis, yaxis, matrix, xlabel_str, ylabel_str, title_str)
%--------------------------------------------------------------------------
% Displays the spectrogram of the signal.
%
% Parameters:
%   xaxis (vector): Values to be plotted along x-axis (time by default).
%   yaxis (vector): Values to be plotted along y-axis (frequency in Hz by default).
%   matrix (2D matrix): The spectrogram values (linear scale). Plotted in dB scale.
%   xlabel_str (string): Label for x-axis (defaults to 'time(s)').
%   ylabel_str (string): Label for y-axis (defaults to 'frequency(Hz)').
%   title_str (string): Title of the plot (defaults to 'Spectrogram').
%
% Returns:
%   None
%--------------------------------------------------------------------------

% Parameter checks

    % 1. Check if xaxis is a numeric vector
    if ~isvector(xaxis) || ~isnumeric(xaxis)
        error('xaxis must be a numeric vector.');
    end

    % 2. Check if yaxis is a numeric vector
    if ~isvector(yaxis) || ~isnumeric(yaxis)
     error('yaxis must be a numeric vector.');
    end

    % 3. Check if matrix is a numeric 2D matrix
    if ~ismatrix(matrix) || ~isnumeric(matrix)
        error('matrix must be a numeric 2D matrix.');
    end

    % 4. Check if xlabel_str is a string or character array
    if nargin < 4 || isempty(xlabel_str)
        xlabel_str = 'time(s)';  % Default label for x-axis
    elseif ~ischar(xlabel_str) && ~isstring(xlabel_str)
        error('xlabel must be a string or character array.');
    end

    % 5. Check if ylabel_str is a string or character array
    if nargin < 5 || isempty(ylabel_str)
        ylabel_str = 'frequency(Hz)';  % Default label for y-axis
    elseif ~ischar(ylabel_str) && ~isstring(ylabel_str)
        error('ylabel must be a string or character array.');
    end

    % 6. Check if title_str is a string or character array
    if nargin < 6 || isempty(title_str)
        title_str = 'Spectrogram';  % Default title
    elseif ~ischar(title_str) && ~isstring(title_str)
        error('title must be a string or character array.');
    end

    % Check that the dimensions of xaxis, yaxis, and matrix are compatible
    if length(xaxis) ~= size(matrix, 2)
        error('The length of xaxis must match the number of columns in the matrix.');
    end

    if length(yaxis) ~= size(matrix, 1)
        error('The length of yaxis must match the number of rows in the matrix.');
    end

    % Create the spectrogram plot
    figure;
    % Plot using imagesc (for a 2D matrix) with proper axis labels
    normalized_matrix = abs(matrix) / max(abs(matrix(:)));

    imagesc(xaxis, yaxis, 20*log10(normalized_matrix));  % Convert to dB scale
    axis xy;  % Correct axis orientation (y-axis from bottom to top)
    ylim([0 10])
    % Set the axis labels and title
    xlabel(xlabel_str);
    ylabel(ylabel_str);
    title(title_str);
    % Add a colorbar for dB values
    colorbar;

end
