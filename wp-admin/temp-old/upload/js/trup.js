var upload_range = 1;


function traidntslot( num )
{
    if ( upload_range < max_tr_upload )
    {
        if ( num == upload_range )
        {
            var up = document.getElementById( 'tr_up' );
            var dv = document.createElement( "div" );

            dv.innerHTML = '<input  type="file" name="upfile_' + upload_range
                               + '" size="54" onchange="traidntslot(' + (upload_range + 1) + ')">';
            up.appendChild( dv );
            upload_range++;
            document.tr_upload.upload_range.value = upload_range;
        }
    }
}
