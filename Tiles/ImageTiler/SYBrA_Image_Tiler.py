#WRITTEN BY: Procymbopteryx
#
#For use in developing SYBrA
#Converts 1x1 textures to 
#2x3 textures to input to the other program


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
                        im_new = Image.new(mode=im.mode,size=(im.width*3,im.height*2))

                        for y in range(2):
                            for x in range(3):
                                im_new.paste(im,(im.width*x,im.height*y))

                        #im_cut.save(str(f[:-4]+'_cut_.png'))
                        #im_new.save(str(f[:-4]+'_new_.png'))
                        im_new.save(str(f[:-4]+'_.png'))
                        print("Saved: "+str(f[:-4]+'_.png'))
                    
                    except Exception as e:
                        print("ERROR Processing: ",f,'\n',e)

input("\nDone\nPress enter to exit...")
