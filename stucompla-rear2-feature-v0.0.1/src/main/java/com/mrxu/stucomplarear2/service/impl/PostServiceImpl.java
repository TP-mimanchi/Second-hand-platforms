package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.*;
import com.mrxu.stucomplarear2.entity.*;
import com.mrxu.stucomplarear2.mapper.*;
import com.mrxu.stucomplarear2.service.LetterService;
import com.mrxu.stucomplarear2.service.PostService;
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
 * @since 2021-12-27
 */
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements PostService {

    @Autowired
    private PostMapper postMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private CollectMapper collectMapper;
    @Autowired
    private CommentMapper commentMapper;
    @Resource
    private LetterService letterService;

    @Override
    public Result publishPost(HttpServletRequest request, PostPublishDto postDto) {
        Post post = new Post();
        post.setTitle(postDto.getTitle());
        post.setCategoryId(postDto.getCategoryId());
        post.setDetail(postDto.getDetail());
        if (StringUtils.isNotBlank(postDto.getImages())) {
            post.setImages(postDto.getImages());
        }
        String accessToken = request.getHeader("Authorization");
        //获取token里面的用户ID
        String userId = JWTUtil.getUserId(accessToken);
        post.setUserId(Integer.valueOf(userId));
        post.setBestPost(false); //默认非精帖
        post.setPostStatus(0); //默认状态正常

        try {
            postMapper.insert(post);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(e.getMessage());
        }
        return Result.succ("发布成功");
    }

    @Override
    public Post updateViewNum(Post post) {
        //更新浏览量
        post.setViewNum(post.getViewNum() + 1);
        postMapper.updateById(post);
        return post;
    }

    @Override
    public Map<String, Object> findPostList(PostFindDto postFindDto) {
        int pageNum = postFindDto.getPageNum() == null ? 1 : postFindDto.getPageNum();
        int pageSize = postFindDto.getPageSize() == null ? 4 : postFindDto.getPageSize();
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        if (postFindDto.getPostId() != null) {
            queryWrapper.eq("post_id", postFindDto.getPostId());
        }
        if (postFindDto.getPostStatus() != null) {
            queryWrapper.eq("post_status", postFindDto.getPostStatus());
        }
        if (StringUtils.isNotBlank(postFindDto.getTitle())) {
            queryWrapper.like("title", postFindDto.getTitle()); //模糊搜索
        }
        if (StringUtils.isNotBlank(postFindDto.getDetail())) {
            queryWrapper.like("detail", postFindDto.getDetail()); //模糊搜索
        }
        if (postFindDto.getUserId() != null) {
            queryWrapper.eq("user_id", postFindDto.getUserId());
        }
        if (postFindDto.getCategoryId() != null) {
            queryWrapper.eq("category_id", postFindDto.getCategoryId());
        }
        String sort = postFindDto.getSort();
        if ("+post_id".equals(sort)) {
            queryWrapper.orderByAsc("post_id");//根据post_id升序排列
        } else if ("-post_id".equals(sort)) {
            queryWrapper.orderByDesc("post_id");
        } else if ("+view_num".equals(sort)) {
            queryWrapper.orderByAsc("view_num");
        } else if ("-view_num".equals(sort)) {
            queryWrapper.orderByDesc("view_num");
        } else if ("+comment_num".equals(sort)) {
            queryWrapper.orderByAsc("comment_num");
        } else if ("-comment_num".equals(sort)) {
            queryWrapper.orderByDesc("comment_num");
        } else {
            queryWrapper.orderByDesc("create_time"); //默认发布时间降序
        }
        if (postFindDto.getBestPost() != null) {
            System.out.println(postFindDto.getBestPost());
            if (postFindDto.getBestPost()) {
                queryWrapper.eq("best_post", postFindDto.getBestPost());
            } else {
                queryWrapper.eq("best_post", postFindDto.getBestPost());
            }
        }

        //当前页 页面大小
        IPage<Post> page = new Page<Post>(pageNum, pageSize);

        IPage<Post> postIPage = postMapper.selectPage(page, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", postIPage.getCurrent());//当前页
        map.put("total", postIPage.getTotal());//总记录数
        map.put("pages", postIPage.getPages());//总页数

        List<PostVo> postVoList = new ArrayList<>();
        map.put("pageSize", postIPage.getSize());//页面大小

        for (Post post : postIPage.getRecords()) {
            PostVo postVo = new PostVo();
            BeanUtils.copyProperties(post, postVo);
            //查对应的发布人信息
            User user = userMapper.selectById(post.getUserId());
            postVo.setUser(user);
            //查对应的帖子类型信息
            Category category = categoryMapper.selectById(post.getCategoryId());
            postVo.setCategory(category);
//            System.out.println(postVo);
            postVoList.add(postVo);
//            System.out.println(postVoList);
        }

        map.put("postList", postVoList);//数据
//        System.out.println(postVoList);
        return map;
    }

    @Override
    public Result editPost(HttpServletRequest request, PostEditDto postEditDto) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            if (postEditDto.getPostId() == null) {
                return Result.fail("帖子ID为空");
            }
            Post post = postMapper.selectById(postEditDto.getPostId());
            if (post.getUserId() != Integer.valueOf(userId)) {
                return Result.fail("不可编辑别人的帖子");
            }

            post.setTitle(postEditDto.getTitle());
            post.setDetail(postEditDto.getDetail());
            post.setImages(postEditDto.getImages());
            post.setCategoryId(postEditDto.getCategoryId());

            postMapper.updateById(post);
            return Result.succ("修改成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result deleteMyPost(Integer postId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            if (postId == null) {
                return Result.fail("帖子ID为空");
            }
            Post post = postMapper.selectById(postId);
            if (post == null) {
                return Result.fail("帖子不存在");
            }
            if (post.getUserId() != Integer.valueOf(userId)) {
                return Result.fail("不可删除别人的帖子");
            }

            //删除对应收藏列表
            QueryWrapper<Collect> collectQueryWrapper = new QueryWrapper<>();
            collectQueryWrapper.eq("post_id", postId);
            collectMapper.delete(collectQueryWrapper);

            //删除评论列表
            QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
            commentQueryWrapper.eq("post_id", postId);
            commentMapper.delete(commentQueryWrapper);

            //删除帖子
            postMapper.deleteById(postId);
            //分类里对应的帖子数要减一
            //加一个消息通知，如‘你收藏的帖子已被xxx删除’
//            letterService.addNotice(
//                    new LetterAddDto(Integer.valueOf(userId),
//                            "你的商品 "+goods.getGoodsName()+" 商品编号："+goodsId+" 已重新上架"));
            return Result.succ("删除成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result lockedPost(Integer postId, String cause) {
        try {
            if (postId == null) {
                return Result.fail("帖子ID不能为空");
            }
            Post post = postMapper.selectById(postId);
            if (post == null) {
                return Result.fail("帖子不存在");
            }
            if (post.getPostStatus() == 1) {
                return Result.fail("已经是锁定状态");
            }
            if (StringUtils.isBlank(cause)) {
                return Result.fail("原因不能为空");
            }
            post.setPostStatus(1);
            postMapper.updateById(post);

            letterService.addNotice(
                    new LetterAddDto(Integer.valueOf(post.getUserId()),
                            "你的帖子 ”" + post.getTitle() + "“ 已被管理员锁定，原因：" + cause));
            return Result.succ("帖子已锁定");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result unLockPost(Integer postId) {
        try {
            if (postId == null) {
                return Result.fail("帖子ID不能为空");
            }
            Post post = postMapper.selectById(postId);
            if (post == null) {
                return Result.fail("帖子不存在");
            }
            if (post.getPostStatus() == 0) {
                return Result.fail("已经是正常状态");
            }
            post.setPostStatus(0);
            postMapper.updateById(post);
            letterService.addNotice(
                    new LetterAddDto(Integer.valueOf(post.getUserId()),
                            "你的帖子 ”" + post.getTitle() + "“ 已解锁"));
            return Result.succ("帖子已解锁");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result deleteByAdmin(Integer postId, String cause) {
        try {
            if (postId == null) {
                return Result.fail("帖子ID不能为空");
            }
            Post post = postMapper.selectById(postId);
            if (post == null) {
                return Result.fail("帖子不存在");
            }
            if (StringUtils.isBlank(cause)) {
                return Result.fail("原因不能为空");
            }

            //删除对应收藏列表
            QueryWrapper<Collect> collectQueryWrapper = new QueryWrapper<>();
            collectQueryWrapper.eq("post_id", postId);
            collectMapper.delete(collectQueryWrapper);

            //删除评论列表
            QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
            commentQueryWrapper.eq("post_id", postId);
            commentMapper.delete(commentQueryWrapper);

            //删除帖子
            postMapper.deleteById(postId);
            //分类里对应的帖子数要减一
            //加一个消息通知，如‘你收藏的帖子已被xxx删除’

            letterService.addNotice(
                    new LetterAddDto(Integer.valueOf(post.getUserId()),
                            "你的帖子 ”" + post.getTitle() + "“ 已被管理员删除，原因：" + cause));
            return Result.succ("删除成功");
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result getPostData() {
        try {
            QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
            queryWrapper.select("category_id,count(*) as categoryIdCount");
            queryWrapper.groupBy("category_id");
            List<Map<String, Object>> postList = postMapper.selectMaps(queryWrapper);
            for (Map<String, Object> map:postList){
                Category category=categoryMapper.selectById((Integer)map.get("category_id"));
                map.put("categoryName",category.getCategoryName());
            }
            System.out.println(postList);
            return Result.succ(postList);
        } catch (Exception exception) {
            exception.printStackTrace();
            return null;
        }
    }

    @Override
    public Result getPostTotal() {
        try {
            QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
            Integer selectCount = postMapper.selectCount(queryWrapper);
            return Result.succ(selectCount);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

}
