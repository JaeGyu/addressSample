package com.cafe24.jaegyu;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.cafe24.jaegyu.address.AddressDAO;
import com.cafe24.jaegyu.address.AddressService;
import com.cafe24.jaegyu.address.AddressServiceImpl;
import com.cafe24.jaegyu.address.AddressVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	@Inject
	AddressDAO dao;
	
	@Resource(name="addressServiceImpl")
	AddressService addressService;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
				DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);

		return "home";
	}
	
	@RequestMapping(value = "/list.json", method = RequestMethod.GET,
			headers = "Accept=application/json", 
			produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody
	Object getListJSON() throws Exception {
		logger.info("get json...........");

		Map<String, Object> map = new HashMap<String,  Object>();
		
		map.put("address", addressService.list());
		map.put("success", "true");
		
		return map;
	}
	
	/*
	 * 업데이트를 하고나서 "list.json"을 호출하여 view와 싱크를 맞출 수도 있다.
	 * */
	@RequestMapping(value = "/update.json", method = RequestMethod.POST,
			headers = "Accept=application/json", 
			produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody
	Object setAddress(@RequestBody String json) throws Exception {
		 Collection<AddressVO> parsedAddresses = this.parseAddressJson(json);
		 
		boolean updateResult =  addressService.modifyAddressInfo(parsedAddresses);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(updateResult == true){
			map.put("success", "true");
		}else{
			map.put("success", "false");
		}

		return map;
	}
	
	@RequestMapping(value="/address",method = RequestMethod.GET)
	public String address(){
		return "address";
	}
	
	@RequestMapping(value="/restgrid",method=RequestMethod.GET)
	public String restGrid(){
		return "restGrid";
	}
	
	@RequestMapping(value="/extjs",method=RequestMethod.GET)
	public String extjs(){
		return "extjs";
	}
	
	/*
	 * JSON데이터를 VO로 변환시킨다.
	 * */
	private Collection<AddressVO> parseAddressJson(String json) throws Exception {
		try {
			if (json.startsWith("[") && json.endsWith("]")) {
				// array of users
				ObjectMapper mapper = new ObjectMapper();
				TypeReference ref = new TypeReference<Collection<AddressVO>>() {
				};
				Collection<AddressVO> user = (Collection<AddressVO>) mapper
						.readValue(json, ref);
				return user;
			} else {
				// Single object
				ObjectMapper mapper = new ObjectMapper();
				Collection<AddressVO> users = new ArrayList<AddressVO>();
				users.add((AddressVO) mapper.readValue(json, AddressVO.class));
				return users;
			}
		} catch (Exception ex) {
			throw new RuntimeException("Invalid AddressVO  Json");
		}
	}
}
