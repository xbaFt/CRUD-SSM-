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
				<button class="btn btn-info" data-toggle="modal" id="add_emp">新增</button>
				<button class="btn btn-danger" id = "emp_delete_all_btn">删除</button>
			</div>
		</div>
		
		<!-- 员工修改模态框 -->
		<div class="modal fade" id="update_modal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改员工信息</h4>
					</div>
					<dir></dir>
					<form class="form-horizontal" id="emp_update_form">
						<div class="form-group">
							<label class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-8">
								<p class="form-control-static" id = "update_name"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Email</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="update_email"
									name="email" placeholder="Email"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="update_gender" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="update_gender2" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">所在部门</label>
							<div class="col-sm-8">
								<!-- 部门信息 -->
								<select class="form-control" name="dId" id="update_dep">
								</select>
							</div>
						</div>

					</form>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="update_save">更新</button>
					</div>
				</div>
			</div>
		</div>
		

		<!-- 模态框 -->
		<div class="modal fade" id="add_modal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">添加员工信息</h4>
					</div>
					<dir></dir>
					<form class="form-horizontal" id="emp_form">
						<div class="form-group">
							<label class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="ipname"
									name="empName" placeholder="Name"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Email</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="ipemail"
									name="email" placeholder="Email"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">所在部门</label>
							<div class="col-sm-8">
								<!-- 部门信息 -->
								<select class="form-control" name="dId" id="dep">
								</select>
							</div>
						</div>

					</form>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="emp_save">保存</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
							<input type = "checkbox" id = "check_all">
							</th>
							<th>ID</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
		</div>
		<!-- 分页条 -->
		<div class="row">
			<div class="col-md-8 col-md-offset-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
	
		//保存当前页信息
		var currer;
		//保存尾页信息
		var lastPage;
		//发送ajax请求要到数据
		$(function() {
			to_page(1);
		});
		//跳页请求
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emp",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});

		}

		//表格数据填充
		function build_emps_table(result) {
			//每次请求前先清空数据
			$("#emps_table tbody").empty()
			var emps = result.extend.pageInfo.list;
			//遍历数据添加到单元格
			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td><input type = 'checkbox' class = 'check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(
						item.departement.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-info btn-sm").append($("<span></span>"))
						.addClass("glyphicon glyphicon-pencil update_edit").append("编辑");
				//为按钮添加一个员工id属性
				editBtn.attr("update_id",item.empId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm update_delete").append($("<span></span>"))
						.addClass("glyphicon glyphicon-trash").append("删除");
				delBtn.attr("del_id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emps_table tbody");
			});
		}

		//分页信息
		function build_page_info(result) {
			$("#page_info_area").empty()
			$("#page_info_area").append(
					"当前页码:" + result.extend.pageInfo.pageNum + ", 总页码:"
							+ result.extend.pageInfo.pages + ", 总共有"
							+ result.extend.pageInfo.total + "记录;");
			currer = result.extend.pageInfo.pageNum;
			lastPage = result.extend.pageInfo.total;
		}

		//构建导航条
		function build_page_nav(result) {
			$("#page_nav_area").empty()
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var pre = $("<li></li>").append($("<a></a>").append("&laquo;"));
			var next = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			ul.append(firstPageLi).append(pre);

			//遍历取出页码
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			//判断是否是最后一页
			if (!result.extend.pageInfo.isLastPage) {
				next.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			//判断是否是首页
			if (!result.extend.pageInfo.isFirstPage) {
				pre.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1)
				});
				firstPageLi.click(function() {
					to_page(1)
				});
			}
			ul.append(next).append(lastPageLi);
			$("#page_nav_area").append(ul);
		}

			//获取部门信息
			function getDept(ele){
				$(ele).empty();
				$.ajax({
					url:"${APP_PATH}/dept",
					type:"GET",
					success:function(result){
							//遍历数据，把数据填充到下拉框 
							$.each(result.extend.dept,function(){
								var optionEmp = $("<option></option>").append(this.deptName).attr("value",this.deptId);
									optionEmp.appendTo($(ele));
							});
					}
				});
			}
			
			//校验表单数据
			function vaildate_add_form(){
				var name = $("#ipname").val();
				//正则规则,二到八位的英文或二到六位以内的汉字
				var regName = /^([a-zA-Z0-9_-]{2,8}$)|(^[\u2E80-\u9FFF]{2,6}$)/;
				if(!regName.test(name)){
					show_validate_msg("error","#ipname","用户名为二到八位字母或汉字");
					return false;
				}else{
					show_validate_msg("success","#ipname","");
				};
				//邮箱验证
				var email = $("#ipemail").val();
				var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(!regEmail.test(email)){
					show_validate_msg("error","#ipemail","邮箱格式错误");
					return false;
				}else{
					show_validate_msg("success","#ipemail","");
				}
				return true;
			}
			
			//验证数据 验证状态,显示信息的节点元素,提示信息
			function show_validate_msg(stauts,ele,msg){
				$(ele).parent().removeClass("has-success has-error");
				$(ele).next("span").text();
				if(stauts == "success"){
					$(ele).parent().addClass("has-success");
					$(ele).next("span").text("");
				}else if(stauts == "error"){
					$(ele).parent().addClass("has-error");
					$(ele).next("span").text(msg);
				}
			}
			//保存按钮的点击事件
			$("#emp_save").click(function(){
				var check = vaildate_add_form();
				if(!check){
					return false;
				}
				if($(this).attr("ajax-va") == "error"){
					return false;
				}
					$.ajax({
						url:"${APP_PATH}/emp",
						type:"POST",
						//利用jQuery 序列化保存表达内容
						data:$("#emp_form").serialize(),
						success:function(result){
							if(result.code==100){
								//关闭模态框
								$("#add_modal").modal('hide');
							}else{
								//判断错误信息类型
								if(undefined != result.extend.fildel_Error.email){
									show_validate_msg("error","#ipemail","邮箱格式错误");
								}
								if(undefined != result.extend.findel_Error.name){
									show_validate_msg("error","#ipname","用户名为二到八位字母或汉字");
								}
							}
							
						}
					});
				
		});
			//清空表单样式
			function clear_form(ele){
				$(ele)[0].reset();
				$(ele).find("*").removeClass("has-success has-error");
				$(ele).find(".help-block").text("");
			}
			
			//新增按钮的点击事件,点击按钮时发送Ajax请求拿到部门信息
			$("#add_emp").click(function(){
				clear_form("#emp_form");
				getDept("#dep");
				$("#add_modal").modal({
					backdrop:"static"
				});
		});	
			//用户名校验,添加文本框修改事件
			$("#ipname").change(function(){
				//发送ajax请求校验用户名是否可用
				var empName = this.value;
				$.ajax({
					url:"${APP_PATH}/checkuser",
					data:"empName="+empName,
					type:"POST",
					success:function(result){
						if(result.code == 100){
							show_validate_msg("success","#ipname","用户名可用");
							$("#emp_save").attr("ajax-va","success");
						}else{
							show_validate_msg("error","#ipname",result.extend.va_msg);
							$("#emp_save").attr("ajax-va","error");
						}
					}
				});
			});
			
			//原生js无法对按钮提前绑定事件 所以利用jquery对更新按钮绑定事件
			$(document).on("click",".update_edit",function(){
				//查找并显示员工信息
				getEmp($(this).attr("update_id"));
				//查找并显示部门信息
				getDept("#update_dep");
				//为更新按钮添加一个员工id属性 方便发送请求时获取id
				$("#update_save").attr("btn_emp_id",$(this).attr("update_id"));
				$("#update_modal").modal({
					backdrop:"static"
				});
				
			});
			
			//查找员工信息
			function getEmp(id){
				$.ajax({
					url:"${APP_PATH}/emp/"+id,
					type:"GET",
					success:function(result){
						var empData = result.extend.emp
						//填充员工信息
						$("#update_name").text(empData.empName);
						$("#update_email").val(empData.email);
						$("#update_modal input[name=gender]").val([empData.gender]);
						$("#update_dep").val([empData.dId]);
					}
				});
			}
			
			//更新员工信息
			$("#update_save").click(function(){
				//验证邮箱信息
				var email = $("#update_email").val();
				var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(!regEmail.test(email)){
					show_validate_msg("error","#update_email","邮箱格式错误");
					return false;
				}else{
					show_validate_msg("success","#update_email","");
				}
				//如果发送post转put的话 要在发送的数添加"&_method=put"标识 这是个put请求
				/**
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("btn_emp_id"),
					type:"POST",
					data:$("#emp_update_form").serialize()+"&_method=PUT",
					success:function(result){
						alert(result.msg);
					}
				});
				**/
				
				/**
				如果直接发送put请求的话
				Employee中的对象属性只有id属性能够封装其他属性无法封装
				
				Tomcat:
					1 tomcat会将请求中的请求数据封装成一个map，
					2  调用request.getParamenter(),就会在这个map中取值
					3 Spring封装pojo的时候会 调用request.getParamenter()拿到数据的值
					4 tomcat不会把put的请求体数据封装到map中
					
				解决方案:
					在web.xml中配置HttpPutFormContentFilter过滤器
					HttpPutFormContentFilter将请求体中的数据重新封装成一个map
					重新包装request，重写 request.getParameter()
				**/
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("btn_emp_id"),
					type:"PUT",
					data:$("#emp_update_form").serialize(),
					success:function(result){
						$("#update_modal").modal("hide");
						to_page(lastPage);
					}
				});
			});
			//删除单个员工信息
			$(document).on("click",".update_delete",function(){
				var name = $(this).parents("tr").find("td:eq(2)").text();
				var id = $(this).attr("del_id");
				if(confirm("你确定要删除 "+name+" ?")){
					$.ajax({
						url:"${APP_PATH}/emp/"+id,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
						}
					});
				}
			});
			//全选或全不选功能
			$("#check_all").click(function(){
				//attr用于获取自定义的值
				//使用prop修改和读取原生dom的值
				$(".check_item").prop("checked",$(this).prop("checked"))
			});
			$(document).on("click",".check_item",function(){
				var flag = $(".check_item:checked").length == $(".check_item").length;
				$("#check_all").prop("checked",flag);
			});
			
			//批量删除
			$("#emp_delete_all_btn").click(function(){
				var empName = "";
				var del_idstr = "";
				$.each($(".check_item:checked"),function(){
					empName += $(this).parents("tr").find("td:eq(2)").text()+",";
					del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				});
				empName = empName.substring(0,empName.length-1);
				del_idstr = del_idstr.substring(0,del_idstr.length-1);
				if(confirm("确认删除 "+empName+"?")){
					$.ajax({
						url:"${APP_PATH}/emp/"+del_idstr,
						type:"DELETE",
						success:function(){
							to_page(currer)
						}
					});
				}
			});
	</script>
</body>
</html>