#WRITTEN BY: Procymbopteryx
#
#For use in developing SYBrA
#Converts 1x1 block textures to 
#1x2 block textures for better rendering


import os
import sys
try:
    from PIL import Image
except:
    print("Pillow Could not be Imported\nInstall it with 'py -m pip install pillow'")
    input()
    sys.exit()


print("Auto Formatting for .png .PNG files in current directory\n")

for root, dirs, files in os.walk('./'):
    for f in files:
        if root == "./":
            if f[-5] != "_":
                if (f[-4:] == ".png") or (f[-4:] == ".PNG"):
                    try:
                        im = Image.open(f)
                        radius = int(im.height/2)
                        im_new = Image.new(mode=im.mode,size=(im.width*4,im.height*2))

                        #TOP LEFT BLOCK
                        im_cut = im.copy().crop((0,0,radius,radius)).resize(size=(radius*4,radius*2),resample=Image.Resampling.NEAREST)
                        im_new.paste(im_cut,box=(0,0))
                        #TOP MIDDLE BLOCK
                        im_cut = im.copy().crop((radius,0,radius*2,radius)).resize(size=(radius*2,radius*2),resample=Image.Resampling.NEAREST)
                        im_new.paste(im_cut,box=(radius*4,0))
                        im_new.paste(im_cut,box=(radius*6,0))
                        #TOP RIGHT BLOCK
                        im_cut = im.copy().crop((radius*2,0,radius*3,radius)).resize(size=(radius*4,radius*2),resample=Image.Resampling.NEAREST)
                        im_new.paste(im_cut,box=(radius*8,0))
                        #BOTTOM LEFT BLOCK
                        im_cut = im.copy().crop((0,radius,radius,radius*2)).resize(size=(radius*2,radius*2),resample=Image.Resampling.NEAREST)
                        im_new.paste(im_cut,box=(0,radius*2))
                        im_new.paste(im_cut,box=(radius*2,radius*2))
                        #BOTTOM MIDDLE BLOCK
                        im_cut = im.copy().crop((radius,radius,radius*2,radius*2)).resize(size=(radius*4,radius),resample=Image.Resampling.NEAREST)
                        im_new.paste(im_cut,box=(radius*4,radius*2))
                        im_new.paste(im_cut,box=(radius*4,radius*3))
                        #BOTTOM RIGHT BLOCK
                        im_cut = im.copy().crop((radius*2,radius,radius*3,radius*2)).resize(size=(radius*4,radius),resample=Image.Resampling.NEAREST)
                        im_new.paste(im_cut,box=(radius*8,radius*2))
                        im_new.paste(im_cut,box=(radius*8,radius*3))

                        #im_cut.save(str(f[:-4]+'_cut_.png'))
                        #im_new.save(str(f[:-4]+'_new_.png'))
                        im_new.save(str(f[:-4]+'_.png'))
                        print("Saved: "+str(f[:-4]+'_.png'))
                    
                    except Exception as e:
                        print("ERROR Processing: ",f,'\n',e)

input("\nDone\nPress enter to exit...")
