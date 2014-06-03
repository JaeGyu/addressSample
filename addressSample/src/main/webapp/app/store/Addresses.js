Ext.define('Address.store.Addresses',{
	extend:'Ext.data.Store',
	//fields:['name','email'],
	model:'Address.model.Address',
	proxy:{
		type:'ajax',
//		url:'list.json',
		api:{
			read: 'list.json',
			update:'update.json'
		},
		reader:{
			type:'json', //URL로 부터 오는 데이터가  json타입니다.
			root:'address',
			successProperty:'success'
		}
	},
	
   autoLoad:true  //url로부터 자동으로 로딩한다.
});