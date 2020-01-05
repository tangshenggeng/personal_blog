<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>积分</title>
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="个人博客">
  <meta name="description" content="个人博客">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
</head>
<style>

		input[type=number] {  
    -moz-appearance:textfield;  
}  
input[type=number]::-webkit-inner-spin-button,  
input[type=number]::-webkit-outer-spin-button {  
    -webkit-appearance: none;  
    margin: 0;  
}  
	
	
</style>
<body>

<%@ include file="/pages/common/header.jsp"%>

<div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
    <li class="layui-nav-item  layui-this">
      <a href="${PATH}/member/toMyIntegralPage/${sessionScope.ident}">
        <i class="iconfont icon-kiss"></i>
        	积分充值
      </a>
    </li>
    <!-- <li class="layui-nav-item">
      <a href="index.html">
        <i class="layui-icon">&#xe612;</i>
        用户中心
      </a>
    </li> -->
    <li class="layui-nav-item">
      <a href="${PATH}/member/toSetMyInfoPage/${sessionScope.ident}">
        <i class="layui-icon">&#xe620;</i>
        基本设置
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="message.html">
        <i class="iconfont icon-renzheng layui-hide-xs" title="加入会员"></i>
        加入会员
      </a>
    </li>
  </ul>

  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li class="layui-this" lay-id="info">我的积分</li>
        <!-- <li lay-id="avatar">头像</li>
        <li lay-id="pass">密码</li>
        <li lay-id="bind">帐号绑定</li> -->
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
          <form method="post">
          	<input type="hidden" name="memIdent" value="${sessionScope.ident}" />
            <div class="layui-form-item">
              <label for="L_email" class="layui-form-label">当前积分</label>
              <div class="layui-input-inline">
                <input type="text" id="L_email" name="beforeIntegral" value="${integral}" readonly="readonly" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <label for="L_integralAmount" class="layui-form-label">积分量</label>
              <div class="layui-input-inline">
                <input type="text" id="L_integralAmount" readonly="readonly" required lay-verify="required"class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <label for="L_payMoney" class="layui-form-label">充值金额</label>
              <div class="layui-input-inline">
                <input type="number" id="L_payMoney" name="payMoney" required lay-verify="number" autocomplete="off" value="" class="layui-input">
              </div>
              <div class="layui-form-mid layui-word-aux">1元=100积分</div>
            </div>
            <div class="layui-form-item">
              <button class="layui-btn" key="set-mine" lay-filter="recharge" lay-submit>确认充值</button>
            </div>
            </form>
          </div>
          
        </div>

      </div>
    </div>
  </div>
<%@ include file="/pages/common/footer.jsp"%>

<script src="${PATH}/static/layui/layui.all.js"></script>
<script type="text/javascript">
var error = "${msg}"
if(error!=""){
	layui.layer.msg(error,{icon:5},function(){
		window.location.href="${PATH}/pages/index.jsp";
	});
}	
layui.use(['layer', 'form'], function(){
	var layer = layui.layer,form = layui.form;
	form.on('submit(recharge)', function(data){
		  var datas = data.field
		  if(datas.payMoney<=0){
			  layer.msg("请输入不小于0的数字")
			  return false;
		  }
		  console.log(datas)
		  $.ajax({
			url:"${PATH}/integralRecharge/rechargeByMen",
			method:"post",
			data:datas,
			success:function(res){
				if(res.code==100){
					layer.msg(res.extend.msg,{icon:6},function(){
						location.reload() 
					})
				}else{
					layer.msg(res.extend.msg,{icon:5})	
				}
			},error:function(){
				layer.msg("系统错误")
			}
		  })
		  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
})
//联动
$("#L_payMoney").bind('input propertychange', function() {
	var num1 = $(this).val();
	if (isNaN(num1)) { //如果为非数字，结果为空
		$("#L_integralAmount").val() = "";
	} else { 
		$("#L_integralAmount").val(num1 * 100)
	}
});

</script>
</body>
</html>