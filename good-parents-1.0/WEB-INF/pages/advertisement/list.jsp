﻿<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<!-- 引入tag.jsp -->
	<%@include file="../public/tag.jsp"%>
	<!DOCTYPE html>
<html lang="en">
<head>
	<title>用户主页面</title>
<!-- 引入css -->
<link rel="stylesheet" type="text/css" href="${path}/resources/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/lib/icheck/icheck.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${path}/resources/static/h-ui.admin/css/style.css" />
	<!-- 分页样式css -->
<link rel="stylesheet" type="text/css" href="${path}/resources/css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/bootstrap.min.css" />
<!-- 引入图片悬浮css -->
<link rel="stylesheet" id="spi-render-css-css" href="${path}/resources/imgshow/css/render.css?ver=3.5.2" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="${path}/resources/imgshow/css/default.include.b2676e.css" media="all" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 广告管理 <span class="c-gray en">&gt;</span> 广告列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<!-- 条件查询start -->
	<form id="From">
	<div class="text-c">

		<span class="select-box inline">
		<select name="type" class="select" onchange="findUser()">
			<option value="">全部类型</option>
			<option value="ADVERTISEMENT">广告</option>
			<option value="CURRICULUM">课程广告</option>
		</select>
		</span>
		<input type="text" name="id" placeholder="id" style="width:7%">
		&nbsp
		<input type="text" name="value" placeholder="课程ID" style="width:7%">
		</from>
		<a class="btn btn-success" onclick="findUser()"><i class="Hui-iconfont">&#xe665;</i> 查询</a>
	</div>
	<!-- 条件查询end -->
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="1">本页共有:<strong id="size"></strong> 条</span> <span class="r">共有数据：<strong id="total"></strong> 条</span> </div>
	<div class="mt-20" >
		<table class="table table-border table-bordered table-bg table-hover" style="white-space: nowrap">
			<thead>
				<tr class="text-c">
					<%--<th width="25"><input type="checkbox" name="" value=""></th>--%>
					<th width="80">ID</th>
					<th width="75">链接/课程ID</th>
					<th width="75">类型</th>
					<th width="75">图片</th>
					<th width="120">排序</th>
					<th width="120">操作</th>
					<th width="120"></th>
					<th width="120"></th>
					<th width="75">创建时间</th>
				</tr>
			</thead>
			<tbody id="goodList">
			</tbody>
		</table>
				<script type="text/html" id="f1">
		{{each data.list as good}}
			<tr>
				<td style="text-align:center;vertical-align:middle;">{{good.id}}</td>
				<td style="text-align:center;vertical-align:middle;">{{good.value}}
					<%--{{if good.type=="CURRICULUM"}}<a href="${path}/page/recommend/live/course/list?id={{good.value}}">{{good.value}} 查看</a>--%>
					<%--{{else if good.type=="ADVERTISEMENT"}}<a href="{{good.value}}">{{if good.value!=null}}查看{{else}}{{/if}}</a>--%>
					<%--{{else}}{{/if}}--%>
				</td>
				<td style="text-align:center;vertical-align:middle;">{{if good.type=="ADVERTISEMENT"}}<font color="blue">广告</font>{{else if good.type=="CURRICULUM"}}<font color="red">课程广告</font>{{else}}{{/if}}</td>
				<td>{{if good.img==NULL}}无{{else if good.img!=NULL}}<a class="sit-preview" href="{{good.img}}" onMouseOver="biggerr()"><img src="{{good.img}}" data-preview-url="{{good.img}}" style="cursor:pointer;width:60px;height:60px;"/></a>{{/if}}</td>
				<td style="text-align:center;vertical-align:middle;">{{good.sort}}</td>
				<!-- 用户审核 -->
				<td style="text-align:center;vertical-align:middle;">
					{{if good.sort==1}}{{else}}<img src="${path}/resources/static/h-ui/images/bin/up.png" onClick="member_up('{{good.sort}}','{{good.id}}')" title="上"><br/>{{/if}}
				</td>s
				<td style="text-align:center;vertical-align:middle;">
					<img src="${path}/resources/static/h-ui/images/bin/down.png" onClick="member_down('{{good.sort}}','{{good.id}}')" title="下">
				</td>
				<td style="text-align:center;vertical-align:middle;">
					<img src="${path}/resources/static/h-ui/images/validform/iconpic-error.png"
						 onClick="member_stop(this,'{{good.id}}')" title="删除">
				</td>
				<td style="text-align:center;vertical-align:middle;">{{$timestampFormatYMDHM good.gmtDatetime}}</td>
			</tr>
		{{/each}}
		</script>
		
	</div>

	<!-- 分页 -->
	<div class="pagination alternate" align="center">
		<ul id="page"></ul>
	</div>

