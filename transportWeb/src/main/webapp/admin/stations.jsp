<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*机顶网址  防止路径出错    只有jsp特有*/
	String path=request.getContextPath();  //  /douban
	//                    http           ://      localhost            :       8080                /douban /       
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>站点管理页面</title>
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

	var url;
	//打开添加站点信息框
	function openStationsAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加站点信息");
	}
	//打开修改站点信息框
	function openUpdateStationsDialog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		 if(selectedRows.length!=1){
			 $.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		 }
		 var row=selectedRows[0];
		 $("#update").dialog("open").dialog("setTitle","编辑站点信息");
		 $("#fm").form("load",row);
		 var sid=selectedRows[0].sid;
		 $.post('selectStationsById',{'id':sid},function(data){
			 $('#sname2').val(data);
		 },'json');
	 }
	 function closeStationsDialog(){
		 $("#dlg").dialog("close");
		 $("#sname1").val("");
	 }
	 function closeUpdateStationsDialog(){
		 $("#update").dialog("close");
		 $("#sname2").val("");
	 }
	 
	 
	//删除站点信息
	function deleteStations(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].sid);
		}
		
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post('deleteStations',{'ids':ids},function(data){
					$.messager.alert("系统提示","已成功删除<font color=red>"+selectedRows.length+"</font>条数据");
					$('#dg').datagrid('reload');
				},'json');
			} 
		});
	}
		//修改站点信息
		function updateStations(){
			var sname=$('#sname2').val();
			if(sname==null || ''==sname.trim()){
				$.messager.alert('系统提示','站点名称不能为空');
				return;
			}
			var selectedRows=$("#dg").datagrid("getSelections");
			var sid=selectedRows[0].sid;
			$.post('updateStations',{'sname':sname,'id':sid},function(data){
				if(data=='have'){
					$.messager.alert('系统提示','该站点名已存在');
				}else if(data==1){
					$.messager.alert('系统提示','站点信息修改成功');
					closeUpdateStationsDialog();
					$('#dg').datagrid('reload');
				}
			},'json');
			
		}
		//添加站点信息
		function saveStations(){
			var sname=$('#sname1').val();
			if(sname==null || ''==sname.trim()){
				$.messager.alert('系统提示','站点名称不能为空');
				return ;
			}
			$.post('saveStations',{'sname':sname},function(data){
				if(data=='have'){
					$.messager.alert('系统提示','该站点名已存在,无需重复添加');
				}else if(data==1){
					$.messager.alert('系统提示','站点添加成功');
					closeStationsDialog();
					$('#dg').datagrid('reload');
				}
			},'json');
		 }
	 
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="站点管理" class="easyui-datagrid"
   pagination="true" rownumbers="true" url="findStationsByPage"
   fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="sid" width="100" align="center">编号</th>
   		<th field="sname" width="100" align="center">站点名称</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 	    <a href="javascript:openStationsAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
 		<a href="javascript:openUpdateStationsDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteStations()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 <!-- 添加新站点开始 -->
 <div id="dlg" class="easyui-dialog" style="width:500px;height:180px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>站点名称：</td>
   			<td><input type="text" id="sname1" name="sname" class="easyui-validatebox" required="true"/></td>
   		</tr>
   	</table>
   </form>
 </div>
 <div id="dlg-buttons">
 	<a href="javascript:saveStations()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeStationsDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 <!-- 添加新站点结束 -->
 
 <!-- 修改站点信息开始 -->
 <div id="update" class="easyui-dialog" style="width:500px;height:180px;padding: 10px 20px"
   closed="true" buttons="#update-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>站点名称：</td>
   			<td><input type="text" id="sname2" name="sname" class="easyui-validatebox" required="true"/></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="update-buttons">
 	<a href="javascript:updateStations()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeUpdateStationsDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 <!-- 修改站点信息结束 -->
</body>
</html>