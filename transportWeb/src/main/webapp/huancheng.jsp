<%@ page language="Java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*机顶网址  防止路径出错    只有jsp特有*/
	String path = request.getContextPath(); //  /douban
	//                    http           ://      localhost            :       8080                /douban /       
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title></title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/fullcalendar.css" />
<link rel="stylesheet" href="css/unicorn.main.css" />
<link rel="stylesheet" href="css/unicorn.grey.css" class="skin-color" />

</script>
</head>
<body>


	<div id="header">
		<h1>
			<a href="./dashboard.html">城市公交查询</a>
		</h1>
	</div>

	<div id="search"></div>
	<div id="user-nav" class="navbar navbar-inverse">
		<ul class="nav btn-group">
			<li class="btn btn-inverse"><a title="" href="#"><i
					class="icon icon-user"></i> <span class="text">个人中心</span></a></li>
			<li class="btn btn-inverse"><a title="" href="#"><i
					class="icon icon-cog"></i> <span class="text">设置</span></a></li>
			<li class="btn btn-inverse"><a title="" href="login.jsp"><i
					class="icon icon-share-alt"></i> <span class="text">退出</span></a></li>
		</ul>
	</div>

	<div id="sidebar">
		<a href="#" class="visible-phone"><i class="icon icon-home"></i>
			城市公交查询</a>
		<ul>
			<li class="active"><a href="index.jsp"><i
					class="icon icon-home"></i> <span>首页</span></a></li>

			<li class="submenu"><a href="#"><i class="icon icon-file"></i><span>公交信息查询</span></a>
				<ul>
					<li><a href="xianlu.jsp">线路查询</a></li>
					<li><a href="zhandian.jsp">站点查询</a></li>
					<li><a href="huancheng.jsp">换乘查询</a></li>
				</ul></li>
		</ul>

	</div>

	<div id="style-switcher">
		<i class="icon-arrow-left icon-white"></i> <span>Style:</span> <a
			href="#grey"
			style="background-color: #555555; border-color: #aaaaaa;"></a> <a
			href="#light-blue" style="background-color: #8399b0;"></a> <a
			href="#blue" style="background-color: #2D2F57;"></a> <a href="#red"
			style="background-color: #673232;"></a> <a href="#red-green"
			style="background-image: url('img/demo/red-green.png'); background-repeat: no-repeat;"></a>
	</div>

	<div id="content">
		<div id="content-header">
			<h1>城市公交查询</h1>
			<div class="btn-group">
				<a class="btn btn-large tip-bottom" title="Manage Files"><i
					class="icon-file"></i></a> <a class="btn btn-large tip-bottom"
					title="Manage Users"><i class="icon-user"></i></a> <a
					class="btn btn-large tip-bottom" title="Manage Orders"><i
					class="icon-shopping-cart"></i></a>
			</div>
		</div>
		<div id="breadcrumb">
			<a href="#" title="Go to Home" class="tip-bottom"><i
				class="icon-home"></i> Home</a> <a href="#" class="current">城市公交查询</a>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="alert alert-info">
						您的位置: <strong>换乘查询</strong> <a href="#" data-dismiss="alert"
							class="close">×</a>
					</div>
				</div>
			</div>


			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>换乘查询</h3>
				</div>
				<div class="panel-body">
					<p>换乘查询(起点-终点)</p>
				</div>
				<select id="selectStart"></select> <span
					class="glyphicon glyphicon-arrow-right">--></span>
				<!--  <span class="glyphicon glyphicon-arrow-left"></span>-->
				<select id="selectStop"></select>
				<!-- Table -->
				<table class="table">
					<button type="button" class="btn btn-primary" onclick="getAllBusFromTo()">查询</button>
				</table>
			</div>



			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box widget-calendar">
						<div class="widget-content nopadding" id="showBusLines">
							 <!-- <ul style="list-style: none;">
									<li><span style="color:red">100路:</span>站点信息</li>
									<li><span style="color:red">100路:</span>站点信息</li>
									<li><span style="color:red">100路:</span>站点信息</li>
									<li><span style="color:red">100路:</span>站点信息</li>
								</ul> -->
						
						</div>
						<div align="center">
							<a href="javascript:showBusLineByPage(1)" title="首页">首页</a> 
							<a href="javascript:showBusLineByPage(2)" title="上一页">上一页</a> 
							<a href="javascript:showBusLineByPage(3)" title="下一页">下一页</a> 
							<a href="javascript:showBusLineByPage(4)" title="尾页">尾页</a>
						</div>
						<div id="showHidden">
							<!-- <input type="hidden" value="1"/>
							<input type="hidden" value="2"/>
							<input type="hidden" value="3"/>
							<input type="hidden" value="4"/>
							<input type="hidden" value="5"/>
							<input type="hidden" value="6"/>  -->
						</div>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div id="footer" class="span12">
					2016 - 2017 &copy;方便你我他 <a
						href="https://wrapbootstrap.com/user/diablo9983"></a>
				</div>
			</div>
		</div>
	</div>


	<script src="js/excanvas.min.js"></script>
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-ui.custom.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.flot.min.js"></script>
	<script src="js/jquery.flot.resize.min.js"></script>
	<script src="js/jquery.peity.min.js"></script>
	<script src="js/fullcalendar.min.js"></script>
	<script src="js/unicorn.js"></script>
	<script src="js/unicorn.dashboard.js"></script>
<script type="text/javascript">
//加载下拉列表
$.post('findAllStations',function(data){
	for(var i=0;i<data.length;i++){
		document.getElementById('selectStart').options.add(new Option(data[i].sname,data[i].sid));
		document.getElementById('selectStop').options.add(new Option(data[i].sname,data[i].sid));
	}
},'json');
//将所有换乘信息放到隐藏域中
function getAllBusFromTo(){
	var start = $("#selectStart option:selected").val();
	var stop = $("#selectStop option:selected").val();
	if(start==stop){
		alert('起点终点为同一站点,请重新选择!!');
		return;
	}
	$.post('getAllBusFromTo',{'start':start,'stop':stop},function(data){
		var str='';
		$('#showHidden').html('');
		for(var i=0;i<data.length;i++){
			str+='<input type="hidden" value="'+data[i].bname+'#'+data[i].bline+'"/>';
		}
		$('#showHidden').append(str);
		showBusLineByPage(1);
	},'json');
	
}
var page=1;
function showBusLineByPage(x){
	//把所有的换乘信息都放在一个数组中
	var strLines=[];
	var obj=$('#showHidden>input');
	var str='';
	var total=obj.length;
	var totalPage=0;
	if(total%6==0){
		totalPage=total/6;
	}else{
		totalPage=parseInt(total/6)+1;
	}
	if(total==0){
		str+='对不起，目前无对应线路...';
	}else{
		if(x==1){
			page=1;
		}else if(x==2){
			if(page==1){
				alert('当前页为第一页');
			}else{
				page--;
			}
		}else if(x==3){
			if(page>=totalPage){
				alert('当前页为最后一页');
			}else{
				page++;
			}
		}else if(x==4){
			page=totalPage;
		}
		for(var i=0;i<obj.length;i++){
			strLines.push($('#showHidden>input')[i].value);
		}
		str+='<ul style="list-style: none;">';
		for(var j=(page-1)*6 ; j<page*6 ; j++){
			if(strLines.length>j){
				str+='<li><span style="color:red">'+strLines[j].split("#")[0]+':</span>'+strLines[j].split("#")[1]+'</li>';
			}
		}
		str+='</ul>';
	}
	$('#showBusLines').html('');
	$('#showBusLines').append(str);
}


</script>
</body>
</html>
