package com.mrxu.stucomplarear2.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.dto.CollectFindDto;
import com.mrxu.stucomplarear2.entity.Collect;
import com.mrxu.stucomplarear2.utils.response.Result;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-04-09
 */
public interface CollectService extends IService<Collect> {

    Result add(Integer postId, HttpServletRequest request);

    Result deleteCollect(Integer postId, HttpServletRequest request);

    Result checkCollect(Integer postId, HttpServletRequest request);

    Result listCollect(CollectFindDto collectFindDto);
}
