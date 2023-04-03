package com.mrxu.stucomplarear2.utils.mybatisplus;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * @purpose: 自动填充配置
 */
@Component //把处理器添加到IOC容器中
public class MyMataObjectHandler implements MetaObjectHandler {
    @Override
    public void insertFill(MetaObject metaObject) {
        //设置每次插入的时候更新 创建时间和更新时间 也就是初始化时间
        this.setFieldValByName("createtime", new Date(), metaObject);
        this.setFieldValByName("updatetime", new Date(), metaObject);
        this.setFieldValByName("createTime", new Date(), metaObject);
        this.setFieldValByName("updateTime", new Date(), metaObject);
        //this.setFieldValByName("roleId",1,metaObject);//角色id
        this.setFieldValByName("commentNum", 0, metaObject);//评论数
        this.setFieldValByName("viewNum", 0, metaObject);//热度 浏览数
        this.setFieldValByName("goodsStatus", true, metaObject);//上架状态

        this.setFieldValByName("likeNum", 0, metaObject);//点赞数
        this.setFieldValByName("collectNum", 0, metaObject);//收藏数
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.setFieldValByName("updatetime", new Date(), metaObject);
        this.setFieldValByName("updateTime", new Date(), metaObject);
        this.setFieldValByName("auditTime", new Date(), metaObject);//上墙审核时间
    }
}
