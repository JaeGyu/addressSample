package com.cafe24.jaegyu.address;

import java.util.Collection;
import java.util.List;

public interface AddressService {

	public List<AddressVO> list() throws Exception;

	public boolean modifyAddressInfo(Collection<AddressVO> parsedAddresses);
}
