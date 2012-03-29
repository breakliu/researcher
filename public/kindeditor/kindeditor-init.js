KindEditor.ready(function(K) {
    for ( var i=1; i<=11; i++ )
    {
	    K.create('#kindeditor_id'+i, {
		    width: "900px",
		    allowFileManager: true,
		    uploadJson: '/kindeditor/upload',
		    fileManagerJson: '/kindeditor/filemanager'
	    });
    }
});
