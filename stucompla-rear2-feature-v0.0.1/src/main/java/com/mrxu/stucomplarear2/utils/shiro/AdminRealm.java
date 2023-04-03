package com.mrxu.stucomplarear2.utils.shiro;

import com.auth0.jwt.exceptions.TokenExpiredException;
import com.mrxu.stucomplarear2.entity.Admin;
import com.mrxu.stucomplarear2.service.AdminService;
import com.mrxu.stucomplarear2.service.RoleService;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.redis.RedisUtil;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import java.util.Set;


public class AdminRealm extends AuthorizingRealm {

    @Resource
    private AdminService adminService;
    @Resource
    private RoleService roleService;
    @Autowired
    private RedisUtil redisUtil;

    //根据token判断此Authenticator是否使用该realm
    //必须重写不然shiro会报错
    @Override
    public boolean supports(AuthenticationToken token) {
        System.out.println("admin supports()");
        System.out.println(JWTUtil.getLoginType((String) token.getPrincipal()).contains("Admin"));
        return JWTUtil.getLoginType((String) token.getPrincipal()).contains("Admin");
    }

    /**
     * 只有当需要检测用户权限的时候才会调用此方法，例如@RequiresRoles,@RequiresPermissions之类的
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        System.out.println(" admin doGetAuthorizationInfo");
        String token = principals.toString();
        String adminId = JWTUtil.getUserId(token);
        Admin admin = adminService.getAdminByAdminId(adminId);
        // 查询数据库，获取用户的角色信息
        Set<String> roles = roleService.getRolesByAdminId(admin.getAdminId());
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(roles);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println(" admin doGetAuthenticationInfo");
        String jwt = (String) token.getCredentials();
        String adminId;
        try {
            adminId = JWTUtil.getUserId(jwt);
        } catch (Exception e) {
            throw new AuthenticationException("token非法，不是规范的token，可能被篡改了，或者过期了");
        }
        if (adminId == null) {
            throw new AuthenticationException("token中无adminId");
        }
        Admin admin = adminService.getAdminByAdminId(adminId);
        if (admin == null) {
            throw new AuthenticationException("该管理员不存在");
        }
        //开始认证，只要AccessToken没有过期，或者refreshToken的时间节点和AccessToken一致即可
        if (redisUtil.hasKey("Admin" + adminId)) {
            //判断AccessToken有无过期
            if (!JWTUtil.verify(jwt)) {
                throw new TokenExpiredException("token认证失效，token过期，重新登陆");
            } else {
                //判断AccessToken和refreshToken的时间节点是否一致
                long current = (long) redisUtil.get("Admin" + adminId);
                if (current == JWTUtil.getExpire(jwt)) {
                    return new SimpleAuthenticationInfo(jwt, jwt, "AdminRealm");
                } else {
                    throw new AuthenticationException("token已经失效，请重新登录！");
                }
            }
        } else {
            throw new AuthenticationException("token过期或者Token错误！！");
        }
    }
}
