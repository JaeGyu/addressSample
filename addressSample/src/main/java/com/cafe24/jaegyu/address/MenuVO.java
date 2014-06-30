package com.cafe24.jaegyu.address;

import java.util.List;

public class MenuVO {
	private String id;
	private String text;
	private boolean leaf;
	private Object queryInfo;
	private List<MenuVO> children;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public boolean isLeaf() {
		return leaf;
	}

	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}

	public Object getQueryInfo() {
		return queryInfo;
	}

	public void setQueryInfo(Object queryInfo) {
		this.queryInfo = queryInfo;
	}

	public List<MenuVO> getChildren() {
		return children;
	}

	public void setChildren(List<MenuVO> children) {
		this.children = children;
	}

	@Override
	public String toString() {
		return "MenuVO [id=" + id + ", text=" + text + ", leaf=" + leaf
				+ ", queryInfo=" + queryInfo + ", children=" + children + "]";
	}
}
