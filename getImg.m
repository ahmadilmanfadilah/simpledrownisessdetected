% deskripsi fungsi mendeteksi mata pada gambar dan memisahkan mata kanan dan kiri
% Uses (syntax) :
%   [T, Rectanglekanan, Rectanglekiri] = getImg(snapshot0)
%
% Input Parameters :
%   snapshot0 := RGB-Image (m-by-n-by-3 matrix)
% 
% Return Parameters :
%   out := 3-by-4 matrix; bounding boxes [y, x, y-width, x-width] of 
%           1:Wajah
%           2:Mata kanan
%           3:Mata kiri
%   T := -1 jika tidak ada wajah / mata
% 
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, University Gunadarma, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------
function  [T, Rectanglekanan, Rectanglekiri] = getImg(snapshot0)
%deklarasi variable global
global Konf;
global Drowapp;
global levelbw;
global levelwhiteR;
global levelwhiteL;
global RIbw;
global LIbw;
global slide;
global sv;
%pengambilan nilai bw dari slider
slv = get(slide,'value');
set(sv,'String',slv);
levelbw = slv;
%kirim gambar ke fungsi getFaces
out = getFaces(snapshot0);
%jika wajah tidak terdeteksi return nilai -1
if(out==-1)
    T=-1;
    Rectanglekanan =-1;
    Rectanglekiri  =-1;
else
        %crop snapshot0 dan ambil mata kanan dan kiri 
        matakiri=(snapshot0(out(3,2):out(3,2)+out(3,4),out(3,1):out(3,1)+out(3,3),:));
        matakanan=(snapshot0(out(2,2):out(2,2)+out(2,4),out(2,1):out(2,1)+out(2,3),:));
        %membuat garis Rectangle/ kotak
        Rectanglekiri = [out(3,1) out(3,2); out(3,1)+out(3,3) out(3,2); out(3,1)+out(3,3) out(3,2)+out(3,4); out(3,1)  out(3,2)+out(3,4); out(3,1) out(3,2)];
        Rectanglekanan = [out(2,1) out(2,2); out(2,1)+out(2,3) out(2,2); out(2,1)+out(2,3) out(2,2)+out(2,4); out(2,1)  out(2,2)+out(2,4); out(2,1) out(2,2)];
    %jika lagi ga mode konfig maka mendeteksi mata kantuk
    if Konf ~=1
            %jika var levelwhiteR kosong dan levelwhiteL kosong dan Drowapp bernilai 1
            if not( isempty(levelwhiteR) && isempty(levelwhiteL)) && Drowapp ==1
            %maka deteksi mata kantuk
            drowsinesseyes(matakanan,matakiri);
            end
    else
	%jika lagi mode konfig ni skrip yg dijalanin
         % jika var levelwhiteR & levelwhiteL kosong
        if isempty(levelwhiteR) && isempty(levelwhiteL)
            %tentukan nilai levelwhiteR, levelwhiteL terlebih dahulu
            [RIbw ,LIbw, levelwhiteR, levelwhiteL] = getwhitelevelnbw(matakanan,matakiri);
        else
            % jika var levelwhiteR & levelwhiteL tidak kosong
            %perbaharui nilai var levelwhiteR, levelwhiteL
            [RIbw, LIbw ,levelwhiteR, levelwhiteL] = getwhitelevelnbw(matakanan,matakiri);
            %menampilkan mata kanan dan kiri RGB dan biner
            subplot(3,4,1),imshow(matakanan); title('Mata Kanan','fontsize',10); 
            subplot(3,4,2),imshow(RIbw); title('Mata Kanan Biner','fontsize',10);
            subplot(3,4,4), imshow(matakiri); title('Mata Kiri','fontsize',10); 
            subplot(3,4,3), imshow(LIbw); title('Mata Kiri Biner','fontsize',10);
        end
    end
    T = -2;
end