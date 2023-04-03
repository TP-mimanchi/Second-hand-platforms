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
 * @since 2022-04-20
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("market_order")
public class MarketOrder implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 订单id
     */
    @TableId(value = "order_id", type = IdType.AUTO)
    private Integer orderId;

    /**
     * 卖家id
     */
    private Integer sellerId;

    /**
     * 买家id
     */
    private Integer buyerId;

    /**
     * 商品id
     */
    private Integer goodsId;

    /**
     * 购买数量
     */
    private Integer buyCount;

    /**
     * 订单总价
     */
    private Double totalPrice;

    /**
     * 订单生成时间
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
     * 订单状态：0-未付 1-已付 2-已发货 3-已签收 4-已退货 5-订单完成
     */
    private Integer orderStatus;

    /**
     * 二手商品名称
     */
    private String goodsName;

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


}
