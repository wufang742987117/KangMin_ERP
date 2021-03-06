/**
 * XLe1丶
 * 2017年10月24日 2017年8月1日16:02:52
 */
package com.yidu.service.ErpDepa;

import java.util.List;
import java.util.Map;

import com.yidu.model.ErpDepa;

/**
 * @author XLe1丶
 * 2017年10月24日
 */
public interface ErpDepaService {
	
    List<ErpDepa>getDepa();
    
    /**
     * 模糊、分页查询部门集合
     * @author 胡鑫
     * @date 2017年10月30日09:00:55
     * @param map map集合 用于存放分页对象 搜索对象....
     * @return 返回部门集合
     */
    public List<ErpDepa> depaFindList(Map<String,Object> map);
    
    /**
     * 模糊部门集合   行数
     * @author 胡鑫
     * @date 2017年10月30日09:00:55
     * @param map map集合 用于存放 搜索对象....
     * @return 返回部门集合
     */
    public int depaFindListRows(Map<String,Object> map);
    
    /**
     * 部门增加
     * @author 胡鑫
     * @date 2017年10月30日15:34:49
     * @param record 部门实体类
     * @return 返回执行的行数
     */
    public int insertSelective(ErpDepa record);
    /**
     * 根据部门id查询部门信息
     * @author 胡鑫
     * @date 2017年10月31日09:25:12
     * @param depaId 部门id
     * @return 返回部门类
     */
    public ErpDepa selectByPrimaryKey(String depaId);
    
    /**
     * 根据部门id修改部门信息
     * @author 胡鑫
     * @date 2017年10月31日15:30:25
     * @param record 部门对象
     * @return 返回执行的行数
     */
    int updateByPrimaryKeySelective(ErpDepa record);
    
    /**
     * 根据部门id删除该部门(修改该部门状态isva为1)
     * @author 胡鑫
     * @date 2017年11月1日11:43:30
     * @param depaId 部门id
     * @return 返回执行的行数
     */
    public int deleteByDepaId(String depaId);
}
