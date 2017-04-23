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
<title>管理员管理</title>
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

$(function(){
	showAdminsByPage();
});	
//弹出添加管理员框
function addAdmin(){
	$("#dlg").dialog("open").dialog("setTitle","添加管理员信息");
}
//关闭弹框
function closeSaveAdminDialog(){
	$("#dlg").dialog("close");
	$("#newPassword").val("");
	$("#newPassword2").val("");
}
//删除管理员
function deleteAdmin(){
	var selectedRows=$("#dg").datagrid("getSelections");
	if(selectedRows.length==0){
		 $.messager.alert("系统提示","请选择要删除的数据！");
		 return;
	 }
	 var strIds=[];
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].aid);
	 }
	 var ids=strIds.join(",");
	 $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post('deleteAdmins',{'ids':ids},function(data){
					$.messager.alert("系统提示","已成功删除<font color=red>"+selectedRows.length+"</font>条数据");
					$('#dg').datagrid('reload');
				},'json');
			} 
   });
}
//添加管理员
function saveNewAdmin(){
	var newPassword=$('#newPassword').val();
	var newPassword2=$('#newPassword2').val();
	if(newPassword!=newPassword2){
		$.messager.alert("系统提示",'两次输入的密码不一致,请重新确认密码');
		return;
	}
	if(newPassword==null || newPassword2==null){
		$.messager.alert("系统提示",'密码不能为空,请输入密码');
		return;
	}
	$.post('saveNewAdmin',{'newPassword':newPassword},function(data){
		if(data==1){
			$.messager.alert("系统提示",'添加管理员成功');
			$('#dg').datagrid('reload');
			closeSaveAdminDialog();
		}
	},'json');
}

//显示管理员列表
function showAdminsByPage(){
	$('#dg').datagrid({
	    url:'showAdminsByPage', 
	    pagination:true, //显示分页工具栏
	 	pageSize:4,
	 	pageList:[2,4,6],
	    columns:[[  
	        {field:'ck',checkbox:true,width:100},   
	        {field:'aid',title:'编号',width:100,align:'center'}  
	    ]]   
	});
}

	
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="管理员管理" class="easyui-datagrid"
   rownumbers="true" fit="true" toolbar="#tb">
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:addAdmin()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加管理员</a>
 		<a href="javascript:deleteAdmin()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除管理员</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 
 <div id="dlg" class="easyui-dialog" style="width:400px;height:200px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>新密码：</td>
   			<td><input type="password" id="newPassword" name="newPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
   		</tr>
   		<tr>
   			<td>确认新密码：</td>
   			<td><input type="password" id="newPassword2" name="newPassword2" class="easyui-validatebox" required="true" style="width: 200px"/></td>
   		</tr>
   		
   	</table>
   </form>
 </div>
 <div id="dlg-buttons">
 	<a href="javascript:saveNewAdmin()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   	<a href="javascript:closeSaveAdminDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 
</body>
</html>