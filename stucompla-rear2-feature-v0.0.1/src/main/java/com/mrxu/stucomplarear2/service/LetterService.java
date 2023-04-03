package com.mrxu.stucomplarear2.service;

import com.mrxu.stucomplarear2.dto.LetterAddDto;
import com.mrxu.stucomplarear2.entity.Letter;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.utils.response.Result;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-04-28
 */
public interface LetterService extends IService<Letter> {

    Result add(LetterAddDto letterAddDto, HttpServletRequest request);

    Result getMySessionList(HttpServletRequest request);

    Result getMyNoticeList(HttpServletRequest request);

    Result addNotice(LetterAddDto letterAddDto);

    Result getMyUnReadTotal(HttpServletRequest request);

    Result getMyUnReadLetterTotal(HttpServletRequest request);

    Result getMyUnReadNoticeTotal(HttpServletRequest request);

    Result getLetterListBySessionId(String sessionId, HttpServletRequest request);
}
