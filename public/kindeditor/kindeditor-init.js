KindEditor.ready(function(K) {
    for ( var i=1; i<=7; i++ )
    {
	    K.create('#kindeditor_id'+i, {
		    width: "80%",
		    allowFileManager: true,
		    uploadJson: '/kindeditor/upload',
		    fileManagerJson: '/kindeditor/filemanager'
	    });
    }
});
