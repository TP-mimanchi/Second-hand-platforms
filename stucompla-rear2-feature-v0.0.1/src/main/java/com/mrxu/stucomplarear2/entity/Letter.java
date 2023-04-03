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
 * @since 2022-04-28
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("letter")
public class Letter implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 私信ID
     */
    @TableId(value = "letter_id", type = IdType.AUTO)
    private Integer letterId;

    /**
     * 接收方ID
     */
    private Integer receiverId;

    /**
     * 发送方ID
     */
    private Integer senderId;

    /**
     * 私信内容
     */
    private String letterDetail;

    /**
     * 私信状态 0-未读 1-已读
     */
    private Integer letterStatus;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)    //用于mybatisplus自动填充时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    /**
     * 双方对话的标识 用户ID小的在前 如“2_3”
     */
    private String sessionId;

}
