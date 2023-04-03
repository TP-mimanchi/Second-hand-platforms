package com.mrxu.stucomplarear2.utils.shiro;

import com.mrxu.stucomplarear2.utils.jwt.JWTFilter;
import org.apache.shiro.authc.pam.FirstSuccessfulStrategy;
import org.apache.shiro.authc.pam.ModularRealmAuthenticator;
import org.apache.shiro.authz.ModularRealmAuthorizer;
import org.apache.shiro.mgt.DefaultSessionStorageEvaluator;
import org.apache.shiro.mgt.DefaultSubjectDAO;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.Filter;
import java.util.*;

@Configuration
public class ShiroConfig {

    @Bean
    public DefaultWebSecurityManager securityManager(MyModularRealmAuthenticator myModularRealmAuthenticator) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();

        Set<Realm> realmHashSet = new HashSet<Realm>();
        realmHashSet.add(userRealm());
        realmHashSet.add(adminRealm());
        securityManager.setAuthenticator(modularRealmAuthenticator());
        securityManager.setAuthorizer(modularRealmAuthorizer());
        // 设置自定义 realm.
        securityManager.setRealms(realmHashSet);


        //关闭session
        DefaultSubjectDAO subjectDAO = new DefaultSubjectDAO();
        DefaultSessionStorageEvaluator sessionStorageEvaluator = new DefaultSessionStorageEvaluator();
        sessionStorageEvaluator.setSessionStorageEnabled(false);
        subjectDAO.setSessionStorageEvaluator(sessionStorageEvaluator);
        securityManager.setSubjectDAO(subjectDAO);
        return securityManager;
    }

    /**
     * 先走 filter ，然后 filter 如果检测到请求头存在 token，则用 token 去 login，走 Realm 去验证
     */
    @Bean
    public ShiroFilterFactoryBean factory(DefaultWebSecurityManager securityManager) {
        ShiroFilterFactoryBean factoryBean = new ShiroFilterFactoryBean();
        factoryBean.setSecurityManager(securityManager);
        // 添加自己的过滤器并且取名为jwt
        Map<String, Filter> filterMap = new LinkedHashMap<>();
        //设置我们自定义的JWT过滤器
        filterMap.put("jwt", new JWTFilter());
        factoryBean.setFilters(filterMap);

        // 设置无权限时跳转的 url;
        factoryBean.setUnauthorizedUrl("/unauthorized/无权限");
        Map<String, String> filterRuleMap = new HashMap<>();
        //放行swagger3
        filterRuleMap.put("/swagger-ui/**", "anon");
        filterRuleMap.put("/v3/api-docs", "anon");
        filterRuleMap.put("/swagger-resources/**", "anon");
        filterRuleMap.put("/webjars/**", "anon");
        //放行
        filterRuleMap.put("/images", "anon");
        filterRuleMap.put("/admin/info/login", "anon");
        filterRuleMap.put("/user/login", "anon");
//        filterRuleMap.put("/post/**", "anon");


        // 所有请求通过我们自己的JWT Filter
        filterRuleMap.put("/**", "jwt");
//        filterRuleMap.put("/post/publish", "jwt");
        // 访问 /unauthorized/** 不通过JWTFilter
        filterRuleMap.put("/user/unauthorized/**", "anon");
        factoryBean.setFilterChainDefinitionMap(filterRuleMap);
        return factoryBean;
    }

    /**
     * 添加注解支持，如果不加的话很有可能注解失效
     */
    @Bean
    public DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator() {

        DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
        defaultAdvisorAutoProxyCreator.setProxyTargetClass(true);
        return defaultAdvisorAutoProxyCreator;
    }

    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(DefaultWebSecurityManager securityManager) {

        AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
        advisor.setSecurityManager(securityManager);
        return advisor;
    }

    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    /**
     * 系统自带的Realm管理，主要针对多realm 认证
     */
    @Bean
    public ModularRealmAuthenticator modularRealmAuthenticator() {
        //自己重写的ModularRealmAuthenticator
        MyModularRealmAuthenticator mymodularRealmAuthenticator = new MyModularRealmAuthenticator();
        mymodularRealmAuthenticator.setAuthenticationStrategy(new FirstSuccessfulStrategy());
        return mymodularRealmAuthenticator;
    }

    /**
     * 系统自带的Realm管理，主要针对多realm 授权
     */
    @Bean
    public ModularRealmAuthorizer modularRealmAuthorizer() {
        //自己重写的ModularRealmAuthorizer
        MyModularRealmAuthorizer modularRealmAuthorizer = new MyModularRealmAuthorizer();
        return modularRealmAuthorizer;
    }

    @Bean("adminRealm")
    public AdminRealm adminRealm() {
        return new AdminRealm();
    }

    @Bean("userRealm")
    public UserRealm userRealm() {
        return new UserRealm();
    }
}
