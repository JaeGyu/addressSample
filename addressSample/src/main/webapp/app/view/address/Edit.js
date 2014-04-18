Ext.define('Address.view.address.Edit',{ //Edit클래스 이름에서 대문자로 시작하는거 파일명도 동일하게 해줘야 됨
	extend:'Ext.window.Window',
	
	/*
	 * alias를  useredit로 등록을 했다
	 * 추후 xtype 'useredit'로 로딩이 가능하다.
	 * */
	alias:'widget.addressedit', 
	
	title:'Edit Person',
	layout: 'fit',
	autoShow: true, //생성되는 즉시 보여지게 한다. 스펠링이나 대소문자틀리면 화면에 안뜬다.
	
	initComponent: function(){
		this.items=[
		    {
			xtype:'form',
			items:[
			       {
			    	   xtype:'textfield',
			    	   name:'name',
			    	   fieldLabel:'Name'
			       },{
			    	   xtype:'textfield',
			    	   name:'address',
			    	   fieldLabel:'Address'
			       },{
			    	   xtype:'textfield',
			    	   name:'tel',
			    	   fieldLabel:'Tel'
			       }
			]
		}];
		
		this.buttons=[
		              {
		            	  text:'Save',
		            	  action:'save'
		              },{
		            	  text:'Cancel',
		            	  scope:this,
		            	  handler: this.close
		              }
	    ];
		
		this.callParent(arguments);
	}
});