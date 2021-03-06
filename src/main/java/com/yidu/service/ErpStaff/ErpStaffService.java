/**
 * XLe1丶
 * 2017年10月19日 2017年8月1日16:02:52
 */
package com.yidu.service.ErpStaff;

import java.util.List;
import java.util.Map;

import com.yidu.model.ErpModel;
import com.yidu.model.ErpStaff;

/**
 * @author XLe1丶
 * 2017年10月19日
 */
public interface ErpStaffService {
	ErpStaff getUser(ErpStaff staff);
	
	int findRowCount(ErpStaff staff);

    List<ErpStaff>findAll(ErpStaff staff);
    
    List<ErpStaff>getStaff();
    
    int updateById(String staId);
    
    int insertSelective(ErpStaff record);
    
    int updateByPrimaryKeySelective(ErpStaff record);
    
    int updateEmpPhoto(ErpStaff record);
    
    int getPhone(String staEmail);
    
    int updateUser(ErpStaff record);
    
    int getPwd(ErpStaff record);
    
    int updatePwd(ErpStaff record);
}
