package com.example.demo.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.example.demo.domain.UserInfo;

public interface UserInfoService {

	/**通过username查找用户信息;*/
    public UserInfo findByUsername(String username);
    
    public List<UserInfo> findAll();
    
    public List<UserInfo> find(String name,String state);
    
    public UserInfo save(UserInfo user);
    
    public Page<UserInfo> findByNameAndStatePageable(String name, String state,Pageable pageable);
   
}
