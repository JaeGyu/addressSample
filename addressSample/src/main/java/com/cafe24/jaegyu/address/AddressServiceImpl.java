package com.cafe24.jaegyu.address;

import java.util.Collection;
import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;

@Service("addressServiceImpl")
public class AddressServiceImpl implements AddressService {

	private static final int UPDATE_SUCCESS_VALUE = 1;
	
	@Inject
	AddressDAO dao;

	@Override
	public List<AddressVO> list() throws Exception {
		return dao.getAll();
	}

	@Override
	public boolean modifyAddressInfo(Collection<AddressVO> parsedAddresses) {
		boolean result = true;

		for (AddressVO addressVO : parsedAddresses) {
			int resultOfUpdate = dao.update(addressVO);
			if (resultOfUpdate != UPDATE_SUCCESS_VALUE) {
				result = false;
			}
		}

		return result;
	}
}
