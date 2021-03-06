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
		<title>分站管理</title>
		<link rel="stylesheet" href="res/layui/css/layui.css">
		<script src="res/js/jquery-2.1.3.min.js" type="text/javascript" ></script>
		<script src="res/layui/layui.js"></script>
		<style type="text/css">
			body{
				padding: 10px;
			}
			#sousuo input{
				width:200px;
			}
		</style>
	</head>
	<body>
		<div class="layui-inline" id="demoTable">
			<form class="layui-form" id="sousuo" style="float: left;">
				<table style="width:420px;">
					<tr>
						<td>
							<input class="layui-input" name="annexData" maxlength="50" id="annexData" placeholder="编号/名称/地址/电话/负责人" autocomplete="off">
						</td>
						<td>
						    <div class="layui-input-inline" style="margin-left: 5px;">
						      <input type="text" id="annexTime" name="annexTime" placeholder="分店创建时间" class="layui-input" readonly="readonly">
						    </div>
						</td>
					</tr>
				</table>
			</form>
			<button style="margin-top: 5px;margin-left: 5px;" class="layui-btn layui-btn-small" data-type="reload"><i class="layui-icon">&#xe615;</i> 搜索</button>
		</div>
		<button id="addButton" style="float:right;margin-top: 3px;margin-left: 35px;" class="layui-btn layui-btn-normal layui-btn-small"><i class="layui-icon">&#xe654;</i>新增分店</button>
		<table class="layui-table" lay-data="{height:400,size:'sm',skin:'row ', url:'annex/findAll.action',method:'post',page:true,limit:10, id:'tb'}" lay-filter="tb">
		  <thead>
		    <tr>
		      <th lay-data="{field:'annexId',hidden}">分店ID</th>
		      <th lay-data="{field:'annexNumber', sort: true,width:250,align:'left',templet:'#annexNumberTpl'}">分店编号</th>
		      <th lay-data="{field:'annexName', sort: true, width:150}">分店名称</th>
		      <th lay-data="{field:'annexAdd', sort: true,width:170,templet:'#annexAddTpl'}">分店地址</th>
		      <th lay-data="{field:'annexPhone', sort: true,width:150,align:'center'}">分店电话</th>
		      <th lay-data="{field:'annexPrice', sort: true,width:150,align:'center'}">分店总资产</th>
		      <th lay-data="{field:'annexBoss', sort: true,width:150,align:'center'}">分店负责人姓名</th>
		      <th lay-data="{field:'annexTime', sort: true,width:160,align:'center'}">分店创建时间</th>
		      <th lay-data="{fixed: 'right', width:150, align:'center', toolbar: '#barDemo1'}">操作</th>
		    </tr>
		  </thead>
		</table>
		<div id="addAnnex" style="padding:10px;display: none;">
			<form class="layui-form layui-form-pane" action="">
				<input id="annexId" type="hidden" name="annexId">
			  <div class="layui-form-item">
			    <label class="layui-form-label">分店名称</label>
			    <div class="layui-input-block">
			      <input type="text" id="annexName" name="annexName" required  lay-verify="required" placeholder="请输入分店名称" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">分店地址</label>
			    <div class="layui-input-block">
			      <input type="text" id="annexAdd" name="annexAdd" required  lay-verify="required" placeholder="请输入分店地址" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">分店电话</label>
			    <div class="layui-input-block">
			      <input type="text" id="annexPhone" name="annexPhone" required  lay-verify="required|phone" placeholder="请输入分店电话" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">分店总资产</label>
			    <div class="layui-input-block">
			      <input type="text" id="annexPrice" name="annexPrice" required  lay-verify="required|number" placeholder="请输入分店总资产" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">分店负责人</label>
			    <div class="layui-input-block">
			      <input type="text" id="annexBoss" name="annexBoss" required  lay-verify="required" placeholder="请输入分店负责人" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
			    </div>
			  </div>
			</form>
		</div>
		
		<script type="text/html" id="barDemo1">
  			<a class="layui-btn layui-btn-mini" lay-event="update"><i class="layui-icon">&#xe642;</i>编辑</a>
			<a class="layui-btn layui-btn-mini layui-btn-warm" lay-event="drop"><i class="layui-icon">&#xe640;</i>删除</a>
		</script>
		
		<script type="text/javascript">
			var table;//数据表格
			var loadIndex;//加载层
			var ts;//弹出层
			//初始化数据表格
			layui.use('table', function(){
			  table = layui.table;
			  
				//监听工具条
				table.on('tool(tb)', function(obj){//tb是table原始容器的属性 lay-filter="对应的值"
				  var formdata = obj.data; //获得当前行数据
				  var layEvent = obj.event; //获得 lay-event 对应的值
				  if(layEvent === 'update'){ //修改
				  	$("#annexId").val(formdata.annexId);
				  	$("#annexName").val(formdata.annexName);
				  	$("#annexAdd").val(formdata.annexAdd);
				  	$("#annexPhone").val(formdata.annexPhone);
				  	$("#annexPrice").val(formdata.annexPrice);
				  	$("#annexBoss").val(formdata.annexBoss);
				  	ts =layer.open({
				        type: 1//样式
				        ,area: ['50%', '385px']
				        ,title:"修改分店信息"//标题
				        ,content: $("#addAnnex")
				        ,shade: [0.8, '#393D49'] //显示遮罩
				        ,shadeClose:true//点击也能遮罩层关闭
				        ,anim:2//弹出动画
				      });
				  }else if(layEvent === 'drop'){ //删除
					  layer.confirm('确认是否删除?', {icon: 3, title:'温馨提示'}, function(index){
						  loadIndex = layer.load();//出现加载层
						  var url = "annex/addOrUpdate.action";
						  var data = {"annexId":formdata.annexId,"isva":0}
							$.post(url,data, function(info){
								layer.close(loadIndex);//加载层关闭  
								if(info>0){
									layer.msg('操作成功！');
									tableReload();//重载表格的方法
									layer.close(ts);//关闭弹出层
									$("button[type='reset']").click();
								}else{
									layer.msg('操作失败！');
								}
							});
						});
				  }
				});
			  
				//搜索
			  var $ = layui.$, active = {
			    reload: function(){
			    	loadIndex = layer.load();//出现加载层
			    	tableReload();//重载表格的方法
			    	layer.close(loadIndex);//加载层关闭  
			    }
			  };
			  
			  $('#demoTable .layui-btn').on('click', function(){
			    var type = $(this).data('type');
			    active[type] ? active[type].call(this) : '';
			  });
			});
			
			//数据表格重载
			function tableReload(){
				table.reload('tb', {
			        where: {
			        	annexData: $('#annexData').val(),
			        	annexTime:$("#annexTime").val()
			        }
			      });
			}
			
			//日期框
			layui.use('laydate', function(){
			  var laydate = layui.laydate;
			  laydate.render({
			    elem: '#annexTime' //指定元素
			    ,theme: 'molv'//样式
			    ,max: 0//最大日期为今天
			    ,range: true//日期范围
			    ,calendar: true//显示节日
			  });
			});
			//点击增加分店
			$("#addButton").click(function(){
				$("#annexId").val("");
				$("button[type='reset']").click();
				ts =layer.open({
			        type: 1//样式
			        ,area: ['50%', '385px']
			        ,title:'增加分店'//标题
			        ,content: $("#addAnnex")
			        ,shade: [0.8, '#393D49'] //显示遮罩
			        ,shadeClose:true//点击也能遮罩层关闭
			        ,anim:2//弹出动画
			      });
			});
			
			layui.use('form', function(){
				var form = layui.form;
				//提交表单
				form.on('submit(formDemo)', function(data){
				  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
				  loadIndex = layer.load();//出现加载层
			  		var url = "annex/addOrUpdate.action";
					$.post(url, data.field, function(info){
						layer.close(loadIndex);//加载层关闭  
						if(info>0){
							layer.msg('操作成功！');
							tableReload();//重载表格的方法
							layer.close(ts);//关闭弹出层
							$("button[type='reset']").click();
						}else{
							layer.msg('操作失败！');
						}
					});
				  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
				});
			});
		</script>
	</body>
</html>