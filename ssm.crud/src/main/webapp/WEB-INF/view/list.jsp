<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工信息</title>
<!-- 获取当前项目路径 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
<!-- 引入bootstrap樣式-->
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-info ">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>ID</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门名称</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女"}</th>
							<th>${emp.email }</th>
							<th>${emp.departement.deptId }</th>
							<th>
								<button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-pencil"
										aria-hidden="true btn-sm"></span> 编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<div class="col-md-6">当前页码:${pageInfo.pageNum},总页码:${pageInfo.pages},总共有${pageInfo.total }记录</div>
		</div>
		<!-- 分页条 -->
		<div class="row">
			<div class="col-md-8 col-md-offset-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH }/emps?pn=">首页</a></li>
					<c:if test="${pageInfo.hasPreviousPage}">
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
						<c:if test="${page_num == pageInfo.pageNum}">
							<li class="active"><a href="#">${page_num}</a></li>
						</c:if>
						<c:if test="${page_num!=pageInfo.pageNum }">
							<li><a href="${APP_PATH }/emps?pn=${page_num }">${page_num}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${!pageInf.ohasNextPage }">
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
					
					<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">尾页</a></li>
				</ul>
				</nav>

			</div>
		</div>
	</div>
</body>
</html>