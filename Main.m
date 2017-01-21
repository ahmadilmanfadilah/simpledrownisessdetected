% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, Gunadarma University, Jakarta
% email: ilmanfadilah@gmail.com
% Image Acquisition Toolbox harus sudah terinstall
% pakai kaca mata belum di test
% -------------------------------------------------------------------------
%menutup semua figure yg masih tampil
%close all;
%menghapus semua variable dari memori
clear all;

% set figure visible on (ditampilkan)
set(0,'DefaultFigureVisible','on');
%ambil input video dari webcam
vid= videoinput('winvideo',1,getResolution());
%konfigrasi triger video manual (biar ga putus2 pas ambil gambar)
triggerconfig(vid,'manual');
% ambil video RGB
set(vid,'ReturnedColorSpace','rgb' );
%memulai mengambil gambar
start(vid);
%deklarasi varible global
global fig;
global flag;
global T; 
global tstart;
global tstop;
global slide;
global sv;
global Konf;
global Drowapp;
global td;
Konf =1;
Drowapp =0;
% set full screen
scrsz = get(0,'ScreenSize');
% set fungsi close pada figure
fig = figure('CloseRequestFcn',{@fungsiclose,vid},'Position',scrsz);
% hapus default title figure
set(gcf, 'Name', 'Aplikasi Deteksi Mata Kantuk', 'NumberTitle', 'Off');
%hapus tool bar figue
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
td = uicontrol(fig,'Style','pushbutton','String','',...
                'fontsize',12,'FontWeight','bold','Position', [400 20 600 40]); % membuat indikator
tk = uicontrol(fig,'Style','pushbutton','String','Keluar',...
                'fontsize',12,'FontWeight','bold','Position', [1070 140 100 250],...
                'Callback', @fungsiclose); % membuat tombol keluar
tstart = uicontrol(fig,'Style','pushbutton','String','Start',...
                'fontsize',12,'FontWeight','bold','Position',[1200 290 100 100],...
                'Callback', @fungsistart); % membuat tombol Start
tstop = uicontrol(fig,'Style','pushbutton','String','Stop',...
                'fontsize',12,'FontWeight','bold','Position',[1200 140 100 100],...
                'Callback', @fungsistop); % membuat tombol stop
slide = uicontrol(fig,'Style','slider',...
                'Min',0,'Max',0.50,'Value',0,...
                'SliderStep',[0.01 0.01],...
                'Position',[300, 120, 40, 300]);
sl = uicontrol(fig,'Style','text','String','Level BW','Position',[180, 20 100, 300],'fontsize',12,'FontWeight','bold');
sv = uicontrol(fig,'Style','text','String','0','Position',[180, -30 100, 300],'fontsize',12,'FontWeight','bold');
set(tstop,'enable','off');
set(td,'enable','off');
set(td,'visible','off');
flag = 0;
%set nilai runloop true
runLoop = true;
%set nilai framecount 0
frameCount = 0; 
%baca audio Tidak_Ada_Mata_Terdeteksi.mp3
[y,Fs] = audioread('tidak_ada_wajah,_atau_mata_terdeteksi.mp3');
%variable p sebagai audio player
p = audioplayer(y, Fs);
%perulangan ambil gambar tiada batas sampai user kelik tombol keluar
while runLoop && frameCount < 2
    frameCount = frameCount + 1;
    % ambil gambar dari input video 
    snapshot0 = getsnapshot(vid);
    % fungsi utama untuk mendeteksi wajah dan kedua mata
    [T, Rectanglekanan, Rectanglekiri] = getImg(snapshot0);
    if T ~=-1
    % menampilkan gambar dengan garis Rectangle /kotak ke kedua mata jika terdeteksi
       subplot(3,4,5:12), imshow(snapshot0,'InitialMagnification','fit'); title('Main Frame','fontsize',10);
        hold on;
        %memasukan garis Rectangle /kotak ke kedua mata
        plot (Rectanglekanan(:,1), Rectanglekanan(:,2), 'r');
        plot (Rectanglekiri(:,1), Rectanglekiri(:,2), 'r');
		%indikator terlihat jika pendeteksian mata kantuk berjalan
        if Konf==0
            set(td,'visible','on');
        else
            set(td,'visible','off');
        end
    else
        %hanya menampilkan gambar saja
       subplot(3,4,5:12), imshow(snapshot0); title('Main Frame','fontsize',10);
       %play audio player jika mata tidak ditemukan
       if T == -1
            playblocking(p);
       end
    end
    
    %pause script agar matlab menampilkan figure dengan gambar
    pause(0.05);
    hold off;
    frameCount = frameCount - 1;
    if flag == 1 %loop berhenti jika flag bernilai 1
      break;
    end
end
% berhenti pengambilan video input
stop(vid);
%hapus variable dari memori
clear;
%clear screen command window
clc;