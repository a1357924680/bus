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
<title>公交查询系统后台管理页面</title>
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

	var url;
	
	function openTab(text,url,iconCls){
		if($("#tabs").tabs("exists",text)){
			$("#tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='admin/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	
	//弹出修改密码弹框
	function alertUpdate(){
		$("#updatePwd").dialog("open").dialog("setTitle","修改密码");
	}
	
	//修改密码操作
	function updatePwd(){
		
	}
	
	
	function closePasswordModifyDialog(){
		resetValue();
		$("#updatePwd").dialog("close");
	}
	
	function resetValue(){
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}
	
	//退出登录
	function logout(){
		$.messager.confirm("系统提示","您确定要退出系统吗？",function(r){
			if(r){
				window.location.href='admin/blogger/logout.do';
			} 
		 });
	}
	//刷新系统
	function refreshSystem(){
		$.post("admin/system/refreshSystem.do",{},function(result){
			if(result.success){
				$.messager.alert("系统提示","已成功刷新系统缓存！");
			}else{
				$.messager.alert("系统提示","刷新系统缓存失败！");
			}
		},"json");
	}

</script>
</head>
<body class="easyui-layout">
<div region="north" style="height: 78px;background-color: #E0ECFF">
	<table style="padding: 5px" width="100%">
		<tr>
			<%-- <td width="50%"><!-- 博客系统的login -->
				<img alt="logo" src="${pageContext.request.contextPath}/static/images/logo.png">
			</td> --%>
			<td width="50%"><h2>城市公交查询系统后台</h2></td>
			<td valign="bottom" align="right" width="50%">
				<font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${currentUser.userName }</font>
			</td>
		</tr>
	</table>
</div>
<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center" style="padding-top: 100px"><font color="red" size="10">城市公交查询系统欢迎您的使用</font></div>
		</div>
	</div>
</div>
<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="个人信息管理" data-options="selected:true,iconCls:'icon-item'" style="padding: 10px">
			<a href="javascript:alertUpdate()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">修改密码</a>
		</div>
		<div title="管理员操作" data-options="selected:true,iconCls:'icon-item'" style="padding: 10px">
			<a href="javascript:openTab('管理员管理','admin.jsp','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">管理员</a>
		</div>
		<div title="站点管理"  data-options="iconCls:'icon-bkgl'" style="padding:10px;">
			<a href="javascript:openTab('站点信息','stations.jsp','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">站点信息</a>
		</div>
		<div title="线路管理" data-options="iconCls:'icon-bklb'" style="padding:10px">
			<a href="javascript:openTab('线路信息','busLine.jsp','icon-bklb')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;">线路信息</a>
		</div>
		
		<div title="系统管理"  data-options="iconCls:'icon-system'" style="padding:10px">
			<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
		</div>
	</div>
</div>
<div region="south" style="height: 25px;padding: 5px" align="center">
	 © 2017 城市公交查询系统 版权所有
</div>
<div id="updatePwd" class="easyui-dialog" style="width:400px;height:200px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>原始密码：</td>
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
 	<a href="javascript:updatePwd()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
   	<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 

 
</body>
</html>