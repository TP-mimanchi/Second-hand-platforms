package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.LetterAddDto;
import com.mrxu.stucomplarear2.dto.MarketOrderFindDto;
import com.mrxu.stucomplarear2.dto.MarketOrderVo;
import com.mrxu.stucomplarear2.dto.OrderAddDto;
import com.mrxu.stucomplarear2.entity.Goods;
import com.mrxu.stucomplarear2.entity.MarketOrder;
import com.mrxu.stucomplarear2.entity.User;
import com.mrxu.stucomplarear2.mapper.GoodsMapper;
import com.mrxu.stucomplarear2.mapper.MarketOrderMapper;
import com.mrxu.stucomplarear2.mapper.UserMapper;
import com.mrxu.stucomplarear2.service.LetterService;
import com.mrxu.stucomplarear2.service.MarketOrderService;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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
 * @since 2022-04-20
 */
@Service
public class MarketOrderServiceImpl extends ServiceImpl<MarketOrderMapper, MarketOrder> implements MarketOrderService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private MarketOrderMapper marketOrderMapper;
    @Resource
    private LetterService letterService;

    @Override
    public Result addOrder(OrderAddDto orderAddDto, HttpServletRequest request) {
        MarketOrderVo marketOrderVo = new MarketOrderVo();
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (orderAddDto.getGoodsId() == null || orderAddDto.getBuyCount() == null || userId == null) {
                return Result.fail("参数错误");
            }

            //检查商品是否存在
            Goods goods = goodsMapper.selectById(orderAddDto.getGoodsId());
            if (goods == null) {
                return Result.fail("商品不存在或已被下架");
            }
            if (goods.getGoodsCount() < 1) {
                return Result.fail("库存不足");
            }
            MarketOrder marketOrder = new MarketOrder();
            //商品信息
            marketOrder.setGoodsId(orderAddDto.getGoodsId());
            marketOrder.setGoodsName(goods.getGoodsName());
            marketOrder.setGoodsImages(goods.getGoodsImages());
            marketOrder.setGoodsCategoryId(goods.getGoodsCategoryId());
            marketOrder.setGoodsPrice(goods.getGoodsPrice());

            //用户信息
            marketOrder.setBuyerId(Integer.valueOf(userId));
            marketOrder.setSellerId(goods.getUserId());

            marketOrder.setBuyCount(orderAddDto.getBuyCount());
            marketOrder.setTotalPrice(goods.getGoodsPrice() * orderAddDto.getBuyCount());
            marketOrder.setOrderStatus(0);
            marketOrderMapper.insert(marketOrder);
//            System.out.println("id:"+marketOrder.getOrderId());
            //实体类中@TableName @TableId(value = "order_id", type = IdType.AUTO)
            //一一对应后，inster()之后，实例中可以获取到id

            MarketOrder marketOrder1 = marketOrderMapper.selectById(marketOrder.getOrderId());
            BeanUtils.copyProperties(marketOrder1, marketOrderVo);

            //查对应的用户信息
            User buyer = userMapper.selectById(marketOrder1.getBuyerId());
            User seller = userMapper.selectById(marketOrder1.getSellerId());

            marketOrderVo.setBuyer(buyer);
            marketOrderVo.setSeller(seller);
            marketOrderVo.setGoods(goods);
        } catch (Exception e) {
            e.printStackTrace();
            Result.fail(e.toString());
        }
        return Result.succ(marketOrderVo);
    }

    @Override
    public Result payOrder(Integer orderId) {
        try {
            if (orderId == null) {
                return Result.fail("参数错误");
            }
            MarketOrder marketOrder = marketOrderMapper.selectById(orderId);
            if (marketOrder == null) {
                return Result.fail("订单不存在");
            }
            Goods goods = goodsMapper.selectById(marketOrder.getGoodsId());
            if (goods.getGoodsCount() < 1) {
                return Result.fail("库存不足");
            }
            //库存减一
            goods.setGoodsCount(goods.getGoodsCount() - 1);
            goodsMapper.updateById(goods);

            //更改订单状态为“已支付”
            marketOrder.setOrderStatus(1);
            marketOrderMapper.updateById(marketOrder);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
        return Result.succ("支付成功");
    }

    @Override
    public Result getMyOrder(MarketOrderFindDto marketOrderFindDto, HttpServletRequest request) {
        int pageNum = marketOrderFindDto.getPageNum() == null ? 1 : marketOrderFindDto.getPageNum();
        int pageSize = marketOrderFindDto.getPageSize() == null ? 4 : marketOrderFindDto.getPageSize();
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            QueryWrapper<MarketOrder> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("buyer_id", userId);
            queryWrapper.orderByDesc("create_time"); //默认创建时间降序
            //当前页 页面大小
            IPage<MarketOrder> page = new Page<>(pageNum, pageSize);

            IPage<MarketOrder> orderIPage = marketOrderMapper.selectPage(page, queryWrapper);

            Map<String, Object> map = new HashMap<>();
            map.put("current", orderIPage.getCurrent());//当前页
            map.put("total", orderIPage.getTotal());//总记录数
            map.put("pages", orderIPage.getPages());//总页数
            map.put("pageSize", orderIPage.getSize());//页面大小

            List<MarketOrderVo> marketOrderVoList = new ArrayList<>();

            for (MarketOrder order : orderIPage.getRecords()) {
                MarketOrderVo marketOrderVo = new MarketOrderVo();
                BeanUtils.copyProperties(order, marketOrderVo);
                //查对应的用户信息
                User buyer = userMapper.selectById(order.getBuyerId());
                User seller = userMapper.selectById(order.getSellerId());
                marketOrderVo.setBuyer(buyer);
                marketOrderVo.setSeller(seller);
                //查询对应商品信息
                Goods goods = goodsMapper.selectById(order.getGoodsId());
                if(goods!=null){
                    marketOrderVo.setGoods(goods);
                }
                marketOrderVoList.add(marketOrderVo);
            }
            map.put("orderList", marketOrderVoList);//数据
            return Result.succ(map);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

//    @Override
//    public Result deleteOrder(Integer orderId, HttpServletRequest request) {
//        try {
//            String accessToken = request.getHeader("Authorization");
//            //获取token里面的用户ID
//            String userId = JWTUtil.getUserId(accessToken);
//
//            if (orderId == null) {
//                return Result.fail("订单ID为空");
//            }
//            MarketOrder marketOrder = marketOrderMapper.selectById(orderId);
//            if (marketOrder == null) {
//                return Result.fail("订单不存在");
//            }
//            if (marketOrder.getBuyerId()!=Integer.valueOf(userId)) {
//                return Result.fail("无权删除别人的订单");
//            }
//            if (0<marketOrder.getOrderStatus()&&marketOrder.getOrderStatus()<5) {
//                return Result.fail("订单未完成，不可删除");
//            }
//            marketOrderMapper.deleteById(orderId);
//            //后台管理成交量应该也要改
//            //加一个消息通知，如‘你的xx订单已被xxx删除’
//            return Result.succ("删除成功");
//        } catch (Exception e) {
//            return Result.fail(e.toString());
//        }
//    }

    @Override
    public Result sendGoods(Integer orderId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (orderId == null) {
                return Result.fail("参数错误");
            }
            MarketOrder marketOrder = marketOrderMapper.selectById(orderId);
            if (marketOrder == null) {
                return Result.fail("订单不存在");
            }
            if (marketOrder.getSellerId()!=Integer.valueOf(userId)) {
                return Result.fail("无权操作");
            }

            //更改订单状态为“已发货”
            marketOrder.setOrderStatus(2);
            marketOrderMapper.updateById(marketOrder);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
        return Result.succ("发货成功");
    }

    @Override
    public Result getOrderTotal() {
        try {
            QueryWrapper<MarketOrder> queryWrapper = new QueryWrapper<>();
            Integer selectCount = marketOrderMapper.selectCount(queryWrapper);
            return Result.succ(selectCount);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result applyReturn(Integer orderId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (orderId == null) {
                return Result.fail("参数错误");
            }
            MarketOrder marketOrder = marketOrderMapper.selectById(orderId);
            if (marketOrder == null) {
                return Result.fail("订单不存在");
            }
            if (marketOrder.getBuyerId()!=Integer.valueOf(userId)) {
                return Result.fail("这不是你的订单");
            }

            //更改订单状态为“退货中”
            marketOrder.setOrderStatus(4);
            marketOrderMapper.updateById(marketOrder);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
        return Result.succ("申请成功");
    }

    @Override
    public Result auditReturn(Integer orderId,Integer auditState, String cause,HttpServletRequest request) {
        try {
            if (auditState==null||(auditState!=0&&auditState!=1)){
                return Result.fail("审核参数错误");
            }
            if (orderId == null) {
                return Result.fail("订单ID为空");
            }
            MarketOrder marketOrder = marketOrderMapper.selectById(orderId);
            if (marketOrder == null) {
                return Result.fail("订单不存在");
            }
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (marketOrder.getSellerId()!=Integer.valueOf(userId)) {
                return Result.fail("无权操作");
            }
            if (auditState==0){
                if (StringUtils.isBlank(cause)) {
                    return Result.fail("原因不能为空");
                }
                //审核不通过后状态回到“已签收”
                marketOrder.setOrderStatus(3);
                marketOrderMapper.updateById(marketOrder);
                letterService.addNotice(
                        new LetterAddDto(Integer.valueOf(marketOrder.getBuyerId()),
                                "你的订单号为" + marketOrder.getOrderId() + "的订单，退货申请卖家审核不通过，原因：" + cause));
                return Result.succ("审核成功");
            }else if(auditState==1){
                //审核通过
                //更改订单状态为“已退货”
                marketOrder.setOrderStatus(5);
                marketOrderMapper.updateById(marketOrder);
                letterService.addNotice(
                        new LetterAddDto(Integer.valueOf(marketOrder.getBuyerId()),
                                "你的订单号为" + marketOrder.getOrderId() + "的订单，退货申请卖家审核已通过！"));
                return Result.succ("审核成功");
            }

        } catch (Exception e) {
            return Result.fail(e.toString());
        }
        return Result.fail("未知错误");
    }

    @Override
    public Result getOrderList(MarketOrderFindDto marketOrderFindDto) {
        int pageNum = marketOrderFindDto.getPageNum() == null ? 1 : marketOrderFindDto.getPageNum();
        int pageSize = marketOrderFindDto.getPageSize() == null ? 4 : marketOrderFindDto.getPageSize();
        try {
            QueryWrapper<MarketOrder> queryWrapper = new QueryWrapper<>();
//            queryWrapper.eq("seller_id", userId);

            if (marketOrderFindDto.getOrderId() != null) {
                queryWrapper.eq("order_id", marketOrderFindDto.getOrderId());
            }
            if (marketOrderFindDto.getBuyerId() != null) {
                queryWrapper.eq("buyer_id", marketOrderFindDto.getBuyerId());
            }
            if (marketOrderFindDto.getSellerId() != null) {
                queryWrapper.eq("seller_id", marketOrderFindDto.getSellerId());
            }
            if (marketOrderFindDto.getGoodsId() != null) {
                queryWrapper.eq("goods_id", marketOrderFindDto.getGoodsId() );
            }
            if (marketOrderFindDto.getOrderStatus() != null) {
                queryWrapper.eq("order_status", marketOrderFindDto.getOrderStatus());
            }
            String sort = marketOrderFindDto.getSort();
            if ("+order_id".equals(sort)) {
                queryWrapper.orderByAsc("order_id");
            } else if ("-order_id".equals(sort)) {
                queryWrapper.orderByDesc("order_id");
            } else if ("+update_time".equals(sort)) {
                queryWrapper.orderByAsc("update_time");
            } else if ("-update_time".equals(sort)) {
                queryWrapper.orderByDesc("update_time");
            } else if ("+total_price".equals(sort)) {
                queryWrapper.orderByAsc("total_price");
            } else if ("-total_price".equals(sort)) {
                queryWrapper.orderByDesc("total_price");
            } else {
                queryWrapper.orderByDesc("create_time"); //默认创建时间降序
            }

            //当前页 页面大小
            IPage<MarketOrder> page = new Page<>(pageNum, pageSize);

            IPage<MarketOrder> orderIPage = marketOrderMapper.selectPage(page, queryWrapper);

            Map<String, Object> map = new HashMap<>();
            map.put("current", orderIPage.getCurrent());//当前页
            map.put("total", orderIPage.getTotal());//总记录数
            map.put("pages", orderIPage.getPages());//总页数
            map.put("pageSize", orderIPage.getSize());//页面大小

            List<MarketOrderVo> marketOrderVoList = new ArrayList<>();

            for (MarketOrder order : orderIPage.getRecords()) {
                MarketOrderVo marketOrderVo = new MarketOrderVo();
                BeanUtils.copyProperties(order, marketOrderVo);
                //查对应的用户信息
                User buyer = userMapper.selectById(order.getBuyerId());
                User seller = userMapper.selectById(order.getSellerId());
                marketOrderVo.setBuyer(buyer);
                marketOrderVo.setSeller(seller);
                //查询对应商品信息
                Goods goods = goodsMapper.selectById(order.getGoodsId());
                marketOrderVo.setGoods(goods);
                marketOrderVoList.add(marketOrderVo);
            }
            map.put("orderList", marketOrderVoList);//数据
            return Result.succ(map);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result receipt(Integer orderId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (orderId == null) {
                return Result.fail("参数错误");
            }
            MarketOrder marketOrder = marketOrderMapper.selectById(orderId);
            if (marketOrder == null) {
                return Result.fail("订单不存在");
            }
            if (marketOrder.getBuyerId()!=Integer.valueOf(userId)) {
                return Result.fail("这不是你的订单");
            }

            //更改订单状态为“已签收”
            marketOrder.setOrderStatus(3);
            marketOrderMapper.updateById(marketOrder);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
        return Result.succ("签收成功");
    }

    @Override
    public Result getMySalesOrders(MarketOrderFindDto marketOrderFindDto, HttpServletRequest request) {
        int pageNum = marketOrderFindDto.getPageNum() == null ? 1 : marketOrderFindDto.getPageNum();
        int pageSize = marketOrderFindDto.getPageSize() == null ? 4 : marketOrderFindDto.getPageSize();
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            QueryWrapper<MarketOrder> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("seller_id", userId);

            if (marketOrderFindDto.getOrderId() != null) {
                queryWrapper.eq("order_id", marketOrderFindDto.getOrderId());
            }
            if (marketOrderFindDto.getBuyerId() != null) {
                queryWrapper.eq("buyer_id", marketOrderFindDto.getBuyerId());
            }
            if (marketOrderFindDto.getGoodsId() != null) {
                queryWrapper.eq("goods_id", marketOrderFindDto.getGoodsId() );
            }
            if (marketOrderFindDto.getOrderStatus() != null) {
                queryWrapper.eq("order_status", marketOrderFindDto.getOrderStatus());
            }
            String sort = marketOrderFindDto.getSort();
            if ("+order_id".equals(sort)) {
                queryWrapper.orderByAsc("order_id");//根据post_id升序排列
            } else if ("-order_id".equals(sort)) {
                queryWrapper.orderByDesc("order_id");
            } else if ("+update_time".equals(sort)) {
                queryWrapper.orderByAsc("update_time");
            } else if ("-update_time".equals(sort)) {
                queryWrapper.orderByDesc("update_time");
            } else if ("+total_price".equals(sort)) {
                queryWrapper.orderByAsc("total_price");
            } else if ("-total_price".equals(sort)) {
                queryWrapper.orderByDesc("total_price");
            } else {
                queryWrapper.orderByDesc("create_time"); //默认发布时间降序
            }

            //当前页 页面大小
            IPage<MarketOrder> page = new Page<>(pageNum, pageSize);

            IPage<MarketOrder> orderIPage = marketOrderMapper.selectPage(page, queryWrapper);

            Map<String, Object> map = new HashMap<>();
            map.put("current", orderIPage.getCurrent());//当前页
            map.put("total", orderIPage.getTotal());//总记录数
            map.put("pages", orderIPage.getPages());//总页数
            map.put("pageSize", orderIPage.getSize());//页面大小

            List<MarketOrderVo> marketOrderVoList = new ArrayList<>();

            for (MarketOrder order : orderIPage.getRecords()) {
                MarketOrderVo marketOrderVo = new MarketOrderVo();
                BeanUtils.copyProperties(order, marketOrderVo);
                //查对应的用户信息
                User buyer = userMapper.selectById(order.getBuyerId());
                User seller = userMapper.selectById(order.getSellerId());
                marketOrderVo.setBuyer(buyer);
                marketOrderVo.setSeller(seller);
                //查询对应商品信息
                Goods goods = goodsMapper.selectById(order.getGoodsId());
                marketOrderVo.setGoods(goods);
                marketOrderVoList.add(marketOrderVo);
            }
            map.put("orderList", marketOrderVoList);//数据
            return Result.succ(map);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

}
