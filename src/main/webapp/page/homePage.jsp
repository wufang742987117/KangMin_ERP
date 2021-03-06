<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>康源医药管理系统</title>
		<link rel="stylesheet" href="res/layui/css/layui.css">
		<script src="res/js/jquery-2.1.3.min.js" type="text/javascript" ></script>
		<script src="res/layui/layui.js"></script>
		<style>
			/*隐藏首页选项卡的关闭按钮*/
			.layui-tab ul.layui-tab-title li:nth-child(1) i {
			    display: none;
			}
			.layui-tab-item{
				height:100%;
			}
			.x-slide_left {
			    width: 17px;
			    height: 61px;
			    background: url(res/img/unfold.png) 0 0 no-repeat;
		        background-position-x: 0px;
		        background-position-y: 0px;
			    position: absolute;
			    top: 200px;
			    left: 0px;
			    cursor: pointer;
			}
		</style>
	</head>
	<body>
		<div class="layui-layout layui-layout-admin">
		  <div class="layui-header">
		    <div class="layui-logo"><img alt="" src="res/img/logo.png" width="30"> 康源医药管理系统</div>
		    <!-- 头部区域（可配合layui已有的水平导航）-->
		    <ul class="layui-nav layui-layout-left">
		      <!-- <li class="layui-nav-item"><a href="">控制台</a></li>
		      <li class="layui-nav-item"><a href="javascript:;">商品管理</a></li>
		      <li class="layui-nav-item"><a href="">用户</a></li>
		      <li class="layui-nav-item">
		        <a href="javascript:;">其它系统</a>
		        <dl class="layui-nav-child">
		          <dd><a href="">邮件管理</a></dd>
		          <dd><a href="">消息管理</a></dd>
		          <dd><a href="">授权管理</a></dd>
		        </dl>
		      </li> -->
		    </ul>
		    <ul class="layui-nav layui-layout-right">
		    	
		      <li class="layui-nav-item">
		        <a href="javascript:;">
		          <img src="${staff.staImg }" class="layui-nav-img">
		          ${staff.staName }
		        </a>
		        <dl class="layui-nav-child">
		          <dd><a href="page/set.jsp">基本资料</a></dd>
		          <dd><a href="">安全设置</a></dd>
		        </dl>
		      </li>
		      <li class="layui-nav-item" id="theme">
                    <a href="javascript:;">
                        <i class="layui-icon">&#xe61b;</i> 主题<span class="layui-nav-more"></span></a>
                    
                    <dl class="layui-nav-child skin layui-anim layui-anim-upbit">
                        <dd class="layui-this"><a href="javascript:;" data-skin="default" style="color:#23262E;"><i class="layui-icon"></i> 默认</a></dd>
                        <dd class=""><a href="javascript:;" data-skin="orange" style="color:#393D49;"><i class="layui-icon"></i> 雅黑</a></dd>
                        <dd class=""><a href="javascript:;" data-skin="orange" style="color:#2F4056;"><i class="layui-icon"></i> 藏青</a></dd>
                        <dd class=""><a href="javascript:;" data-skin="blue.1" style="color:#696969;"><i class="layui-icon"></i>深灰色 </a></dd>
                        <dd class=""><a href="javascript:;" data-skin="green" style="color:#009688;"><i class="layui-icon"></i> 墨绿</a></dd>
                        <dd class=""><a href="javascript:;" data-skin="pink" style="color:#4682B4;"><i class="layui-icon"></i>钢蓝  </a></dd>
                        <dd class=""><a href="javascript:;" data-skin="red" style="color:#dd4b39;"><i class="layui-icon"></i> 枫叶红</a></dd>
                    </dl>
                </li>
		      <li class="layui-nav-item"><a href="javascript:logout();">注销</a></li>
		    </ul>
		  </div>
		  
		  <div class="layui-side layui-bg-black x-side">
		    <div class="layui-side-scroll">
		      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
		      <ul class="layui-nav layui-nav-tree">
		      	<c:forEach items="${model }" var="model">
		        <li class="layui-nav-item">
		          <a class="" href="javascript:;">${model.modelName }</a>
		          <dl class="layui-nav-child">
		          	<c:forEach items="${modelSub }" var="modelSub">
		          		<c:if test="${model.modelId==modelSub.erpModelId }">
		            		<dd><a id="${modelSub.modelId }" class="tab" href="javascript:;" title="${modelSub.modelCode }">${modelSub.modelName }</a></dd>
		       			</c:if>
		       		</c:forEach>
		          </dl>
		        </li>
		        </c:forEach>
		      
		      </ul>
		    </div>
		  </div>
		  
		  <div class="layui-body x-main">
		    <!-- 内容主体区域 -->
		    <div id="top-tab" class="layui-tab layui-tab-brief" lay-filter="demo" lay-allowClose="true" style="margin: 0px;height:100%;">
			  <ul class="layui-tab-title">
			    <li class="layui-this" id="close"  style="-moz-user-select:none;">首页</li>
			  </ul>
			  <div class="layui-tab-content" style="height:85%;">
			  	<div class="x-slide_left"  style="background-position: 0px 0px;"></div>
			    <div class="layui-tab-item layui-show">
			    	<!-- 首页显示的内容 -->
			    	<iframe name="iframe" width="100%" height="100%" scrolling="yes" frameborder="0" noresize="noresize" src="index.jsp"></iframe>
			    </div>
			  </div>
			</div>
		  </div>
		</div>
		
		<script>
		layui.use('element', function(){
		  var element = layui.element;
		  	//新增或切换选项卡
			$(".tab").click(function(){
				var tabId =$(this).attr('id');
				var falg = true;
				var li = $("#top-tab li");
				$(li).each(function(i,element){
					if($(this).attr("lay-id")==tabId){
						falg = false;
					}
				});
				if(falg==false){
					element.tabChange('demo',tabId);//切换到指定的Tab项
				}else{
					element.tabAdd('demo', {
					  title: $(this).text()
					  ,content: '<iframe name="iframe" width="100%" height="100%" scrolling="yes" frameborder="0" noresize="noresize" src="'+$(this).attr("title")+'"></iframe>' //支持传入html
					  ,id:$(this).attr('id')
					});
					element.tabChange('demo',tabId);//切换到指定的Tab项
				}
				
				//关闭全部选项
			  	$("#close").dblclick(function(){
			  		var li = $("#top-tab li");
					$(li).each(function(i,ele){
						var layId = $(this).attr("lay-id");
						element.tabDelete('demo',layId);
					});
			  	});
			});
		});
		
		layui.use('layer', function(){
			  var layer = layui.layer;
			  //鼠标放到首页上显示提示信息
			  $('#close').mouseover(function(){
			  	  var that = this;
			  	  layer.tips('双击关闭',"#close",{
			  		tips:2,
			  		time :700
			  	  }); //在元素的事件回调体中，follow直接赋予this即可
			  	});
			  
			});
		if($(window).width()<750){
			trun = 0;
			$('.x-slide_left').css('background-position','0px -61px');
		}else{
			trun = 1;
		}
		$('.x-slide_left').click(function(event) {
			if(trun){
				$('.x-side').animate({left: '-200px'},200).siblings('.x-main').animate({left: '0px'},200);
				$(this).css('background-position','0px -61px');
				trun=0;
			}else{
				$('.x-side').animate({left: '0px'},200).siblings('.x-main').animate({left: '200px'},200);
				$(this).css('background-position','0px 0px');
				trun=1;
			}
			
		});
		//注销
		function logout(){
			layer.confirm('是否立即注销?', {icon: 3, title:'注销'}, function(index){
				layer.close(index);
				url="staff/deleteSession.action";
				$.post(url,null,function(m){
					location.href="page/login.jsp";
				});
			});
		}
		//更换主题
		$("#theme dl dd a").click(function(){
			$(".layui-layout-admin .layui-header").css("background-color",$(this).css("color"));
		});
		</script>
	</body>
</html>