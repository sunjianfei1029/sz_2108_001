<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.min.js"></script>
	<script>
		function deleteSelected() {
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
			//alert(id);
			location = "/delete.do?id=" + id;
		}

		// 页面加载完成事件
		jQuery(function ($) {

			// 给id为selectAll的元素绑定点击事件
			$("#selectAll").click(function () {
				// 让所有复选框的选中状态和全选按钮的选中状态一样！
				// 在事件中，this永远是触发事件的元素
				$(":checkbox[name=chk]").prop("checked", this.checked);
			});

			// 点击复选框会影响全选按钮的选中状态
			$(":checkbox[name=chk]").click(function () {

				/*$("#selectAll").prop("checked", true);

				// 查找是否有没选中的复选框，如果有，则让全选按钮取消选中
				$(":checkbox[name=chk]").each(function () {
					if (this.checked == false) {
						$("#selectAll").prop("checked", false);
						return false; // 结束each循环必须使用return false,不可以 break;
					}
				});*/

				$("#selectAll").prop("checked", $(":checkbox[name=chk]:checked").size() == $(":checkbox[name=chk]").size());

			});

			$("#addBtn").click(function () {
				// location: 地址栏对象
				location = "/add.html";
			})

			$("img[del]").click(function () {
				// confirm函数：确认框，包含确认和取消按钮，点击确定返回true
				if( confirm("确定删除吗？") ) {
					location = "/delete.do?id=" + $(this).attr("del") ;
				}
			})


			$("img[edit]").click(function () {
				var id = $(this).attr("edit"); // attr方法用于获取标签的自定义属性，获取元素的edit属性的值
				// 去后台根据id查询商品信息
				location = "/edit.html?id="+id;
			})
		});


	</script>
</head>
<body>
<div style="padding: 10px;">
	<div class="option">
		<input id="addBtn" type="button" value="添加" />
		<input onclick="deleteSelected()" type="button" value="删除选中" />
		<a href="/index_ajax.html">进入ajax操作页面</a>
	</div>
	<table cellspacing="0" cellpadding="0" bordercolor="gray" border="1" width="100%">
		<tr style="font-weight: bold; font-size: 12pt; height: 25px; background-color: #afd1f3">
			<td width="40px" align="center">
				<input type="checkbox" id="selectAll" />
			</td>
			<td width="80px" align="center">序号</td>
			<td width="" align="center">商品名称</td>
			<td width="100px" align="center">商品价格</td>
			<td width="100px" align="center">剩余数量</td>
			<td width="500px" align="center">商品描述</td>
			<td width="120px" align="center">编辑</td>
		</tr>
		<%--
		varStatus：和循环相关的属性都封装到该对象中！
		--%>
		<c:forEach items="${products}" var="p" varStatus="sta">
		<tr>
			<td align="center">
				<input type="checkbox" value="${p.id}" name="chk" />
			</td>
			<td style="height: 22px" align="center">${sta.count}</td>
			<td style="height: 22px" align="left">${p.name}</td>
			<td style="height: 22px" align="center">${p.price}</td>
			<td style="height: 22px" align="center">${p.num}</td>
			<td style="height: 22px" align="left"><div>${p.description}</div></td>
			<td align="center">
				<img edit="${p.id}" src="${pageContext.request.contextPath}/static/images/i_edit.gif" border="0" style="cursor: hand">&nbsp;&nbsp;
				<img del="${p.id}" src="${pageContext.request.contextPath}/static/images/i_del.gif" border="0" style="cursor: hand">
			</td>
		</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>