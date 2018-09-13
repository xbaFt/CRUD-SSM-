package com.at.crud.bean;

public class Departement {
    private Integer deptId;

    private String deptName;
    
    public Departement(Integer detId,String deptName) {
    	this.deptId = deptId;
    	this.deptName = deptName;
    }
    
    public Departement() {
		super();
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}