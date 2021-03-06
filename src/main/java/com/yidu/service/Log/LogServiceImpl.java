/**
 * 
 */
package com.yidu.service.Log;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yidu.dao.ErpLogMapper;
import com.yidu.model.ErpLog;

/**
 * 生产日志表service接口
 * @author dong
 * @data 2017年11月20日
 */
@Service
public class LogServiceImpl implements LogService{

	@Resource
	public ErpLogMapper erpLogMapper;
	
	/**
	 * 增加生产日志
	 */
	@Override
	public int insert(ErpLog record) {
		// TODO Auto-generated method stub
		return erpLogMapper.insert(record);
	}

	/**
	 * 查询所有
	 */
	@Override
	public List<ErpLog> selectshow(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return erpLogMapper.selectshow(map);
	}

	/**
	 * 总行数
	 */
	@Override
	public int select(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return erpLogMapper.select(map);
	}

}
