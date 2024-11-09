%--------------------------------------------------------------------------
% FILENAME: custom_spectrogram
% DESCRIPTION: Computes the spectrogram of the given digital signal
%
% AUTHOR: Kananelo Chabeli
% DATE: 05-11-2024
%
%--------------------------------------------------------------------------



function [time,frequencies,matrix] = custom_spectrogram(data, window, hop_size, fs)
%--------------------------------------------------------------------------
%   Computes the spectrogram of the input signal.
%
%   Parameters:
%       data(vector): Input signal whose spectrogram is to be computed
%
%       window(int or vector): if vector, this is will be window function
%       used for STFT. If int, is specifies the window size. Window
%       Function is taken to be hamming window function.
%
%       hop_size(int): specifies the number of sample to move to the right
%       by for taking the next frame.
%
%       fs(double): specifies the samplimng rate(in Hz) of the input signal
%
%   Returns:
%      time: time axis in seconds.
%      frequencies: frequency axis in Hz
%      matrix: spectrogram data ( complex)
%--------------------------------------------------------------------------

    %check the window parameter
    if isvector(window)
        % If it's a vector, use it directly (i.e., a custom window function)
        window = window(:);  % Make sure it's a column vector if it's not already
    elseif isscalar(window)
        % If it's an integer, generate a Hamming window of that size
        window = hamming(window);
    else
        error('Window must be either an integer (window size) or a vector (window function).');
    end

    % Step 1: compuite parameters required for computation of the
    % spectrogram.
    
    
    N = length(data);  % param1: number of samples in the signal
    K = length(window); %param 2: frame or window size
    %N.B param3 is hop_size given as the argument
    
    % Step 2: Initialize variables and buffers
    
    no_of_frames = floor((N - K) / hop_size) + 1; 
    
    no_of_freq_bins = floor(K / 2) + 1;
    
    matrix = zeros(no_of_freq_bins, no_of_frames);

    %time and frequency axes:
    time = (0:no_of_frames-1) * (hop_size / fs); %time axis is influenced by hop_size
    
    frequencies = (0:no_of_freq_bins-1) * (fs / K); %frequency axis labeled in Hz
    
    %step 3: Iterate in all segment, computing DFT of each windowed segment
    for frame = 0:no_of_frames-1 %first frame is called frame0
        %the start index of the frame samples in the actual signal
        start_index = frame * hop_size + 1;
        if start_index + K - 1 > N
            break;  % prevent out-of-bounds indexing
        end
        
        %obtain the windowed sigment of the current frame
        windowed_segment = window .* data(start_index:start_index + K - 1);
        
        %compute the DFT of the windowed signal(its magnitude actually)
        windowed_segment_dft = abs(fft(windowed_segment));
        
        %add the first half of the frequencies in the matrix
        matrix(:, frame + 1) = windowed_segment_dft(1:no_of_freq_bins);
    end
   
end
