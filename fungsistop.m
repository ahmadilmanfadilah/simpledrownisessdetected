% deskripsi fungsi berhenti deteksi kantuk dan variable2 tertentu :
% 1.levelwhiteR;
% 2.levelwhiteL;
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, Gunadarma University, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------
function fungsistop(src,callbackdata)
global levelwhiteR;
global levelwhiteL;
global tstop;
global slide;
global tstart;
global Konf;
global Drowapp;
global dronis;
selection =  questdlg('Anda Yakin Berhenti Deteksi Mata Kantuk?', ...
	'Perhatian', ...
	'Ya','Tidak','Ya');
   switch selection, 
      case 'Ya'
          levelwhiteR=[];
          levelwhiteL=[];
          Konf =1;
          Drowapp =0;
          dronis=0;
        set(tstop,'enable','off');
        set(slide,'enable','on');
        set(tstart,'enable','on');
      case 'Tidak'
      return 
   end
