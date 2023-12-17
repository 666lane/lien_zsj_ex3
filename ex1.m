
%%
% 生成白噪声信号
Fs = 1000;  % 采样频率
T = 1/Fs;   % 采样间隔
t = 0:T:1;  % 时间向量
N = length(t); % 信号长度
% 生成白噪声信号
white_noise = randn(1, N);
% 设计一阶低通滤波器
fc = 50;  % 截止频率
[b, a] = butter(1, fc/(Fs/2), 'low');
% 通过滤波器滤波
filtered_signal = filter(b, a, white_noise);
% 绘制输入输出波形对比
figure;
subplot(2,2,1);
plot(t, white_noise);
title('输入白噪声波形');
subplot(2,2,2);
plot(t, filtered_signal);
title('通过低通滤波器后的波形');
% 计算并绘制自相关函数
subplot(2,2,3);
[correlation_lag, auto_corr] = xcorr(white_noise, 'coeff');
plot(auto_corr,correlation_lag);
title('输入白噪声自相关函数');
subplot(2,2,4);
[correlation_lag_filtered, auto_corr_filtered] = xcorr(filtered_signal, 'coeff');
plot( auto_corr_filtered,correlation_lag_filtered);
title('滤波后信号自相关函数');
% 计算并绘制功率谱密度
figure;
subplot(2,1,1);
pwelch(white_noise, [], [], [], Fs);
title('输入白噪声功率谱密度');
subplot(2,1,2);
pwelch(filtered_signal, [], [], [], Fs);
title('滤波后信号功率谱密度');
% 计算功率和互相关函数
power_input = sum(white_noise.^2) / N;
power_output = sum(filtered_signal.^2) / N;
[correlation_lag_cross, cross_corr] = xcorr(white_noise, filtered_signal, 'coeff');
% 显示功率和互相关函数
disp(['输入白噪声功率: ', num2str(power_input)]);
disp(['滤波后信号功率: ', num2str(power_output)]);
figure;
subplot(2,1,1);
plot( cross_corr,correlation_lag_cross);
title('输入白噪声与滤波后信号的互相关函数');
subplot(2,1,2);
plot(t, white_noise, t, filtered_signal);
legend('输入白噪声', '滤波后信号');
title('输入白噪声与滤波后信号的波形对比');

%%
% 参数设置
Fs = 1000;  % 采样频率
T = 1/Fs;   % 采样间隔
t = 0:T:1;  % 时间向量
N = length(t); % 信号长度
% 生成白噪声信号
white_noise = randn(1, N);
% 不同带宽的低通滤波器
fc1 = 50;   % 第一个滤波器截止频率
fc2 = 200;  % 第二个滤波器截止频率
[b1, a1] = butter(4, fc1/(Fs/2), 'low');
filtered_signal1 = filter(b1, a1, white_noise);
[b2, a2] = butter(4, fc2/(Fs/2), 'low');
filtered_signal2 = filter(b2, a2, white_noise);
% 绘制白噪声波形
figure;
subplot(3,1,1);
plot(t, white_noise);
title('输入白噪声波形');
% 绘制经过不同带宽低通滤波器后的波形
subplot(3,1,2);
plot(t, filtered_signal1);
title(['通过低通滤波器（截止频率 ', num2str(fc1), ' Hz）后的波形']);
subplot(3,1,3);
plot(t, filtered_signal2);
title(['通过低通滤波器（截止频率 ', num2str(fc2), ' Hz）后的波形']);
% 绘制概率密度函数
figure;
edges = -5:0.1:5; % 选择适当的区间和步长
pdf_white = normpdf(edges, 0, 1); % 白噪声的概率密度函数
subplot(3,1,1);
plot(edges, pdf_white);
title('白噪声的概率密度函数');
pdf_filtered1 = normpdf(edges, mean(filtered_signal1), std(filtered_signal1));
subplot(3,1,2);
plot(edges, pdf_filtered1);
title(['通过低通滤波器后的概率密度函数（截止频率 ', num2str(fc1), ' Hz）']);
pdf_filtered2 = normpdf(edges, mean(filtered_signal2), std(filtered_signal2));
subplot(3,1,3);
plot(edges, pdf_filtered2);
title(['通过低通滤波器后的概率密度函数（截止频率 ', num2str(fc2), ' Hz）']);


%%
% 步骤 1: 生成窄带随机过程（调制的方法）
Fs = 1000; % 采样频率
T = 1/Fs; % 采样时间间隔
t = 0:T:1; % 时间向量
f0 = 50; % 信号的中心频率
A = 1; % 信号的振幅
% 生成窄带信号
narrowband_signal = A * cos(2*pi*f0*t);
% 生成高斯白噪声
noise = 0.1 * randn(size(t));
% 将窄带信号调制到高频
carrier_frequency = 500; % 载波频率
modulated_signal = narrowband_signal .* cos(2*pi*carrier_frequency*t);
% 加入高斯白噪声
narrowband_random_process = modulated_signal + noise;
figure;
subplot(2, 1, 1);
plot(t, narrowband_signal);
title('原始窄带信号');
xlabel('时间 (秒)');
ylabel('幅度');
subplot(2, 1, 2);
plot(t, modulated_signal);
title('调制后的信号');
xlabel('时间 (秒)');
ylabel('幅度');

%%
% 步骤 1: 生成白噪声
Fs = 1000; % 采样频率
T = 1/Fs; % 采样时间间隔
t = 0:T:1; % 时间向量
white_noise = 0.1 * randn(size(t));
% 步骤 2: 设计带通滤波器
center_frequency = 50; % 带通中心频率
bandwidth = 20; % 带宽
% 设计带通滤波器
[b, a] = butter(4, [(center_frequency - bandwidth/2)/(Fs/2), (center_frequency + bandwidth/2)/(Fs/2)], 'bandpass');
% 步骤 3: 通过滤波器处理白噪声
narrowband_signal = filter(b, a, white_noise);
figure;
subplot(2, 1, 1);
plot(t, white_noise);
title('白噪声');
xlabel('时间 (秒)');
ylabel('幅度');
subplot(2, 1, 2);
plot(t, narrowband_signal);
title('窄带信号');
xlabel('时间 (秒)');
ylabel('幅度');
