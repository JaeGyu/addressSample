Ext.define('Address.view.address.List', {
	extend : 'Ext.grid.Panel',
	alias : 'widget.addresslist',
	store:'Addresses',
	title : 'All Persons',

	initComponent : function() {
		this.columns=[
		              {header:'Name', dataIndex: 'name', flex: 1}, //flex 화면에 보이는 컬럼간의 width 비율 1:5 
		              {header:'Address', dataIndex: 'address', flex: 5},
		              {header:'TEL', dataIndex: 'tel', flex: 5}
		];
		
		/*
		 * this.callParent(arguments); <-꼭 이렇게 그대로 작성해야 결과가 나옴
		 * 슈퍼 클래스를 호출하는 방법임
		 * initComponent()메서드가 java에서 생성자와 비슷한 역할을 하는것 같다.
		 * 따라서 자바에서 super()로 슈퍼클래스를 호출해 주듯이 
		 * 여기서도 같은 맥락에서 호출해 주는 것 같다.
		 * */
		this.callParent(arguments);  
	}
});