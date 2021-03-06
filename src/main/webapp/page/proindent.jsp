<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理</title>
	<link rel="stylesheet" href="<%=basePath%>res/layui/css/layui.css" media="all">
	<script src="<%=basePath%>res/js/jquery-2.1.3.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>res/layui/layui.js" charset="utf-8"></script>

  <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
  <style type="text/css">
  	.layui-table-view {
	    margin: 10px 18px;
	    overflow: hidden;
	}
	body{
		padding: 1px;
	}

	#sousuo td{
		padding-right: 5px;
		padding-top: 5px;
	}
	#sousuo .layui-input {
 		height: 40px;
	}
  </style>
</head>
<body> 

<div class="demoTable">
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="layui-inline">
		  	<form class="layui-form" id="sousuo" style="float: left;">
		  		<table>
		  			<tr>
		  				<td>
		  				    <input class="layui-input" name="key" id="key" maxlength="50" placeholder="关键字" autocomplete="off">
		  				</td>
		  				<td>
			  				<select id="indentUrgency" name="indentUrgency" lay-verify="" width="50px">
							  <option value="">是否紧急</option>
							   <option value="1">是</option>
							    <option value="0">否</option>
							</select>
		  				</td>
		  				</tr>
		  				<tr>
		  				<td>
			  				<select id="state" name="state" lay-verify="" width="50px">
							  <option value="">审核状态</option>
							   <option value="2">已审核</option>
							    <option value="1">未审核</option>
							</select>
		  			                                            	</td>
		  				<td>
			  				<select id="indentState" name="indentState" lay-verify="" width="50px">
							  <option value="">订单生产状态</option>
							   <option value="1">订单开始</option>
							    <option value="2">订单生产中</option>
							      <option value="3">订单已完成</option>
							      <option value="4">申请配料</option>
							</select>
		  				</td>
		  			</tr>
		  		</table>
			</form>
			<button class="layui-btn" style="margin-top: 5px;" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
		 	<button class="layui-btn layui-btn-warm" onclick="add()"><i class="layui-icon">&#xe608;</i>增加订单日志</button>
		  </div>
		</div>



<table class="layui-table" lay-data="{width: 968, height:495, url:'dent/showList.action', page:true,id:'testReload',method:'post'}" lay-filter="demo">
  <thead>
    <tr>
      <th lay-data="{field:'indentId', width:140, sort: true, fixed: true},hidden:'true'">ID</th>
      <th lay-data="{field:'indentNumber', width:160}">生产订单编号</th>
   	  <th lay-data="{field:'indentMoney', width:114}">生产订单金额</th>
      <th lay-data="{field:'indentCount', width:76}">数量</th>
   	  <th lay-data="{field:'indentUrgency', width:100,templet:'#urg', align:'center'}">是否紧急</th>
   	  <th lay-data="{field:'state', width:100,templet:'#state1'}">审核状态</th>
   	  <th lay-data="{field:'indentState', width:140, align:'center',templet:'#zt'}">订单生产状态</th>
   	  <th lay-data="{field:'remark', width:140, align:'center'}">备注</th>
   	  <th lay-data="{field:'indentEmetime', width:150, sort: true}">生产订单生成时间</th>
   	  <th lay-data="{field:'indentWorktime', width:100, sort: true}">本次订单需要花费的时间</th>
   	  <th lay-data="{field:'indentEndtime', width:120, sort: true}">预计完成时间</th>
      <th lay-data="{fixed: 'right', width:280, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>

