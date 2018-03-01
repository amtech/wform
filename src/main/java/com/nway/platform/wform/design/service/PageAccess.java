package com.nway.platform.wform.design.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.nway.platform.wform.access.dao.PageMapper;
import com.nway.platform.wform.access.mybatis.MybatisMapper;
import com.nway.platform.wform.component.ComponentRegister;
import com.nway.platform.wform.component.MultiValueComponent;
import com.nway.platform.wform.component.impl.KeyComponent;
import com.nway.platform.wform.design.db.TableGenerator;
import com.nway.platform.wform.design.entity.Field;
import com.nway.platform.wform.design.entity.Page;
import com.nway.platform.wform.design.entity.PageForm;
import com.nway.platform.wform.design.entity.PageList;
import com.nway.platform.wform.design.entity.PageListCondition;

@Component
public class PageAccess {

	@Autowired
	private PageMapper formPageMapper;
	
	@Autowired
	private ComponentRegister componentRegister;
	
	@Autowired
	private MybatisMapper mybatisMapper;
	
	@Autowired
	private TableGenerator tableGenerator;
	
	public Page getFormPage(String id) {
		
		Page page = formPageMapper.getFormPage(id);
		
 		for (PageForm field : page.getFormFields()) {

			field.setObjType(componentRegister.getComponent(field.getType()));
			
			if(KeyComponent.class.isInstance(field.getObjType())) {
				
				page.setKeyName(field.getName());
			}
			
			if(MultiValueComponent.class.isInstance(field.getObjType())) {
				
				field.setMultiValue(true);
			}
		}
 		
 		for (PageList field : page.getListFields()) {
 			
 			field.setObjType(componentRegister.getComponent(field.getType()));
 			
 			if(MultiValueComponent.class.isInstance(field.getObjType())) {
				
				field.setMultiValue(true);
			}
 		}
 		
 		for (PageListCondition field : page.getListCondition()) {
 			
 			field.setObjType(componentRegister.getComponent(field.getType()));
 			
 			if(MultiValueComponent.class.isInstance(field.getObjType())) {
 				
 				field.setMultiValue(true);
 			}
 		}
		
		return page;
	}
	
	public Map<String, Map<String, String>> listFieldAttr(String pageId) {		
		
		List<Map<String, String>> attrOrgin = formPageMapper.listFieldAttr(pageId);
		
		Map<String, Map<String, String>> retVal = new HashMap<String,Map<String,String>>();
		
		for(Map<String, String> row : attrOrgin) {
			
			Map<String, String> groupRow = retVal.get(row.get("fieldName"));
			
			if(groupRow != null) {
				
				groupRow.put(row.get("attrName"), row.get("attrValue"));
			}
			else {
				
				groupRow = new HashMap<String, String>();
				
				groupRow.put(row.get("attrName"), row.get("attrValue"));
				
				retVal.put(row.get("fieldName"), groupRow);
			}
		}
		
		return retVal;
	}
	
	public void saveFields(List<Map<String, Map<String, String>>> fields) {

		for (Map<String, Map<String, String>> field : fields) {

			Map<String, String> base = field.get("baseAttr");
			Map<String, String> ext = field.get("extAttr");
			Map<String, String> custom = field.get("customAttr");
			
			String fieldId = UUID.randomUUID().toString();
			
			base.put("fieldId", fieldId);
			ext.put("fieldId", fieldId);
			
			formPageMapper.saveFieldBase(base);
			
			if (ext.size() > 0) {
				
				formPageMapper.saveFieldExt(ext);
			}
			
			if (custom.size() > 0) {
				
				Map<String,String> customAttrs = new HashMap<String, String>();
				
				for(Entry<String, String> entry : custom.entrySet()) {
					
					customAttrs.put("attrName", entry.getKey());
					customAttrs.put("attrValue", entry.getValue());
				}
				
				customAttrs.put("pageId", base.get("pageId"));
				customAttrs.put("fieldName", base.get("name"));
				
				formPageMapper.saveFieldCustom(customAttrs);
			}
		}
	}
	
	public void publishPage(String pageId) throws Exception {
		
		Page page = formPageMapper.getFormPage(pageId);
		
		mybatisMapper.createMapper(page);
		
		tableGenerator.createTable(page);
	}
	
	public List<Field> listFields(String pageId) {
		
		return formPageMapper.listFields(pageId);
	}
}
