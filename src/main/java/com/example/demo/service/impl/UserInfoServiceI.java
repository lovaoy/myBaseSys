package com.example.demo.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.demo.dao.UserInfoDao;
import com.example.demo.domain.UserInfo;
import com.example.demo.service.UserInfoService;

@Service
public class UserInfoServiceI implements UserInfoService {
	
	@Resource
    private UserInfoDao userInfoDao;
    @Override
    public UserInfo findByUsername(String username) {
        System.out.println("UserInfoServiceImpl.findByUsername()");
        return userInfoDao.findByUsername(username);
    }

    @Override
    public List<UserInfo> findAll(){
    	System.out.println("UserInfoServiceImpl.findAll()");
    	return userInfoDao.findAll();
    }
    
    @Override
    public List<UserInfo> find(String name,String state){
    	System.out.println("UserInfoServiceImpl.find()");
    	return userInfoDao.find(name, state);
    }
    
    @Override
    public UserInfo save(UserInfo user) {
    	System.out.println("UserInfoServiceImpl.save()");
    	return userInfoDao.save(user);
    }
    
    @Override
    public Page<UserInfo>  findByNameAndStatePageable(String name, String state,Pageable pageable){
    	System.out.println("UserInfoServiceImpl.findByNameAndStatePageable(Pageable pageable,String name, String state)");
    	return userInfoDao.findByNameAndStatePageable(name,state,pageable);
    	
    }
   
}
