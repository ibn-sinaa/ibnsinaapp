<?



if (!defined('traidnt')) {
    die("Error: 404 Not Found");
}

function FolderSize($directory, $format=FALSE)
 {
    $size = 0;

     if(substr($directory,-1) == '/')
     {
        $directory = substr($directory,0,-1);
    }

    if(!file_exists($directory) || !is_dir($directory) || !is_readable($directory))
    {
        return -1;
     }
    if($handle = opendir($directory))
   {
        while(($file = readdir($handle)) !== false)
         {
           $path = $directory.'/'.$file;

           if($file != '.' && $file != '..')
            {
                if(is_file($path))
                {
                    $size += filesize($path);

                }elseif(is_dir($path))
                {
                     $handlesize = FolderSize($path);

                    if($handlesize >= 0)
                    {

                        $size += $handlesize;


                    }else{
                        return -1;
                    }
               }
            }
        }
        closedir($handle);
    }
     if($format == TRUE)
     {
         if($size / 1048576 > 1)
         {
            return round($size / 1048576, 1).' MB';

         }elseif($size / 1024 > 1)
         {
             return round($size / 1024, 1).' KB';

         }else{
             return round($size, 1).' bytes';
         }
     }else{
         return $size;
     }
 }


?>