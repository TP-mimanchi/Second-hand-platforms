package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.entity.Role;
import com.mrxu.stucomplarear2.mapper.RoleMapper;
import com.mrxu.stucomplarear2.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-01
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public Set<String> getRolesByUserId(Integer userId) {
        return roleMapper.selectRolesByUserId(userId);
    }

    @Override
    public Set<String> getRolesByAdminId(Integer adminId) {
        return roleMapper.selectRolesByAdminId(adminId);
    }
}
