<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>找回密码/重置密码</title>
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
        <li><a href="${PATH }/pages/login.jsp">登入</a></li>
        <li class="layui-this">找回密码<!--重置密码--></li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form layui-form-pane">
            <form method="post">
              <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                  <input type="email" id="email" name="mEmail" required lay-verify="email" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="formPwd1" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">确认新密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="formPwd2" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">验证码</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="formCode" required lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                </div>
                 <div class="layui-form-mid" style="padding: 0 !important;">
                  <span style="color: #c00;"><input type="button" onclick="sendemail()" id="codeBtn" value="点击获取验证码"  name="vercode" class="layui-input" style="padding-right: 10px;"></span>
                </div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" alert="1" lay-filter="*" lay-submit>修改</button>
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
layui.use(['layer','form'], function(){
	var layer = layui.layer,form=layui.form;
	form.on('submit(*)', function(data){
	  var datas= data.field;
	  $.ajax({
		url:"${PATH}/member/forgetPwd",
		method:"post",
		data:datas,
		success:function(res){
			if(res.code==100){
				layer.msg(res.extend.msg,{icon:6},function(){
					window.location.href="${PATH}/pages/login.jsp";
				})
			}else{
				layer.msg(res.extend.msg,{icon:5})	
			}
		},error:function(){
			layer.msg("系统出错！")
		}
	  });
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
})
</script>
<script>
//验证码
var countdown=60; 
function sendemail(){
	layui.use('layer', function(){
	  	var layer = layui.layer;
	  	var obj = $("#codeBtn");
	    var email = $("#email").val();
	    var reg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	    if(!reg.test(email)){
	    	layer.msg("请输入正确的邮箱！",{icon:5});
	    	return;
	    }
	    $.ajax({
	    	url:"${PATH}/regiterCode/createEmailCode?regEmail="+email,
	    	method:"get",
	    	success:function(res){
	    		if(res.code==100){
	    			layer.msg(res.extend.msg,{icon:6});
	    		}else{
	    			layer.msg(res.extend.msg,{icon:5});
	    		}
	    	},error:function(){
	    		layer.msg("系统错误！",{icon:5});
	    		return;
	    	}
	    });
	    settime(obj);
	});
    }
function settime(obj) { //发送验证码倒计时
    if (countdown == 0) { 
        obj.attr('disabled',false); 
        //obj.removeattr("disabled"); 
        obj.val("点击获取验证码");
        countdown = 60; 
        return;
    } else { 
        obj.attr('disabled',true);
        obj.val("重新发送(" + countdown + ")");
        countdown--; 
    } 
setTimeout(function() { 
    settime(obj) }
    ,1000) 
}
</script>

</body>
</html>