package com.at.crud.dao;

import com.at.crud.bean.Departement;
import com.at.crud.bean.DepartementExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepartementMapper {
    long countByExample(DepartementExample example);

    int deleteByExample(DepartementExample example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Departement record);

    int insertSelective(Departement record);

    List<Departement> selectByExample(DepartementExample example);

    Departement selectByPrimaryKey(Integer deptId);

    int updateByExampleSelective(@Param("record") Departement record, @Param("example") DepartementExample example);

    int updateByExample(@Param("record") Departement record, @Param("example") DepartementExample example);

    int updateByPrimaryKeySelective(Departement record);

    int updateByPrimaryKey(Departement record);
}