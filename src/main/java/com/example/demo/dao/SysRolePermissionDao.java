package com.example.demo.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.domain.SysRolePermission;

public interface SysRolePermissionDao extends CrudRepository<SysRolePermission,Long>{

	@Modifying
	@Transactional
	@Query(value="delete from sys_role_permission where role_id = ?1",nativeQuery = true)
	public void deleteByRoleId(Integer roleId);
	
	@Modifying
	@Transactional
	@Query(value="insert into sys_role_permission (role_id, permission_id) values( ?1, ?2)",nativeQuery = true)
	public void save(Integer roleId, Integer permissionId);
}
