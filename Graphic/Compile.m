clc;
clear mex
mex -I"../ControlLib/Inc" ...,
    imCar.c ...,
    imProc.c ...,
    imCom.c ...,
    ../ControlLib/ControlParam.c
CarSpeed=200;%��λΪcm/s
CAMERA_W=160;
CAMERA_H=120;
for i=1:127
    try
        imfilename=strcat('.\Image_txt\Imag',int2str(i),'.txt');%����ͼƬ
        svfilename=strcat('.\Image_txt\solve\Imag',int2str(i),'.bmp');%���ͼƬ
        %img=uint8(not(imread(imfilename))*255)';%����BMP��ʽͼƬ
        img=uint8(load(imfilename))';      %����txt�ı���ʽͼƬ
        [W H]=size(img);
        if W ~=CAMERA_W && H~= CAMERA_H
            continue
        end
        [L R M  dir imOut M_F M_Real]=imCar(img,CarSpeed);
        imshow(imOut) 
        hold on
        plot(1:1:CAMERA_H,[L R M],'-r')
        saveas(gcf,svfilename)
        close all
        clear mex
    catch e
        e
        continue
    end
end

