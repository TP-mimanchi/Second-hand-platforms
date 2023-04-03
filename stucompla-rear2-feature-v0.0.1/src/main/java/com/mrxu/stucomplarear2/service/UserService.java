package com.mrxu.stucomplarear2.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.dto.RegisterDto;
import com.mrxu.stucomplarear2.dto.UserEditDto;
import com.mrxu.stucomplarear2.dto.UserFindDto;
import com.mrxu.stucomplarear2.entity.User;
import com.mrxu.stucomplarear2.utils.response.Result;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-01
 */
public interface UserService extends IService<User> {

    String register(RegisterDto registerDto);

    User getUserByUsername(String username);

    User getUserByUserId(String userId);

    String changePassword(ServletRequest request, String oldPassword, String password, String secondPassword);

    Map<String, Object> findUserList(UserFindDto userFindDto);

    Result editUserInfo(UserEditDto userEditDto, HttpServletRequest request);

    Result changePwdByAdmin(String newPassword, String secondPassword,Integer userId);

    Result lockedUser(Integer userId, String cause);

    Result unLockUser(Integer userId);

    Result getUserTotal();
}
