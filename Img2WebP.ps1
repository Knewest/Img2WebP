$WebPEncoderPath = "C:\Codecs\LibWebPV1.3.0\bin\cwebp.exe"
$GIF2WebPEncoderPath = "C:\Codecs\LibWebPV1.3.0\bin\gif2webp.exe"
# Download CWEBP.EXE and GIF2WEBP.EXE at: https://developers.google.com/speed/webp/docs/precompiled

$FFMPEGPath = "C:\Codecs\LibFFMPEGV6.0\bin\ffmpeg.exe"
# Download FFMPEG.EXE at: https://www.gyan.dev/ffmpeg/builds/

$JPEGXRDecoderPath = "C:\Codecs\LibJXRv2019.10.9\LibJXRv2019.10.9_Release_x64\JXRDecApp.exe"
# Download JXRDECAPP.EXE at: https://github.com/Knewest/precompiled-jxrlib-binaries/releases/tag/Release-v2019.10.9

$JPEGXLDecoderPath = "C:\Codecs\LibJXLv0.8.1\djxl.exe"
# Download DJXL.EXE at: https://jpeg.org/jpegxl/software.html

$JPEGXLEncoderPath = "C:\Codecs\LibJXLv0.8.1\cjxl.exe"
# Download CJXL.EXE at: https://jpeg.org/jpegxl/software.html

$IdentifyPath = "C:\Codecs\LibImageMagick\ImageMagick-7.1.1-Q16-HDRI\identify.exe"
# Download IDENTIFY.EXE at: https://imagemagick.org/script/download.php#windows

$MagickPath = "C:\Codecs\LibImageMagick\ImageMagick-7.1.1-Q16-HDRI\magick.exe"
# Download MAGICK.EXE at: https://imagemagick.org/script/download.php#windows

# Load assembly so messages can actually appear on your screen.
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# This will search for PNG, APNG, JPG, JPEG, JPE, EXIF, JFIF, BMP, DIB, RLE, AVIF, TIF, TIFF, JXR, WDP, WMP, JXL, JP2, J2C, JPG2, JPF, JPX, J2K, TGA, HEIC, HEIF and GIF files in the current directory and its subdirectories.
$images = Get-ChildItem -Path (Get-Location) -Include *.png, *.apng, *.jpg,*.jpeg,*.jpe,*.exif,*.jfif,*.bmp,*.dib,*.rle,*.avif,*.tif,*.tiff,*.jxr,*.wdp,*.wmp,*.jxl,*.jp2,*.j2c,*.jpg2,*.jpf,*.jpx,*.j2k,*.tga,*.heic,*.heif,*.gif -Recurse

