##################################################################################
## Company: fpgaPublish
## Engineer: f
## 
## Create Date: 2022/12/17 22:44:57
## Design Name: imag_reco
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

p_file = pwd
cd("output2")
size = importdata('f_size.dat')
l_file = glob("*")
# ================================================================================
# read bmp file
numb = rows(l_file);
j = 0;
for i = 1 : numb 
    name = l_file(i,:)
    if (regexp(name{1},'.*\w+\.bmp.*') == 1) 
        j = j + 1;
        m_name{j} = name{1}
    end
end 
numb_file = j;
# ================================================================================
# recognize pan site
NB_PLOT = 3
for i = 1 : numb_file 
    im = imread(m_name{i});
    subplot(numb_file*NB_PLOT,1,(i-1)*NB_PLOT+1);
    imshow(im);
    hold on;
    w_imag = columns(im)    
    h_imag = rows(im) 
    # get size unit
    im_bit = im(:,:,1);

    for j = 1 : w_imag
        for k = 1 : h_imag
            m = 1;
            while(m)
                if(k <= m || j <= m || w_imag + 1 - j <= m || h_imag + 1 - k <= m)
                    break;
                elseif(im_bit(k-m:k+m,j-m:j+m) == zeros(m * 2 + 1))
                    m = m + 1;
                else 
                    break;
                end
            end
            m = m - 1;
            if(m == size)
                im_anchor(k,j) = 0;
            else 
                im_anchor(k,j) = 255;
            end
        end
    end
    im_bits = cat(3,im_anchor,im_anchor,im_anchor);
    subplot(numb_file*NB_PLOT,1,(i-1)*NB_PLOT+2);
    imshow(im_bits);
    hold on;
    cd(p_file);
    mkdir("output3");
    cd("output3");
    imwrite(im_bits,"f_anchor.bmp");
end 

