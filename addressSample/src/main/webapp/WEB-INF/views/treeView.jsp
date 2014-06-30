<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf8" />
<link
	href='http://cdn.sencha.io/ext/gpl/4.2.1/resources/css/ext-all.css'
	rel='stylesheet' />
<script src='http://cdn.sencha.io/ext/gpl/4.2.1/ext-all.js'></script>
<script>
	Ext.onReady(function() {
		var store = Ext.create("Ext.data.TreeStore", {
			proxy : {
				type : "ajax",
				url : "data/treeData.jsonn"
			},
			root : {
				text : "data",
				expanded : true
			},
			reader:{
				type:'json', //URL로 부터 오는 데이터가  json타입니다.
				root:'data'
			}
		});

		Ext.create("Ext.tree.Panel", {
			title : "Countries &amp; cities",
			width : 500,
			height : 300,
			store : store,
			rootVisible : false,
			renderTo : Ext.getBody(),
			style : "margin: 50px",
			listeners:{
				itemclick : function( RowModel, record, item, index, e, eOpts ){
					console.log(record.raw.getTemp());
				}
			}
		});
	});
</script>
</head>
<body></body>
</html>