package com.cafe24.jaegyu.address;

import java.util.List;

public interface AddressDAO {

	public List<AddressVO> getAll() throws Exception;

	public int update(AddressVO addressVO);
}
