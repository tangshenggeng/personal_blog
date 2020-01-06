<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>KPP个人博客后台</title>
  <link rel="stylesheet" href="${PATH}/static/Content/Layui-KnifeZ/css/layui.css">
<style>
   .layui-layedit-tool .layui-colorpicker-xs {
       border: 0;
   }

   .layui-layedit-tool .layui-colorpicker-trigger-span i {
       display: none !important;
   }
   
		input[type=number] {  
    -moz-appearance:textfield;  
}  
input[type=number]::-webkit-inner-spin-button,  
input[type=number]::-webkit-outer-spin-button {  
    -webkit-appearance: none;  
    margin: 0;  
}  
	
</style>
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@ include file="/WEB-INF/view/common/header.jsp"%>
   <div class="layui-side layui-bg-cyan">
    <div class="layui-side-scroll" >
      	<ul class="layui-nav layui-nav-tree">
      	<li class="layui-nav-item"><a href="${PATH}/admin/index" class="layui-btn layui-btn-warm layui-btn-fluid">返回管理中心</a></li>      	
			<li class="layui-nav-item"><button type="button" class="layui-btn layui-btn-fluid">已存在的标签</button></li>      	
			<li class="layui-nav-item" id="labelList">
			<button type="button" v-for="item in labels" class="layui-btn layui-btn-normal layui-btn-xs layui-btn-radius"> {{item.labelName}} {{item.blogNum}}</button>
			</li>      	
      	</ul>
    </div>
  </div>
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">
    	<blockquote class="layui-elem-quote">
		<a href="${PATH}/admin/index">主页</a> /
		<a>编写博客</a>
	</blockquote>
		<form class="layui-form layui-col-md10 layui-col-md-offset1" style="margin-top: 20px">
			<div class="layui-form-item">
				<label class="layui-form-label">标题</label>
				<div class="layui-input-block">
					<input type="text" name="blogTitle" required lay-verify="required"
						placeholder="请输入标题" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">内容</label>
				<div class="layui-input-block">
					<textarea name="blogText" id="layeditDemo" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md6" >
					<div class="layui-form-item">
					<label class="layui-form-label">标签</label>
					<div class="layui-input-block">
						<input type="text" name="blogLabel" required lay-verify="required"
							placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
					</div>
				</div>
				<div class="layui-col-md6" >
					<div class="layui-form-item">
					<label class="layui-form-label">积分</label>
					<div class="layui-input-block">
						<input type="number" name="needIntegral" required lay-verify="number"
							placeholder="请输入" autocomplete="off" class="layui-input">
					</div>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">状态</label>
				<div class="layui-input-block">
					 <input type="radio" name="blogState" value="展示" title="展示" checked>
      				<input type="radio" name="blogState" value="隐藏" title="隐藏" >
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="addBlog">添加</button>
					<button type="reset" id="resetBtn" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>
    </div>
  </div>
  
  
  <div class="layui-footer layui-bg-green">
    <!-- 底部固定区域 -->
    © KPP个人博客
  </div>
</div>
<script src="${PATH}/static/js/jquery2.0-min.js"></script>	
<script src="${PATH}/static/Content/Layui-KnifeZ/layui.js"></script>
<script src="${PATH}/static/Content/ace/ace.js"></script>
<script src="${PATH}/static/Content/ace/ace.js"></script>
<script src="${PATH}/static/vue/vue.min.js"></script>
<script src="${PATH}/static/vue/vue-resource.min.js"></script>
<script>
var labelList = new Vue({
	el:"#labelList",
	data:{
		labels:[],
	},created: function () {
		//供应商
		this.$http.get("${PATH}/blogLabel/getLabelList",{
			}).then(function(response){
				console.log(response.body)
			//成功
			this.labels=response.body;
		},function(response) {
			//错误
			console.log("系统错误！")
		});
	}
	})

