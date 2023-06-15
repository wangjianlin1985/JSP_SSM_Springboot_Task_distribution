package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Task {
    /*任务id*/
    private Integer taskId;
    public Integer getTaskId(){
        return taskId;
    }
    public void setTaskId(Integer taskId){
        this.taskId = taskId;
    }

    /*所属工作*/
    private ActivityInfo workObj;
    public ActivityInfo getWorkObj() {
        return workObj;
    }
    public void setWorkObj(ActivityInfo workObj) {
        this.workObj = workObj;
    }

    /*任务标题*/
    @NotEmpty(message="任务标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*任务内容*/
    @NotEmpty(message="任务内容不能为空")
    private String taskContent;
    public String getTaskContent() {
        return taskContent;
    }
    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String pubTime;
    public String getPubTime() {
        return pubTime;
    }
    public void setPubTime(String pubTime) {
        this.pubTime = pubTime;
    }

    /*任务状态*/
    @NotEmpty(message="任务状态不能为空")
    private String taskState;
    public String getTaskState() {
        return taskState;
    }
    public void setTaskState(String taskState) {
        this.taskState = taskState;
    }

    /*任务截止时间*/
    @NotEmpty(message="任务截止时间不能为空")
    private String endTime;
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    /*接手用户*/
    @NotEmpty(message="接手用户不能为空")
    private String takeUser;
    public String getTakeUser() {
        return takeUser;
    }
    public void setTakeUser(String takeUser) {
        this.takeUser = takeUser;
    }

    /*工作日志记录*/
    private String workRecord;
    public String getWorkRecord() {
        return workRecord;
    }
    public void setWorkRecord(String workRecord) {
        this.workRecord = workRecord;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTask=new JSONObject(); 
		jsonTask.accumulate("taskId", this.getTaskId());
		jsonTask.accumulate("workObj", this.getWorkObj().getActivityTitle());
		jsonTask.accumulate("workObjPri", this.getWorkObj().getActivityId());
		jsonTask.accumulate("title", this.getTitle());
		jsonTask.accumulate("taskContent", this.getTaskContent());
		jsonTask.accumulate("pubTime", this.getPubTime().length()>19?this.getPubTime().substring(0,19):this.getPubTime());
		jsonTask.accumulate("taskState", this.getTaskState());
		jsonTask.accumulate("endTime", this.getEndTime().length()>19?this.getEndTime().substring(0,19):this.getEndTime());
		jsonTask.accumulate("takeUser", this.getTakeUser());
		jsonTask.accumulate("workRecord", this.getWorkRecord());
		return jsonTask;
    }}