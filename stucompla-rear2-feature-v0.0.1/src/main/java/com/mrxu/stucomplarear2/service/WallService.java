package com.mrxu.stucomplarear2.service;

import com.mrxu.stucomplarear2.dto.WallApplyDto;
import com.mrxu.stucomplarear2.dto.WallAuditDto;
import com.mrxu.stucomplarear2.dto.WallFindDto;
import com.mrxu.stucomplarear2.entity.Wall;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.utils.response.Result;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-15
 */
public interface WallService extends IService<Wall> {

    String apply(WallApplyDto wallDto , HttpServletRequest request);

    String audit(WallAuditDto wallAuditDto,HttpServletRequest request);

    Map<String, Object> findWallList(Integer pageNum, Integer pageSize);

    Map<String, Object> findWall(WallFindDto wallFindDto);

    Result getWallTotal();

    Result getWallData();

    Result findMyWall(WallFindDto wallFindDto, HttpServletRequest request);
}
