package com.mrxu.stucomplarear2.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.dto.PostEditDto;
import com.mrxu.stucomplarear2.dto.PostFindDto;
import com.mrxu.stucomplarear2.dto.PostPublishDto;
import com.mrxu.stucomplarear2.entity.Post;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-27
 */
@Service
public interface PostService extends IService<Post> {

    Result publishPost(HttpServletRequest request, PostPublishDto postDto);

    Post updateViewNum(Post post);

    Map<String, Object> findPostList(PostFindDto postFindDto);

    Result editPost(HttpServletRequest request, PostEditDto postEditDto);

    Result deleteMyPost(Integer postId, HttpServletRequest request);

    Result lockedPost(Integer postId,String cause);

    Result unLockPost(Integer postId);

    Result deleteByAdmin(Integer postId,String cause);

    Result getPostData();

    Result getPostTotal();
}
