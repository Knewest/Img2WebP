## Convert these image types to WebP (lossless) using Img2WebP:
- PNG (*.png)
- APNG (*.png)
- JPEG 1 (*.jpeg, *.jpg, *.jpe, *.jfif, *.exif)
- JPEG 2000 (*.jp2, *.j2c, *.jpg2, *.jpf, *.jpx, *.j2k)
- JPEG XR (*.jxr, *.wdp, *.wmp)
- JPEG XL (*.jxl)
- BMP (*.bmp, *.dib, *.rle)
- TIFF (*.tiff, *.tif)
- TGA (*.tga)
- GIF (*.gif)
- AV1/AVIF (*.avif)
- HEIF (*.heic, *.heif)
- TGA (*.tga)

### Notes:
JPEG 1 is first losslessly converted to JPEG XL - which has the ability to do lossless JPEG 1 recompression - as an intermediate format to then losslessly convert to WebP. <br>
Without this intermediate format, JPEG 1 would lose quality upon being converted, even if it was supposed to be lossless. JPEG 1 is a volatile format.

To use the program, you may have to right click the file and unblock it.

## How to use:
Place the Img2WebP.ps1 file into the folder where all your images are, this will convert all files within the same folder and subdirectories, you will be also given an option to output the WebP results in a different folder that still keeps the same folder structure. <br>
Again, you may have to unblock the file before you can use it. You can do this by right clicking it and pressing 'Unblock'. You can also just run it as an administrator. <br>
The instructions are a W.I.P.
