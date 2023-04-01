## Convert these image types to WebP (lossless) using Img2WebP:
- PNG (*.png)
- APNG (*.apng, *.png)
- JPEG 1 (*.jpeg, *.jpg, *.jpe, *.jfif, *.jif, *.jfi)
- JPEG 2000 (*.jp2, *.j2c, *.jpg2, *.jpf, *.jpx, *.j2k)
- JPEG XR (*.jxr, *.hdp, *.wdp, *.wmp)
- JPEG XL (*.jxl)
- BMP (*.bmp, *.dib, *.rle)
- TIFF (*.tiff, *.tif)
- TGA (*.tga)
- GIF (*.gif)
- AVIF (*.avif)
- HEIF (*.heic, *.heif)
- TGA (*.tga)
- DDS (*.dds)

### Notes:
JPEG 1 is first losslessly converted to JPEG XL - which has the ability to do lossless JPEG 1 recompression - as an intermediate format to then losslessly convert to WebP. <br>
Without this intermediate format, JPEG 1 would lose quality upon being converted, even if it was supposed to be lossless. JPEG 1 is a volatile format.

To use the program, you may have to right click the file and unblock it.

## How to use:
1 - Download the *.ps1 program here: https://github.com/Knewest/Img2WebP/releases
<br>2 - You will have to download and install all the libraries for the program to function, I list of them will be found in the code or below. You can view the code [here](https://raw.githubusercontent.com/Knewest/Img2WebP/main/Img2WebP.ps1) or by using notepad.
<br>3 - Right click the *.ps1 programg and click the "unblock" button.<br>If you have UAC disabled, you may have to run the program in administrator if it get blocked.
<br>4 - Place the *.ps1 file in the folder with the images you need converting to WebP lossless, consider the subdirectories too.
<br>5 - Right click the *.ps1 file and run it in Powershell, you will be asked if you want the outputted files to be put in a seperate folder (mimicing the folder structure too), once answered, this will begin the process.
<br>6 - Wait for the conversion to complete and enjoy.
<br><br>
The instructions are a W.I.P.
