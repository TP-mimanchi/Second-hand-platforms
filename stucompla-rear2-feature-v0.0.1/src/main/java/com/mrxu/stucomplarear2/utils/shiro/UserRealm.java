package com.mrxu.stucomplarear2.utils.shiro;

import com.auth0.jwt.exceptions.TokenExpiredException;
import com.mrxu.stucomplarear2.entity.User;
import com.mrxu.stucomplarear2.service.RoleService;
import com.mrxu.stucomplarear2.service.UserService;
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


public class UserRealm extends AuthorizingRealm {

    @Resource
    private UserService userService;
    @Resource
    private RoleService roleService;
    @Autowired
    private RedisUtil redisUtil;

    /**
     * 根据authenticationToken里的jwt的loginType判断此Authenticator是否使用该realm
     */
    @Override
    public boolean supports(AuthenticationToken authenticationToken) {
        return JWTUtil.getLoginType((String) authenticationToken.getPrincipal()).contains("User");
    }

    /**
     * 只有当需要检测用户权限的时候才会调用此方法，例如@RequiresRoles,@RequiresPermissions之类的
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        System.out.println("user doGetAuthorizationInfo");
        String token = principals.toString();
        String userId = JWTUtil.getUserId(token);
        User user = userService.getUserByUserId(userId);
        // 从数据库获取用户的角色信息
        Set<String> roles = roleService.getRolesByUserId(user.getUserId());
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(roles);
        return info;
    }

    /**
     * 默认使用此方法进行认证，错误抛出异常即可，在需要用户认证和鉴权的时候才会调用
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println(" user doGetAuthenticationInfo");
        String jwt = (String) token.getCredentials();
        String userId;
        try {
            userId = JWTUtil.getUserId(jwt);
        } catch (Exception e) {
            throw new AuthenticationException("token非法，不是规范的token，可能被篡改了，或者过期了");
        }
        if (userId == null) {
            throw new AuthenticationException("token中无用户Id");
        }
        User user = userService.getUserByUserId(userId);
        if(user.getLocked()){
            throw new AuthenticationException("该账户已被锁定，请联系管理员1452162669@qq.com");
        }
        if (user == null) {
            throw new AuthenticationException("该用户不存在");
        }
        //开始认证，只要AccessToken没有过期，或者refreshToken的时间节点和AccessToken一致即可
        if (redisUtil.hasKey("User" + userId)) {
            //判断AccessToken有无过期
            if (!JWTUtil.verify(jwt)) {
                throw new TokenExpiredException("token认证失效，token过期，重新登陆");
            } else {
                //判断AccessToken和refreshToken的时间节点是否一致
                long current = (long) redisUtil.get("User" + userId);
                if (current == JWTUtil.getExpire(jwt)) {
                    return new SimpleAuthenticationInfo(jwt, jwt, "UserRealm");
                } else {
                    throw new AuthenticationException("token已经失效，请重新登录！");
                }
            }
        } else {
            throw new AuthenticationException("token过期或者Token错误！！");
        }
    }

}
