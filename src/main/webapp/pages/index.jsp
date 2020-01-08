<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>KPP个人博客</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="个人博客">
  <meta name="description" content="个人博客">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
  <script src="${PATH}/static/vue/vue.min.js"></script>
<script src="${PATH}/static/vue/vue-resource.min.js"></script>
<script src="${PATH}/static/js/comment.js"></script>
</head>
<body>
 <%@ include file="/pages/common/header.jsp"%>

<div class="layui-container">
  <div class="layui-row layui-col-space15" id="blogsListIndex">
    <div class="layui-col-md8">
      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <!-- <a href="" class="layui-this">综合</a>
          <span class="fly-mid"></span>
          <a href="">未结</a>
          <span class="fly-mid"></span>
          <a href="">已结</a>-->
          <!-- <span class="fly-search"><i class="layui-icon"></i></span> -->
          <div class="layui-form" style="padding: 5px">
          	<div class="layui-form-item">
			    <div class="layui-input-inline">
			      <input type="text" v-model="keyword" placeholder="请输入关键字" autocomplete="off" class="layui-input">
			    </div>
			    <div class="layui-form-mid layui-word-aux"><a href="javascript:void(0);" v-on:click="getByKeyworlds"><i class="layui-icon layui-icon-search"></i></a></div>
			  </div>
          </div>
          <span class="fly-filter-right layui-hide-xs">
            <a href="javascript:void(0);" v-on:click="getByCondition('all')" class="layui-this">按最新</a>
            <span class="fly-mid"></span>
            <a href="javascript:void(0);" v-on:click="getByCondition('commet')" style="color: #FF5722;">按热议</a>
          </span>
        </div>

        <ul class="fly-list">          
          <li style="padding-left: 15px" v-for="item in blogList">
            <h2>
              <!-- <a class="layui-badge">分享</a> -->
              <a href="javascript:void(0);" v-on:click="readBlogByMem(item)">{{item.blogTitle}}</a>
            </h2>
            <div class="fly-list-info">
              <a href="#" link>
                <cite>KPP</cite>
                <!--
                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                <i class="layui-badge fly-badge-vip">VIP3</i>
                -->
              </a>
              <span>{{item.createTime | moment}}</span>
              
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
        
        <!-- <div class="fly-none">没有相关数据</div> -->
    	<!-- 分页 -->
        <div style="text-align: center">
			<div class="laypage-main">
				<a href="javascript:void(0);" v-on:click="previous(current-1)"  class="laypage-prev">上一页</a>
				<a v-for="item in pages" v-bind:class="{'laypage-curr' : item==current }"  href="javascript:;" v-on:click="jumpToPage(item)">{{item}}</a>
				<a href="javascript:void(0);" v-on:click="next(current+1)" class="laypage-next">下一页</a>
			</div>
		</div>

      </div>
    </div>
    <div class="layui-col-md4">
      <dl class="fly-panel fly-list-one" style="padding: 10px">
        <dt class="fly-panel-title">标签</dt>
		<span>
			<a href="javascript:void(0);" v-on:click="getByLabelIdent('all')" class="layui-btn layui-btn-radius layui-btn-xs">
				全部 {{getTotal.labelNum}}
			</a>
			&nbsp;
		</span>
		<span v-for="item in labels">
			<a href="javascript:void(0);" v-on:click="getByLabelIdent(item.labelIdent)" class="layui-btn layui-btn-radius layui-btn-normal layui-btn-xs">
				{{item.labelName}}  
				<span> {{item.blogNum}}</span>
			</a>
			&nbsp;
		</span>
					<!-- 无数据时 -->
        <!--
        <div class="fly-none">没有相关数据</div>
        -->
      </dl>

      <div class="fly-panel">
        <div class="fly-panel-title">
          这里可作为广告区域
        </div>
        <div class="fly-panel-main">
          <a href="" target="_blank" class="fly-zanzhu" style="background-color: #393D49;">虚席以待</a>
        </div>
      </div>
      
      <div class="fly-panel fly-link">
        <h3 class="fly-panel-title">友情链接</h3>
        <dl class="fly-panel-main">
          <dd><a href="http://www.layui.com/" target="_blank">layui</a><dd>
          <dd><a href="http://layim.layui.com/" target="_blank">WebIM</a><dd>
          <dd><a href="http://layer.layui.com/" target="_blank">layer</a><dd>
          <dd><a href="http://www.layui.com/laydate/" target="_blank">layDate</a><dd>
          <dd><a href="mailto:xianxin@layui-inc.com?subject=%E7%94%B3%E8%AF%B7Fly%E7%A4%BE%E5%8C%BA%E5%8F%8B%E9%93%BE" class="fly-link">申请友链</a><dd>
        </dl>
      </div>

    </div>
  </div>
</div>

<%@ include file="/pages/common/footer.jsp"%>

