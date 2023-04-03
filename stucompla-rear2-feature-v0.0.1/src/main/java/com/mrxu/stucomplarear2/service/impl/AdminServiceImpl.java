package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.AdminFindDto;
import com.mrxu.stucomplarear2.entity.Admin;
import com.mrxu.stucomplarear2.mapper.AdminMapper;
import com.mrxu.stucomplarear2.service.AdminService;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.redis.RedisUtil;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-04-02
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {

    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private RedisUtil redisUtil;

    @Override
    public Result addAdmin(String username, String password, Integer roleId) {
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            return Result.fail("账号密码不能为空");
        }
        if (password.length() > 16 || password.length() < 6) {
            return Result.fail("密码长度只能在6~16位");
        }
        if (username.length() > 10 || username.length() < 3) {
            return Result.fail("用户名长度只能在3-10位");
        }
        if (roleId == 2 || roleId == 3) {
            //查询是否有重名
            QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("username", username);
            if (adminMapper.selectOne(queryWrapper) != null) {
                return Result.fail("该管理员已存在");
            }
            //没有重名则添加
            Admin admin = new Admin();
            admin.setUsername(username);
            admin.setRoleId(roleId);
            adminMapper.insert(admin);

            admin.setPassword(String.valueOf(new SimpleHash("SHA-1",
                    password, //原始密码
                    admin.getAdminId().toString(),//用用户id当盐值
                    16))); //加密次数
            adminMapper.updateById(admin);
            return Result.succ("添加成功");
        } else {
            return Result.fail("角色参数错误");
        }

    }

    @Override
    public Result login(String username, String password, HttpServletResponse response) {
        //查询管理员是否存在
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        Admin admin_temp = adminMapper.selectOne(queryWrapper);

        queryWrapper.eq("password", String.valueOf(new SimpleHash("SHA-1",
                password, //输入的原始密码
                admin_temp.getAdminId().toString(),//用户id当盐值
                16)));
        Admin admin = adminMapper.selectOne(queryWrapper);
        if (admin == null) {
            return Result.fail("用户名或密码错误！");
        }
        long currentTimeMillis = System.currentTimeMillis();
        String token = JWTUtil.createToken(String.valueOf(admin.getAdminId()), currentTimeMillis, "Admin");
        redisUtil.set("Admin" + admin.getAdminId(), currentTimeMillis, 60 * 30);//redis里存30分钟
        (response).setHeader("Authorization", token);
        (response).setHeader("Access-Control-Expose-Headers", "Authorization");//前端可以拿到这个响应头
        return Result.succ(200, "登陆成功", token);
    }

    @Override
    public Admin getAdminByAdminId(String adminId) {
        return adminMapper.selectById(adminId);
    }

    @Override
    public Map<String, Object> findAdminList(AdminFindDto adminFindDto) {
        int pageNum = adminFindDto.getPageNum() == null ? 1 : adminFindDto.getPageNum();
        int pageSize = adminFindDto.getPageSize() == null ? 4 : adminFindDto.getPageSize();
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        if (adminFindDto.getAdminId() != null) {
            queryWrapper.eq("admin_id", adminFindDto.getAdminId());
        }
        if (StringUtils.isNotBlank(adminFindDto.getUsername())) {
            queryWrapper.like("username", adminFindDto.getUsername());
        }
        if (adminFindDto.getRoleId() != null) {
            queryWrapper.eq("role_id", adminFindDto.getRoleId());
        }
        if ("+id".equals(adminFindDto.getSort())) {
            queryWrapper.orderByAsc("admin_id"); //根据admin_id升序排列
        } else {
            queryWrapper.orderByDesc("admin_id"); //根据admin_id降序排列
        }
        //当前页 页面大小
        IPage<Admin> page = new Page<Admin>(pageNum, pageSize);


        IPage<Admin> adminIPage = adminMapper.selectPage(page, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", adminIPage.getCurrent());//当前页
        map.put("total", adminIPage.getTotal());//总记录数
        map.put("pages", adminIPage.getPages());//总页数
        map.put("pageSize", adminIPage.getSize());//页面大小
        map.put("adminList", adminIPage.getRecords());//数据
        return map;
    }

    @Override
    public Result changePassword(String oldPassword, String inPassword, String secondPassword, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (StringUtils.isBlank(inPassword)) {
                return Result.fail("密码不能为空");
            }
            if (!inPassword.equals(secondPassword)) {
                return Result.fail("重复密码不匹配");
            }
            if (inPassword.length() > 16 || inPassword.length() < 6) {
                return Result.fail("密码长度只能在6~16位");
            }
            Admin admin = adminMapper.selectById(userId);
            oldPassword = String.valueOf(new SimpleHash("SHA-1",
                    oldPassword, //原始密码
                    admin.getAdminId().toString(),//用用户id当盐值
                    16));
            inPassword = String.valueOf(new SimpleHash("SHA-1",
                    inPassword, //原始密码
                    admin.getAdminId().toString(),//用用户id当盐值
                    16));
            if (!admin.getPassword().equals(oldPassword)) {
                return Result.fail("旧密码不正确");
            }
            admin.setPassword(inPassword);
            adminMapper.updateById(admin);
            return Result.succ("修改成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result changeMyUsername(String username, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            if (StringUtils.isBlank(username)) {
                return Result.fail("用户名不能为空");
            }
            if (username.length() < 3 || username.length() > 10) {
                return Result.fail("用户名长度只能在3-10位");
            }
            //查询是否有重名
            QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("username", username);
            if (adminMapper.selectOne(queryWrapper) != null) {
                return Result.fail("该用户名已存在");
            }

            Admin admin = adminMapper.selectById(userId);
            admin.setUsername(username);
            adminMapper.updateById(admin);
            return Result.succ("修改成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result changeRole(Integer adminId, Integer roleId) {
        try {
            if (adminId != null && (roleId == 2 || roleId == 3)) {
                Admin admin = adminMapper.selectById(adminId);
                if (admin == null) {
                    return Result.fail("该管理员不存在");
                }
                admin.setRoleId(roleId);
                adminMapper.updateById(admin);
                return Result.succ("修改成功");
            } else {
                return Result.fail("参数错误");
            }
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result deleteAdmin(Integer adminId) {
        try {
            if (adminId != null) {
                Admin admin = adminMapper.selectById(adminId);
                if (admin == null) {
                    return Result.fail("该管理员不存在");
                }
                adminMapper.deleteById(adminId);
                return Result.succ("删除成功");
            } else {
                return Result.fail("参数错误");
            }
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }


}
