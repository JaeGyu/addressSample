<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf8" />
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.com/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.com/easyui/demo/demo.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript"
	src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
</head>
<script>
	function doSearch() {
		$('#tt').datagrid('load', {
			name : $('#name').val(),
			address : $('#address').val()
		});
	}
</script>
</head>
<body>

	<table id="tt" class="easyui-datagrid"
		style="width: 600px; height: 250px" url="list2.json" toolbar="#tb"
		title="Load Data" iconCls="icon-save" rownumbers="true"
		pagination="true">
		<thead>
			<tr>
				<th field="name" width="80">Name</th>
				<th field="address" width="180">Address</th>
				<th field="tel" width="80" align="right">Tel</th>
			</tr>
		</thead>
	</table>


	<div id="tb" style="padding: 3px">
		<span>Name:</span> <input id="name"
			style="line-height: 26px; border: 1px solid #ccc"> 
		<span>Address:</span> <input id="address"
			style="line-height: 26px; border: 1px solid #ccc"> <a
			href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">Search</a>
	</div>

</body>
</html>