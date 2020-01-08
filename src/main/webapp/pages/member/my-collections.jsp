<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>我的收藏</title>
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="个人博客">
  <meta name="description" content="个人博客">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
</head>
<body>

<%@ include file="/pages/common/header.jsp"%>

<div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
    <li class="layui-nav-item layui-this">
      <a href="${PATH}/member/toMyCollectBlogPage/${sessionScope.ident}">
        <i class="layui-icon layui-icon-star" style="top: 4px;"></i>
        	我的收藏
      </a>
    </li>
    <!-- <li class="layui-nav-item">
      <a href="index.html">
        <i class="layui-icon">&#xe612;</i>
        用户中心
      </a>
    </li> -->
    <li class="layui-nav-item">
      <a href="${PATH}/member/toMyBuyBlogPage/${sessionScope.ident}">
        <i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe657;</i>
       我的购买
      </a>
    </li>
    <!-- <li class="layui-nav-item">
      <a href="message.html">
        <i class="iconfont icon-renzheng layui-hide-xs" title="加入会员"></i>
        加入会员
      </a>
    </li> -->
  </ul>

  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  
  <div class="fly-panel fly-panel-user">
    <div class="layui-tab layui-tab-brief">
      	<ul class="fly-list" id="myCollectionBlogs">  
      		<h2 v-if="myBlogs==''" align="center">
          		暂无收藏
              <!-- <a class="layui-badge">分享</a> -->
            </h2>        
          <li style="padding-left: 15px" v-for="item in myBlogs">
            <h2>
              <!-- <a class="layui-badge">分享</a> -->
              <a :href="'${PATH}/blog/getBlogByIdent/'+item.blogIdent" >{{item.blogTitle}}</a>
            </h2>
            <div class="fly-list-info">
              <a href="#" link>
                <cite>KPP</cite>
                <!--
                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                <i class="layui-badge fly-badge-vip">VIP3</i>
                -->
              </a>
              <span> {{item.createTime | moment}}</span>
              
              <span class="fly-list-kiss layui-hide-xs" title="积分"><span v-if="item.needIntegral != 0"><i class="iconfont icon-kiss"></i> {{item.needIntegral}}</span> <span v-else>免费</span></span>
              <!--<span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>-->
              <span class="fly-list-nums"> 
                <i class="iconfont icon-pinglun1" title="评论"></i> {{item.commetNum}}
              </span>
            </div>
            <div class="fly-list-badge">
              <span class="layui-badge layui-bg-black" v-if="item.commetNum > 1">置顶</span>
              <span class="layui-badge layui-bg-red" v-if="item.needIntegral > 1">精帖</span>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
<%@ include file="/pages/common/footer.jsp"%>

<script src="${PATH}/static/layui/layui.all.js"></script>
<script src="${PATH}/static/vue/vue.min.js"></script>
<script src="${PATH}/static/vue/vue-resource.min.js"></script>
<script src="${PATH}/static/js/comment.js"></script>
<script type="text/javascript">
var error = "${msg}"
if(error!=""){
	layui.layer.msg(error,{icon:5},function(){
		window.location.href="${PATH}/pages/index.jsp";
	});
}
var name = "${sessionScope.name}"
if(name==""){
	layui.layer.msg("登录超时！请重新登录！",{icon:5},function(){
		window.location.href="${PATH}/pages/login.jsp";
	});
}
var myCollectionBlogs = new Vue({
	el:"#myCollectionBlogs",
	data:{
		myBlogs:[],
		ident:"${ident}"
	},created: function () {
		this.$http.get("${PATH}/blogCollection/getBlogListByMem/"+this.ident).then(function(response){
			console.log(response.body)
			//成功
			this.myBlogs=response.body;
		},function(response) {
			//错误
			console.log("系统错误！")
		});
	}
})
Vue.filter('moment', function (value, formatString) {
    formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
    return moment(value).format(formatString);
});
</script>
</body>
</html>