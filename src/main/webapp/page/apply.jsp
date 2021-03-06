<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=basePath%>res/layui/css/layui.css"
	media="all">
<script src="<%=basePath%>res/js/jquery-2.1.3.min.js"
	type="text/javascript"></script>
<script src="<%=basePath%>res/layui/layui.js" charset="utf-8"></script>

<title>供货商表</title>

</head>
<body>

	<div class="demoTable">
		字段搜索
		<div class="layui-inline">
			<input class="layui-input" name="id" id="demoReload"
				autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload" onclick="sousuo">搜索</button>
		<button data-type="auto" class="layui-btn layui-btn-normal"
			onclick="add('')">新增</button>
	</div>

	<table class="layui-hide" id="LAY_table_user" lay-filter="user">


	</table>
	<script>
	var table;
		
		layui.use('table', function() {
			table = layui.table;

			//方法级渲染
			table.render({
				elem : '#LAY_table_user',
				url : 'EepApplyAction/showList.action',
				method : 'POST',
				cols : [ [ {
					checkbox : true,
					fixed : true
				}, {
					field : 'applyNumber',
					title : '供货商编号',
					width : 180,
					align : 'center'
				}, {
					field : 'applyName',
					title : '供货商名称',
					width : 180,
					sort : true,
					align : 'center'
				}, {
					field : 'applyBoss',
					title : '供货商法人代表名称',
					width : 180,
					align : 'center'
				}, {
					field : 'applyAdr',
					title : '供货商地址',
					width : 180,
					align : 'center'
				}, {
					field : 'applyPhone',
					title : '供货商电话',
					width : 180,
					align : 'center'
				}, {
					field : 'applyEmail',
					title : '供货商邮编',
					width : 180,
					align : 'center'
				}, {
					fixed : 'right',
					title : '操作',
					width : 210,
					align : 'center',
					toolbar : '#barDemo'
				} ] ],
				id : 'testReload',
				page : true,
				height : 315
			});

			table.on('tool(user)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				var data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值
				var tr = obj.tr; //获得当前行 tr 的DOM对象

				if (layEvent === 'del') { //删除
					layer.confirm('真的删除行么', function(index) {
						obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
						layer.close(index);
						//向服务端发送删除指令.
						var url = "EepApplyAction/delete.action";
						var data2 = {
							'applyId' : data.applyId
						};
						$.post(url, data2, function() {

						})
					});
				} else if (layEvent === 'edit') {
					var title = '编辑供货商表';
					addOrUpdata(title, data.applyId);
				}
			});

			//This搜索
			var $ = layui.$, active = {
				reload : function() {
					var demoReload = $('#demoReload');
					table.reload('testReload', {
						where : {
							keywords : demoReload.val(),
						}
					});
				}
			};
			
			$('.demoTable .layui-btn').on('click', function() {
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});
		});
		
		
		function addOrUpdata(title, applyId) {
			layer.open({
				type : 2,
				content : 'page/applyForm.jsp?id=' + applyId,
				area : [ '800px', '400px' ],
				title : title,
				cancel : function(index, layero) {

					layer.confirm('是否关闭?', {
						icon : 3,
						title : '提示'
					}, function(index2) {
						//do something

						layer.close(index);
						layer.close(index2);
					});
					return false;
				}
			});
		}

		function add(obj) {
			var addCen = layer.open({
				id : "purcFrom",
				type : 2 //Page层类型
				,skin : 'layui-layer-molv'//样式
				,area : [ '55%', '65%' ]
				,title : '点击增加'
				,shade : [ 0.8, '#393D49' ] //显示遮罩
				,maxmin : true //允许全屏最小化
				,anim : 2 //0-6的动画形式，-1不开启
				,shadeClose : true//点击也能遮罩层关闭
				,content : "page/applyForm.jsp?applyId="+ obj.applyId
			});
		}
	</script>
	<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>
</body>
</html>