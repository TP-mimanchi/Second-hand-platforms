package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.CollectFindDto;
import com.mrxu.stucomplarear2.entity.Collect;
import com.mrxu.stucomplarear2.entity.Post;
import com.mrxu.stucomplarear2.mapper.CollectMapper;
import com.mrxu.stucomplarear2.mapper.PostMapper;
import com.mrxu.stucomplarear2.service.CollectService;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.response.Result;
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
 * @since 2022-04-09
 */
@Service
public class CollectServiceImpl extends ServiceImpl<CollectMapper, Collect> implements CollectService {

    @Autowired
    private PostMapper postMapper;
    @Autowired
    private CollectMapper collectMapper;

    @Override
    public Result add(Integer postId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (userId == null || postId == null) {
                Result.fail("参数错误");
            }
            Post post = postMapper.selectById(postId);
            if (post == null) {
                Result.fail("帖子不存在");
            }
            QueryWrapper<Collect> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("post_id", postId);
            queryWrapper.eq("user_id", Integer.valueOf(userId));
            if (collectMapper.selectOne(queryWrapper) != null) {
                return Result.fail("已收藏");
            }
            Collect collect = new Collect();
            collect.setUserId(Integer.valueOf(userId));
            collect.setPostId(postId);
            collectMapper.insert(collect);
            post.setCollectNum(post.getCollectNum() + 1);
            postMapper.updateById(post);

            QueryWrapper<Collect> queryWrapper2 = new QueryWrapper<>();
            queryWrapper2.eq("post_id", postId);
            Integer selectCount = collectMapper.selectCount(queryWrapper2);


//            Post post = postMapper.selectById(postId);

        } catch (Exception e) {
            e.printStackTrace();
            Result.fail(e.toString());
        }
        return Result.succ("收藏成功");
    }

    @Override
    public Result deleteCollect(Integer postId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (userId == null || postId == null) {
                Result.fail("参数错误");
            }
            Post post = postMapper.selectById(postId);
            if (post == null) {
                Result.fail("帖子不存在");
            }

            QueryWrapper<Collect> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("post_id", postId);
            queryWrapper.eq("user_id", Integer.valueOf(userId));
            if (collectMapper.selectOne(queryWrapper) == null) {
                return Result.fail("您还没收藏，取消收藏失败");
            }
            collectMapper.delete(queryWrapper);

            post.setCollectNum(post.getCollectNum() - 1);
            postMapper.updateById(post);

        } catch (Exception e) {
            e.printStackTrace();
            Result.fail(e.toString());
        }
        return Result.succ("取消收藏成功");
    }

    @Override
    public Result checkCollect(Integer postId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (userId == null || postId == null) {
                Result.fail("参数错误");
            }
            if (postMapper.selectById(postId) == null) {
                Result.fail("帖子不存在");
            }
            QueryWrapper<Collect> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("post_id", postId);
            queryWrapper.eq("user_id", Integer.valueOf(userId));
            if (collectMapper.selectOne(queryWrapper) == null) {
                return Result.succ(false);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Result.fail(e.toString());
        }
        return Result.succ(true);
    }

    @Override
    public Result listCollect(CollectFindDto collectFindDto) {
        int pageNum = collectFindDto.getPageNum() == null ? 1 : collectFindDto.getPageNum();
        int pageSize = collectFindDto.getPageSize() == null ? 8 : collectFindDto.getPageSize();
        if (collectFindDto.getUserId()==null) {
            return Result.fail("用户ID为null");
        }
        QueryWrapper<Collect> queryWrapper =new QueryWrapper<>();
        queryWrapper.eq("user_id",collectFindDto.getUserId());
        queryWrapper.orderByDesc("create_time"); //默认收藏时间降序
        //当前页 页面大小
        IPage<Collect> page = new Page<Collect>(pageNum, pageSize);
        IPage<Collect> collectIPage = collectMapper.selectPage(page, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", collectIPage.getCurrent());//当前页
        map.put("total", collectIPage.getTotal());//总记录数
        map.put("pages", collectIPage.getPages());//总页数
        map.put("pageSize", collectIPage.getSize());//页面大小
        List<Post> postList = new ArrayList<>();
        for(Collect collect:collectIPage.getRecords()){
            Post post=postMapper.selectById(collect.getPostId());
            postList.add(post);
        }
        map.put("postList", postList);//数据
        return Result.succ(map);
    }


}
