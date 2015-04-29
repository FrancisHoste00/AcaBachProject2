
<img src="imgHiRes\stop.jpg" alt="image" /><br><br>
<?php
$org_info = getimagesize("imgHiRes\stop.jpg");
echo $org_info[3] . '<br><br>';
$rsr_org = imagecreatefromjpeg("imgHiRes\stop.jpg");
$rsr_scl = imagescale($rsr_org, 860, 860,  IMG_BICUBIC_FIXED);
imagejpeg($rsr_scl, "imgHiRes\c43.jpg");
imagedestroy($rsr_org);
imagedestroy($rsr_scl);
?>
<img src="imgHiRes\c43.jpg" alt="imagebfb" /><br><br>
<?php
$scl_info = getimagesize("imgHiRes\c43.jpg");
echo $scl_info[3];
?>