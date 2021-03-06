package com.yidu.dao;

import java.util.List;
import java.util.Map;

import com.yidu.model.ErpImg;

public interface ErpImgMapper {
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
    int insertSelective(ErpImg record);
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
     * 查询raw的img
     * @return 返回list
     */
    List<ErpImg> findImgRaw();
    /**
     * 添加药品图片
     * @param imgUrl img地址
     * @param kinId 药品id
     * @return int
     */
    int insertSelectiveKin(String imgUrl,String kinId);
}