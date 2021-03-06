/**
 * XLe1丶
 * 2017年11月7日 2017年8月1日16:02:52
 */
package com.yidu.action.ErpModel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yidu.model.ErpModel;
import com.yidu.service.ErpModel.ErpModelService;
import com.yidu.util.Pages;
import com.yidu.util.SsmMessage;

/**
 * @author XLe1丶
 * 2017年11月7日
 */
@Controller
@RequestMapping("model")
public class ErpModelAction {
	
	
	@Resource
	private ErpModelService modelService;
	
	@RequestMapping("findAll")
	@ResponseBody
	public Map<String,Object>findAll(ErpModel model,int page ,int limit){
		Map<String, Object> map = new HashMap<String, Object>();
		Pages pages = new Pages();
		pages.setCurPage(page);
		pages.setMaxResult(limit);
		model.setPage(pages.getFirstRows());
		model.setLimit(limit);
		List<ErpModel>list = modelService.findAll(model);
		map.put("count", modelService.findRowCount(model));
		map.put("data", list);
		map.put("code",0);
		map.put("msg", "");
		return map;
	}
	
	@RequestMapping("getErpModel")
	@ResponseBody
	public String getErpModel() throws JsonProcessingException{
		ObjectMapper objectMapper = new ObjectMapper();
		List<ErpModel>list = modelService.getErpModel();
		String json = objectMapper.writeValueAsString(list);
		System.out.println("model          ："+json);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("add")
	public SsmMessage add(ErpModel model){
		SsmMessage mes = new SsmMessage();
		if("".equals(model.getModelId()) || null==model.getModelId()){
			model.setModelId(UUID.randomUUID().toString());
			model.setIsva("1");
			model.setErpModelId("0");
			modelService.insertSelective(model);
			mes.setMes("add");
		}else{
			modelService.updateByPrimaryKeySelective(model);
			mes.setMes("update");
		}
		return mes;
		
	}
	
	
	@RequestMapping("deleteModel")
	@ResponseBody
	public SsmMessage deleteRole(String modelId){
		SsmMessage mes = new SsmMessage();
		int rows = modelService.deleteModel(modelId);
		if(rows>0){
			modelService.updateSubordinate(modelId);
			mes.setMes("ok");
		}
		return mes;
	}
	
	
	
	
	@RequestMapping("addBelow")
	public ModelAndView addBelow(String modelId){
		ModelAndView view = new ModelAndView("addBelow");
		List<ErpModel>list= modelService.addBelow(modelId);
		view.addObject("model", list);
		view.addObject("modelId", modelId);
		return view;
	}
	
	
	@RequestMapping("addBelowModel")
	@ResponseBody
	public SsmMessage addBelowModel(HttpServletRequest request,String modelId,ErpModel m){
		System.out.println("                    进来了。。。。。。。。。。");
		String[] modelName = request.getParameterValues("modelName");
		String[] modelCode = request.getParameterValues("modelCode");
		SsmMessage mes = new SsmMessage();
		if(modelName[0]!="" && modelCode[0]!=""){
			System.out.println("modelName.length"+modelName.length);
			for(int i =0;i<modelName.length;i++){
				if(modelName[i]!=""){
					ErpModel model = new ErpModel();
					model.setModelId(UUID.randomUUID().toString());
					model.setIsva("1");
					model.setModelCode(modelCode[i]);
					model.setModelName(modelName[i]);
					model.setErpModelId(modelId);
					modelService.insertSelective(model);
				}
			}
			mes.setMes("ok");
		}
		
		return mes;
	}
	
	
	
	@RequestMapping("updateBelowModel")
	@ResponseBody
	public SsmMessage updateBelowModel(HttpServletRequest request){
		SsmMessage mes = new SsmMessage();
		String[] modelId = request.getParameterValues("modelId");
		String[] modelName = request.getParameterValues("modelName");
		String[] modelCode = request.getParameterValues("modelCode");
		for(int i =0;i<modelId.length;i++){
			ErpModel model = new ErpModel();
			model.setModelId(modelId[i]);
			model.setModelName(modelName[i]);
			model.setModelCode(modelCode[i]);
			modelService.updateByPrimaryKeySelective(model);
		}
		mes.setMes("ok");
		return mes;
	}
	
}
