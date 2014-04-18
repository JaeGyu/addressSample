package com.cafe24.jaegyu.utils;

import java.util.ArrayList;
import java.util.Collection;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import com.cafe24.jaegyu.address.AddressDAO;
import com.cafe24.jaegyu.address.AddressVO;

public class Utils {
	
	
	/*
	 * JSON데이터를 VO로 변환시킨다.
	 * 추후 제네릭 적용하는 걸로 변경 할 것
	 * Utils 클래스로 추출 해서 관리 할 것   
	 * */
	public  Collection<AddressVO> parseAddressJson(String json) throws Exception {
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
				users.add((AddressVO) mapper.readValue(json, AddressDAO.class));
				return users;
			}
		} catch (Exception ex) {
			throw new RuntimeException("Invalid AddressVO  Json");
		}
	}
}
