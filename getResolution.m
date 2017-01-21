function[out]=getResolution()
% deskripsi fungsi mendapatkan resolusi kamera terbaik:
% syntax :
%   [out]=getResolution()
%
% Input Parameters :
%
% Return Parameters :
%   out := Resolusi Kamera Tertinggi
%
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, Gunadarma University, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------

% menapatkan informasi dari hardwere
info = imaqhwinfo('winvideo');

% check hardwere ada
if (isempty(info.DeviceIDs))
    error('No Image Aquisition Adaptor available');
end

% memasukan resolusi2 yg didukung oleh hardwere ke var array
f= info.DeviceInfo.SupportedFormats;
max=0;

% pecahkan ke var a 
% gunakan regex buat replace string dan ambil resolusi tertinggi
for i=1:length(f)
    a=f{i};
    s = regexprep(a, 'MJPG_', '');
    s = regexprep(s, 'YUY2_', '');
    s = regexprep(s, 'I420_', '');
    s = regexprep(s, 'RGB24_', '');
    s = regexprep(s, 'x', '*');
    if max<eval(s)
        out=a;
        max=eval(s);
    end
end

end
