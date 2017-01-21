% deskripsi fungsi memulai deteksi mata kantuk dan tracking
% Author : Ahmad Ilman Fadilah
% Date : June 18, 2016
% Version : 1.0
%
% -------------------------------------------------------------------------
% (c) 2016, 4KA39, University Gunadarma, Jakarta
% email: ilmanfadilah@gmail.com
% -------------------------------------------------------------------------
function fungsireset(src,callbackdata)
global Konf;
global levelwhiteR;
global levelwhiteL;
global Drowapp;
global levelbw;
global tstop;
global slide;
global sv;
global tstart;
if (levelwhiteR < 200 || levelwhiteL < 200) %|| (levelwhiteR > 700 || levelwhiteL > 700)
    msgbox('Mata Harus Dengan Keadaan Normal Dan Level BW Harus Lebih Dari 0', 'Perhatian','Warn');
else
selection =  questdlg(strcat('Anda Yakin Memulai Deteksi Mata Kantuk Dan Tracking Kedua pupil dengan Level BW?', num2str(levelbw)), ...
	'Perhatian', ...
	'Ya','Tidak','Ya');
   switch selection, 
      case 'Ya'
          if (levelwhiteR < 200 || levelwhiteL < 200) %|| (levelwhiteR > 700 || levelwhiteL > 700)
            msgbox('Mata Harus Dengan Keadaan Normal Dan Level BW Harus Lebih Dari 0', 'Perhatian','Warn');
            return
            else
          Konf = 0;
          Drowapp = 1;
          set(tstop,'enable','on');
          set(slide,'enable','off');
          set(tstart,'enable','off');
          set(sv,'String',levelbw);
          end
      case 'Tidak'
      return 
   end
end