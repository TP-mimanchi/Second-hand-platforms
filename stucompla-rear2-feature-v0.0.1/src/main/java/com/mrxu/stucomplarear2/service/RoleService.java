package com.mrxu.stucomplarear2.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.entity.Role;

import java.util.Set;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-01
 */
public interface RoleService extends IService<Role> {

    Set<String> getRolesByUserId(Integer userId);

    Set<String> getRolesByAdminId(Integer adminId);
}
