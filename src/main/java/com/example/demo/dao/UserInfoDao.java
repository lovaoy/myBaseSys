package com.example.demo.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
/** jpa 方式*/
import org.springframework.data.repository.CrudRepository;

import com.example.demo.domain.UserInfo;

public interface UserInfoDao extends CrudRepository<UserInfo,Long> {
    //通过username查找用户信息;
    public UserInfo findByUsername(String username);
    //查找所有用户
    public List<UserInfo> findAll();
    
    //根据username和state查询，其中username为模糊查询
    @Query(value = "select * from user_info where if(?1 !='',name like %?1%,1=1) and if(?2 !='',state=?2,1=1)",nativeQuery = true)
    public List<UserInfo> find(String name,String state);
    //添加用户
    public UserInfo save(UserInfo user);
    
    @Query(value = "select * from user_info where if(?1 !='',name like %?1%,1=1) and if(?2 !='',state=?2,1=1)",
    		countQuery="select count(*) from user_info where if(?1 !='',name like %?1%,1=1) and if(?2 !='',state=?2,1=1)",
    		nativeQuery = true)
    Page<UserInfo> findByNameAndStatePageable(String name, String state, Pageable pageable);
    
   
}
/** mybatis 方式 ，无法取出userifno中的role list
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.UserInfo;

public interface UserInfoDao {
    //通过username查找用户信息;
	@Select("select * from user_info where username = '${username}'")
    UserInfo findByUsername(@Param("username") String username);
}*/
