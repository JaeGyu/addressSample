//Ext.Loader.setConfig({enabled:true, disableCache:true});
Ext.application({
	name: 'Address',  //어플리케이션 명 
	appFolder:'app', // 어플리케이션 폴더 
	//실행시 사용할 모든 컨트롤러를 명시한다. 
	controllers:[
	             'FrameController' //어플리케이션이 사용할 컨트롤러
	],
	
	launch: function(){
		Ext.create('Ext.container.Viewport',{
			layout:'fit',
			items:[
			       {
			    	   /*
			    	    *Vicki.view.user20140408.List20140408의 alias를 
			    	    *'widget.userlist20140408'로 정의하여 등록이 되었으므로 xtype은 
			    	    *'userlist20140408'로 사용이 가능하다. 
			    	    * */
			    	   xtype:'addresslist',
			    	   title:'주소록',
			    	   html:'연락처 리스트'
			       }]
		});
	}
});