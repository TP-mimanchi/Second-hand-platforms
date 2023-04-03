package com.mrxu.stucomplarear2.utils.swagger;

import io.swagger.annotations.ApiOperation;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;

import java.util.ArrayList;
import java.util.List;

@EnableOpenApi   // 开启Swagger自定义接口文档
@Configuration   // 相当于Spring配置中的<beans>
public class SwaggerConfig {
    @Bean   // 相当于Spring 配置中的<bean>
    public Docket createRestApi() {
        //访问地址：http://localhost:8086/swagger-ui/index.html
        //swagger3.0使用 OAS_30   springboot版本不能2.6.0 要2.5.6
        return new Docket(DocumentationType.OAS_30)
                .apiInfo(apiInfo())
                .select()
                //此包路径下的类，才生成接口文档
                //.apis(RequestHandlerSelectors.basePackage("cn.opendatachain.manage.controller"))
                //加了ApiOperation的类,才生成接口文档
                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .paths(PathSelectors.any())
                .build()
                /* 设置安全模式，swagger可以设置访问token */
                .securitySchemes(securitySchemes())
                .securityContexts(securityContexts());
    }
    // API基础信息定义（就是更新Swagger默认页面上的信息）
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("Swagger3接口文档")    //文档标题
                .description("文档描述：更多问题，请联系开发者")    //文档描述
                .contact(new Contact("Mr.xu", null, "1452162669@qq.com(email)")) //作者、作者网站(url)、作者邮箱
                .version("1.0")
                .build();
    }

    /**
     * 认证的安全上下文
     */
    private List<SecurityScheme> securitySchemes() {
        List<SecurityScheme> securitySchemes = new ArrayList<>();
        securitySchemes.add(new ApiKey("Authorization", "Authorization", "header"));
        return securitySchemes;
    }

    /**
     * 授权信息全局应用
     */
    private List<SecurityContext> securityContexts() {
        List<SecurityContext> securityContexts = new ArrayList<>();
        securityContexts.add(SecurityContext.builder()
                .securityReferences(defaultAuth())
                .forPaths(PathSelectors.any()).build());
        return securityContexts;
    }

    private List<SecurityReference> defaultAuth() {
        AuthorizationScope authorizationScope = new AuthorizationScope("global", "accessEverything");
        AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
        authorizationScopes[0] = authorizationScope;
        List<SecurityReference> securityReferences = new ArrayList<>();
        securityReferences.add(new SecurityReference("Authorization", authorizationScopes));
        return securityReferences;
    }
}