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
<script type="text/javascript" src="static/jquery-easyui-1.3.3/jquery-form.js"></script>
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
		$("#updateBusLine").dialog("open").dialog("setTitle","修改公交信息");
		var rowData = $('#dg').datagrid('getSelected');	
		//alert(rowData.bline);
		alert(rowData.bid);
		var bid=rowData.bid
		$.post('selectblineById',{'bid':bid},function(data){
			
		},'json');
		$("#updateBusLine").form('load',rowData);
	} 
	
	//打开修改公交信息框
	/* function openUpdateBusLine(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			 $.messager.alert("系统提示","请选择要修改的数据！");
			 return;
		 }
		 var row=selectedRows[0];
		 $("#updateBusLine").dialog("open").dialog("setTitle","修改公交信息");
		 $("#fm").form("load",row);
		 var sid=selectedRows[0].sid;
		 $.post('selectStationsById',{'id':sid},function(data){
			 $('#bname2').val(data),$('#bbegin2').val(data),$('#bstop2').val(data),$('#hiddenLine').val(data);
		 },'json');
	} */
	
	//关闭添加信息弹框
	function closeAddBusLineDialog(){
		$("#addBusLine").dialog("close");
		resetToLine();
		resetToLine1();
	}
	function closeUpdateBusLineDialog(){
		$("#updateBusLine").dialog("close");
		resetToLine();
		resetToLine1();
	}
	
	//添加公交信息
	function addBusLine(){
		var bname=$('#bname1').val();
		if(bname==null || ''==bname.trim()){
			$.messager.alert('系统提示','线路名称不能为空 ');
			return ;
		}
		var bbegin=$('#bbegin1').val();
		var bstop=$('#bstop1').val();
		var hiddenLine='-'+$('#hiddenLine').val();
		$.post('addBusLine',{"bname":bname,"bbegin":bbegin,"bstop":bstop,"hiddenLine":hiddenLine},function(data){
			if(data=='have'){
				$.messager.alert('系统提示','该线路已存在,无需重复添加');
			}
			if(data>0){
				$.messager.alert('系统提示','添加成功 ');
				closeAddBusLineDialog();
				$('#dg').datagrid('reload');
			}else{
				$.messager.alert('系统提示','添加失败  ');
			}
		},'json')
		
		$('bname1').val('');
		$('bbegin1').val('');
		$('bstop1').val('');
		$('#hiddenLine').val('');
		$('#showLine').text('');
	}
	
	//修改公交信息
	function updateBusLine(){
		var bname=$('#bname2').val();
		if(bname==null || ''==bname.trim()){
			$.messager.alert('系统提示','站点名称不能为空');
			return;
		}
		var bbegin=$('#bbegin2').val();
		var bstop=$('#bstop2').val();
		var hiddenLine='-'+$('#hiddenLine').val();
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
	//删除公交信息
	function deleteBusLine(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			 $.messager.alert("系统提示","请选择要删除的数据！");
			 return;
		 }
		
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].bid); //js数组  将元素添加到数组当中去 
		}
		
		var ids=strIds.join(","); //将数组用逗号分隔 
		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post('deleteBusLine',{'ids':ids},function(data){
					$.messager.alert("系统提示","已成功删除<font color=red>"+selectedRows.length+"</font>条数据");
					$('#dg').datagrid('reload');
				},'json');
			} 
		});
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
		var strs=new Array();//定义数组
		strs=hiddenStr.split('-');
		var flag=false;
		for(var i=0;i<strs.length;i++){
			if(strs[i]==value){
				flag=true;
				break;
			}
		}
		if(flag){
			$.messager.confirm("系统提示","站点已存在你是否要再添加相同的站点 ？",function(r){
				if(r){
					flag=false;
					hiddenStr+=value+"-";
					showStr+=text+"->";
					$('#hiddenLine').val(hiddenStr);
					$('#showLine').text(showStr);
				}
			 });
		}else{
			hiddenStr+=value+"-";
			showStr+=text+"->";
			$('#hiddenLine').val(hiddenStr);
			$('#showLine').text(showStr);
		}
	}
	// add时候的清空路线
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
	
	
	
	//update的 清空路线
	function resetToLine2(){
		$('#hiddenLine').val('');
		$('#showLine2').text('');
	}
</script>
</head>

<body style="margin: 1px">

<table id="dg" title="公交管理" class="easyui-datagrid"
   pagination="true" rownumbers="true"  fitColumns="true"
    url="findByPage"  fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="bid" width="40" align="center">编号</th>
   		<th field="bname" width="50" align="center" >公交名称</th>
   		<th field="bline" width="200" align="center" resizable="true" nowrap="false">线路信息</th><!-- 起点-终点 -->
   		<th field="bbegin" width="60" align="center">早班车时间</th>
   		<th field="bstop" width="60" align="center">末班车时间</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:openAddBusLine()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
 		<a href="javascript:openUpdateBusLine()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteBusLine()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 	<!-- <div>
 		&nbsp;标题：&nbsp;<input type="text" id="s_title" size="20" onkeydown="if(event.keyCode==13) searchBlog()"/>
 		<a href="javascript:searchBline()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 	</div> -->
 </div>
 <!-- 添加公交信息开始 -->
 <div id="addBusLine"  class="easyui-dialog" style="width:550px;height:300px;padding: 10px 20px"
   closed="true" buttons="#add-buttons">
 	<form id="fm"  method="post"  >
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
   			<td>站点名称：</td>
   			<td>
   				
   				 <input id="bline1" class="easyui-combobox" name="bline" 
    				data-options="valueField:'sid',textField:'sname',url:'findAllStations' " /> 
    				
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
 <div id="updateBusLine"  class="easyui-dialog" style="width:550px;height:300px;padding: 10px 20px"
   closed="true" buttons="#update-buttons">
 	<form id="updateBusLine" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>公交名称：</td>
   			<td><input type="text" id="bname2" name="bname" class="easyui-validatebox" required="true" readOnly="readonly"/>&nbsp;<span style="color:red">(只读)</span></td>
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
   			<td>站点名称：</td>
   			<td>
   				<input id="bline1" class="easyui-combobox" name="bline2" 
    				data-options="valueField:'sid',textField:'sname',url:'findAllStations' " /> 
   				
   				<a href="javascript:addToLine()" class="easyui-linkbutton" iconCls="icon-ok">添加到路线</a>
   				<a href="javascript:resetToLine2()" class="easyui-linkbutton" iconCls="icon-cancel">清空路线</a>
			</td>
   		</tr>
   		<tr>
   			<td>&nbsp</td>
   			<input id="hiddenLine2"   type="hidden"/>
   			<td><textarea id="showLine2" name="bline"></textarea></td>
   		</tr>
   	</table>
   </form>
 </div>
 <div id="update-buttons">
 	<a href="javascript:updateBusLine()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeUpdateBusLineDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 <!-- 修改公交信息结束 -->
</body>
</html>