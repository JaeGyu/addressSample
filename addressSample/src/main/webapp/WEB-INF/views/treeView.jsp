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
				url : "data/treeData.json"
			},
			root : {
				text : "countries",
				expanded : true
			}
		});

		Ext.create("Ext.tree.Panel", {
			title : "Countries &amp; cities",
			width : 500,
			height : 300,
			store : store,
			rootVisible : false,
			renderTo : Ext.getBody(),
			style : "margin: 50px"
		});
	});
</script>
</head>
<body></body>
</html>