<script src="${PATH}/static/layui/layui.all.js"></script>
<script>
	var blogsListIndex = new Vue({
		el:"#blogsListIndex",
		data:{
			blogList:[],
			condition:"all",
			ident:"all",	//
			keyword:"",
			current:1,		//当前页初始化
			pages:[],
			labels:[]
		},created: function () {
			this.$http.post("${PATH}/blog/getBlogListIndex",{
				condition:this.condition,
				ident:this.ident,
				keyword:this.keyword,
				page:1,
			}).then(function(response){
				console.log(response.body)
				//成功
				this.pages=response.body.pages;
				this.current=response.body.current;
				this.blogList=response.body.records;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
			//查询label
			this.$http.get("${PATH}/blogLabel/getLabelList").then(function(response){
				console.log(response.body)
				//成功
				this.labels = response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		},computed:{
			 //获取“全部”标签
		    getTotal:function(){
		        //获取productList中select为true的数据。
		        var _proList=this.labels,
				        labelNum=0;
		        for(var i=0,len=_proList.length;i<len;i++){
		            //总价累加
		            labelNum+=_proList[i].blogNum;
		        }
		        //选择产品的件数就是_proList.length，总价就是totalPrice
		        return {labelNum:labelNum}
		    }
		 },methods:{
			previous:function(page){	//上一页
				if(page<1){
					layui.layer.msg("不存在上一页！")
				}else{
					this.$http.post("${PATH}/blog/getBlogListIndex",{
						condition:this.condition,
						ident:this.ident,
						keyword:this.keyword,
						page:page,
					}).then(function(response){
						//成功
						this.blogList=response.body.records;
						this.pages=response.body.pages;
						this.current=response.body.current;
					},function(response) {
						console.log("系统错误！")
					});
				}
			},next:function(page){	//下一页
				if(page>this.pages){
					layui.layer.msg("不存在下一页！")
				}else{
					this.$http.post("${PATH}/blog/getBlogListIndex",{
						condition:this.condition,
						ident:this.ident,
						keyword:this.keyword,
						page:page,
					}).then(function(response){
						console.log(response.body)
						//成功
						this.blogList=response.body.records;
						this.pages=response.body.pages;
						this.current=response.body.current;
					},function(response) {
						console.log("系统错误！")
					});
				}
			},jumpToPage:function(page){		//页面跳转
				this.$http.post("${PATH}/blog/getBlogListIndex",{
					condition:this.condition,
					ident:this.ident,
					keyword:this.keyword,
					page:page,
				}).then(function(response){
					//成功
					this.blogList=response.body.records;
					this.pages=response.body.pages;
					this.current=response.body.current;
				},function(response) {
					console.log("系统错误！")
				});
			},getByCondition:function(kw){			//筛选
				this.condition = kw
				this.$http.post("${PATH}/blog/getBlogListIndex",{
					condition:this.condition,
					ident:this.ident,
					keyword:this.keyword,
					page:this.current,
				}).then(function(response){
					//成功
					this.blogList=response.body.records;
					this.pages=response.body.pages;
					this.current=response.body.current;
				},function(response) {
					console.log("系统错误！")
				});
			},getByLabelIdent:function(ident){		//标签查看
				this.ident = ident
				this.$http.post("${PATH}/blog/getBlogListIndex",{
					condition:this.condition,
					ident:this.ident,
					keyword:this.keyword,
					page:this.current,
				}).then(function(response){
					//成功
					this.blogList=response.body.records;
					this.pages=response.body.pages;
					this.current=response.body.current;
				},function(response) {
					console.log("系统错误！")
				});
			},getByKeyworlds:function(){			//关键字查询
				this.$http.post("${PATH}/blog/getBlogListIndex",{
					condition:this.condition,
					ident:this.ident,
					keyword:this.keyword,
					page:this.current,
				}).then(function(response){
					//成功
					this.blogList=response.body.records;
					this.pages=response.body.pages;
					this.current=response.body.current;
				},function(response) {
					console.log("系统错误！")
				});
			},readBlogByMem:function(blog){			//阅读博客
				var integral = blog.needIntegral;
				var blogIdent = blog.blogIdent;
				var memIdent = "${sessionScope.ident}"
				if(integral==0){	//如果免费的直接跳转过去阅读
					window.location.href="${PATH}/blog/getBlogByIdent/"+blog.blogIdent;
				}else{	
					//非免费的博客
					if(memIdent==""){
						layui.layer.msg("请先登录",function(){
							window.location.href="${PATH}/pages/login.jsp";
						})
						return false;
					}
					$.ajax({
						url:"${PATH}/blogBuy/blogIsBuy/"+blogIdent+"/"+memIdent,
						method:"get",
						success:function(res){
							console.log(res)
							if(res.code==100){	//已经购买
								window.location.href="${PATH}/blog/getBlogByIdent/"+blog.blogIdent;
							}else{
								if(res.extend.msg=="未购买"){			//未购买
									layer.confirm('是否花费 '+integral+' 积分购买？', {icon: 3, title:'提示'}, function(index){
										  $.ajax({
											  url:"${PATH}/blogBuy/blogForBuy/"+blogIdent+"/"+memIdent,
											  method:"get",
											  success:function(res){
												  console.log(res)
												  if(res.code==100){
													  window.location.href="${PATH}/blog/getBlogByIdent/"+res.extend.ident;
												  }else{
													  layui.layer.msg(res.extend.msg)
												  }
											  }
										  })
										  layer.close(index);
									});
								}else{								//登录超时
									layui.layer.msg(res.extend.msg,function(){
										window.location.href="${PATH}/pages/login.jsp";
									})
								}
							}
						}
					});
				}
			}
		}
	})
	Vue.filter('moment', function (value, formatString) {
	    formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
	    return moment(value).format(formatString);
	});
</script>
</body>
</html>