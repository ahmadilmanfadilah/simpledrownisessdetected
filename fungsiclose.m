% deskripsi fungsi menutup semua figure
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, University Gunadarma, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------
function fungsiclose(src,callbackdata)
global flag;
selection =  questdlg('Anda Yakin Menutup Aplikasi?', ...
	'Perhatian', ...
	'Ya','Tidak','Ya');
   switch selection, 
      case 'Ya'
          flag = 1;
         close all force;
         close all;
         set(0,'DefaultFigureVisible','off')
      case 'Tidak'
      return 
   end