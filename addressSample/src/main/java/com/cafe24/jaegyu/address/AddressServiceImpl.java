package com.cafe24.jaegyu.address;

import java.util.Collection;
import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;

@Service("addressServiceImpl")
public class AddressServiceImpl implements AddressService {

	private static final int SUCCESS_VALUE = 1; 

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
			if (resultOfUpdate != SUCCESS_VALUE) {
				result = false;
			}
		}

		return result;
	}

	@Override
	public boolean insertAddressInfo(Collection<AddressVO> parsedAddresses) {
		boolean result = true;

		for (AddressVO addressVO : parsedAddresses) {

			// insert시 컬렉션으로 하는 법 적용 할 것
			int resultOfInsert = dao.insert(addressVO);
			if(resultOfInsert != SUCCESS_VALUE){
				result = false;
			}
		}

		return result;
	}

	@Override
	public boolean deleteAddress(Collection<AddressVO> parsedAddresses) {
		boolean result = true;

		for (AddressVO addressVO : parsedAddresses) {
			int resultOfDelete = dao.delete(addressVO);
			if(resultOfDelete != SUCCESS_VALUE){
				result = false;
			}
		}

		return result;
	}
}
