<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>联系我们</title>
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="个人博客">
  <meta name="description" content="个人博客">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
</head>
<body>

 <%@ include file="/pages/common/header.jsp"%>


<div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li class="layui-this">联系我们</li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form">
            <form method="post" action="${PATH}/admin/loginInto">
              <div class="layui-form-item">
                <label for="L_contactName" class="layui-form-label">称呼</label>
                <div class="layui-input-block">
                  <input type="text" id="L_contactName" name="contactName" lay-verify="required"   autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_contactEmail" class="layui-form-label">email</label>
                <div class="layui-input-block">
                  <input type="email" id="L_contactEmail" lay-verify="email" name="contactEmail" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_contactPhone" class="layui-form-label">电话</label>
                <div class="layui-input-block">
                  <input type="text" id="L_contactPhone" lay-verify="phone" name="contactPhone" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_contactSort" class="layui-form-label">类型</label>
                <div class="layui-input-block">
                  <input type="password" id="L_contactSort" lay-verify="required"  name="contactSort" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_contactMessage" class="layui-form-label">备注</label>
                <div class="layui-input-block">
                <textarea id="L_contactMessage" name="contactMessage" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
                </div>
              </div>
              <div class="layui-form-item">
	             <div class="layui-input-block">
	               <button class="layui-btn"  lay-submit lay-filter="*" >立即留言</button>
	               <button class="layui-btn layui-btn-primary" type="reset" id="resetBtn" >重置</button>
	             </div>
			  </div>             
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="/pages/common/footer.jsp"%>

<script src="${PATH}/static/layui/layui.all.js"></script>
<script>
layui.use(['form','layer'], function(){
	  var form = layui.form,layer=layui.layer;
	  form.on('submit(*)', function(data){
		  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		  var datas = data.field;
		  $.ajax({
				url:"${PATH}/contact/addContact",
				method:"post",
				data:datas,
				success:function(res){
					if(res.code==100){
						layui.layer.msg(res.extend.msg,{icon:6},function(){
							$("#resetBtn").click();
						})
					}else{
						layui.layer.msg(res.extend.msg,{icon:5},function(){
							$("#resetBtn").click();
						})	
					}
				},error:function(){
					layui.layer.msg("系统错误")
				}
			})
		  
		  
		  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
	});

</script>
</body>
</html>