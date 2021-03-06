<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*机顶网址  防止路径出错    只有jsp特有*/
	String path=request.getContextPath();  //  /douban
	//                    http           ://      localhost            :       8080                /douban /       
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title></title>
		<base href="<%=basePath %>">
		<meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="css/bootstrap.min.css" />
		<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
		<link rel="stylesheet" href="css/fullcalendar.css" />	
		<link rel="stylesheet" href="css/unicorn.main.css" />
		<link rel="stylesheet" href="css/unicorn.grey.css" class="skin-color" />
	</head>
	<body>
		
		
		<div id="header">
			<h1><a href="./dashboard.html">城市公交查询</a></h1>		
		</div>
		
		<div id="search">
			
		</div>
		<div id="user-nav" class="navbar navbar-inverse">
            <ul class="nav btn-group">
                <li class="btn btn-inverse" ><a title="" href="#"><i class="icon icon-user"></i> <span class="text">个人中心</span></a></li>
                <li class="btn btn-inverse"><a title="" href="#"><i class="icon icon-cog"></i> <span class="text">设置</span></a></li>
                <li class="btn btn-inverse"><a title="" href="login.jsp"><i class="icon icon-share-alt"></i> <span class="text">退出</span></a></li>
            </ul>
        </div>
            
		<div id="sidebar">
			<a href="#" class="visible-phone"><i class="icon icon-home"></i> 城市公交查询</a>
			<ul>
				<li class="active"><a href="index.jsp"><i class="icon icon-home"></i> <span>首页</span></a></li>
				
				<li class="submenu">
					<a href="#"><i class="icon icon-file"></i> <span>公交信息查询</span></a>
					<ul>
						<li><a href="xianlu.jsp">线路查询</a></li>
						<li><a href="zhandian.jsp">站点查询</a></li>
						<li><a href="huancheng.jsp">换乘查询</a></li>
					</ul>
				</li>
			</ul>
		
		</div>
		
		<div id="style-switcher">
			<i class="icon-arrow-left icon-white"></i>
			<span>Style:</span>
			<a href="#grey" style="background-color: #555555;border-color: #aaaaaa;"></a>
            <a href="#light-blue" style="background-color: #8399b0;"></a>
			<a href="#blue" style="background-color: #2D2F57;"></a>
			<a href="#red" style="background-color: #673232;"></a>
            <a href="#red-green" style="background-image: url('img/demo/red-green.png');background-repeat: no-repeat;"></a>
		</div>
		
		<div id="content">
			<div id="content-header">
				<h1>城市公交查询</h1>
				<div class="btn-group">
					<a class="btn btn-large tip-bottom" title="Manage Files"><i class="icon-file"></i></a>
					<a class="btn btn-large tip-bottom" title="Manage Users"><i class="icon-user"></i></a>
					<a class="btn btn-large tip-bottom" title="Manage Orders"><i class="icon-shopping-cart"></i></a>
				</div>
			</div>
			<div id="breadcrumb">
				<a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
				<a href="#" class="current">城市公交查询</a>
			</div>
			<div class="container-fluid" align="center">
				<div class="row-fluid">
					<div class="span12">
						<div class="alert alert-info">
							欢迎来到 <strong>城市公交查询网站</strong>
							<a href="#" data-dismiss="alert" class="close">×</a>
						</div>
					</div>	
				</div>
				
				<!-- 轮播 -->
				<div id="myCarousel" class="carousel slide" align="center" style="width:700px" data-interval="1000" data-wrap="true">
					    <!-- 轮播（Carousel）指标 -->
					    <ol class="carousel-indicators">
					        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					        <li data-target="#myCarousel" data-slide-to="1"></li>
					        <li data-target="#myCarousel" data-slide-to="2"></li>
					        <li data-target="#myCarousel" data-slide-to="3"></li>
					        <li data-target="#myCarousel" data-slide-to="4"></li>
					        <li data-target="#myCarousel" data-slide-to="5"></li>
					    </ol>   
					    <!-- 轮播（Carousel）项目 -->
					    <div class="carousel-inner" >
					        <div class="item active">
					            <img src="img/lunbo/1.jpg" alt="First slide">
					            <div class="carousel-caption">公交图片 1</div>
					        </div>
					        <div class="item">
					            <img src="img/lunbo/2.jpg" alt="Second slide">
					            <div class="carousel-caption">公交图片 2</div>
					        </div>
					        <div class="item">
					            <img src="img/lunbo/3.jpg" alt="Third slide">
					            <div class="carousel-caption">公交图片 3</div>
					        </div>
					        <div class="item">
					            <img src="img/lunbo/4.jpg" alt="forth slide">
					            <div class="carousel-caption">公交图片 4</div>
					        </div>
					        <div class="item">
					            <img src="img/lunbo/5.jpg" alt="fifth slide">
					            <div class="carousel-caption">公交图片 5</div>
					        </div>
					        <div class="item">
					            <img src="img/lunbo/6.jpg" alt="sixth slide">
					            <div class="carousel-caption">公交图片 6</div>
					        </div>
					    </div>
					    <!-- 轮播（Carousel）导航 -->
					    <a class="carousel-control left" href="#myCarousel" 
					        data-slide="prev">&lsaquo;
					    </a>
					    <a class="carousel-control right" href="#myCarousel" 
					        data-slide="next">&rsaquo;
					    </a>
				</div>
				
				<div class="row-fluid">
					<div id="footer" class="span12">
						2016 - 2017 &copy;方便你我他 <a href="https://wrapbootstrap.com/user/diablo9983"></a>
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
            $('#myCarousel').carousel({
            	interval: 1500
            })
            </script>
	</body>
</html>
