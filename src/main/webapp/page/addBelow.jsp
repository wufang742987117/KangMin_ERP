<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <html>
    
    <head>
      <base href="${pageContext.request.contextPath }/">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Insert title here</title>
 		<link rel="stylesheet" href="res/layui/css/layui.css">
 		<link rel="stylesheet" href="res/zTree_v3/css/demo.css">
		<script src="res/js/jquery-2.1.3.min.js" type="text/javascript" ></script>
		<script src="res/layui/layui.js"></script>
    <body>
      <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
          <li class="layui-this">编辑/查看下级模块</li>
          <li>添加下级模块</li></ul>
        <div class="layui-tab-content">
          <div class="layui-tab-item layui-show" class="superior-forms">
          <form action="" id="twoFrom" class="layui-form">
          <div style="text-align:center;">
          	<c:forEach items="${model }" var="model">
          	<div id="${model.modelId }">
          	<input type="hidden" value="${model.modelId }" name="modelId">
            <div class="layui-inline" style="margin-top: 15px;">
		      <label class="layui-form-label" style="width:105px;">下级模块名称：</label>
		      <div class="layui-input-inline">
		        <input name="modelName" id="modelName" autocomplete="off" lay-verify="required" class="layui-input" type="tel" value="${model.modelName }">
		      </div>
		    </div>
		    <div class="layui-inline" style="margin-top: 15px;">
		    <label class="layui-form-label" style="width:110px;">下级模块URL：</label>
		      <div class="layui-input-inline">
		        <input name="modelCode" id="modelCode" autocomplete="off" lay-verify="required" class="layui-input" type="tel" value="${model.modelCode }">
		      </div>
		    </div>
		    <div class="layui-inline" style="margin-top: 15px;">
		    <a  class="layui-btn layui-btn-danger" href="javascript:deleteModel('${model.modelId }')">删除</a>
		    </div>
		    </div>
		    </c:forEach>
		    </div>
		    <div style="height:30px;"></div>
                <div style="text-align:center;">
                  <button type="button" class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
              </div>
              </form>
          </div>
          
          
          
          
          <div class="layui-tab-item">
          <form action="" id="oneFrom" class="layui-form">
          	<input type="hidden" value="${modelId }" id="modelId">
          	<div id="div" style="text-align:center;">
          	<div class="div">
            <div class="layui-inline" style="margin-top: 15px;" >
		      <label class="layui-form-label" style="width:105px;">下级模块名称：</label>
		      <div class="layui-input-inline">
		        <input name="modelName" id="modelName" autocomplete="off" lay-verify="required" class="layui-input" type="text" >
		      </div>
		      </div>
		     <div class="layui-inline" style="margin-top: 15px;">
		      <label class="layui-form-label" style="width:110px;">下级模块URL：</label>
		      <div class="layui-input-inline">
		        <input name="modelCode" id="modelCode" autocomplete="off" lay-verify="required" class="layui-input" type="text" >
		      </div>
		    </div>
		    <div class="layui-inline" style="margin-top: 15px;">
		    <button class='layui-btn layui-btn-danger' onclick='deleteThis(this)'>删除</button>
		    </div>
		    </div>
		    </div>
			<div style="height:30px;"></div>
                <div style="text-align:center;">
                  <button type="button" class="layui-btn" lay-submit lay-filter="formDemo2">立即提交</button>
                  <button type="button" class="layui-btn layui-btn-normal" id="onAdd">继续添加</button>
                  <button type="reset" class="layui-btn layui-btn-primary">重置</button>
              </div>
           
           </form>
          </div>
          
        </div>
      </div>
      <script>//Demo
      var layer;
      var form;
      var element;
      layui.use(['form','element','layer'], function(){
      form = layui.form;
      element = layui.element;
      layer = layui.layer;
      
      
      
      form.on('submit(formDemo2)', function(data){
    	  console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
    	  console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
    	  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
      	  	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
      	  	var modelId = $("#modelId").val();
  			var modelName = document.getElementsByClassName("modelName");
  		    	  layer.confirm('确定提交吗！', function(){
  					url="model/addBelowModel.action?modelId="+modelId;
  					data=$('#oneFrom').serialize();
  					$.post(url,data,function(m){
  						if(m.mes=="ok"){
  		       				  parent.layer.close(index);
  		       				  parent.table.reload('testReload');
  		       				  parent.layer.msg("增加下级模块成功");
  		       		    }
  					},"json")
  		    	  });
    	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    	  

	})
	
	
	form.on('submit(formDemo)', function(data){
    	  console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
    	  console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
    	  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
    	  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    	  layer.confirm('确定提交吗！', function(){
			url="model/updateBelowModel.action";
			data=$('#twoFrom').serialize();
			$.post(url,data,function(m){
				if(m.mes=="ok"){
       				  parent.layer.close(index);
       				  parent.table.reload('testReload');
       				  parent.layer.msg("修改下级模块成功");
       		    }
			},"json")
    	  });
    	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    	  

	})
	
	
  })
      
      
      
      function deleteModel(modelId){
	    	  layer.confirm('确定删除该模块吗', function(index){
	        	  url="model/deleteModel.action";
	        	  data={modelId:modelId}
	        	  $.post(url,data,function(m){
	        		  if(m.mes=="ok"){
	        			  $("#"+modelId+"").remove();
		        		  layer.msg("删除成功");
	        		  }
	        	  },"json")
	          }); 
      }
      
      
      
      
      
      
      	$(function(){
      		$("#onAdd").click(function(){
      			$("#div").append("<div class='div'><div class='layui-inline' style='margin-top: 15px;'><label class='layui-form-label' style='width:105px;'>下级模块名称：</label><div class='layui-input-inline'><input name='modelName' id='modelName' autocomplete='off' class='layui-input' type='tel'></div></div><div class='layui-inline' style='margin-top: 15px;'><label class='layui-form-label' style='width:110px;'>下级模块URL：</label> <div class='layui-input-inline'><input name='modelCode' id='modelCode' autocomplete='off' class='layui-input' type='tel'></div> <button class='layui-btn layui-btn-danger' onclick='deleteThis(this)'>删除</button></div><div>");
      			
      		})
      	})
      	
        
      	
      	function deleteThis(obj){
      		var tr = $(obj).parent().parent().remove();
      	}
      	
        </script>
        
    
        
    </body>
  
  </html>