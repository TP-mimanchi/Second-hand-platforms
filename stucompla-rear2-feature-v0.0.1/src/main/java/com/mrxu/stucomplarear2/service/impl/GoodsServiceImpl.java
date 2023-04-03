package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.*;
import com.mrxu.stucomplarear2.entity.Goods;
import com.mrxu.stucomplarear2.entity.GoodsCategory;
import com.mrxu.stucomplarear2.entity.User;
import com.mrxu.stucomplarear2.mapper.GoodsCategoryMapper;
import com.mrxu.stucomplarear2.mapper.GoodsMapper;
import com.mrxu.stucomplarear2.mapper.MarketOrderMapper;
import com.mrxu.stucomplarear2.mapper.UserMapper;
import com.mrxu.stucomplarear2.service.GoodsService;
import com.mrxu.stucomplarear2.service.LetterService;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods> implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private MarketOrderMapper marketOrderMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private GoodsCategoryMapper goodsCategoryMapper;
    @Autowired
    private LetterService letterService;

    @Override
    public Result add(GoodsAddDto goodsDto, HttpServletRequest request) {
        if (StringUtils.isBlank(goodsDto.getGoodsName())
                ||StringUtils.isBlank(goodsDto.getGoodsDetail())
                ||goodsDto.getGoodsCount()==null
                ||goodsDto.getGoodsCategoryId()==null
                ||goodsDto.getGoodsPrice()==null
                ||StringUtils.isBlank(goodsDto.getGoodsImages())){
            return Result.fail("请完成必填项");
        }
        if (goodsDto.getGoodsName().length()<1||goodsDto.getGoodsName().length()>15){
            return Result.fail("商品名长度要在1-15位");
        }
        try {
            Goods goods = new Goods();
            BeanUtils.copyProperties(goodsDto, goods);

            System.out.println(goodsDto);
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            goods.setUserId(Integer.valueOf(userId));

            goodsMapper.insert(goods);
        } catch (Exception e) {
            e.printStackTrace();
            Result.fail(e.toString());
        }
        return Result.succ("发布成功");
    }

    @Override
    public Result findGoods(GoodsFindDto goodsFindDto) {
        int pageNum = goodsFindDto.getPageNum() == null ? 1 : goodsFindDto.getPageNum();
        int pageSize = goodsFindDto.getPageSize() == null ? 20 : goodsFindDto.getPageSize();
        QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
        if (goodsFindDto.getGoodsId() != null) {
            queryWrapper.eq("goods_id", goodsFindDto.getGoodsId());
        }
        if (goodsFindDto.getGoodsCategoryId() != null) {
            queryWrapper.eq("goods_category_id", goodsFindDto.getGoodsCategoryId());
        }
        if (goodsFindDto.getUserId() != null) {
            queryWrapper.eq("user_id", goodsFindDto.getUserId());
        }
        if (goodsFindDto.getKeyName() != null) {
            queryWrapper.and(qw -> qw.like("goods_name", goodsFindDto.getKeyName())
                    .or().like("goods_detail", goodsFindDto.getKeyName()));
//            queryWrapper.like("goods_name", goodsFindDto.getKeyName()).or().like("goods_detail", goodsFindDto.getKeyName());
        }
        if (goodsFindDto.getGoodsStatus() != null) {
            queryWrapper.eq("goods_status", goodsFindDto.getGoodsStatus());
        }
        String sort = goodsFindDto.getSort();
        if ("+goods_id".equals(sort)) {
            queryWrapper.orderByAsc("goods_id");
        } else if ("-goods_id".equals(sort)) {
            queryWrapper.orderByDesc("goods_id");
        } else if ("+goods_price".equals(sort)) {
            queryWrapper.orderByAsc("goods_price");
        } else if ("-goods_price".equals(sort)) {
            queryWrapper.orderByDesc("goods_price");
        } else {
            queryWrapper.orderByDesc("create_time"); //默认发布时间降序
        }
        IPage<Goods> page = new Page<>(pageNum, pageSize);
        IPage<Goods> goodsIPage = goodsMapper.selectPage(page, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", goodsIPage.getCurrent());//当前页
        map.put("total", goodsIPage.getTotal());//总记录数
        map.put("pages", goodsIPage.getPages());//总页数

        map.put("pageSize", goodsIPage.getSize());//页面大小

        List<GoodsVo> goodsVoList = new ArrayList<>();
        for (Goods goods : goodsIPage.getRecords()) {
            GoodsVo goodsVo = new GoodsVo();
            BeanUtils.copyProperties(goods, goodsVo);
            //查对应的发布人信息
            User user = userMapper.selectById(goods.getUserId());
            goodsVo.setUser(user);
            //查对应的帖子类型信息
            GoodsCategory goodsCategory = goodsCategoryMapper.selectById(goods.getGoodsCategoryId());
            goodsVo.setGoodsCategory(goodsCategory);
//            System.out.println(postVo);
            goodsVoList.add(goodsVo);
//            System.out.println(postVoList);
        }

        map.put("goodsList", goodsVoList);//数据

        return Result.succ(map);
    }

    @Override
    public Goods updateViewNum(Goods goods) {
        goods.setViewNum(goods.getViewNum() + 1);
        goodsMapper.updateById(goods);
        return goods;
    }

    @Override
    public Result editGoods(GoodsEditDto goodsEditDto, HttpServletRequest request) {
        if (StringUtils.isBlank(goodsEditDto.getGoodsName())
                ||StringUtils.isBlank(goodsEditDto.getGoodsDetail())
                ||goodsEditDto.getGoodsCount()==null
                ||goodsEditDto.getGoodsCategoryId()==null
                ||goodsEditDto.getGoodsPrice()==null
                ||StringUtils.isBlank(goodsEditDto.getGoodsImages())){
            return Result.fail("请完成必填项");
        }
        if (goodsEditDto.getGoodsName().length()<1||goodsEditDto.getGoodsName().length()>15){
            return Result.fail("商品名长度要在1-15位");
        }
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            if (goodsEditDto.getGoodsId() == null) {
                return Result.fail("商品ID为空");
            }
            Goods goods = goodsMapper.selectById(goodsEditDto.getGoodsId());
            if (goods.getUserId() != Integer.valueOf(userId)) {
                return Result.fail("不可编辑别人的商品");
            }
            goods.setGoodsCategoryId(goodsEditDto.getGoodsCategoryId());
            goods.setGoodsCount(goodsEditDto.getGoodsCount());
            goods.setGoodsDetail(goodsEditDto.getGoodsDetail());
            goods.setGoodsImages(goodsEditDto.getGoodsImages());
            goods.setGoodsPrice(goodsEditDto.getGoodsPrice());
            goods.setGoodsName(goodsEditDto.getGoodsName());
            goodsMapper.updateById(goods);
            return Result.succ("修改成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result deleteMyGoods(Integer goodsId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            if (goodsId == null) {
                return Result.fail("商品ID为空");
            }
            Goods goods = goodsMapper.selectById(goodsId);
            if (goods == null) {
                return Result.fail("商品不存在");
            }
            if (goods.getUserId() != Integer.valueOf(userId)) {
                return Result.fail("不可删除别人的商品");
            }
            goodsMapper.deleteById(goodsId);
            return Result.succ("删除成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result unShelveGoods(Integer goodsId) {
        try {
            if (goodsId == null) {
                return Result.fail("商品ID为空");
            }
            Goods goods = goodsMapper.selectById(goodsId);
            if (goods == null) {
                return Result.fail("商品不存在");
            }
            goods.setGoodsStatus(false);
            goodsMapper.updateById(goods);
            return Result.succ("下架成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }

    }

    @Override
    public Result deleteGoods(Integer goodsId) {
        try {
            if (goodsId == null) {
                return Result.fail("商品ID为空");
            }
            Goods goods = goodsMapper.selectById(goodsId);
            if (goods == null) {
                return Result.fail("商品不存在");
            }
            goodsMapper.deleteById(goodsId);
            return Result.succ("删除成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result putMyGoods(Integer goodsId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            if (goodsId == null) {
                return Result.fail("商品ID为空");
            }
            Goods goods = goodsMapper.selectById(goodsId);
            if (goods == null) {
                return Result.fail("商品不存在");
            }
            if (goods.getUserId() != Integer.valueOf(userId)) {
                return Result.fail("无权操作别人的商品");
            }
            goods.setGoodsStatus(true);
            goodsMapper.updateById(goods);
            letterService.addNotice(
                    new LetterAddDto(Integer.valueOf(userId),
                            "你的商品 ”"+goods.getGoodsName()+"“ 商品编号："+goodsId+" 已重新上架"));
            return Result.succ("上架成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result unShelveMyGoods(Integer goodsId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (goodsId == null) {
                return Result.fail("商品ID为空");
            }
            Goods goods = goodsMapper.selectById(goodsId);
            if (goods == null) {
                return Result.fail("商品不存在");
            }
            if (goods.getUserId() != Integer.valueOf(userId)) {
                return Result.fail("无权操作别人的商品");
            }
            goods.setGoodsStatus(false);
            goodsMapper.updateById(goods);
            letterService.addNotice(
                    new LetterAddDto(Integer.valueOf(userId),
                            "你的商品 ”"+goods.getGoodsName()+"“ 商品编号："+goodsId+" 已被自己下架"));
            return Result.succ("下架成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result getGoodsTotal() {
        try {
            QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
            Integer selectCount = goodsMapper.selectCount(queryWrapper);
            return Result.succ(selectCount);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result getGoodsByCategory() {
        try {
            QueryWrapper<Goods> queryWrapper = new QueryWrapper<>();
            queryWrapper.select("goods_category_id,count(*) as goodsCategoryIdCount");
            queryWrapper.groupBy("goods_category_id");
            queryWrapper.last("limit 5");
            List<Map<String, Object>> goodsList = goodsMapper.selectMaps(queryWrapper);
            for (Map<String, Object> map:goodsList){
                GoodsCategory goodsCategory = goodsCategoryMapper.selectById((Integer) map.get("goods_category_id"));
                map.put("categoryName",goodsCategory.getCategoryName());
            }
            return Result.succ(goodsList);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }

}
