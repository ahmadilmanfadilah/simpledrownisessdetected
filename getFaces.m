% deskripsi fungsi mendeteksi wajah pada gambar dan memilah mata kanan dan kiri
% Uses (syntax) :
%   out = getFaces(snapshot0);
%
% Input Parameters :
%   snapshot0 := RGB-Image (m-by-n-by-3 matrix)
% 
% Return Parameters :
%   out := 3-by-4 matrix; bounding boxes of [y, x, y-width, x-width]
%           1:Face
%           2:Mata Kanan
%           3:Mata kiri
% 
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, University Gunadarma, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------
function[out]=getFaces(snapshot0)
%var out = -1 jika tidak ada wajah (mata juga pasti ga ada)
out=-1;
%skala = 8 agar posisi penentuan posisi wajah dan mata lebih cepat dan akurat
skala =8;
%var FaceDetect = di isi dengan fungsi deteksi wajah menggunakan algoritma viola jones
FaceDetect = vision.CascadeObjectDetector();
%Gambar di rubah ukuran dan di konversi ke rgb2gray lalu deteksi posisi wajah pada gambar
wajah=step(FaceDetect,rgb2gray(snapshot0(1:skala:end,1:skala:end,:)));
%jika wajah terdeteksi
if ~isempty(wajah)
    %isi variable out dengan matrix 3x4 dengan nilai per index 0
    out=zeros(3,4);
    %nilai matrix wajah, indexnya dikurangi satu biar ga ter lalu ke kiri bawah gambar (kanan kalau di layar)
    wajah(1,:) = wajah(1,:)-1;
    wajah(2,:) = wajah(1,:)-1;
    wajah(3,:) = wajah(1,:)-1;
    wajah(4,:) = wajah(1,:)-1;
    %ambil wajah dengan ukuran tertinggi
    pos = find( wajah(:,3)==max(wajah(:,3)));
    pos=pos(1);
    %baris pertama var out ber isi posisi wajah dengan nilai dari mengkalikan semua nilai kolom wajah dengan skala
    out(1,:)=(wajah(pos,:)*skala);
    %ambil nilai baris ke 1 kolom ke 3 dari var out
    siz=out(1,3);
    
%     membuat Bounding Box for mata kanan
    kiri=0.2;
    kanan=0.60;
    atas=0.34;
    bawah=0.58;
	%perhitungsn untuk nilai out baris ke 2
    out(2,:)=[out(1,1)+siz*kiri,out(1,2)+siz*atas,siz*(1-kanan-kiri),siz*(1-atas-bawah)];
    
%    membuat Bounding Box for mata kiri
    kiri=0.60;
    kanan=0.2;
    atas=0.34;
    bawah=0.58;
	%perhitungsn untuk nilai out baris ke 3
    out(3,:)=[out(1,1)+siz*kiri,out(1,2)+siz*atas,siz*(1-kanan-kiri),siz*(1-atas-bawah)];
end
% hapus variable kec out
clearvars -except out

% menggenapkan semua nilai matrix out
out=round(out);