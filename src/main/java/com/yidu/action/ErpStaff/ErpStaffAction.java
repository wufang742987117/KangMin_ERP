/**
 * XLe1丶
 * 2017年10月19日 2017年8月1日16:02:52
 */
package com.yidu.action.ErpStaff;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yidu.model.ErpAnnex;
import com.yidu.model.ErpDepa;
import com.yidu.model.ErpModel;
import com.yidu.model.ErpModelSubordinate;
import com.yidu.model.ErpPersonelRole;
import com.yidu.model.ErpRole;
import com.yidu.model.ErpStaff;
import com.yidu.service.ErpDepa.ErpDepaService;
import com.yidu.service.ErpModel.ErpModelService;
import com.yidu.service.ErpModelSubordinate.ErpModelSubordinateService;
import com.yidu.service.ErpModelSubordinate.ErpModelSubordinateServiceImpl;
import com.yidu.service.ErpPersonelRole.ErpPersonelRoleService;
import com.yidu.service.ErpRole.ErpRoleService;
import com.yidu.service.ErpStaff.ErpStaffService;
import com.yidu.service.annex.AnnexService;
import com.yidu.util.Pages;
import com.yidu.util.SsmMessage;
import com.yidu.util.Upload;

/**
 * @author XLe1丶
 * 2017年10月19日
 */
@Controller
@RequestMapping("staff")
public class ErpStaffAction {
	
	
	@Resource
	private ErpStaffService staffService;
	
	@Resource
	private ErpModelService modelService;
	
	@Resource
	private ErpModelSubordinateService modelSubService;
	
	@Resource
	private ErpDepaService depaService;
	
	@Resource
	private ErpRoleService roleService;
	
	@Resource
	private ErpPersonelRoleService personelRoleService;
	
	@Resource
	private AnnexService annexService;
	
	
	@RequestMapping("login")
	@ResponseBody
	public SsmMessage login(ErpStaff staff,HttpServletRequest request,HttpSession session,HttpServletResponse response) throws ServletException, IOException{
		System.out.println("进入方法"+staff.getStaEmail()+"               "+staff.getStaPwd());
		ErpStaff rows = staffService.getUser(staff);
		SsmMessage mes = new SsmMessage();
		if(rows!=null){
			session.setAttribute("staff", rows);
			mes.setMes("ok");
			return mes;
		}else{
			System.out.println("妹纸");
			mes.setMes("no");
			return mes;
		}
		
	}
	
