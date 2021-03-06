package com.yidu.dao;

import com.yidu.model.ErpPurchaseDetails;
/**
 * 订单详细表
 * @author Gjwen
 * 2017年10月26日-下午2:46:26
 */
public interface ErpPurchaseDetailsMapper {
    int deleteByPrimaryKey(String purDetId);
    /**
     * 增加
     * @param record
     * @return
     */
    int insert(String[] rawId);

    int insertSelective(ErpPurchaseDetails record);

    ErpPurchaseDetails selectByPrimaryKey(String purDetId);

    int updateByPrimaryKeySelective(ErpPurchaseDetails record);

    int updateByPrimaryKey(ErpPurchaseDetails record);
}