Ext.define('Address.controller.FrameController',{
	extend:'Ext.app.Controller',
	views:[
	       /*
	        * 뷰를 추가하는데 패키지를 제외한 나머지 이름을 적는다.
	        * view 폴더 아래에 있는 폴더 - 파일 명에 해당하는게 이름 
	        * */
	       'address.List',
	       'address.Edit'
	],
	stores:[
	        'Addresses'
	],
	models:[
	        'Address'
	],
	
	init:function(){
		console.log('사용자 컨트롤러를 초기화 합니다. Application의 lanunch 함수가 불려지기 전에 호출됩니다.');
		this.control({
			/*
			 * 패널이 렌더링 될때 호출이 된다. 이시점에 비즈니스 로직이 필요한경우 
			 * 사용하면 될 것 같다.
			 * */
			'viewport > panel':{   //ExtJS4부터 추가된 컴포넌트 쿼리 Viewport직계 자손 중 panel을 찾아라!!
				render : this.onPanelRendered
			},
			'addresslist':{  //alias가 userlist20140408로 정의된 클래스의 인스턴스들을 처리한다.
				itemdblclick: this.editAddress //editUser이라는 함수를 호출 한다.
			},
			'addressedit button[action=save]':{
				click: this.updateAddress
			}
		});
	},
	updateAddress:function(button){
		console.log('저장 버튼을 클릭 하였습니다.');
		
		
		var win = button.up('window'),
		      form    =  win.down('form'), 
		      record = form.getRecord();
		     values  = form.getValues();
		     
		     record.set(values);
		     win.close();
		     
		     /*
		      * 컨트롤러에 store, model, view 를 등록하게 되면 get 함수가 자동으로 등록이 됩니다.
			  * 지금까지 작성된 컨트롤러를 예를 들면, getUserModel(), getUsersStore(), 
			  * getUserListView(), getUserEditView() 함수가 추가되어 컨트롤러에서 사용이 가능합니다.
		      * */
		     this.getAddressesStore().sync();
		     
	},
	editAddress:function(grid, record){
		console.log(record.get('name')+'이(가) 더블클릭 되었습니다.');
		var view = Ext.widget('addressedit');  //Address.view.address.Edit 인스턴스를 생성한다.
	
		/*
		 * 윈도우 내부 form패널에 그리드에서 선택된 레코드 정보를 채워주게 된다.
		 * down(String selector, [Boolean returnDom]) 함수는 CSS 셀렉터를 기반으로 자식요소를 검색합니다.
		 * */
		view.down('form').loadRecord(record); 
	},
	onPanelRendered: function(){
		console.log('패널이 렌더링 되었습니다.');
	}
});