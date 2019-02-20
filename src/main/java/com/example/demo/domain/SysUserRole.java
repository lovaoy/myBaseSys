package com.example.demo.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 关联用户的角色
 * @author ylmac
 *
 */
@Entity
public class SysUserRole {

	@Id
	@Column(name="uid")
	private Integer uid;
	private Integer roleId;
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	
	
	
}
