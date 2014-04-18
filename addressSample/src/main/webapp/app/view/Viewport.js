Ext.define('ria.view.Viewport',{
	extend:'Ext.container.Viewport',
	layout: 'border',
	items: [
	        {
	        	region:'center',
	        	xtype:'panel',
	        	title:'중간',
	        },
	        {
	        	region:'west',
	        	xtype:'panel',
	        	width: 200,
	        	title:'죄측'
	        }
	 ]
});
