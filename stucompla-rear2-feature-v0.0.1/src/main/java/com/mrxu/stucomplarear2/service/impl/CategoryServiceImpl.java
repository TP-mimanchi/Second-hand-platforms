package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.entity.Category;
import com.mrxu.stucomplarear2.mapper.CategoryMapper;
import com.mrxu.stucomplarear2.service.CategoryService;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-27
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public Result listCategories() {
        QueryWrapper<Category> queryWrapper = new QueryWrapper<>();
        List<Category> categories = categoryMapper.selectList(queryWrapper);
        if (categories.isEmpty()) {
            return Result.fail("无数据");
        }
        return Result.succ(categories);
    }
}
