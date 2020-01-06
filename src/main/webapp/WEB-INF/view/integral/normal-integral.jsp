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
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@ include file="/WEB-INF/view/common/header.jsp"%>
  <%@ include file="/WEB-INF/view/common/nav.jsp"%>
  <div class="layui-body">
  	<div style="padding: 15px;">
    	<blockquote class="layui-elem-quote">
		<a href="${PATH}/admin/index">主页</a> /
		<a>正常充值</a>
	</blockquote>
		<form class="layui-form" id="kwCustForm">
			<!-- <div class="layui-col-md3">
				<div class="layui-form-item">
					<label class="layui-form-label">关键字</label>
					<div class="layui-input-block">
						<input type="text" name="custName"  placeholder="请输入" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div> --> 
			<div class="layui-col-md3">
				<div class="layui-form-item">
					<label class="layui-form-label">客户标识</label>
					<div class="layui-input-block">
						<input type="text" name="custEmail"  placeholder="请输入" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label range-label">日期</label>
					<div class="layui-input-inline">
						<input type="text" id="start_date" placeholder="请选择" name="start_date"
							autocomplete="off" class="layui-input">
					</div>
					<div class="layui-form-mid">-</div>
					<div class="layui-input-inline">
						<input type="text" id="end_date" placeholder="请选择" name="end_date"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" type="button" id="kwFormBtn">筛选</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form><br>
		<div class="row">
			<div class="layui-col-md12">
				<div class="card">
					<div class="card-header">
						<h2>正常充值</h2><br>
						<button class="layui-btn layui-btn-danger" type="button" id="delByIds"><i class="layui-icon layui-icon-delete"></i>删除选中</button>
						<button class="layui-btn " type="button" id="exceptionCustBtn"><i class="layui-icon layui-icon-face-surprised"></i>选中异常</button>
					</div>
					<div class="card-body">
						<table id="dataListTb" lay-filter="dataTbFilter"
							class="table table-responsive table-hover">

						</table>
					</div>
				</div>
			</div>
		</div>
    </div>
  </div>
  <div class="layui-footer layui-bg-green">
    <!-- 底部固定区域 -->
    © KPP个人博客
  </div>
</div>
<div style="display: none;" id="lookCloInfoModel">
	<div  style="margin: 20px 20px">
		<div class="panel panel-default">
			  <div class="panel-body" id="cloInfoDiv">
			    
			  </div>
			</div>
	</div>
