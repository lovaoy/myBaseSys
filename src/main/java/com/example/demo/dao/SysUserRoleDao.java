package com.example.demo.dao;


import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.UserInfo;

public interface SysUserRoleDao extends CrudRepository<UserInfo,Long> {

	@Modifying
	@Transactional
	@Query(value="delete from sys_user_role where uid = ?1",nativeQuery = true)
	public void deleteByUid(Integer uid);
	
	@Modifying
	@Transactional
	@Query(value="insert into sys_user_role (uid, role_id) values( ?1, ?2)",nativeQuery = true)
	public void save(Integer uid, Integer roleId);
}
