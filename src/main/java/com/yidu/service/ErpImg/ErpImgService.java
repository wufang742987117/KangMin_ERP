/**
 * 
 */
package com.yidu.service.ErpImg;

import java.util.List;
import java.util.Map;

import com.yidu.model.ErpImg;

/**
 * 图片
 * @author 大晶儿
 * 2017年10月26日
 */
public interface ErpImgService {
	/**
	 * 添加单个对象
	 * @param record
	 * @return
	 */
    int insert(ErpImg record);
    /**
     * 选择添加
     * @param record
     * @return 
     */
    int insertSelective(String imgUrl,String rawId);
    /**
     * 添加药品图片
     * @param imgUrl img地址
     * @param kinId 药品编号
     * @return int
     */
    int insertSelectiveKin(String imgUrl,String kinId);
    /**
     * 修改
     * @param record
     * @return
     */
    int updateImg(ErpImg record);
    /**
     * 查询单个产品的图片
     * @param ID
     * @return
     */
    List<ErpImg> findImg(Map map);
    /**
     * 查询所有的原材料图片
     * @return
     */
    List<ErpImg> findImgRaw();
}
