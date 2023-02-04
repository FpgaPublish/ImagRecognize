##################################################################################
## Company: fpgaPublish
## Engineer: f
## 
## Create Date: 2022/12/13 21:58:43
## Design Name: imag_cut
## Module Name: 
## Project Name: 
## Target Devices: 
## Tool Versions: 
## Description: 
## 
## Dependencies: 
##  
## Revision: 
## Revision 0.01 - File Created 
## Additional Comments:
## 
##################################################################################
clear();
# ================================================================================
# get path
p_file = pwd
l_file = glob("*")
# ================================================================================
# read bmp file
numb = rows(l_file);
j = 0;
for i = 1 : numb 
    name = l_file(i,:);
    if (regexp(name{1},'.*\w+\.bmp.*') == 1) 
        j = j + 1;
        m_name{j} = name{1}
    end
end 
numb_file = j;
# ================================================================================
# plot data
NB_PLOT = 3
for i = 1 : numb_file 
    im = imread(m_name{i});
    subplot(numb_file*NB_PLOT,1,(i-1)*NB_PLOT+1);
    imshow(im);
    hold on;
    # gray imag
    im_r = im(:,:,1);
    im_g = im(:,:,2);
    im_b = im(:,:,3);
    im_gray = (im_r ./ 3 + im_g  ./ 3 + im_b ./ 3) ;
    im(:,:,1) = im_gray;
    im(:,:,2) = im_gray;
    im(:,:,3) = im_gray;
    subplot(numb_file*NB_PLOT,1,(i-1)*NB_PLOT+2);
    imshow(im);
    hold on;
    # cut imag
    w_imag = columns(im_gray)    
    h_imag = rows(im_gray) 
    # get site
    z = 1;
    b_first = 0;
    NB_THRE = 230;
    NB_OFFSET = 20;

    for j = NB_OFFSET : h_imag - NB_OFFSET
        b_still = 0;
        for k = NB_OFFSET : w_imag - NB_OFFSET
            if(im_gray(j,k) < NB_THRE)
                if(b_first == 0)
                    x_site{z} = k;
                    y_site{z} = j;
                    x_over{z} = k;
                    y_over{z} = j;
                    b_first = 1;
                    b_still = 1;
                end
                if(1)
                    if(j == y_over{z} + 1 && (k >= x_site{z} - NB_OFFSET && k <= x_over{z} + NB_OFFSET))
                        m = x_site{z};
                        while (im_gray(j,m) < NB_THRE)
                            m = m - 1;
                        end
                        x_site{z} = m + 1;
                        m = x_over{z};
                        while (im_gray(j,m) < NB_THRE)
                            m = m + 1;
                        end
                        x_over{z} = m - 1;
                        
                        y_over{z} = j;
                        b_still = 1;
                    end
                end
            end
        end
        if(b_still == 0 && b_first == 1)
            b_first = 0;
            s = "result is:";
            x_site{z}       ;
            y_site{z}       ;
            x_over{z}       ;
            y_over{z}       ;
            z = z + 1       ;
            break;
        end
    end 
    z = z - 1 %whole recognize
    # x site cut

    # plot site
    imag_red = im_gray;
    for m = 1 : z;
        
        for k = x_over{z} + 1: w_imag - NB_OFFSET 
            b_still = 0;
            for j = y_site{m} : y_over{m}
                if(im_gray(j,k) < NB_THRE)
                    if(k == x_over{z} + 1) %over add
                        x_over{z} = k;
                        b_still = 1;
                    end
                end
            end
            if(b_still == 0)
                break;
            end
        end
        for k = x_site{z} - 1 : -1 : NB_OFFSET 
            for j = y_site{m} : y_over{m}
                if(im_gray(j,k) < NB_THRE)
                    if(k == x_site{z} - 1) %site add
                        x_site{z} = k;
                        b_still = 1;
                    end
                end
            end
            if(b_still == 0)
                break;
            end
        end
        for k = x_site{m} : x_over{m}
            imag_red(y_site{m},k) = 0;
            imag_red(y_over{m},k) = 0;
        end
        for k = y_site{m} : y_over{m}
            imag_red(k,x_site{m}) = 0;
            imag_red(k,x_over{m}) = 0;
        end
        for k = x_site{m}: x_over{m}
            for l = y_site{m}: y_over{m}
                im_cut(l - y_site{m} + 1,k - x_site{m} + 1,1) = im_gray(l,k);
                im_cut(l - y_site{m} + 1,k - x_site{m} + 1,2) = im_gray(l,k);
                im_cut(l - y_site{m} + 1,k - x_site{m} + 1,3) = im_gray(l,k);
                
            end 
        end
    end 
    im(:,:,1) = imag_red;
    im(:,:,2) = imag_red;
    im(:,:,3) = im_gray;
    subplot(numb_file*NB_PLOT,1,(i-1)*NB_PLOT+3);
    imshow(im);
    mkdir("output1");
    cd("output1");
    # imwrite(im,"f_cut.bmp");
    imwrite(im_cut,"f_cut.bmp");
    # monitor
    w_imag = columns(im_gray)
    h_imag = rows(im_gray)

    # ================================================================================
    # temp result imag
    
    
end