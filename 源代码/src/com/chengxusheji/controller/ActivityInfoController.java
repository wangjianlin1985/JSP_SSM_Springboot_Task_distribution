package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ActivityInfoService;
import com.chengxusheji.po.ActivityInfo;

//ActivityInfo管理控制层
@Controller
@RequestMapping("/ActivityInfo")
public class ActivityInfoController extends BaseController {

    /*业务层对象*/
    @Resource ActivityInfoService activityInfoService;

	@InitBinder("activityInfo")
	public void initBinderActivityInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("activityInfo.");
	}
	/*跳转到添加ActivityInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ActivityInfo());
		return "ActivityInfo_add";
	}

	/*客户端ajax方式提交添加工作活动信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ActivityInfo activityInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			activityInfo.setActivityPhoto(this.handlePhotoUpload(request, "activityPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        activityInfoService.addActivityInfo(activityInfo);
        message = "工作活动添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询工作活动信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String activityTitle,String pubTime,String endTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (activityTitle == null) activityTitle = "";
		if (pubTime == null) pubTime = "";
		if (endTime == null) endTime = "";
		if(rows != 0)activityInfoService.setRows(rows);
		List<ActivityInfo> activityInfoList = activityInfoService.queryActivityInfo(activityTitle, pubTime, endTime, page);
	    /*计算总的页数和总的记录数*/
	    activityInfoService.queryTotalPageAndRecordNumber(activityTitle, pubTime, endTime);
	    /*获取到总的页码数目*/
	    int totalPage = activityInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = activityInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ActivityInfo activityInfo:activityInfoList) {
			JSONObject jsonActivityInfo = activityInfo.getJsonObject();
			jsonArray.put(jsonActivityInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询工作活动信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ActivityInfo> activityInfoList = activityInfoService.queryAllActivityInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ActivityInfo activityInfo:activityInfoList) {
			JSONObject jsonActivityInfo = new JSONObject();
			jsonActivityInfo.accumulate("activityId", activityInfo.getActivityId());
			jsonActivityInfo.accumulate("activityTitle", activityInfo.getActivityTitle());
			jsonArray.put(jsonActivityInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询工作活动信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String activityTitle,String pubTime,String endTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (activityTitle == null) activityTitle = "";
		if (pubTime == null) pubTime = "";
		if (endTime == null) endTime = "";
		List<ActivityInfo> activityInfoList = activityInfoService.queryActivityInfo(activityTitle, pubTime, endTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    activityInfoService.queryTotalPageAndRecordNumber(activityTitle, pubTime, endTime);
	    /*获取到总的页码数目*/
	    int totalPage = activityInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = activityInfoService.getRecordNumber();
	    request.setAttribute("activityInfoList",  activityInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("activityTitle", activityTitle);
	    request.setAttribute("pubTime", pubTime);
	    request.setAttribute("endTime", endTime);
		return "ActivityInfo/activityInfo_frontquery_result"; 
	}

     /*前台查询ActivityInfo信息*/
	@RequestMapping(value="/{activityId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer activityId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键activityId获取ActivityInfo对象*/
        ActivityInfo activityInfo = activityInfoService.getActivityInfo(activityId);

        request.setAttribute("activityInfo",  activityInfo);
        return "ActivityInfo/activityInfo_frontshow";
	}

	/*ajax方式显示工作活动修改jsp视图页*/
	@RequestMapping(value="/{activityId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer activityId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键activityId获取ActivityInfo对象*/
        ActivityInfo activityInfo = activityInfoService.getActivityInfo(activityId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonActivityInfo = activityInfo.getJsonObject();
		out.println(jsonActivityInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新工作活动信息*/
	@RequestMapping(value = "/{activityId}/update", method = RequestMethod.POST)
	public void update(@Validated ActivityInfo activityInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String activityPhotoFileName = this.handlePhotoUpload(request, "activityPhotoFile");
		if(!activityPhotoFileName.equals("upload/NoImage.jpg"))activityInfo.setActivityPhoto(activityPhotoFileName); 


		try {
			activityInfoService.updateActivityInfo(activityInfo);
			message = "工作活动更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "工作活动更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除工作活动信息*/
	@RequestMapping(value="/{activityId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer activityId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  activityInfoService.deleteActivityInfo(activityId);
	            request.setAttribute("message", "工作活动删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "工作活动删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条工作活动记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String activityIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = activityInfoService.deleteActivityInfos(activityIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出工作活动信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String activityTitle,String pubTime,String endTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(activityTitle == null) activityTitle = "";
        if(pubTime == null) pubTime = "";
        if(endTime == null) endTime = "";
        List<ActivityInfo> activityInfoList = activityInfoService.queryActivityInfo(activityTitle,pubTime,endTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "ActivityInfo信息记录"; 
        String[] headers = { "活动标题","活动图片","发布时间","活动截止时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<activityInfoList.size();i++) {
        	ActivityInfo activityInfo = activityInfoList.get(i); 
        	dataset.add(new String[]{activityInfo.getActivityTitle(),activityInfo.getActivityPhoto(),activityInfo.getPubTime(),activityInfo.getEndTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"ActivityInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
