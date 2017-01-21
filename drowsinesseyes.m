% deskripsi fungsi mendeteksi mata kantuk dari perhitungan pixel putih pada
% kedua gambar (mata kanan dan kiri) sesuai level bw dan pixel putih yg
% sudah ditentukan pada slide
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, University Gunadarma, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------
function drowsinesseyes(right,left)
 [y,Fs] = audioread('mata_anda_mengantuk.mp3');
 drw = audioplayer(y, Fs);
global levelwhiteR;
global levelwhiteL;
global dronis;
global td;

    [Rbw, Lbw ,lvlwR, lvlwL] = getwhitelevelnbw(right,left);
        %% jika ukuran mata menecil atau menutup 
        if lvlwR < levelwhiteR & lvlwL < levelwhiteL
            %tambahkan nilai dronis 1
            dronis = dronis+1;
        else
            %jika tidak maka var dronis 0
            dronis = 0;
        end
        if dronis <=3
             set(td,'BackgroundColor','g');
        else
            set(td,'BackgroundColor','r');
        end
        %jika var bernilai 6 atau lebih  maka play mp3
        if dronis >=6
            playblocking(drw);
        end
        subplot(3,4,1),imshow(right); title('Mata Kanan','fontsize',10);
        subplot(3,4,2),imshow(Rbw); title('Mata Kanan Biner','fontsize',10);
        subplot(3,4,4), imshow(left); title('Mata Kiri','fontsize',10);
        subplot(3,4,3), imshow(Lbw); title('Mata Kiri Biner','fontsize',10);
