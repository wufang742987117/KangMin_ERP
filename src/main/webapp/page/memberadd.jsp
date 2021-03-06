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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员增加</title>
		<link rel="stylesheet" href="<%=basePath%>res/layui/css/layui.css" media="all">
	<script src="<%=basePath%>res/js/jquery-2.1.3.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>res/layui/layui.js" charset="utf-8"></script>
		
	<style type="text/css">
		.layui-input, .layui-textarea {
		    display: block;
		    width: 85%;
		    padding-left: 10px;
		}
	</style>
	
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>增加会员</legend>
</fieldset>
 
 
 <form class="layui-form" id="express" method="post">
	<input type="hidden" id="memberId" name="memberId">
   <div class="layui-form-item">
    <label class="layui-form-label">会员姓名</label>
    <div class="layui-input-block">
      <input name="memberName" id="memberName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" type="text">
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">单选框</label>
    <div class="layui-input-block">
      <input name="memberSex" id="memberSex"  value="男" title="男" checked="" type="radio">
      <input name="memberSex" id="memberSex" value="女" title="女" type="radio">
    </div>
  </div>
  
   <div class="layui-form-item">
      <label class="layui-form-label">验证手机</label>
       <div class="layui-input-block">
        <input name="memberPhone" id="memberPhone" lay-verify="phone" autocomplete="off" placeholder="请输入正确的手机号码" class="layui-input" type="tel">
      </div>
    </div>

 <div class="layui-form-item">
      <label class="layui-form-label">验证邮箱</label>
       <div class="layui-input-block">
        <input name="memberEmail" id="memberEmail" lay-verify="email" autocomplete="off" placeholder="请输入正确的邮箱" class="layui-input" type="text">
      </div>
    </div>
  
   <div class="layui-form-item">
    <div class="layui-input-block">
      <input type="button" class="layui-btn" lay-submit="" lay-filter="demo1" value="立即提交">
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>

<!-- 表单验证 -->
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
//监听提交
	form.on('submit(demo1)', function(data){
		  //注意：parent 是 JS 自带的全局对象，可用于操作父页面
		  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		  
		  var url="member/addOrUpdate.action";
		  var date =$("#express").serialize();
		  $.post(url,date,function(mes){
			  if(mes.state==1){
				  parent.layer.close(index);
				  parent.layer.msg(mes.mes);
				  parent.table.reload('testReload');
				}else{
					 parent.layer.close(index);
					 parent.layer.msg(mes.mes);
					parent.table.reload('testReload');
				}
		  },"json");
	});
});

//取网址上的ID
function GetQueryString(id){
    var reg = new RegExp("(^|&)"+ id +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return  unescape(r[2]); return null;
}

	//当页面加载时运行，给文本复职
	$(function(){
			var id = GetQueryString("memberId");
			var data = {"memberId":id};
			var url = "member/findById.action";
			if(id!=null & id!=""){
				$.post(url, data, function(mes){
					$("#memberId").val(mes.memberId);
					$("#memberName").val(mes.memberName);
					$("#memberPhone").val(mes.memberPhone);
					$("#memberEmail").val(mes.memberEmail);
					$("#express").find("input[type='radio'][name='memberSex'][value="+mes.memberSex+"]").prop("checked","checked");//单选框赋值
					form.render("radio");
				});
			}
			
			
		});
</script>
</body>
</html>