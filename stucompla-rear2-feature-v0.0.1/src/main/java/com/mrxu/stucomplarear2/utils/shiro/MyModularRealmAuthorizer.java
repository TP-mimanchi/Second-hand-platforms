package com.mrxu.stucomplarear2.utils.shiro;

import org.apache.shiro.authz.Authorizer;
import org.apache.shiro.authz.ModularRealmAuthorizer;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.subject.PrincipalCollection;

import java.util.Set;

public class MyModularRealmAuthorizer extends ModularRealmAuthorizer {

    @Override
    public boolean isPermitted(PrincipalCollection principals, String permission) {
        // 判断getRealms()是否返回为空
        assertRealmsConfigured();
        Set<String> realmNames = principals.getRealmNames();
        //获取realm的名字
        String realmName = realmNames.iterator().next();
        for (Realm realm : getRealms()) {
            if (!(realm instanceof Authorizer)) continue;
            //匹配名字
            if(realmName.contains("User")) {
                if (realm instanceof UserRealm) {
                    return ((UserRealm) realm).isPermitted(principals, permission);
                }
            }
            if(realmName.contains("Admin")) {
                if (realm instanceof AdminRealm) {
                    return ((AdminRealm) realm).isPermitted(principals, permission);
                }
            }
        }
        return false;
    }

    @Override
    public boolean hasRole(PrincipalCollection principals, String roleIdentifier) {
        // 判断getRealms()是否返回为空
        assertRealmsConfigured();
        Set<String> realmNames = principals.getRealmNames();
        //获取realm的名字
        String realmName = realmNames.iterator().next();
        for (Realm realm : getRealms()) {
            if (!(realm instanceof Authorizer)) continue;
            //匹配名字
            if(realmName.contains("User")) {
                if (realm instanceof UserRealm) {
                    return ((UserRealm) realm).hasRole(principals, roleIdentifier);
                }
            }
            if(realmName.contains("Admin")) {
                if (realm instanceof AdminRealm) {
                    return ((AdminRealm) realm).hasRole(principals, roleIdentifier);
                }
            }
        }
        return false;
    }
}
