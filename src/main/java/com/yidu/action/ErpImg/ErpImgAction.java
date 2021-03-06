/**
 * 
 */
package com.yidu.action.ErpImg;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yidu.model.ErpImg;
import com.yidu.service.ErpImg.ErpImgService;
import com.yidu.util.SsmMessage;

/**
 * 图片的action
 * @author 大晶儿
 * 2017年10月26日
 */
@Controller
@RequestMapping("ErpImgAction")
public class ErpImgAction {
	@Resource
	private ErpImgService service;
	/**
	 * 添加图片
	 * @param record 图片的对象
	 * @return 返回消息类
	 */
	@RequestMapping("insertSelective")
	@ResponseBody
	public SsmMessage insertSelective(@RequestParam(value = "file", required = false) MultipartFile file,String rawId){
		SsmMessage mes = new SsmMessage();
		String path = "E:\\T219\\img";
	 	String fileName = UUID.randomUUID()+".png";
        File targetFile = new File(path, fileName);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }
        //保存
        try {
        	System.out.println(targetFile);
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
            return mes;
        }
        String imgUrl = "/upload/"+fileName;
        int rows = service.insertSelective(imgUrl, rawId);
		if(rows<-1){
			mes.setState(0);
			mes.setMes("添加失败");
		}else{
			mes.setState(1);
			mes.setMes("添加成功");
		}
		return mes;
	}
	/**
	 * 添加图片
	 * @param record 图片的对象
	 * @return 返回消息类
	 */
	@RequestMapping("insertSelectiveKin")
	@ResponseBody
	public SsmMessage insertSelectiveKin(@RequestParam(value = "file", required = false) MultipartFile file,String kinId){
		System.out.println("----------------------------------------------------------"+kinId);
		SsmMessage mes = new SsmMessage();
		String path = "E:\\T219\\img";
	 	String fileName = UUID.randomUUID()+".png";
        File targetFile = new File(path, fileName);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }
        //保存
        try {
        	System.out.println(targetFile);
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
            return mes;
        }
        String imgUrl = "/upload/"+fileName;
        int rows = service.insertSelectiveKin(imgUrl, kinId);
		if(rows<-1){
			mes.setState(0);
			mes.setMes("添加失败");
		}else{
			mes.setState(1);
			mes.setMes("添加成功");
		}
		return mes;
	}
	/**
	 * 查询单个对象的图片
	 * @param map
	 * @return
	 */
	@RequestMapping("findImg")
	@ResponseBody
	public List<ErpImg> findImg(String pricer) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pricer",pricer );
		List<ErpImg> list = service.findImg(map);
		return list;
	}
	
}
