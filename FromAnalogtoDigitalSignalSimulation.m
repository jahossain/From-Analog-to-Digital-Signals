%% Assignment 1 – From Analog to Digital Signals with MATLAB
% Author: Md Junayed Al Hossain
% Course: Mathematical Algorithms (Savonia UAS)
% Description:
% This script simulates the full path from analog signals to digital data:
% 1. Analog signal generation
% 2. Sampling
% 3. Quantization
% 4. Encoding to binary
% 5. Digital bitstream formation

clc; clear; close all;

%% --------------------------------------------------------
% 1. ANALOG SIGNAL GENERATION
% ---------------------------------------------------------

t = 0:0.0001:0.01;      % Fine time -> "continuous-like"
f = 100;                % Analog frequency (100 Hz)

x_analog = sin(2*pi*f*t);

figure;
plot(t, x_analog, 'LineWidth', 1.5);
title('Analog Signal (Sine Wave)');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;


%% --------------------------------------------------------
% 2. SAMPLING
% ---------------------------------------------------------

Fs = 1000;              % Sampling frequency (1 kHz)
Ts = 1/Fs;              % Sampling period

n = 0:Ts:0.01;          % Discrete-time sample points
x_sampled = sin(2*pi*f*n);

figure;
stem(n, x_sampled, 'filled');
title('Sampled Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;


%% --------------------------------------------------------
% 3. QUANTIZATION
% ---------------------------------------------------------

bits = 4;                        % 4-bit quantization
levels = 2^bits;                 % Number of levels

x_min = min(x_sampled);
x_max = max(x_sampled);

q_step = (x_max - x_min) / levels;

% Convert each sample to its quantization index
x_index = round((x_sampled - x_min) / q_step);

% Convert back to amplitude (quantized)
x_quantized = x_index * q_step + x_min;

figure;
stem(n, x_quantized, 'filled');
title(['Quantized Signal (' num2str(bits) '-bit)']);
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;


%% --------------------------------------------------------
% 4. ENCODING – Binary representation
% ---------------------------------------------------------

binary_codes = dec2bin(x_index, bits);

disp('--- First 10 encoded samples (binary) ---');
disp(binary_codes(1:10, :));


%% --------------------------------------------------------
% 5. DIGITAL BITSTREAM
% ---------------------------------------------------------

bitstream = reshape(binary_codes.', 1, []);   % Convert matrix → 1 row of bits

disp('--- First 40 bits of the bitstream ---');
disp(bitstream(1:40));


%% --------------------------------------------------------
% SUMMARY
% ---------------------------------------------------------

fprintf('\nSimulation complete!\n');
fprintf('Analog → Sampling → Quantization → Encoding → Digital Bitstream\n\n');
fprintf('Bits per sample: %d\n', bits);
fprintf('Total samples: %d\n', length(x_sampled));
fprintf('Total bits in stream: %d\n', length(bitstream));
