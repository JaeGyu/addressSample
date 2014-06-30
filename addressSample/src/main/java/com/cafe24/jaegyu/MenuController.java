package com.cafe24.jaegyu;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.jaegyu.address.KeyStringForMenuVO;
import com.cafe24.jaegyu.address.MenuVO;

public class MenuController {
	
	@ResponseBody
	@RequestMapping(value="/testMenu.json")
	public Object getTestMenu(){
		List<MenuVO> parentMenu = new ArrayList<MenuVO>();
		List<MenuVO> childMenu = new ArrayList<MenuVO>();
		
		MenuVO evnSettingMusic = new MenuVO();
		evnSettingMusic.setId("EvnSetting");
		evnSettingMusic.setText("MusicEvent");
		evnSettingMusic.setQueryInfo(new KeyStringForMenuVO("1"));
		evnSettingMusic.setLeaf(true);
		evnSettingMusic.setChildren(null);
		
		MenuVO evnListMovie = new MenuVO();
		evnListMovie.setId("EvnSetting");
		evnListMovie.setText("MovieEvent");
		evnListMovie.setQueryInfo(new KeyStringForMenuVO("13"));
		evnListMovie.setLeaf(true);
		evnListMovie.setChildren(null);
		
		childMenu.add(evnSettingMusic);
		childMenu.add(evnListMovie);
		
		MenuVO evnList = new MenuVO();
		evnList.setId("EvnListController");
		evnList.setText("Events");
		evnList.setQueryInfo(new KeyStringForMenuVO(""));
		evnList.setLeaf(false);
		evnList.setChildren(childMenu);
		
		parentMenu.add(evnList);
		
		return parentMenu;
	}
}
