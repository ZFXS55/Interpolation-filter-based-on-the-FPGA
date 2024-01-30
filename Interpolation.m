N  =  256;        %采样点数 256
n  =  0:1:N-1;    %采样序列
Ts =  0.5*1e-6;  %采样周期  2MHz 在FPGA里是25个时钟一个点，时钟是50MHz
fs =  1/Ts;       %采样率 2MHz
tn =  n*Ts ;      %离散采样时间段
A1 =  1;
f1 =  1*1e4;
xn =  A1*sin(2*pi*tn/N*fs);
stem(tn,xn);

% 采样序列为input_seq，长度为256
input_seq = xn; % 输入的采样序列

% 25倍插值后的序列长度
interp_length = 256 * 25;

% 进行插零值
zero_padded_seq = zeros(1, interp_length);
zero_padded_seq(1:25:end) = input_seq;

% 设计低通滤波器
filter_order = 99; % 滤波器阶数
cutoff_freq = 0.04; % 截止频率
filter_coeff = fir1(filter_order, cutoff_freq);


% 应用低通滤波器
filtered_seq = conv(zero_padded_seq, filter_coeff, 'same');
%filtered_seq = conv(zero_padded_seq, fix_x, 'same');
% 输出插值后的序列
output_seq = 25*filtered_seq;

% 绘制结果
figure;
subplot(3, 1, 1);
plot(input_seq);
title('原始序列');
subplot(3, 1, 2);
plot(zero_padded_seq);
title('补0后的序列');

subplot(3, 1, 3);
plot(output_seq);
title('插值和滤波后的序列');












%%
%%事实证明这段代码可以用~~~这玩意是把系数写进coe文件，至于放大不放大再说吧。
% 定义数组
%x = [CompModule12.APF.SOS]; % 长为56的double型数组
%x = [CompModule12.APF.a CompModule12.APF.b]; % 长为56的double型数组

% 将矩阵转化为1行10列的矩阵
%x = reshape(x', [1,10])
% 放大2的16次幂
x = filter_coeff * 20;
qpath = quantizer('fixed','round','saturate',[20,0]);
fix_x = quantize(qpath,x);

% 转换为16进制有符号数
% x_hex = dec2hex(typecast(int16(x), 'uint16')); % 转换为无符号整型，并转换为16进制字符串
% x_hex = reshape(x_hex, [], 4); % 将16进制字符串按4个字符一组划分
% fix_x = flipud(fix_x); % 翻转顺序，以满足coe文件的顺序要求
% fix_x = cellstr(fix_x); % 转换为cell数组
% fix_x = strcat(fix_x, {';'}); % 添加分号

% 存储coe文件

% 2. 将输入数组转换为16进制字符串
hex_string = dec2hex(fix_x)
% 3. 将16进制字符串写入coe文件
filename = ' G:\BaiduNetdiskWorkspace\English_path\Interpolation\Interpolation_fir_99order.coe'; % 文件名

fileID = fopen(filename, 'w');
fprintf(fileID, 'memory_initialization_radix=16;\nmemory_initialization_vector=\n');
for i = 1:size(hex_string, 1)
    fprintf(fileID, '%s,\n', hex_string(i,:));
end
fclose(fileID);













