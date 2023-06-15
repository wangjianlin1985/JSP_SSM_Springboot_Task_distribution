package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Task;

public interface TaskMapper {
	/*添加任务信息*/
	public void addTask(Task task) throws Exception;

	/*按照查询条件分页查询任务记录*/
	public ArrayList<Task> queryTask(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有任务记录*/
	public ArrayList<Task> queryTaskList(@Param("where") String where) throws Exception;

	/*按照查询条件的任务记录数*/
	public int queryTaskCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条任务记录*/
	public Task getTask(int taskId) throws Exception;

	/*更新任务记录*/
	public void updateTask(Task task) throws Exception;

	/*删除任务记录*/
	public void deleteTask(int taskId) throws Exception;

}
