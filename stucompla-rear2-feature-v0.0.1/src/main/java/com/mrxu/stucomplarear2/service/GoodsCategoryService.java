package com.mrxu.stucomplarear2.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.dto.GoodsCategoryDto;
import com.mrxu.stucomplarear2.entity.GoodsCategory;
import com.mrxu.stucomplarear2.utils.response.Result;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-04-15
 */
public interface GoodsCategoryService extends IService<GoodsCategory> {

    Result getGoodsCategoryList(GoodsCategoryDto goodsCategoryDto);
}
