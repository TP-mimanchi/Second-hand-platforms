package com.mrxu.stucomplarear2.service;

import com.mrxu.stucomplarear2.entity.Category;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.utils.response.Result;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-27
 */
public interface CategoryService extends IService<Category> {

    Result listCategories();
}
