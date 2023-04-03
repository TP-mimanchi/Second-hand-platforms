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
@TableName("goods_category")
public class GoodsCategory implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 二手商品分类id
     */
    @TableId(value = "category_id", type = IdType.AUTO)
    private Integer categoryId;

    /**
     * 二手商品分类级别(1-一级分类 2-二级分类 3-三级分类)
     */
    private Integer categoryLevel;

    /**
     * 二手商品父分类id
     */
    private Integer parentId;

    /**
     * 二手商品分类名称
     */
    private String categoryName;

    /**
     * 二手商品分类创建时间
     */
    @TableField(fill = FieldFill.INSERT)    //用于mybatisplus自动填充时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /**
     * 二手商品分类修改时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;


}
