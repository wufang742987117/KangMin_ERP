package com.yidu.dao;

import java.util.List;
import java.util.Map;

import com.yidu.model.ErpStaff;

public interface ErpStaffMapper {
    int deleteByPrimaryKey(String staId);

    int insert(ErpStaff record);

    int insertSelective(ErpStaff record);

    ErpStaff selectByPrimaryKey(String staId);

    int updateByPrimaryKeySelective(ErpStaff record);

    int updateByPrimaryKey(ErpStaff record);
    
    ErpStaff getUser(ErpStaff record);
    
    int findRowCount(ErpStaff staff);
    
    List<ErpStaff>findAll(ErpStaff staff);
    
    List<ErpStaff>getStaff();
    
    int updateById(String staId);
    
    int updateEmpPhoto(ErpStaff record);
    
    int getPhone(String staEmail);
    
    int updateUser(ErpStaff record);
    
    int getPwd(ErpStaff record);
    
    int updatePwd(ErpStaff record);
    
    
}