# Ask the user if they want to create a folder to put the converted files in.
$createWebPFolder = [System.Windows.Forms.MessageBox]::Show('Would you like to create a folder to put the converted files in?

This will copy all the directories the source images are in and place them in a "WebP_Output" folder.

Otherwise, it will just output the results to the same folder as the source image.', " ", [System.Windows.Forms.MessageBoxButtons]::YesNo)

# Set the path where the converted files will be stored.
if ($createWebPFolder -eq "Yes") {
    $outputPath = (Get-Location).Path + "\WebP_Output"
    New-Item -ItemType Directory -Path $outputPath -Force
} else {
    $outputPath = (Get-Location).Path
}

	foreach ($image in $images) {
		$currentPath = Get-Location
		$relativePath = ""
		if($image.DirectoryName.Length -ge ($currentPath.Path.Length + 1)) {
			$relativePath = $image.DirectoryName.Substring(($currentPath.Path.Length + 1))
		}

		$outputDir = Join-Path $outputPath $relativePath
		if (!(Test-Path $outputDir)) {
			New-Item -ItemType Directory -Path $outputDir -Force
		}
		$fileName = Join-Path $outputDir $image.BaseName


if ($image.Extension -eq ".png" -or $image.Extension -eq ".apng") {
    # Check if IDENTIFY.EXE encoder/decoder exists, otherwise prompt user to download.
    if (-not(Test-Path $IdentifyPath)) {
        [System.Windows.Forms.MessageBox]::Show("The ImageMagick resolver (IDENTIFY.EXE) was not found.`n_________________________________________________________________________`n`nPlease download it at the link below:`n`nhttps://imagemagick.org/script/download.php#windows`n_________________________________________________________________________`n`nIf you already have them installed, make sure the directories in the code is set correctly.`nThe code can be opened using Notepad.")
        break
    }
    # Use IDENTIFY.EXE to determine if the image is an animated PNG or not.
    $identifyOutput = & $IdentifyPath $image.FullName | Select-String -Pattern "PNG|APNG"

    # If the image is an animated PNG, convert it to an animated WebP using FFMPEG.EXE.
    if ($identifyOutput) {
        # Check if FFMPEG.EXE encoder/decoder exists, otherwise prompt user to download.
        if (-not(Test-Path $FFMPEGPath)) {
            [System.Windows.Forms.MessageBox]::Show("The FFMPEG encoder/decoder (FFMPEG.EXE) was not found.`n_________________________________________________________________________`n`nPlease download it at the link below:`n`nhttps://www.gyan.dev/ffmpeg/builds/`n_________________________________________________________________________`n`nIf you already have it installed, make sure the directories in the code is set correctly.`nThe code can be opened using Notepad.")
            break
        }
		& $FFMPEGPath -i $image.FullName -loop 0 -c:v libwebp_anim -compression_level 4 -lossless 1 -an -sn "$fileName.webp"
    }
    # If the image is not an animated PNG, convert it to a static WebP using FFMPEG.EXE too.
}
	
	elseif ($image.Extension -eq ".jxr" -or $image.Extension -eq ".wdp") {
	# Check if JPEGXRDecoderPath and WebPEncoderPath exist, otherwise prompt user to download.
	if (-not(Test-Path $JPEGXRDecoderPath) -or -not(Test-Path $WebPEncoderPath)) {
		[System.Windows.Forms.MessageBox]::Show("The JPEG XR decoder (JXRDECAPP.EXE) and/or the WebP encoder (CWEBP.EXE) were not found.`n_________________________________________________________________________`n`nPlease download them at the links below:`n`nhttps://github.com/Knewest/precompiled-jxrlib-binaries/releases/tag/Release-v2019.10.9`nhttps://developers.google.com/speed/webp/docs/precompiled`n_________________________________________________________________________`n`nIf you already have them installed, make sure the directories in the code is set correctly.`nThe code can be opened using Notepad.")
		break
	}

	# This will losslessly convert JXR to TIF using JXRDECAPP.EXE.
	$tempTIFPath = Join-Path $outputDir ($image.BaseName + ".tif")
	& $JPEGXRDecoderPath -i $image.FullName -o $tempTIFPath
	
	# This will losslessly convert the temporary PNG to WebP using CWEBP.EXE.
    & $WebPEncoderPath -lossless -z 6 $tempTIFPath -o "$fileName.webp"
	
	# Delete the temporary TIF file.
    Remove-Item $tempTIFPath
}

elseif ($image.Extension -eq ".jpg" -or $image.Extension -eq ".jpeg" -or $image.Extension -eq ".jpe" -or $image.Extension -eq ".jfif" -or $image.Extension -eq ".exif") {
	if (-not(Test-Path $JPEGXLEncoderPath)) {
		[System.Windows.Forms.MessageBox]::Show("The JPEG XL encoder (CJXL.EXE), JPEG XL decoder (DJXL.EXE) and/or the WebP encoder (CWEBP.EXE) was not found.`n_________________________________________________________________________`n`nPlease download them at the links below:`n`nhttps://jpeg.org/jpegxl/software.html`nhttps://jpeg.org/jpegxl/software.html`nhttps://developers.google.com/speed/webp/docs/precompiled`n_________________________________________________________________________`n`nIf you already have them installed, make sure the directories in the code is set correctly.`nThe code can be opened using Notepad.")
		break
	}

	# Convert the image to JXL format using CJXL.EXE.
	$tempJXLPath = Join-Path $outputDir ($image.BaseName + ".jxl")
	& $JPEGXLEncoderPath --lossless_jpeg=0 --jpeg_reconstruction_cfl=0 -q 100 -e 8 --brotli_effort 9 --faster_decoding=4 $image.FullName $tempJXLPath
	
	# Convert the JXL file to PNG format using DJXL.EXE.
	$tempPNGPath = Join-Path $outputDir ($image.BaseName + ".png")
	& $JPEGXLDecoderPath -q 100 $tempJXLPath $tempPNGPath
	
	# Convert the temporary PNG file to a lossless WebP format using CWEBP.EXE.
	$WebPPath = Join-Path $outputDir ($image.BaseName + ".webp")
	& $WebPEncoderPath $tempPNGPath -lossless -z 6 -o $WebPPath
	
	# Delete the temporary files.
	Remove-Item $tempJXLPath
	Remove-Item $tempPNGPath
}

	elseif ($image.Extension -eq ".jp2" -or $image.Extension -eq ".j2c" -or $image.Extension -eq ".jpg2" -or $image.Extension -eq ".jpf" -or $image.Extension -eq ".jpx" -or $image.Extension -eq ".j2k" -or $image.Extension -eq ".tga") {
		# Check if FFMPEG exists, otherwise prompt user to download it.
		if (-not(Test-Path $FFMPEGPath)) {
			[System.Windows.Forms.MessageBox]::Show("The FFMPEG encoder/decoder (FFMPEG.EXE) was not found.`n_________________________________________________________________________`n`nPlease download it at the link below:`n`nhttps://www.gyan.dev/ffmpeg/builds/`n_________________________________________________________________________`n`nIf you already have it installed, make sure the directories in the code is set correctly.`nThe code can be opened using Notepad.")
			break
		}
		# This will losslessly covert JPEG 2000 and TGA to WebP.
		& $FFMPEGPath -i $image.FullName -c:v libwebp -compression_level 4 -lossless 1 -an -sn "$fileName.webp"
	}

    elseif ($image.Extension -eq ".jxl") {
        # Check if JPEGXLDecoderPath and WebPEncoderPath exist, otherwise prompt user to download.
        if (-not(Test-Path $JPEGXLDecoderPath) -or -not(Test-Path $WebPEncoderPath)) {
            [System.Windows.Forms.MessageBox]::Show("The JPEG XL decoder (DJXL.EXE) and/or the WebP encoder (CWEBP.EXE) were not found.`n_________________________________________________________________________`n`nPlease download them at the links below:`n`nhttps://jpeg.org/jpegxl/software.html`nhttps://developers.google.com/speed/webp/docs/precompiled`n_________________________________________________________________________`n`nIf you already have them installed, make sure the directories in the code is set correctly.`nThe code can be opened using Notepad.")
            break
        }

        # This will losslessly convert JXL to PNG using DJXL.EXE.
        $tempPNGPath = Join-Path $outputDir ($image.BaseName + ".png")
        & $JPEGXLDecoderPath -q 100 $image.FullName $tempPNGPath

        # This will losslessly convert the temporary PNG to WebP using CWEBP.EXE.
        & $WebPEncoderPath -lossless -z 6 $tempPNGPath -o "$fileName.webp"

        # Delete the temporary PNG file.
        Remove-Item $tempPNGPath
    }
	elseif ($image.Extension -eq ".gif") {
    # Check if GIF2WEBP.EXE encoder exists, otherwise prompt user to download.
    if (-not(Test-Path $GIF2WebPEncoderPath)) {
        [System.Windows.Forms.MessageBox]::Show("The WebP encoders (CWEBP.EXE and/or GIF2WEBP.EXE) were not found.`n_________________________________________________________________________`n`nPlease download both of them at the link below:`n`nhttps://developers.google.com/speed/webp/docs/precompiled`n_________________________________________________________________________`n`nIf you already have them installed, make sure the directories in the code is set correctly.`nThe code can be opened using Notepad.")
        break
    }
    # This will losslessly convert animated GIF to animated WebP using GIF2WEBP.EXE.
    & $GIF2WebPEncoderPath -m 6 $image.FullName -o "$fileName.webp"
    } else {
        # This will losslessly convert all other image formats to WebP using CWEBP.EXE.
        & $WebPEncoderPath -lossless -z 6 $image.FullName -o "$fileName.webp"
    }
}

# This will show a popup message once all files are converted to WebP.
$msgBoxTitle = "Image conversion complete:"
$msgBoxText = "The image conversion process has finished.`nEnjoy your WebP files!`n_______________________________________________________________`n`n`© Knew (2023-2023)`nThis program is licensed under Boost Software License 1.0.`n_______________________________________________________________`n`nSource: https://github.com/Knewest"
$msgBoxButton = "OK"
$msgBoxIcon = "Information"
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($msgBoxText, $msgBoxTitle, $msgBoxButton, $msgBoxIcon)

# Version 1.2.0 of Img2WebP
# Copyright (Boost Software License 1.0) 2023-2023 Knew
