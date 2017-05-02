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
<title>线路查询</title>
<base href="<%=basePath%>">
<meta charset="UTF-8" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/fullcalendar.css" />
<link rel="stylesheet" href="css/unicorn.main.css" />
<link rel="stylesheet" href="css/unicorn.grey.css" class="skin-color" />
<script type="text/javascript">

		var pageNum=1;
		function showBusByPage(x) {
			getBusTotal();
			var totalSize=$('#total').val();//总数
			var totalPage=0;
			if(totalSize%6==0){
				totalPage=totalSize/6;
			}else{
				totalPage=parseInt(totalSize/6)+1;
			}
			if(x==1){
				pageNum=1;
			}else if(x==2){  
				if(pageNum==1){
					alert('当前页为第一页');
				}else{
					pageNum--;
				}
			}else if(x==3){
				if(pageNum>=totalPage){//最后一页
					alert('当前页为最后一页');
				}else{
					pageNum++;
				}
			}else if(x==4){
				pageNum=totalPage;
			}
			showBusLines(pageNum);
		}

		function showBusLines(pageNum) {
			var bname = $('#inputaddress').val();
			$.post('findAllByPage', {'bname':bname,'page':pageNum,'rows':6,'bline':""}, function(data) {
				$('#showBusLines').html('');
				var str = '';
				if (data.length != 0) {
					str += '<ul style="list-style: none;">';
					for (var i = 0; i < data.length; i++) {
						str+='<li><span style="color:red">'+data[i].bname+':</span>'+data[i].bline+'</li>';
					}
					str+='</ul>'
				} else {
					str += '对不起,目前无对应条件';
				}
				$('#showBusLines').append(str);
			}, 'json');
		}
		function getBusTotal(){
			var bname = $('#inputaddress').val();
			$.post('getBusTotal',{'bname':bname,'bline':""},function(data){
				$('#total').val(data);
			},'json');
		}
	</script>
</head>
<body>


	<div id="header">
		<h1>
			<a href="#">城市公交查询</a>
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

			<li class="submenu"><a href="#"><i class="icon icon-file"></i>
					<span>公交信息查询</span></a>
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
						您的位置: <strong>线路查询</strong> <a href="#" data-dismiss="alert"
							class="close">×</a>
					</div>
				</div>
			</div>

			<div class="panel panel-default">

				<div class="panel-heading">
					<h3>线路查询</h3>
				</div>
				<div class="panel-body">
					<p>线路查询(线路名称)</p>
					<input type="hidden" id="total"/>
				</div>
				<input type="address" id="inputaddress" class="form-control"
					required autofocus>
				<!-- Table -->
				<table class="table">
					<button type="button" class="btn btn-primary"
						onclick="showBusByPage(1)">查询</button>
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
							<a href="javascript:showBusByPage(1)" title="首页">首页</a>
							<a href="javascript:showBusByPage(2)" title="上一页">上一页</a>
							<a href="javascript:showBusByPage(3)" title="下一页">下一页</a> 
							<a href="javascript:showBusByPage(4)" title="尾页">尾页</a>
						</div>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div id="footer" class="span12">
					2016 - 2017 &copy; 方便你我他 <a
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
	
</body>
</html>