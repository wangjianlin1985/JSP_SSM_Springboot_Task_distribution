<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Task" %>
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Task> taskList = (List<Task>)request.getAttribute("taskList");
    //获取所有的workObj信息
    List<ActivityInfo> activityInfoList = (List<ActivityInfo>)request.getAttribute("activityInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    ActivityInfo workObj = (ActivityInfo)request.getAttribute("workObj");
    String title = (String)request.getAttribute("title"); //任务标题查询关键字
    String pubTime = (String)request.getAttribute("pubTime"); //发布时间查询关键字
    String taskState = (String)request.getAttribute("taskState"); //任务状态查询关键字
    String endTime = (String)request.getAttribute("endTime"); //任务截止时间查询关键字
    String takeUser = (String)request.getAttribute("takeUser"); //接手用户查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>任务查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#taskListPanel" aria-controls="taskListPanel" role="tab" data-toggle="tab">任务列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Task/task_frontAdd.jsp" style="display:none;">添加任务</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="taskListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>所属工作</td><td>任务标题</td><td>发布时间</td><td>任务状态</td><td>任务截止时间</td><td>接手用户</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<taskList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Task task = taskList.get(i); //获取到任务对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=task.getWorkObj().getActivityTitle() %></td>
 											<td><%=task.getTitle() %></td>
 											<td><%=task.getPubTime() %></td>
 											<td><%=task.getTaskState() %></td>
 											<td><%=task.getEndTime() %></td>
 											<td><%=task.getTakeUser() %></td>
 											<td>
 												<a href="<%=basePath  %>Task/<%=task.getTaskId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="taskEdit('<%=task.getTaskId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="taskDelete('<%=task.getTaskId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>任务查询</h1>
		</div>
		<form name="taskQueryForm" id="taskQueryForm" action="<%=basePath %>Task/frontlist" class="mar_t15">
            <div class="form-group">
            	<label for="workObj_activityId">所属工作：</label>
                <select id="workObj_activityId" name="workObj.activityId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ActivityInfo activityInfoTemp:activityInfoList) {
	 					String selected = "";
 					if(workObj!=null && workObj.getActivityId()!=null && workObj.getActivityId().intValue()==activityInfoTemp.getActivityId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=activityInfoTemp.getActivityId() %>" <%=selected %>><%=activityInfoTemp.getActivityTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="title">任务标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入任务标题">
			</div>






			<div class="form-group">
				<label for="pubTime">发布时间:</label>
				<input type="text" id="pubTime" name="pubTime" class="form-control"  placeholder="请选择发布时间" value="<%=pubTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="taskState">任务状态:</label>
				<input type="text" id="taskState" name="taskState" value="<%=taskState %>" class="form-control" placeholder="请输入任务状态">
			</div>






			<div class="form-group">
				<label for="endTime">任务截止时间:</label>
				<input type="text" id="endTime" name="endTime" class="form-control"  placeholder="请选择任务截止时间" value="<%=endTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="takeUser">接手用户:</label>
				<input type="text" id="takeUser" name="takeUser" value="<%=takeUser %>" class="form-control" placeholder="请输入接手用户">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="taskEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;任务信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="taskEditForm" id="taskEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="task_taskId_edit" class="col-md-3 text-right">任务id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="task_taskId_edit" name="task.taskId" class="form-control" placeholder="请输入任务id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="task_workObj_activityId_edit" class="col-md-3 text-right">所属工作:</label>
		  	 <div class="col-md-9">
			    <select id="task_workObj_activityId_edit" name="task.workObj.activityId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_title_edit" class="col-md-3 text-right">任务标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="task_title_edit" name="task.title" class="form-control" placeholder="请输入任务标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_taskContent_edit" class="col-md-3 text-right">任务内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="task_taskContent_edit" name="task.taskContent" rows="8" class="form-control" placeholder="请输入任务内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_pubTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date task_pubTime_edit col-md-12" data-link-field="task_pubTime_edit">
                    <input class="form-control" id="task_pubTime_edit" name="task.pubTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_taskState_edit" class="col-md-3 text-right">任务状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="task_taskState_edit" name="task.taskState" class="form-control" placeholder="请输入任务状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_endTime_edit" class="col-md-3 text-right">任务截止时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date task_endTime_edit col-md-12" data-link-field="task_endTime_edit">
                    <input class="form-control" id="task_endTime_edit" name="task.endTime" size="16" type="text" value="" placeholder="请选择任务截止时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_takeUser_edit" class="col-md-3 text-right">接手用户:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="task_takeUser_edit" name="task.takeUser" class="form-control" placeholder="请输入接手用户">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_workRecord_edit" class="col-md-3 text-right">工作日志记录:</label>
		  	 <div class="col-md-9">
			    <textarea id="task_workRecord_edit" name="task.workRecord" rows="8" class="form-control" placeholder="请输入工作日志记录"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#taskEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxTaskModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.taskQueryForm.currentPage.value = currentPage;
    document.taskQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.taskQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.taskQueryForm.currentPage.value = pageValue;
    documenttaskQueryForm.submit();
}

/*弹出修改任务界面并初始化数据*/
function taskEdit(taskId) {
	$.ajax({
		url :  basePath + "Task/" + taskId + "/update",
		type : "get",
		dataType: "json",
		success : function (task, response, status) {
			if (task) {
				$("#task_taskId_edit").val(task.taskId);
				$.ajax({
					url: basePath + "ActivityInfo/listAll",
					type: "get",
					success: function(activityInfos,response,status) { 
						$("#task_workObj_activityId_edit").empty();
						var html="";
		        		$(activityInfos).each(function(i,activityInfo){
		        			html += "<option value='" + activityInfo.activityId + "'>" + activityInfo.activityTitle + "</option>";
		        		});
		        		$("#task_workObj_activityId_edit").html(html);
		        		$("#task_workObj_activityId_edit").val(task.workObjPri);
					}
				});
				$("#task_title_edit").val(task.title);
				$("#task_taskContent_edit").val(task.taskContent);
				$("#task_pubTime_edit").val(task.pubTime);
				$("#task_taskState_edit").val(task.taskState);
				$("#task_endTime_edit").val(task.endTime);
				$("#task_takeUser_edit").val(task.takeUser);
				$("#task_workRecord_edit").val(task.workRecord);
				$('#taskEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除任务信息*/
function taskDelete(taskId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Task/deletes",
			data : {
				taskIds : taskId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#taskQueryForm").submit();
					//location.href= basePath + "Task/frontlist";
				}
				else 
					alert(data.message);
			},
		});
	}
}

/*ajax方式提交任务信息表单给服务器端修改*/
function ajaxTaskModify() {
	$.ajax({
		url :  basePath + "Task/" + $("#task_taskId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#taskEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#taskQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*发布时间组件*/
    $('.task_pubTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*任务截止时间组件*/
    $('.task_endTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

