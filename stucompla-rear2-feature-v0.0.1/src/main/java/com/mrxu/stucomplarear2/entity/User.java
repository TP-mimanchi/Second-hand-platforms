package com.mrxu.stucomplarear2.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * User实体类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-01
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("user")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;

    /**
     * 账号
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)    //用于mybatisplus自动填充时间
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private Date createtime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private Date updatetime;

    /**
     * 角色ID
     */
    //@TableField(fill = FieldFill.INSERT)
    private Integer roleId;

    /**
     * 性别
     */
    private String sex;

    /**
     * 是否锁定
     */
    @TableField(fill = FieldFill.INSERT)
    private boolean locked;

    /**
     * 小写的boolean基本类型作为类的属性时,自动生成的get方法,是is开头的
     * 所以最好重写get方法,保证是getXxxx的格式
     * @return
     */
    public boolean getLocked() {
        return locked;
    }

    /**
     * 头像
     */
    private String avatar;

    /**
     * 个性签名
     */
    private String signature;
}
