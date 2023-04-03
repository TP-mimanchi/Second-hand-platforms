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
 * @since 2021-12-15
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("wall")
public class Wall implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 墙ID
     */
    @TableId(value = "wall_id", type = IdType.AUTO)
    private Integer wallId;

    /**
     * 审核人ID
     */
    private Integer adminId;

    /**
     * 墙内容
     */
    private String wallContent;

    /**
     * 申请时间
     */
    @TableField(fill = FieldFill.INSERT)    //用于mybatisplus自动填充时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createtime;

    /**
     * 评论数量
     */
    @TableField(fill = FieldFill.INSERT)
    private Integer commentNum;

    /**
     * 点赞数量
     */
    @TableField(fill = FieldFill.INSERT)
    private Integer likeNum;

    /**
     * 审核状态：0-待审 1-审核通过 2-未通过
     */
    private Integer auditState;

    /**
     * 审核不过原因
     */
    private String auditFailedCause;

    /**
     * 审核时间
     */
    @TableField(fill = FieldFill.UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date auditTime;

    /**
     * 申请人ID
     */
    private Integer userId;

    /**
     * 墙图片
     */
    private String wallImages;


}
