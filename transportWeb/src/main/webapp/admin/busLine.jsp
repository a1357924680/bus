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
<title>公交管理页面</title>
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

	function formatBlogType(val,row){
		return val.typeName;
	}
	
	function formatTitle(val,row){
		return "<a target='_blank' href='blog/articles/"+row.id+".html'>"+val+"</a>"
	}
	
	//打开添加公交信息框
	function openAddBusLine(){
		$("#addBusLine").dialog("open").dialog("setTitle","添加公交信息");
	}
	
	//打开修改公交信息框
	function openUpdateBusLine(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			 $.messager.alert("系统提示","请选择要修改的数据！");
			 return;
		 }
		 var row=selectedRows[0];
		 $("#updateBusLine").dialog("open").dialog("setTitle","修改公交信息");
	}
	
	//关闭添加信息弹框
	function closeAddBusLineDialog(){
		$("#addBusLine").dialog("close");
		resetToLine();
		resetToLine1();
	}
	
	//添加公交信息
	function addBusLine(){
		
	}	
	//修改公交信息
	function updateBusLine(){
		
	}
	//删除公交信息
	function deleteBusLine(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			 $.messager.alert("系统提示","请选择要删除的数据！");
			 return;
		 }
	}
	//搜索公交信息
	function searchBline(){
		
	} 
	
	
	//将路线信息添加到span中显示在界面上
	function addToLine(){
		var hiddenStr=$('#hiddenLine').val();
		var showStr=$('#showLine').text();
		var value=$('#bline1').combobox('getValue');//获取到value,即站点id  hiddenLine
		var text=$('#bline1').combobox('getText'); //获取text,即站点名称  showLine
		hiddenStr+=value+"-";
		showStr+=text+"->";
		$('#hiddenLine').val(hiddenStr);
		$('#showLine').text(showStr);
	}
	//清空路线
	function resetToLine(){
		$('#hiddenLine').val('');
		$('#showLine').text('');
	}
	//将路线信息添加到span中显示在界面上
	function addToLine1(){
		var hiddenStr=$('#hiddenLine').val();
		var showStr=$('#showLine').text();
		var value=$('#bline2').combobox('getValue');//获取到value,即站点id  hiddenLine
		var text=$('#bline2').combobox('getText'); //获取text,即站点名称  showLine
		hiddenStr+=value+"-";
		showStr+=text+"->";
		$('#hiddenLine').val(hiddenStr);
		$('#showLine').text(showStr);
	}
	//清空路线
	function resetToLine1(){
		$('#hiddenLine').val('');
		$('#showLine').text('');
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="博客管理" class="easyui-datagrid"
   pagination="true" rownumbers="true"
   fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="100" align="center">编号</th>
   		<th field="bname" width="100" align="center" formatter="formatTitle">公交名称</th>
   		<th field="bline" width="150" align="center">线路信息</th><!-- 起点-终点 -->
   		<th field="bbegin" width="100" align="center">早班车时间</th>
   		<th field="bstop" width="100" align="center">末班车时间</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:openAddBusLine()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
 		<a href="javascript:openUpdateBusLine()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteBusLine()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 	<div>
 		&nbsp;标题：&nbsp;<input type="text" id="s_title" size="20" onkeydown="if(event.keyCode==13) searchBlog()"/>
 		<a href="javascript:searchBline()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 	</div>
 </div>
 <!-- 添加公交信息开始 -->
 <div id="addBusLine"  class="easyui-dialog" style="width:500px;height:250px;padding: 10px 20px"
   closed="true" buttons="#add-buttons">
 	<form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>公交名称：</td>
   			<td><input type="text" id="bname1" name="sname" class="easyui-validatebox" required="true"/></td>
   		</tr>
   		<tr>
   			<td>早班车时间：</td>
   			<td><input type="text" id="bbegin1" name="bbegin" class="easyui-timespinner" required="true"data-options="showSeconds:false"/></td>
   		</tr>
   		<tr>
   			<td>末班车时间：</td>
   			<td><input type="text" id="bstop1" name="bstop" class="easyui-timespinner" required="true"data-options="showSeconds:false"/></td>
   		</tr>
   		<tr>
   			<td>公交名称：</td>
   			<td>
   				<select id="bline1" name="bline" class="easyui-combobox"required="true">
   					<option value="1">高铁站</option>  
    				<option value="2">湖南工学院</option>  
    				<option value="3">人人乐超市</option>  
    				<option value="4">火车站</option>  
    				<option value="5">南华大学</option>
   				</select>
   				<!-- <input id="bline1" class="easyui-combobox" name="bline"  
    				data-options="valueField:'sid',textField:'sname',url:'get_data.php'" /> -->
   				<a href="javascript:addToLine()" class="easyui-linkbutton" iconCls="icon-ok">添加到路线</a>
   				<a href="javascript:resetToLine()" class="easyui-linkbutton" iconCls="icon-cancel">清空路线</a>
			</td>
   		</tr>
   		<tr>
   			<td>&nbsp</td>
   			<td>
   				<spqn id="showLine"></spqn>
   				<input id="hiddenLine" type="hidden"/>
   			</td>
   		</tr>
   	</table>
   </form>
 </div>
 <div id="add-buttons">
 	<a href="javascript:addBusLine()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeAddBusLineDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 <!-- 添加公交信息结束 -->
 <!-- 修改公交信息开始 -->
 <div id="updateBusLine"  class="easyui-dialog" style="width:500px;height:250px;padding: 10px 20px"
   closed="true" buttons="#update-buttons">
 	<form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>公交名称：</td>
   			<td><input type="text" id="bname2" name="sname" class="easyui-validatebox" required="true"/></td>
   		</tr>
   		<tr>
   			<td>早班车时间：</td>
   			<td><input type="text" id="bbegin2" name="bbegin" class="easyui-timespinner" required="true"data-options="showSeconds:false"/></td>
   		</tr>
   		<tr>
   			<td>末班车时间：</td>
   			<td><input type="text" id="bstop2" name="bstop" class="easyui-timespinner" required="true"data-options="showSeconds:false"/></td>
   		</tr>
   		<tr>
   			<td>公交名称：</td>
   			<td>
   				<select id="bline2" name="bline" class="easyui-combobox"required="true">
   					<option value="aa">aitem1</option>  
    				<option>bitem2</option>  
    				<option>bitem3</option>  
    				<option>ditem4</option>  
    				<option>eitem5</option>
   				</select>
   				<!-- <input id="bline1" class="easyui-combobox" name="bline"  
    				data-options="valueField:'sid',textField:'sname',url:'get_data.php'" /> -->
   				<a href="javascript:addToLine1()" class="easyui-linkbutton" iconCls="icon-ok">添加到路线</a>
   				<a href="javascript:resetToLine1()" class="easyui-linkbutton" iconCls="icon-cancel">清空路线</a>
			</td>
   		</tr>
   		<tr>
   			<td>&nbsp</td>
   			<td><spqn id="showLine"></spqn></td>
   		</tr>
   	</table>
   </form>
 </div>
 <div id="update-buttons">
 	<a href="javascript:updateBusLine()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeAddBusLineDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 <!-- 修改公交信息结束 -->
</body>
</html>