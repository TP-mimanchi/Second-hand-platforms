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
 * @since 2022-04-15
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("goods")
public class Goods implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 二手商品id
     */
    @TableId(value = "goods_id", type = IdType.AUTO)
    private Integer goodsId;

    /**
     * 二手商品名称
     */
    private String goodsName;

    /**
     * 二手商品详情
     */
    private String goodsDetail;

    /**
     * 二手商品图片
     */
    private String goodsImages;

    /**
     * 二手商品定价
     */
    private Double goodsPrice;

    /**
     * 二手商品分类id
     */
    private Integer goodsCategoryId;

    /**
     * 二手商品数量
     */
    private Integer goodsCount;

    /**
     * 二手商品上架状态：0-下架 1-上架
     */
    private boolean goodsStatus;

    /**
     * 二手商品发布时间
     */
    @TableField(fill = FieldFill.INSERT)    //用于mybatisplus自动填充时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /**
     * 二手商品信息更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    /**
     * 发布人id
     */
    private Integer userId;

    /*
    点击数
     */
    @TableField(fill = FieldFill.INSERT)
    private Integer viewNum;

}
