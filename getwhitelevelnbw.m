% deskripsi fungsi menentukan nilai level bw dan jml pixel putih
% putih pada gambar
% Uses (syntax) :
%   [Rbw Lbw levelwhiteR levelwhiteL] = getwhitelevelnbw(matakanan,matakiri)
%
% Input Parameters :
%   matakiri := RGB-Image (m-by-n-by-3 matrix); bounding box of matakiri Eye
%   matakanan := RGB-Image (m-by-n-by-3 matrix); bounding box of matakanan Eye
% 
% Return Parameters :
%   Rbw := gambar biner mata kanan
%   Lbw := gambar biner mata kiri
%   levelwhiteR := jml pixel putih pada gambar mata kanan
%   levelwhiteL := jml pixel putih pada gambar mata kiri
% 
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, University Gunadarma, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------
function  [Rbw, Lbw, levelwhiteR, levelwhiteL] = getwhitelevelnbw(matakanan,matakiri)
global levelbw;
     Rbw= ~im2bw(rgb2gray(matakanan),levelbw);
     %menentukan nilai pixel putih pada mata kanan
     levelwhiteR = sum(Rbw(:));
     Lbw= ~im2bw(rgb2gray(matakiri),levelbw);
     %menentukan nilai pixel putih pada mata kiri
     levelwhiteL = sum(Lbw(:));