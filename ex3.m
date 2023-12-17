clear all
% 设置ARMA模型参数
order_AR = 2;
order_MA = 1;
coeff_AR = [0.5, -0.3]; % 修改为您所需的AR系数
coeff_MA = 0.2;        % 修改为您所需的MA系数

% 生成ARMA模型信号
num_samples = 1000;
variance = 1; % 模型的方差，可根据需要修改
arma_model = arima('ARLags', 1:order_AR, 'AR', coeff_AR, 'MALags', 1:order_MA, 'MA', coeff_MA, 'Variance', variance, 'Constant', 0); % 添加方差和常数项

% 生成ARMA模型信号
arma_simulated_data = simulate(arma_model, num_samples);

% 画出波形
figure;
plot(arma_simulated_data);
title('ARMA模型信号');
xlabel('Time');
ylabel('Amplitude');

% 估计均值和方差
estimated_mean_arma = mean(arma_simulated_data);
estimated_variance_arma = var(arma_simulated_data);

% 估计自相关函数
max_lag_arma = 20; % 可根据需要修改
acf_values_arma = autocorr(arma_simulated_data, max_lag_arma);

% 画出自相关函数
figure;
plot(0:max_lag_arma, acf_values_arma);
title('自相关函数 (ARMA)');
xlabel('Lag');
ylabel('Autocorrelation');

% 估计功率谱密度
figure;
pwelch(arma_simulated_data);


% 显示估计的均值和方差
disp(['ARMA模型信号均值: ' num2str(estimated_mean_arma)]);
disp(['ARMA模型信号方差: ' num2str(estimated_variance_arma)]);
