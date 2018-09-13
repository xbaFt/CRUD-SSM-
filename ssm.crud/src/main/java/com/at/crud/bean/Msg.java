package com.at.crud.bean;

import java.util.HashMap;
import java.util.Map;

//返回通用信息
public class Msg {
	//状态码 成功-100 失败-200
	private int code;
	//提示信息
	private String msg;
	//返回给用户的数据
	private Map<String,Object> extend = new HashMap<String, Object>();
	
	//处理成功
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("请求成功");
		return result;
	}
	
	//处理失败
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("请求失败");
		return result;
	}
	
	//返回用户自定义对象
	public Msg add(String key,Object value){
		this.getExtend().put(key, value);
		return this;
	}
	public int getCode() {
		return code;
	}
	
	public void setCode(int code) {
		this.code = code;
	}
	
	public String getMsg() {
		return msg;
	}
	
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public Map<String, Object> getExtend() {
		return extend;
	}
	
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	
}