</div>
<script src="${PATH}/static/js/jquery2.0-min.js"></script>	
<script src="${PATH}/static/layui/layui.all.js"></script>	
<script>
$(function() {
	renderTb();
});
function renderTb() {
	var data = $("#kwCustForm").serializeArray();
	layui.use(['table','util'], function() {
		var table = layui.table
		,util = layui.util;
		//第一个实例
		table.render({
			elem : '#dataListTb',
			height :400,
			url : '${PATH}/integralRecharge/getNormalList',
			id:"datListTbId",
			size : 'sm ',
			contentType: "application/json",//必须指定，否则会报415错误
		    dataType : 'json',
			method:"POST",
			id:"dataListTbId",
			page : true //开启分页
			,
			title:"正常充值订单",
			toolbar : "#toolbarDemo",
			defaultToolbar : [ 'filter','exports' ],
			where : {
				kwdata : data
			},
			cols : [ [ //表头
			{
				field : 'rechargeId',
				title : '#',
				type:"checkbox",
				align : "center"
			},{
				field : 'rechargeIdent',
				title : '充值单号',
				align : "center"
			},{
				field : 'beforeIntegral',
				title : '充值之前积分',
				sort:true,
				align : "center"
			},{
				field : 'payMoney',
				title : '充值金额',
				sort:true,
				align : "center"
			},{
				field : 'afterIntegral',
				title : '充值之后积分',
				sort:true,
				align : "center"
			},{
				field : 'memIdent',
				title : '客户标识',
				align : "center"
			},{
				field : 'createTime',
				title : '创建时间',
				sort:true,
				align : "center"
				,templet:"<div>{{layui.util.toDateString(d.createTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
			},{
				fixed : 'right',
				width : 150,
				rowspan : 2,
				title : '操作',
				align : 'center',
				toolbar : '#barDemo'
			}]],
			parseData : function(res) { //res 即为原始返回的数据
				console.log(res)
				return {
					"code" : res.status, //解析接口状态
					"msg" : res.message, //解析提示文本
					"count" : res.total, //解析数据长度
					"data" : res.data
				//解析数据列表
				};
			}
		});
		table.on('tool(dataTbFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
		  	var data = obj.data; //获得当前行数据
		  	var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		  	 if(layEvent === 'detail'){
		  		$.ajax({
					url:"${PATH}/member/getByMemIdent/"+data.memIdent,
					method:"get",
					success:function(res){
						$("#cloInfoDiv").html(res)
					}
				});
		  		layui.layer.open({
					title : '查看充值人信息',
					fix : true,
					resize : false,
					move : false,
					area : [ '600px', '400px' ],
					shadeClose : false,
					type : 1,
					anim: 5,
					content : $('#lookCloInfoModel'),
					cancel : function(index, layero) {
						$('#lookCloInfoModel').css("display", "none")
					}
				 })
		  	  }else if(layEvent === 'LAYTABLE_TIPS'){
		  	    layer.alert('Hi，头部工具栏扩展的右侧图标。');
		  	  }
		});
	});
}
//批量删除
$("#delByIds").click(function(){
	layui.use(['table','layer'], function() {
		var table = layui.table
		,layer = layui.layer;
		layer.confirm('真的删除行么', function(index){
			var checkStatus = table.checkStatus('dataListTbId');
			var datas = checkStatus.data
			var ids = new Array();
			$(datas).each(function(){
				ids.push($(this)[0].rechargeId);
			})
			
			if(ids.length==0){
				layer.msg("请选择数据！");
				return false;
			}
			$.ajax({
				url:"${PATH}/integralRecharge/delByIds",
				method:"POST",
				contentType: "application/json",//必须指定，否则会报415错误
			    dataType : 'json',
				data:JSON.stringify(ids),
				success:function(res){
					console.log(res)
					if(res.code == 100){
						layer.msg(res.extend.msg,{icon:6},function(){
							renderTb();
						});
					}else{
						layer.msg(res.extend.msg,{icon:5},function(){
							renderTb();
						});
					}
				},error:function(){
					layer.msg("系统错误！",{icon:5},function(){
						renderTb();
					});
				}
			});	
		  layer.close(index);
		});
	});
})
//批量异常
$("#exceptionCustBtn").click(function(){
	layui.use(['table','layer'], function() {
		var table = layui.table
		,layer = layui.layer;
		layer.confirm('确认该充值订单异常吗？', function(index){
			var checkStatus = table.checkStatus('dataListTbId');
			var datas = checkStatus.data
			var ids = new Array();
			$(datas).each(function(){
				ids.push($(this)[0].rechargeId);
			})
			if(ids.length==0){
				layer.msg("请选择数据！");
				return false;
			}
			$.ajax({
				url:"${PATH}/integralRecharge/exceptionByIds",
				method:"POST",
				contentType: "application/json",//必须指定，否则会报415错误
			    dataType : 'json',
				data:JSON.stringify(ids),
				success:function(res){
					console.log(res)
					if(res.code == 100){
						layer.msg(res.extend.msg,{icon:6},function(){
							renderTb();
						});
					}else{
						layer.msg(res.extend.msg,{icon:5},function(){
							renderTb();
						});
					}
				},error:function(){
					layer.msg("系统错误！",{icon:5},function(){
						renderTb();
					});
				}
			});	
		  layer.close(index);
		});
	});
})
layui.use('laydate', function(){
  var laydate = layui.laydate;
  //执行一个laydate实例
  laydate.render({
    elem: '#start_date' //指定元素,
    ,eventElem: '#start_date'
    ,trigger: 'click'
  });
  laydate.render({
    elem: '#end_date' //指定元素,
    ,eventElem: '#end_date'
    ,trigger: 'click'
  });
});
//筛选
$("#kwFormBtn").click(function(){
	renderTb();
});
</script>
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
  </div>
</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
</script>
</body>
</html>