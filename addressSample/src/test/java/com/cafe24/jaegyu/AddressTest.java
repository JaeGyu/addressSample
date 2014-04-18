package com.cafe24.jaegyu;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cafe24.jaegyu.address.AddressDAO;
import com.cafe24.jaegyu.address.AddressService;
import com.cafe24.jaegyu.address.AddressVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/**/*-context.xml"})
public class AddressTest {

	@Inject
	AddressDAO dao;
	
	@Resource(name="addressServiceImpl")
	AddressService addressService;
	
	@Test
	public void testName() throws Exception {
		List<AddressVO> list = dao.getAll();
		System.out.println(list);
	}
	
	@Test
	public void testServiceImpl() throws Exception {
		System.out.println(addressService);
		addressService.list();
//		System.out.println(list);
	}
	
	@Test
	public void testUpdateAddress() throws Exception {
		Collection<AddressVO> c = new ArrayList<AddressVO>();
		
		AddressVO addressVO = new AddressVO();
		addressVO.setId(5);
		addressVO.setName("홍길동");
		addressVO.setAddress("서울시 구로동 66-99");
		addressVO.setTel("010-0101-0101");
		
		c.add(addressVO);
		
		assertEquals(true, addressService.modifyAddressInfo(c));
	}
	
}