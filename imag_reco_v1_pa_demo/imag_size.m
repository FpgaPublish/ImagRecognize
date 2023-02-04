##################################################################################
## Company: fpgaPublish
## Engineer: f
## 
## Create Date: 2022/12/30 14:44:08
## Design Name: imag_size
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
# functin flow
# 1. load imag
# 2. reco size
# 3. set size

# define base unit
# 1 1 1 
# 1 1 1
# 1 1 1

# ================================================================================
# get path
p_file = pwd
cd("output1")
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
# plot data
NB_PLOT = 3
for i = 1 : numb_file 
    im = imread(m_name{i});
    subplot(numb_file*NB_PLOT,1,(i-1)*NB_PLOT+1);
    imshow(im);
    hold on;
    w_imag = columns(im)    
    h_imag = rows(im) 
    # get size unit
    im_gray = im(:,:,1);
    for j = 1 : w_imag 
        for k = 1 : h_imag
            if(im_gray(k,j) > 200)
                im_bit(k,j) = 255;
            else 
                im_bit(k,j) = 0;
            end
        end
    end
    im_bits = cat(3,im_bit,im_bit,im_bit);
    subplot(numb_file*NB_PLOT,1,(i-1)*NB_PLOT+2);
    imshow(im_bits);
    hold on;
    cd(p_file);
    mkdir("output1");
    cd("output2");
    imwrite(im_bits,"f_size.bmp");
    #init size
    a_size{1,1} = 0;
    a_size{1,2} = 0;
    t = 1;
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
            size_flg = 1;
            if(m > 0)
                for n = 2 : t
                    if(m == a_size{n,1})
                        a_size{n,2} = a_size{n,2} + 1;
                        if(n > 2)
                            a_size{n-1,2} = a_size{n-1,2} - 1;
                        end
                        
                        size_flg = 0;
                    end 
                end
                if(size_flg)
                    t = t + 1;
                    a_size{t,1} = m;
                    a_size{t,2} = 1;
                end
            end
            
        end
    end 
    a_size 
    c_size = 1; # defult 1
    for(j = 3 : rows(a_size))
        if(a_size{j,2} >= a_size{j-1,2})
            c_size = a_size{j,1}
        end
    end
    cd(p_file);
    cd("output2");
    dlmwrite("f_size.dat",c_size);
end