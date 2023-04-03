package com.mrxu.stucomplarear2.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.dto.AdminFindDto;
import com.mrxu.stucomplarear2.entity.Admin;
import com.mrxu.stucomplarear2.utils.response.Result;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-04-02
 */
public interface AdminService extends IService<Admin> {

    Result addAdmin(String username, String password, Integer roleId);

    Result login(String username, String password, HttpServletResponse response);

    Admin getAdminByAdminId(String adminId);

    Map<String, Object> findAdminList(AdminFindDto adminFindDto);

    Result changePassword(String oldPassword, String inPassword, String secondPassword, HttpServletRequest request);

    Result changeMyUsername(String username, HttpServletRequest request);

    Result changeRole(Integer adminId, Integer roleId);

    Result deleteAdmin(Integer adminId);
}
