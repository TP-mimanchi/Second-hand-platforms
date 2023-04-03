package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.GoodsCategoryDto;
import com.mrxu.stucomplarear2.entity.GoodsCategory;
import com.mrxu.stucomplarear2.mapper.GoodsCategoryMapper;
import com.mrxu.stucomplarear2.service.GoodsCategoryService;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-04-15
 */
@Service
public class GoodsCategoryServiceImpl extends ServiceImpl<GoodsCategoryMapper, GoodsCategory> implements GoodsCategoryService {

    @Autowired
    private GoodsCategoryMapper goodsCategoryMapper;

    @Override
    public Result getGoodsCategoryList(GoodsCategoryDto goodsCategoryDto) {
        int pageNum = goodsCategoryDto.getPageNum() == null ? 1 : goodsCategoryDto.getPageNum();
        int pageSize = goodsCategoryDto.getPageSize() == null ? 200 : goodsCategoryDto.getPageSize();

        QueryWrapper<GoodsCategory> queryWrapper = new QueryWrapper<>();
        if (goodsCategoryDto.getCategoryId() != null) {
            queryWrapper.eq("category_id", goodsCategoryDto.getCategoryId());
        }
        if (goodsCategoryDto.getCategoryName() != null) {
            queryWrapper.eq("category_name", goodsCategoryDto.getCategoryName());
        }
        if (goodsCategoryDto.getCategoryLevel() != null) {
            queryWrapper.eq("categoery_level", goodsCategoryDto.getCategoryLevel());
        }
        if (goodsCategoryDto.getParentId() != null) {
            queryWrapper.eq("parent_id", goodsCategoryDto.getParentId());
        }
        String sort = goodsCategoryDto.getSort();
        if ("+category_id".equals(sort)) {
            queryWrapper.orderByAsc("category_id");
        } else if ("-category_id".equals(sort)) {
            queryWrapper.orderByDesc("category_id");
        } else if ("+categoery_level".equals(sort)) {
            queryWrapper.orderByAsc("categoery_level");
        } else if ("-categoery_level".equals(sort)) {
            queryWrapper.orderByDesc("categoery_level");
        } else if ("+parent_id".equals(sort)) {
            queryWrapper.orderByAsc("parent_id");
        } else if ("-parent_id".equals(sort)) {
            queryWrapper.orderByDesc("parent_id");
        } else {
            queryWrapper.orderByAsc("create_time");
        }
        IPage<GoodsCategory> page = new Page<>(pageNum, pageSize);
        IPage<GoodsCategory> goodsCategoryIPage = goodsCategoryMapper.selectPage(page, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", goodsCategoryIPage.getCurrent());//当前页
        map.put("total", goodsCategoryIPage.getTotal());//总记录数
        map.put("pages", goodsCategoryIPage.getPages());//总页数

        map.put("pageSize", goodsCategoryIPage.getSize());//页面大小
        map.put("goodsCategoryList", goodsCategoryIPage.getRecords());//数据

        return Result.succ(map);
    }
}