</script>
<script>
layui.use(['layedit', 'layer', 'jquery'], function () {
    var $ = layui.jquery
        , layer = layui.layer
        , layedit = layui.layedit;
    layedit.set({
        //暴露layupload参数设置接口 --详细查看layupload参数说明
        uploadImage: {
            url: '${PATH}/blog/uploadBlogImg',
            accept: 'image',
            acceptMime: 'image/*',
            exts: 'jpg|png|gif|bmp|jpeg',
            size: 1024 * 10,
            done: function (data) {
                console.log(data)
            }
        },
        uploadVideo: {
            url: '${PATH}/blog/uploadBlogVideo',
            accept: 'video',
            acceptMime: 'video/*',
            exts: 'mp4|flv|avi|rm|rmvb',
            size: 1024 * 10 * 2,
            done: function (data) {
                console.log(data);
            }
        }
        , uploadFiles: {
            url: '${PATH}/blog/uploadBlogFile',
            accept: 'file',
            acceptMime: 'file/*',
            size: '20480',
            autoInsert: true , //自动插入编辑器设置
            done: function (data) {
                console.log(data);
            }
        }
        //右键删除图片/视频时的回调参数，post到后台删除服务器文件等操作，
        //传递参数：
        //图片： imgpath --图片路径
        //视频： filepath --视频路径 imgpath --封面路径
        //附件： filepath --附件路径
        , calldel: {
            url: '${PATH}/blog/deleteFile',//
            done: function (data) {
                console.log(data);
            }
        }
        , rightBtn: {
            type: "layBtn",//default|layBtn|custom  浏览器默认/layedit右键面板/自定义菜单 default和layBtn无需配置customEvent
            customEvent: function (targetName, event) {
                //根据tagName分类型设置
                switch (targetName) {
                    case "img":
                        alert("this is img");
                        break;
                    default:
                        alert("hello world");
                        break;
                };
                //或者直接统一设定
                //alert("all in one");
            }
        }
        //测试参数
        , backDelImg: true
        //开发者模式 --默认为false
        , devmode: true
        //是否自动同步到textarea
        , autoSync: true
        //内容改变监听事件
        , onchange: function (content) {
            console.log(content);
        }
        //插入代码设置 --hide:false 等同于不配置codeConfig
        , codeConfig: {
            hide: true,  //是否隐藏编码语言选择框
            default: 'javascript', //hide为true时的默认语言格式
            encode: true //是否转义
            ,class:'layui-code' //默认样式
        }
        //新增iframe外置样式和js
        , quote:{
            style: ['${PATH}/static/Content/css.css'],
            //js: ['/Content/Layui-KnifeZ/lay/modules/jquery.js']
        }
        //自定义样式-暂只支持video添加
        //, customTheme: {
        //    video: {
        //        title: ['原版', 'custom_1', 'custom_2']
        //        , content: ['', 'theme1', 'theme2']
        //        , preview: ['', '/images/prive.jpg', '/images/prive2.jpg']
        //    }
        //}
        //插入自定义链接
        , customlink:{
            title: '插入layui官网'
            , href: 'https://www.layui.com'
            ,onmouseup:''
        }
        , facePath: 'http://knifez.gitee.io/kz.layedit/Content/Layui-KnifeZ/'
        , devmode: true
        , videoAttr: ' preload="none" ' 
        //预览样式设置，等同layer的offset和area规则，暂时只支持offset ,area两个参数
        //默认为 offset:['r'],area:['50%','100%']
        , previewAttr: {
            offset: 'r'
            ,area:['50%','100%']
        }
        , tool: [
            'html', 'undo', 'redo', 'code', 'strong', 'italic', 'underline', 'del', 'addhr', '|','removeformat', 'fontFomatt', 'fontfamily','fontSize', 'fontBackColor', 'colorpicker', 'face'
            , '|', 'left', 'center', 'right', '|', 'link', 'unlink', 'images', 'image_alt', 'video','attachment', 'anchors'
            , '|'
            , 'table','customlink'
            , 'fullScreen','preview'
        ]
        , height: '500px'
    });
    var ieditor = layedit.build('layeditDemo');
    //设置编辑器内容
    layedit.setContent(ieditor, "内容改变后加个回车增加一行，否则有可能编写不成功！", false);
    $("#openlayer").click(function () {
        layer.open({
            type: 2,
            area: ['700px', '500px'],
            fix: false, //不固定
            maxmin: true,
            shadeClose: true,
            shade: 0.5,
            title: "title",
            content: 'add.html'
        });
    })
})
</script>
<script>
layui.use(['layer','form'], function(){
	var layer = layui.layer,
	form = layui.form;
	form.on('submit(addBlog)', function(data){
		  var datas = data.field
		  console.log(datas)
		  var blogText = datas.blogText
		  if(blogText=="内容改变后加个回车增加一行，否则有可能编写不成功！"){
			  layer.msg("内容未改变！")
			  return false;
		  }
		  $.ajax({
			url:"${PATH}/blog/addBlog",
			data:datas,
			method:"post",
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
		  });
		  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
});
</script>
</body>
</html>