package com.cafe24.jaegyu.address;

public class KeyStringForMenuVO {
	private String keyString;

	public KeyStringForMenuVO(String keyString) {
		super();
		this.keyString = keyString;
	}

	public String getKeyString() {
		return keyString;
	}

	public void setKeyString(String keyString) {
		this.keyString = keyString;
	}

	@Override
	public String toString() {
		return "KeyStringForMenuVO [keyString=" + keyString + "]";
	}
}