	@RequestMapping("findAllModel")
	public ModelAndView findAllModel(HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException{
		ErpStaff staff = (ErpStaff) session.getAttribute("staff");
		if(staff!=null){
			List<ErpModel>list = modelService.findAllModel(staff.getStaEmail());
			List<ErpModel>list2 = modelService.getModel(staff.getRoleId());
			request.setAttribute("model", list);
			request.setAttribute("modelSub", list2);
			ModelAndView view = new ModelAndView("homePage");
			return view; 
		}else{
			return null;
		}
		
		
	}
	
	
	@ResponseBody
	@RequestMapping("findAll")
	public Map<String, Object>findAll(ErpStaff staff,int page ,int limit){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("搜索框中的值为："+staff.getRoleName());
		Pages pages = new Pages();
		pages.setCurPage(page);
		pages.setMaxResult(limit);
		staff.setPage(pages.getFirstRows());
		staff.setLimit(limit);
		List<ErpStaff>list = staffService.findAll(staff);
		map.put("count", staffService.findRowCount(staff));
		map.put("data", list);
		map.put("code",0);
		map.put("msg", "");
		return map;
		
	}
	
	@ResponseBody
	@RequestMapping("getStaff")
	public String getStaff() throws JsonProcessingException{
		ObjectMapper objectMapper = new ObjectMapper();
		List<ErpStaff>list = staffService.getStaff();
		String jsonString = objectMapper.writeValueAsString(list);
		System.out.println(jsonString);
		return jsonString;
		
	}
	
	
	@ResponseBody
	@RequestMapping("getDepa")
	public String getDepa() throws JsonProcessingException{
		ObjectMapper objectMapper = new ObjectMapper();
		List<ErpDepa>list = depaService.getDepa();
		String jsonString = objectMapper.writeValueAsString(list);
		System.out.println("部门的json是"+jsonString);
		return jsonString;
	}
	
	@RequestMapping("updateById")
	@ResponseBody
	public String updateById(String id){
		staffService.updateById(id);
		return null;
		
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
	
	
	@ResponseBody
	@RequestMapping("add")
	public SsmMessage add(ErpStaff staff){
		System.out.println("人员id+++++++++++++++++++"+staff.getAnnexId());
		SsmMessage mes = new SsmMessage();
		if("".equals(staff.getStaId()) || null==staff.getStaId()){
			staff.setIsva(1);
			staff.setStaId(UUID.randomUUID().toString());
			staffService.insertSelective(staff);
			ErpPersonelRole role = new ErpPersonelRole();
			role.setStaId(staff.getStaId());
			role.setRoleId(staff.getRoleId());
			role.setPerRoleId(UUID.randomUUID().toString());
			personelRoleService.insertSelective(role);
			mes.setMes("add");
		}else{
			System.out.println("进入了修改方法"+staff.getDepaId()+"     人员id"+staff.getRoleId()+"       "+staff.getPerRoleId());
			staffService.updateByPrimaryKeySelective(staff);
			ErpPersonelRole role = new ErpPersonelRole();
			role.setStaId(staff.getStaId());
			role.setRoleId(staff.getRoleId());
			role.setPerRoleId(staff.getPerRoleId());
			personelRoleService.updateByPrimaryKeySelective(role);
			mes.setMes("update");
		}
		return mes;
	}
	
	
	@RequestMapping("/updateEmpPhoto")
	@ResponseBody  //ajax注解
	public String updateEmpPhoto(@RequestParam(value = "file", required = false) MultipartFile file, 
					HttpServletRequest request){
			String id = request.getParameter("id");
			ErpStaff staff = new ErpStaff();
		 	System.out.println("来到上传文件方法++++++++++++++++++++++++++++++++++++++++++++"+id);
		 	String path = "E://save";
		 	String fileName = UUID.randomUUID()+".png";
	        System.out.println("path:"+path+",fileName:"+fileName);
	        File targetFile = new File(path, fileName);
	        if(!targetFile.exists()){
	            targetFile.mkdirs();
	        }
	        //保存
	        try {
	            file.transferTo(targetFile);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        staff.setStaImg("/upload/"+fileName);
	        staff.setStaId(id);
	        staffService.updateEmpPhoto(staff);
	        return "result";
	}
	
	@RequestMapping("getPhone")
	@ResponseBody
	public SsmMessage getPhone(String staEmail){
		SsmMessage mes = new SsmMessage();
		int rows = staffService.getPhone(staEmail);
		System.out.println("进来==============================================");
		if(rows>0){
			mes.setMes("no");
		}
		return mes;
	}
	
	@RequestMapping("getPwd")
	@ResponseBody
	public SsmMessage getPwd(String staPwd,HttpSession session){
		SsmMessage mes = new SsmMessage();
		ErpStaff staff = (ErpStaff) session.getAttribute("staff");
		ErpStaff sta = new ErpStaff();
		sta.setStaId(staff.getStaId());
		sta.setStaPwd(staPwd);
		int rows = staffService.getPwd(sta);
		System.out.println("进来==============================================");
		if(rows>0){
			mes.setMes("ok");
		}else{
			mes.setMes("no");
		}
		return mes;
	}
	
	
	@ResponseBody
	@RequestMapping("getAnnex")
	public List<ErpAnnex> getAnnex(){
		System.out.println("进来了。。。。。。。。。。。。。。。");
		List<ErpAnnex>list = annexService.getAnnex();
		return list;
	}
	
	@ResponseBody
	@RequestMapping("updateUser")
	public SsmMessage updateUser(ErpStaff staff,HttpSession session){
		SsmMessage mes = new SsmMessage();
		int rows = staffService.updateUser(staff);
		ErpStaff s = (ErpStaff) session.getAttribute("staff");
		staff.setStaPwd(s.getStaPwd());
		if(rows>0){
			ErpStaff sta = staffService.getUser(staff);
			session.setAttribute("staff", sta);
			mes.setMes("ok");
		}
		return mes;
	}
	
	
	@ResponseBody
	@RequestMapping("updatePwd")
	public SsmMessage updatePwd(ErpStaff staff,HttpSession session){
		SsmMessage mes = new SsmMessage();
		int rows = staffService.updatePwd(staff);
		ErpStaff s = (ErpStaff) session.getAttribute("staff");
		staff.setStaEmail(s.getStaEmail());
		if(rows>0){
			ErpStaff sta = staffService.getUser(staff);
			session.setAttribute("staff", sta);
			mes.setMes("ok");
		}
		return mes;
	}
	
	
	@ResponseBody
	@RequestMapping("updateUserImg")
	public Upload  updateUserImg(MultipartFile file,HttpSession session){
		Upload upload = new Upload();
		ErpStaff staff = (ErpStaff) session.getAttribute("staff");
		ErpStaff sta = new ErpStaff();
		String name = file.getOriginalFilename();
		String suffixName = name.substring(name.lastIndexOf("."));
		String hash = UUID.randomUUID().toString();
		String fileName = hash+suffixName;
		String path = "E://save";
		File tempFile = new File(path,fileName);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		try {
			file.transferTo(tempFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		sta.setStaImg("/upload/"+fileName);
		sta.setStaId(staff.getStaId());
		int rows = staffService.updateEmpPhoto(sta);
		if(rows>0){
			upload.setStatus("0");
			upload.setUrl("/upload/"+fileName);
			ErpStaff s = (ErpStaff) session.getAttribute("staff");
			staff.setStaEmail(s.getStaEmail());
			staff.setStaPwd(s.getStaPwd());
			ErpStaff staa = staffService.getUser(staff);
			session.setAttribute("staff", staa);
		}
		System.out.println("进入修改图片的方法。。。。。。。。。。。"+"/upload/"+fileName+"         "+staff.getStaId());
		return upload;
	}
	
	/**
	 * 查询所有总人数方法
	 * @return 人员数量
	 * @author ouyang
	 * @dateTime 2017年12月12日08:36:47
	 */
	@ResponseBody
	@RequestMapping("/findAllSize")
	public int findAllSize(){
		return staffService.findRowCount(new ErpStaff());
	}
	/**
	 * 注销(清空session)
	 * @param session HttpSession
	 * @return 是否成功
	 * @author ouyang
	 * @dataTime 2017年12月7日13:33:19
	 */
	@ResponseBody
	@RequestMapping("/deleteSession")
	public void deleteSession(HttpSession session){
		session.removeAttribute("staff");
	}
}
