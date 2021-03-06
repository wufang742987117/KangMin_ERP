/**
 * XLe1丶
 * 2017年11月3日 2017年8月1日16:02:52
 */
package com.yidu.action.ErpRole;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yidu.model.ErpModel;
import com.yidu.model.ErpRole;
import com.yidu.model.ErpRoleModel;
import com.yidu.model.ErpRoleModelSubordinate;
import com.yidu.model.ErpStaff;
import com.yidu.service.ErpModel.ErpModelService;
import com.yidu.service.ErpRole.ErpRoleService;
import com.yidu.service.ErpRoleModel.ErpRoleModelService;
import com.yidu.service.ErpRoleModelSubordinate.ErpRoleModelSubordinateService;
import com.yidu.util.Pages;
import com.yidu.util.SsmMessage;
import com.yidu.util.ZTree;

/**
 * @author XLe1丶
 * 2017年11月3日
 */
@Controller
@RequestMapping("role")
public class ErpRoleAction {
	
	@Resource
	private ErpRoleService roleService;
	
	
	@Resource
	private ErpModelService modelService;
	
	@Resource
	private ErpRoleModelService roleModelService;
	
	@Resource
	private ErpRoleModelSubordinateService roleModelSubService;
	
	@RequestMapping("findAll")
	@ResponseBody
	public Map<String,Object>findAll(ErpRole role,int page ,int limit){
		Map<String, Object> map = new HashMap<String, Object>();
		Pages pages = new Pages();
		pages.setCurPage(page);
		pages.setMaxResult(limit);
		role.setPage(pages.getFirstRows());
		role.setLimit(limit);
		List<ErpRole>list = roleService.findAllRole(role);
		map.put("count", roleService.findRowCount(role));
		map.put("data", list);
		map.put("code",0);
		map.put("msg", "");
		return map;
		
	}
	
	@RequestMapping("getRole")
	@ResponseBody
	public String getRole() throws JsonProcessingException{
		ObjectMapper objectMapper = new ObjectMapper();
		List<ErpRole>list = roleService.findAll();
		String json = objectMapper.writeValueAsString(list);
		System.out.println("权限："+json);
		return json;
	}
	
	@RequestMapping("deleteRole")
	public void deleteRole(String roleId){
		roleService.deleteRole(roleId);
	}
	
	
	@ResponseBody
	@RequestMapping("add")
	public SsmMessage add(ErpRole role){
		SsmMessage mes = new SsmMessage();
		if("".equals(role.getRoleId()) || null==role.getRoleId()){
			role.setRoleId(UUID.randomUUID().toString());
			role.setIsva("1");
			roleService.insertSelective(role);
			mes.setMes("add");
		}else{
			roleService.updateByPrimaryKeySelective(role);
			mes.setMes("update");
		}
		return mes;
		
	}
	
	@RequestMapping("getRoleValue")
	@ResponseBody
	public List<ZTree> getRoleValue(String roleId){
		List<ZTree> tree= new ArrayList<ZTree>();
		List<ErpRole> list = roleService.getRoleValue(roleId);
		List<ErpModel> model = modelService.getModel(roleId);
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			ErpRole erpRole = (ErpRole) iterator.next();
			ZTree t = new ZTree();
			t.setId(erpRole.getModelId());
			t.setpId(erpRole.getErpModelId());
			t.setName(erpRole.getModelName());
			tree.add(t);
		}
		for (Iterator iterator = model.iterator(); iterator.hasNext();) {
			ErpModel erpModel = (ErpModel) iterator.next();
			for(int i = 0;i<tree.size();i++){
				if(tree.get(i).getId()==erpModel.getErpModelId() || tree.get(i).getId().equals(erpModel.getErpModelId())){
					ZTree t = new ZTree();
					t.setId(erpModel.getModelId());
					t.setName(erpModel.getModelName());
					t.setpId(erpModel.getErpModelId());
					tree.add(t);
				}
			}
		}
		return tree;
	}
	
	@RequestMapping("getModel")
	@ResponseBody
	public List<ZTree> getModel(String roleId){
		List<ZTree> tree= new ArrayList<ZTree>();
		List<ErpModel> model = modelService.finModel();
		List<ErpModel> model2 = modelService.getModel(roleId);
		List<ErpRoleModel> model3 = roleModelService.getMessage(roleId);
		for (Iterator iterator = model.iterator(); iterator.hasNext();) {
			ErpModel erpModel = (ErpModel) iterator.next();
			ZTree t = new ZTree();
			t.setId(erpModel.getModelId());
			t.setpId(erpModel.getErpModelId());
			t.setName(erpModel.getModelName());
			for (Iterator iterator2 = model2.iterator(); iterator2.hasNext();) {
				ErpModel erpModel2 = (ErpModel) iterator2.next();
				if(erpModel.getModelId().equals(erpModel2.getModelId())){
					t.setChecked("true");
				}
			}
			for (Iterator iterator2 = model3.iterator(); iterator2.hasNext();) {
				ErpRoleModel erpRoleModel = (ErpRoleModel) iterator2.next();
				if(erpModel.getModelId().equals(erpRoleModel.getModelId())){
					t.setChecked("true");
				}
			}
			tree.add(t);
			
		}
		return tree;
	}
	
	@RequestMapping("addModel")
	@ResponseBody
	public SsmMessage ModelAdd(String modelId,String roleId,String modelSubId){
		SsmMessage mes = new SsmMessage();
		String [] stringSplit = modelId.split(",");
		String [] stringSplit2 = modelSubId.split(",");
		System.out.println("stringSplit+++++++++++++++++++"+modelSubId+"         "+modelId);
		
		roleModelSubService.deleteByPrimaryKey(roleId);
		roleService.deleteModel(roleId);
		for(int i = 0;i<stringSplit.length;i++){
			ErpRoleModel model = new ErpRoleModel();
			model.setRoleModelId(UUID.randomUUID().toString());
			model.setRoleId(roleId);
			model.setModelId(stringSplit[i]);
			roleModelService.insertSelective(model);
		}
		
		for(int i = 0;i<stringSplit2.length;i++){
			ErpRoleModelSubordinate sub = new ErpRoleModelSubordinate();
			sub.setRoleId(roleId);
			sub.setModelId(stringSplit2[i]);
			sub.setSubId(UUID.randomUUID().toString());
			roleModelSubService.insertSelective(sub);
		}
		mes.setMes("ok");
		return mes;
	}
}
