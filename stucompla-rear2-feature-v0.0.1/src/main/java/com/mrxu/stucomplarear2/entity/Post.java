package com.mrxu.stucomplarear2.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 *
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-27
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("post")
public class Post implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 帖子ID
     */
    @TableId(value = "post_id", type = IdType.AUTO)
    private Integer postId;

    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String detail;

    /**
     * 图片
     */
    private String images;

    /**
     * 评论数
     */
    @TableField(fill = FieldFill.INSERT)
    private Integer commentNum;

    /**
     * 点击数
     */
    @TableField(fill = FieldFill.INSERT)
    private Integer viewNum;

    /**
     * 发布时间
     */
    @TableField(fill = FieldFill.INSERT)    //用于mybatisplus自动填充时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /**
     * 发布人ID
     */
    private Integer userId;

    /**
     * 种类ID
     */
    private Integer categoryId;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    /**
     * 是否精帖
     */
    @TableField(fill = FieldFill.INSERT)
    private boolean bestPost;

    /**
     * 收藏数
     */
    @TableField(fill = FieldFill.INSERT)
    private Integer collectNum;

    /**
     *帖子状态 0-正常 1-锁定
     */
    private Integer postStatus;

}
