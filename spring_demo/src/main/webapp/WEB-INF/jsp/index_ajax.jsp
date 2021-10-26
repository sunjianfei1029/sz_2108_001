<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="/static/css/style.css" />
	<link rel="stylesheet" type="text/css" href="/static/css/bootstrap.min.css" />


	<script type="text/javascript" src="/static/js/jquery.min.js"></script>
	<script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
	<script>

		// 页面加载完成事件
		jQuery(function ($) {
			// 发送ajax请求访问后端数据接口获取商品列表
			function list() {
				$.ajax({
					url: "/product/products.json",
					success: function (data) {
						//console.log(data);
						var html = "";
						// data: [{},{},...]
						// 循环拼接html内容
						$(data).each(function (index) {
							html += '<tr>';
							html += '	<td>';
							html += '		<input type="checkbox" value="'+this.id+'" name="chk" />';
							html += '	</td>';
							html += '	<td>'+(index+1)+'</td>';
							html += '	<td>'+this.name+'</td>';
							html += '	<td>'+this.price+'</td>';
							html += '	<td>'+this.num+'</td>';
							html += '	<td><div>'+this.description+'</div></td>';
							html += '	<td align="center">';
							html += '		<img data-toggle="modal" data-target="#editModal" edit="'+this.id+'" src="/static/images/i_edit.gif" border="0" style="cursor: hand">&nbsp;&nbsp;';
							html += '		<img del="'+this.id+'" src="/static/images/i_del.gif" border="0" style="cursor: hand">';
							html += '	</td>';
							html += '</tr>';
						});

						// 将拼接好的html，渲染到页面中
						$("#dataBody").html( html );
					}
				});
			}

			list(); // 加载列表


			// 给删除图标绑定点击事件
			// 事件的委派机制：将事件绑定到目标元素的父元素上，这个父元素要一开始就存在于页面中。
			$("#dataBody").on("click", "img[del]", function () {

				if (!confirm("确定删除吗？")) return ;

				var id = $(this).attr("del");
				$.ajax({
					url: "/product/"+id+"/名称",
					type: "delete",
					success: function (data) {
						// data: {success: true/false, msg: "具体消息"}
						if ( data.success ) {
							list(); // 重新加载列表
						}
						alert(data.msg);
					}
				})
			});

			$("#delBtn").click(function () {
				// 得到id的格式为："1,2,3"
				// 获取选中的复选框
				var $cks = $(":checkbox[name=chk]:checked");
				if( $cks.size() == 0 ) {
					alert("请选择删除项！");
					return ; // 方法遇到return就会结束执行
				}

				// 如果点击取消(false)，则结束代码的执行
				if( !confirm("确定删除吗？") ) return;

				var id = "";
				$cks.each(function () {
					// this的循环中的元素
					id += "," + this.value;
				});

				// ",1,2,3" ===> "1,2,3"
				id = id.substring(1) // 从指定位置截取到最后

				// 通过ajax调用后端删除接口完成删除操作
				$.ajax({
					//url: "/ajax/delete.do?id=" + id,
					url: "/product/"+id,
					type: "delete",
					success: function (data) {
						// data: {success: true/false, msg: "具体消息"}
						if ( data.success ) {
							list(); // 重新加载列表
						}
						alert(data.msg);
					}
				})
			})

			$("#saveBtn").click(function () {
				$.ajax({
					url: "/product",
					type: "post", // 请求方式
					// 提交的数据
					data: {
						name: $("#save_name").val(),
						price: $("#save_price").val(),
						num: $("#save_num").val(),
						description: $("#save_description").val()
					},
					success: function (data) {
						if ( data.success ) {
							list(); // 重新加载列表
							$("#addModal").modal('hide'); // 隐藏id为addModal的窗口
						}
						alert(data.msg);
					}
				})
			})


			$("#dataBody").on("click", "img[edit]", function () {
				var id = $(this).attr("edit");
				// 根据id获取商品信息，然后回显数据
				$.ajax({
					//url: "/ajax/edit.do?id=" + id,
					url: "/product/"+id,
					type: "get", // 默认get方式
					success: function (data) {
						// data: {id:1,name:"商品名称",...}
						$("#edit_id").val(data.id);
						$("#edit_name").val(data.name);
						$("#edit_price").val(data.price);
						$("#edit_num").val(data.num);
						$("#edit_description").val(data.description);
					}
				})
			});


			$("#editBtn").click(function () {
				$.ajax({
					url: "/product",
					type: "put", // 请求方式
					// 提交的数据
					data: {
						id: $("#edit_id").val(),
						name: $("#edit_name").val(),
						price: $("#edit_price").val(),
						num: $("#edit_num").val(),
						description: $("#edit_description").val()
					},
					success: function (data) {
						if ( data.success ) {
							list(); // 重新加载列表
							$("#editModal").modal('hide'); // 隐藏id为addModal的窗口
						}
						alert(data.msg);
					}
				})
			})
		});

	</script>
</head>
<body>

<!-- 添加商品的模态窗口 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">添加商品</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label for="save_name" class="col-sm-2 control-label">商品名称</label>
						<div class="col-sm-10">
							<input type="text" id="save_name" name="name" class="form-control" placeholder="商品名称">
						</div>
					</div>
					<div class="form-group">
						<label for="save_price" class="col-sm-2 control-label">商品价格</label>
						<div class="col-sm-10">
							<input type="text" id="save_price" class="form-control" placeholder="商品价格">
						</div>
					</div>
					<div class="form-group">
						<label for="save_num" class="col-sm-2 control-label">商品数量</label>
						<div class="col-sm-10">
							<input type="text" id="save_num" name="num" class="form-control" placeholder="商品数量">
						</div>
					</div>
					<div class="form-group">
						<label for="save_description" class="col-sm-2 control-label">商品描述</label>
						<div class="col-sm-10">
							<textarea id="save_description" name="description" class="form-control" placeholder="商品描述"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button id="saveBtn" type="button" class="btn btn-primary">保存</button>
			</div>
		</div>
	</div>
</div>

<%--编辑窗口--%>
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">修改商品</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<%--隐藏域，作为修改条件--%>
					<input type="hidden" id="edit_id" />
					<div class="form-group">
						<label for="edit_name" class="col-sm-2 control-label">商品名称</label>
						<div class="col-sm-10">
							<input type="text" id="edit_name" name="name" class="form-control" placeholder="商品名称">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_price" class="col-sm-2 control-label">商品价格</label>
						<div class="col-sm-10">
							<input type="text" id="edit_price" class="form-control" placeholder="商品价格">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_num" class="col-sm-2 control-label">商品数量</label>
						<div class="col-sm-10">
							<input type="text" id="edit_num" name="num" class="form-control" placeholder="商品数量">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_description" class="col-sm-2 control-label">商品描述</label>
						<div class="col-sm-10">
							<textarea id="edit_description" name="description" class="form-control" placeholder="商品描述"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button id="editBtn" type="button" class="btn btn-primary">修改</button>
			</div>
		</div>
	</div>
</div>

<div style="padding: 10px;">
	<div class="option">
		<input id="addBtn" class="btn btn-default" type="button" value="添加" data-toggle="modal" data-target="#addModal" />
		<input id="delBtn" class="btn btn-default" type="button" value="删除选中" />
	</div>
	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<td>
					<input type="checkbox" id="selectAll" />
				</td>
				<td>序号</td>
				<td>商品名称</td>
				<td>商品价格</td>
				<td>剩余数量</td>
				<td>商品描述</td>
				<td>编辑</td>
			</tr>
		</thead>
		<tbody id="dataBody"></tbody>
	</table>
</div>
</body>
</html>