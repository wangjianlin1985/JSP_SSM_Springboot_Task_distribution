<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Task" %>
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的workObj信息
    List<ActivityInfo> activityInfoList = (List<ActivityInfo>)request.getAttribute("activityInfoList");
    Task task = (Task)request.getAttribute("task");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看任务详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Task/frontlist">任务信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务id:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">所属工作:</div>
		<div class="col-md-10 col-xs-6"><%=task.getWorkObj().getActivityTitle() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务标题:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTitle()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务内容:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskContent()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">发布时间:</div>
		<div class="col-md-10 col-xs-6"><%=task.getPubTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务状态:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskState()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务截止时间:</div>
		<div class="col-md-10 col-xs-6"><%=task.getEndTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">接手用户:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTakeUser()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">工作日志记录:</div>
		<div class="col-md-10 col-xs-6"><%=task.getWorkRecord()%></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="userGetTask();" class="btn btn-primary" style="display:<%=task.getTaskState().equals("准备中")?"":"none" %>;">领取任务</button>
			&nbsp;&nbsp;&nbsp;
			<button onclick="history.back();" class="btn btn-primary">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 
function userGetTask() {
	if(confirm('确认领取这个任务?')) {

		$.ajax({
			url : basePath + "Task/userGetTask",
			type : "post",
			dataType: "json",
			data:{
				//"task.takeUser":"<%=session.getAttribute("user_name") %>",
				"task.taskId": <%=task.getTaskId()%>
			},
			success : function (obj, response, status) {
				if(obj.success){ 
					alert(obj.message);
					//跳转到我领取的任务列表
					location.href = basePath + "Task/frontUserlist";
				} else {
					alert(obj.message);
				}
			}
		});
		
	}
	
}
 
 
 
 </script> 
</body>
</html>