<script type="text/html" id="f2">
	<!-- 分页 -->
	{{if data.prePage==0}}
	<li class="disabled"><a>上一页</a></li>
	{{else}}
	<li class="disabled"><a onclick="findUser({{data.prePage}})">上一页</a></li>
	{{/if}}
		{{each data.navigatepageNums as n}}
	<li class="active"> <a onclick="findUser({{n}})">{{n}}</a> </li>
		{{/each}}
	{{if data.nextPage==0}}
	<li class="disabled"><a>下一页</a></li>
	{{else}}
	<li class="disabled"><a onclick="findUser({{data.nextPage}})">下一页</a></li>
	{{/if}}
</script>

<script type="text/javascript" src="${path}/resources/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${path}/resources/lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="${path}/resources/lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="${path}/resources/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${path}/resources/static/h-ui/js/H-ui.js"></script> 
<script type="text/javascript" src="${path}/resources/static/h-ui.admin/js/H-ui.admin.js"></script>


<script src="${path}/resources/js/jquery.js"></script>
<script src="${path}/resources/js/template.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script src="${path}/resources/js/promise.min.js"></script>
<script src="${path}/resources/js/project.js"></script>
<script src="${path}/resources/js/jquery.common.js"></script>
<!-- 图片悬浮js -->
<script type="text/javascript" src="${path}/resources/imgshow/js/async-share.js?ver=3.5.2"></script>
<script type="text/javascript" src="${path}/resources/imgshow/js/default.include-footer.304291.js"></script>
<!-- 日期控件 -->
<script type="text/javascript" src="${path}/resources/datePicker/WdatePicker.js"></script>
<script type="text/javascript">
    findUser();
    function findUser(pageNum){
        var fromList=$("#From").formSerialize();
        var p=$.extend({pageNum: pageNum},fromList);
		Project.ajax("/advertisement/admin/page",p).ajaxOK(function(data) {
			$("#goodList").html(template("f1",data));//作用到表格
			$("#page").html(template("f2",data));//作用到分页
			$("#total").html(data.data.total);//作用到统计total
			$("#size").html(data.data.size);//作用到统计每页显示size
			biggerr();//初始页
			// 面调用图片悬浮放大方法
		});
    }

	<%--function member_stop(obj,id){//id为用户的id，obj没用到--%>
		<%--layer.confirm('确认要把该视频加入待审核状态吗？',function(index){--%>
            <%--layer.msg('已停用!',{icon: 6,time:1000});--%>
			<%--var state ='1';//停用用户--%>
            <%--layer_show("拉黑原因","${path}/page/user/fill/state?id="+id,600,360);--%>
		<%--});--%>
	<%--}--%>

    function member_up(obj,id){//id为用户的id，obj没用到
            Project.ajax("/advertisement/update/up",{id:id}).ajaxOK(function(data) {
                    layer.msg('成功!',{icon: 6,time:1000});
                    findUser();//刷新
            });
    }

    function member_down(obj,id){//id为用户的id，obj没用到
            Project.ajax("/advertisement/update/down",{id:id}).ajaxOK(function(data) {
                layer.msg('成功!',{icon: 6,time:1000});
                findUser();//刷新
            });
    }

    function member_stop(obj,id){//id为用户的id，obj没用到
        layer.confirm('确认要删除吗？',function(index){
            Project.ajax("/advertisement/delete",{id:id}).ajaxOK(function(data) {
                layer.msg('成功!',{icon: 6,time:1000});
                findUser();//刷新
            });
        });
    }

	/**
	 * 弹出用户信息悬浮框
	 * */
    function member_show(title,url,id,w,h){
        layer_show(title,url,w,h);
    }


	//图片悬浮事件处理
	function biggerr() {
		jQuery(".sit-preview").smartImageTooltip({
			previewTemplate : "simple",
			imageWidth : "350px"
		});
	}
	</script>

</body>
</html>