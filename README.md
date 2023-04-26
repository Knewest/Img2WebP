## Convert these image types to WebP (lossless) using Img2WebP:
- PNG (`*.png`)
- APNG (`*.apng`, `*.png`)
- JPEG 1 (`*.jpeg`, `*.jpg`, `*.jpe`, `*.jfif`, `*.jif`, `*.jfi`)
- JPEG 2000 (`*.jp2`, `*.j2c`, `*.jpg2`, `*.jpf`, `*.jpx`, `*.j2k`)
- JPEG XR (`*.jxr`, `*.hdp`, `*.wdp`, `*.wmp`)
- JPEG XL (`*.jxl`)
- BMP (`*.bmp`, `*.dib`, `*.rle`)
- TIFF (`*.tiff`, `*.tif`)
- TGA (`*.tga`)
- GIF (`*.gif`)
- AVIF (`*.avif`)
- HEIF (`*.heic`, `*.heif`)
- TGA (`*.tga`)
- DDS (`*.dds`)

### Notes:
JPEG 1 is first losslessly converted to JPEG XL - which has the ability to do lossless JPEG 1 recompression - as an intermediate format to then losslessly convert to WebP. <br>
Without this intermediate format, JPEG 1 would lose quality upon being converted, even if it was supposed to be lossless. JPEG 1 is a volatile format.

To use the program, you may have to right click the file and unblock it.

## How to use:
1. Download the `*.ps1` program here: https://github.com/Knewest/Img2WebP/releases

2. You will have to download and install all the libraries for the program to function, I list of them will be found in the code or below. You can view the code [here](https://raw.githubusercontent.com/Knewest/Img2WebP/main/Img2WebP.ps1) or by using notepad.

3. You may have to right click the `*.ps1` program and click the "unblock" button.
<br>- Otherwise, there should the a notification giving you a security warning. Read it and act accordingly. If you have UAC disabled, you may have to run the program in administrator if it gets blocked.

4. Place the `*.ps1` file in the folder with the images you need converting to WebP lossless, consider the subdirectories too.

5. Right click the `*.ps1` file and run it in Powershell, you will be asked if you want the outputted files to be put in a seperate folder (mimicing the folder structure too), once answered, this will begin the process.

6. Wait for the conversion to complete and enjoy.
<br><br>
The instructions are a W.I.P.


## How to setup:
1. Download and install all the libraries and binaries needed for the `*.ps1` program to work: 
> <sub>- <b>libwebp</b> - https://developers.google.com/speed/webp/docs/precompiled<br>
> <br>- <b>FFMPEG</b> - https://www.gyan.dev/ffmpeg/builds/<br>
> <br>- <b>libjxr</b> - https://github.com/Knewest/precompiled-jxrlib-binaries/releases/tag/Release-v2019.10.9<br>
> <br>- <b>libjxl</b> - https://github.com/libjxl/libjxl/releases/tag/v0.8.1<br>
> <br>- <b>ImageMagick</b> - https://imagemagick.org/script/download.php
> <br>-- <b>Note</b> - It should be the one along the lines of `ImageMagick-7.1.1-7-Q16-HDRI-x64-dll.exe`.<br></sub>

2. Once you have downloaded and installed them all, open the code and set the directories for each library/binary respectively. The directories will be at the top of the code.

3. You may now successfully use the `*.ps1` program.
<br>- <b>Note</b> - Windows may not allow you to run PowerShell scripts, so you will need to right click to unblock it and trust it upon exectuing it.

## What do I have planned?
I plan to turn this into a user friendly tool that will automatically install all requirely libraries and without the need to move the Powershell script into a folder, rather it would be a simple binary exacutable with an interface.
