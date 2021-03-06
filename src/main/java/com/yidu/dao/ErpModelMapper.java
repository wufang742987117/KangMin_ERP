package com.yidu.dao;

import java.util.List;

import com.yidu.model.ErpModel;

public interface ErpModelMapper {
    int deleteByPrimaryKey(String modelId);

    int insert(ErpModel record);

    int insertSelective(ErpModel record);

    ErpModel selectByPrimaryKey(String modelId);

    int updateByPrimaryKeySelective(ErpModel record);

    int updateByPrimaryKey(ErpModel record);
    
    List<ErpModel> findAllModel (String staName);
    
    List<ErpModel> getModel (String roleId);
    
    List<ErpModel> findAll(ErpModel record);
    
    int findRowCount(ErpModel record);
    
    List<ErpModel> getErpModel();
    
    int deleteModel(String roleId);
    
    List<ErpModel>addBelow(String modelId);
    
    List<ErpModel> finModel();
    
    int updateSubordinate (String modelId);
    
}