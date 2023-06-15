package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ActivityInfo {
    /*活动id*/
    private Integer activityId;
    public Integer getActivityId(){
        return activityId;
    }
    public void setActivityId(Integer activityId){
        this.activityId = activityId;
    }

    /*活动标题*/
    @NotEmpty(message="活动标题不能为空")
    private String activityTitle;
    public String getActivityTitle() {
        return activityTitle;
    }
    public void setActivityTitle(String activityTitle) {
        this.activityTitle = activityTitle;
    }

    /*活动内容*/
    @NotEmpty(message="活动内容不能为空")
    private String activityContent;
    public String getActivityContent() {
        return activityContent;
    }
    public void setActivityContent(String activityContent) {
        this.activityContent = activityContent;
    }

    /*活动图片*/
    private String activityPhoto;
    public String getActivityPhoto() {
        return activityPhoto;
    }
    public void setActivityPhoto(String activityPhoto) {
        this.activityPhoto = activityPhoto;
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

    /*活动截止时间*/
    @NotEmpty(message="活动截止时间不能为空")
    private String endTime;
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonActivityInfo=new JSONObject(); 
		jsonActivityInfo.accumulate("activityId", this.getActivityId());
		jsonActivityInfo.accumulate("activityTitle", this.getActivityTitle());
		jsonActivityInfo.accumulate("activityContent", this.getActivityContent());
		jsonActivityInfo.accumulate("activityPhoto", this.getActivityPhoto());
		jsonActivityInfo.accumulate("pubTime", this.getPubTime().length()>19?this.getPubTime().substring(0,19):this.getPubTime());
		jsonActivityInfo.accumulate("endTime", this.getEndTime().length()>19?this.getEndTime().substring(0,19):this.getEndTime());
		return jsonActivityInfo;
    }}