<!-- 判断是否审核 -->
<script type="text/html" id="state1">
	  {{#  if(d.state==1){ }}
    		  <span class="layui-btn layui-btn-danger layui-btn-small">未审核</span>
  	{{# }else if(d.state==2) { }}
			 <span class="layui-btn layui-btn-warm layui-btn-small">以审核</span>
	{{#  } }}
</script>

<!-- 判断是否紧急 -->
<script type="text/html" id="urg">
	  {{#  if(d.indentUrgency==1){ }}
    		<span class="layui-btn layui-btn-warm layui-btn-small">紧急</span>
  	{{# }else if(d.indentUrgency==0) { }}
    	   <span class="layui-btn layui-btn-normal layui-btn-small">不紧急</span>
	{{#  } }}
</script>

<!-- 判断订单生产状态 -->
<script type="text/html" id="zt">
	  {{#  if(d.indentState==1){ }}
    		<span class="layui-btn layui-btn-primary layui-btn-small">订单开始</span>
  	{{# }else if(d.indentState==2) { }}
    	   <span class="layui-btn layui-btn-warm layui-btn-small">订单生产中</span>
	{{# }else if(d.indentState==3) { }}
    	   <span class="layui-btn layui-btn-normal layui-btn-small">订单已完成</span>
	{{# }else if(d.indentState==4) { }}
			<span class="layui-btn layui-btn-danger layui-btn-small">申请配料中</span>
	{{#  } }}
</script>

<script type="text/html" id="barDemo">
{{#  if(d.indentState==4 && d.state==2){ }}
  <a class="layui-btn layui-btn-normal layui-btn-mini" lay-event="pf">配料</a>
{{# }else { }}
	<a class="layui-btn layui-btn-disabled layui-btn-mini">配料</a>
{{#  } }}
  <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
  <a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="show">查看</a>
{{#  if(d.indentState==3){ }}
  <a class="layui-btn layui-btn-normal layui-btn-mini" lay-event="zj">质检</a>
{{# }else { }}
	<a class="layui-btn layui-btn-disabled layui-btn-mini ">质检</a>
{{#  } }}
</script>
          
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
$('.x-slide_left',window.parent.document).click();//关闭左边菜单栏
var table;
layui.use('table', function(){
  table = layui.table;
  //监听表格复选框选择
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(demo)', function(obj){
    var data = obj.data;
    if(obj.event === 'detail'){
      layer.msg('ID：'+ data.id + ' 的查看操作');
    } else if(obj.event === 'del'){
    	if(data.indentState==4){
    	layer.confirm('真的删除行么', function(index){
    	 obj.del();
        layer.close(index);
        url = "dent/delete.action?indentId="+data.indentId;
        $.post(url,null,function(mes){
        	table.reload('testReload');
        	
        	if(mes.state==1){
				layer.msg(mes.mes);
				tableReload();//重载表格的方法
			}else{
				layer.msg(mes.mes);
			}
        	
            
        },"json")
      
      });
    	}else{
			layer.msg("订单生产中,不能删除！！！");
		} 
     
	} else if(obj.event === 'edit'){
		if(data.indentState==4){
			layer.open({
				type:2,
				skin: 'layui-layer-molv',//样式
				content:'page/proindentupdate.jsp?indentId='+data.indentId,
				area: ['80%', '50%'],
				title: '编辑订单',
			});
		}else{
			layer.msg("订单生产中,不能修改！！！");
		} 
    }else  if(obj.event==='show'){
    	layer.open({
			type:2,
			skin: 'layui-layer-molv',//样式
			content:'page/proindentupdateshow.jsp?indentId='+data.indentId,
			area: ['80%', '80%'],
			title: '查看订单',
		});	
    }else if(obj.event==='pf'){
    	layer.open({
			type:2,
			skin: 'layui-layer-molv',//样式
			content:'page/proindentpf.jsp?indentId='+data.indentId+'&indentCount='+data.indentCount,
			area: ['80%', '80%'],
			title: '配置配方',
		});
    	
    }else if(obj.event==='zj'){
    	var da = {"indentId":data.indentId};
    	$.post("ErpQualityAction/selectShowNew.action",da,function(mes){
    		if(mes.state==1){//真确的样式
    	 		layer.msg('<i class="layui-icon" style="font-size: 40px; color: #5FB878;">&#xe618;</i>'+mes.mes);
    	 		ajxaTable();
    	 	}else{
    	 		layer.msg('<i class="layui-icon" style="font-size: 40px; color: #FF5722;">&#x1006;</i>'+mes.mes);
    	 	}
    	});
    }
  });
  
 
  var $ = layui.$, active = {
		    reload: function(){
		      var demoReload = $('#key');
			  var demoReload1 = $('#indentUrgency');
		      var demoReload2 = $('#state');
		      var demoReload3 = $('#indentState');
		      table.reload('testReload', {
		        where: {
		         
		        	key: demoReload.val(),
		        	indentUrgency:demoReload1.val(),
		        	state:demoReload2.val(),
		        	indentState :demoReload3.val()
		        }
		      });
		    }
		  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});

function add(){
	
	layer.open({
		type:2,
		skin: 'layui-layer-molv',//样式
		content:'page/Logadd.jsp',
		area: ['98%', '80%'],
		title: '增加订单日志',
	});

}


</script>

</body>
</html>