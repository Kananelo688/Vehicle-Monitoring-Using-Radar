%--------------------------------------------------------------------------
% FILENAME: radar_spectrograms.m
% DESCRIPTION: Plots spectrograms of different  RADAR signals
%
% AUTHOR:Kananelo Chabeli
% DATE: 05-11-2024
%--------------------------------------------------------------------------

clear ; %clear the workspace
close all; %close all figures

%--------------------------------------------------------------------------
%                           1. Parameters
%--------------------------------------------------------------------------

window_size = 2048; %window or frame size
hop_size = 512;  %hop size
filename = "../dataset/Kananelo_White_Lab_walking.wav";
speed_of_light = 299792458; % speed nof light in m/s
carrier_frequency = 24e9; %carrier frequency of the transmitted signal in Hz

%speed to multiply doppler frequencie to convert to speed in m/s
speed_factor = speed_of_light/(2*carrier_frequency);

%
%--------------------------------------------------------------------------
%                           2. Read Audio File
%--------------------------------------------------------------------------

[data,sampling_freq] = audioread(filename);

%--------------------------------------------------------------------------
%                           3. Compute Spectrogram using custom fucntion
%--------------------------------------------------------------------------

[t,f,spec] = custom_spectrogram(data,hamming(window_size),hop_size,sampling_freq);

%--------------------------------------------------------------------------
%                           4. Plotting Spectrogram
%--------------------------------------------------------------------------
%speed in m/s
target_speed_ms =  speed_factor*f;          

%convert Doppler frequencies to speed                                        
display_spectrogram(t,target_speed_ms,spec,'time(seconds)','speed(m/s)','Spectrogram when Zaakir is running');









