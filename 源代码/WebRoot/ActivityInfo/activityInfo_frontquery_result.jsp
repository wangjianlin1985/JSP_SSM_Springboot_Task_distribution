<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ActivityInfo> activityInfoList = (List<ActivityInfo>)request.getAttribute("activityInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String activityTitle = (String)request.getAttribute("activityTitle"); //活动标题查询关键字
    String pubTime = (String)request.getAttribute("pubTime"); //发布时间查询关键字
    String endTime = (String)request.getAttribute("endTime"); //活动截止时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>工作活动查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>ActivityInfo/frontlist">工作活动信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>ActivityInfo/activityInfo_frontAdd.jsp" style="display:none;">添加工作活动</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<activityInfoList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		ActivityInfo activityInfo = activityInfoList.get(i); //获取到工作活动对象
            		String clearLeft = "";
            		if(i%3 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-4 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>ActivityInfo/<%=activityInfo.getActivityId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=activityInfo.getActivityPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		活动标题:<%=activityInfo.getActivityTitle() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=activityInfo.getPubTime() %>
			     	</div>
			     	<div class="field">
	            		活动截止时间:<%=activityInfo.getEndTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>ActivityInfo/<%=activityInfo.getActivityId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="activityInfoEdit('<%=activityInfo.getActivityId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="activityInfoDelete('<%=activityInfo.getActivityId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>工作活动查询</h1>
		</div>
		<form name="activityInfoQueryForm" id="activityInfoQueryForm" action="<%=basePath %>ActivityInfo/frontlist" class="mar_t15">
			<div class="form-group">
				<label for="activityTitle">活动标题:</label>
				<input type="text" id="activityTitle" name="activityTitle" value="<%=activityTitle %>" class="form-control" placeholder="请输入活动标题">
			</div>
			<div class="form-group">
				<label for="pubTime">发布时间:</label>
				<input type="text" id="pubTime" name="pubTime" class="form-control"  placeholder="请选择发布时间" value="<%=pubTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="endTime">活动截止时间:</label>
				<input type="text" id="endTime" name="endTime" class="form-control"  placeholder="请选择活动截止时间" value="<%=endTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="activityInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;工作活动信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="activityInfoEditForm" id="activityInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="activityInfo_activityId_edit" class="col-md-3 text-right">活动id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="activityInfo_activityId_edit" name="activityInfo.activityId" class="form-control" placeholder="请输入活动id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="activityInfo_activityTitle_edit" class="col-md-3 text-right">活动标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="activityInfo_activityTitle_edit" name="activityInfo.activityTitle" class="form-control" placeholder="请输入活动标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_activityContent_edit" class="col-md-3 text-right">活动内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="activityInfo_activityContent_edit" name="activityInfo.activityContent" rows="8" class="form-control" placeholder="请输入活动内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_activityPhoto_edit" class="col-md-3 text-right">活动图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="activityInfo_activityPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="activityInfo_activityPhoto" name="activityInfo.activityPhoto"/>
			    <input id="activityPhotoFile" name="activityPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_pubTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date activityInfo_pubTime_edit col-md-12" data-link-field="activityInfo_pubTime_edit">
                    <input class="form-control" id="activityInfo_pubTime_edit" name="activityInfo.pubTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="activityInfo_endTime_edit" class="col-md-3 text-right">活动截止时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date activityInfo_endTime_edit col-md-12" data-link-field="activityInfo_endTime_edit">
                    <input class="form-control" id="activityInfo_endTime_edit" name="activityInfo.endTime" size="16" type="text" value="" placeholder="请选择活动截止时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#activityInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxActivityInfoModify();">提交</button>
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
    document.activityInfoQueryForm.currentPage.value = currentPage;
    document.activityInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.activityInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.activityInfoQueryForm.currentPage.value = pageValue;
    documentactivityInfoQueryForm.submit();
}

/*弹出修改工作活动界面并初始化数据*/
function activityInfoEdit(activityId) {
	$.ajax({
		url :  basePath + "ActivityInfo/" + activityId + "/update",
		type : "get",
		dataType: "json",
		success : function (activityInfo, response, status) {
			if (activityInfo) {
				$("#activityInfo_activityId_edit").val(activityInfo.activityId);
				$("#activityInfo_activityTitle_edit").val(activityInfo.activityTitle);
				$("#activityInfo_activityContent_edit").val(activityInfo.activityContent);
				$("#activityInfo_activityPhoto").val(activityInfo.activityPhoto);
				$("#activityInfo_activityPhotoImg").attr("src", basePath +　activityInfo.activityPhoto);
				$("#activityInfo_pubTime_edit").val(activityInfo.pubTime);
				$("#activityInfo_endTime_edit").val(activityInfo.endTime);
				$('#activityInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除工作活动信息*/
function activityInfoDelete(activityId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ActivityInfo/deletes",
			data : {
				activityIds : activityId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#activityInfoQueryForm").submit();
					//location.href= basePath + "ActivityInfo/frontlist";
				}
				else 
					alert(data.message);
			},
		});
	}
}

/*ajax方式提交工作活动信息表单给服务器端修改*/
function ajaxActivityInfoModify() {
	$.ajax({
		url :  basePath + "ActivityInfo/" + $("#activityInfo_activityId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#activityInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#activityInfoQueryForm").submit();
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
    $('.activityInfo_pubTime_edit').datetimepicker({
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
    /*活动截止时间组件*/
    $('.activityInfo_endTime_edit').datetimepicker({
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

