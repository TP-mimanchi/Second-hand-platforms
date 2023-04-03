package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.WallApplyDto;
import com.mrxu.stucomplarear2.dto.WallAuditDto;
import com.mrxu.stucomplarear2.dto.WallFindDto;
import com.mrxu.stucomplarear2.entity.User;
import com.mrxu.stucomplarear2.entity.Wall;
import com.mrxu.stucomplarear2.mapper.UserMapper;
import com.mrxu.stucomplarear2.mapper.WallMapper;
import com.mrxu.stucomplarear2.service.WallService;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Mr.Xu
 * @since 2021-12-15
 */
@Service
public class WallServiceImpl extends ServiceImpl<WallMapper, Wall> implements WallService {

    @Autowired
    private WallMapper wallMapper;
    @Autowired
    private UserMapper userMapper;

    @Override
    public String apply(WallApplyDto wallApplyDto , HttpServletRequest request) {
        String accessToken = request.getHeader("Authorization");
        //获取token里面的用户ID
        String userId = JWTUtil.getUserId(accessToken);

        if (userId == null) {
            return "参数错误";
        }
        if (StringUtils.isBlank(wallApplyDto.getWallContent())&&StringUtils.isBlank(wallApplyDto.getWallImages())) {
            return "内容不能为空";
        }
        Wall wall = new Wall();
        wall.setUserId(Integer.valueOf(userId));
        wall.setWallContent(wallApplyDto.getWallContent());
        if (StringUtils.isNotBlank(wallApplyDto.getWallImages())){
            wall.setWallImages(wallApplyDto.getWallImages());
        }
        wall.setAuditState(0);
        wallMapper.insert(wall);
        return "申请成功";
    }

    @Override
    public String audit(WallAuditDto wallAuditDto , HttpServletRequest request) {
        String accessToken = request.getHeader("Authorization");
        //获取token里面的用户ID
        String adminId = JWTUtil.getUserId(accessToken);

        if (wallAuditDto.getWallId() == null) {
            return "墙ID不能为空";
        }
        if (adminId == null) {
            return "审核员ID不能为空";
        }
        if (wallAuditDto.getAuditState() != 1 && wallAuditDto.getAuditState() != 2) {
            return "审核状态参数错误";
        }
        Wall findWall = wallMapper.selectById(wallAuditDto.getWallId());
        if (findWall == null) {
            return "该信息不存在";
        }
        findWall.setAdminId(Integer.valueOf(adminId));
        findWall.setAuditState(wallAuditDto.getAuditState());
        if (wallAuditDto.getAuditState() == 1) {
            findWall.setAuditFailedCause(null);
        }
        if (wallAuditDto.getAuditState() == 2) {
            findWall.setAuditFailedCause(wallAuditDto.getAuditFailedCause());
        }
        wallMapper.updateById(findWall);
        return "审核成功";
    }

    @Override
    public Map<String, Object> findWallList(Integer pageNum, Integer pageSize) {
        int first = pageNum == null ? 1 : pageNum;
        int second = pageSize == null ? 4 : pageSize;
        //当前页 页面大小
        IPage<Wall> page = new Page<Wall>(first, second);
        QueryWrapper<Wall> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("audit_state", 1);   //已审的内容
        queryWrapper.orderByDesc("audit_time"); //根据审核时间降序排列
        IPage<Wall> wallIPage = wallMapper.selectPage(page, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", wallIPage.getCurrent());//当前页
        map.put("total", wallIPage.getTotal());//总记录数
        map.put("pages", wallIPage.getPages());//总页数
        map.put("pageSize", wallIPage.getSize());//页面大小
        map.put("walls", wallIPage.getRecords());//数据
        return map;
    }

    @Override
    public Map<String, Object> findWall(WallFindDto wallFindDto) {
        int pageNum = wallFindDto.getPageNum() == null ? 1 : wallFindDto.getPageNum();
        int pageSize = wallFindDto.getPageSize() == null ? 10 : wallFindDto.getPageSize();
        QueryWrapper<Wall> queryWrapper = new QueryWrapper<>();
        if (wallFindDto.getWallId() != null) {
            queryWrapper.eq("wall_id", wallFindDto.getWallId());
        }
        if (wallFindDto.getAdminId() != null) {
            queryWrapper.eq("admin_id", wallFindDto.getAdminId());
        }
        if (wallFindDto.getUserId() != null) {
            queryWrapper.eq("user_id", wallFindDto.getUserId());
        }
        if (wallFindDto.getAuditState() != null) {
            queryWrapper.eq("audit_state", wallFindDto.getAuditState());
        }
        String sort=wallFindDto.getSort();
        if ("+wall_id".equals(sort)) {
            queryWrapper.orderByAsc("wall_id");//根据post_id升序排列
        } else if ("-wall_id".equals(sort)) {
            queryWrapper.orderByDesc("wall_id");
        } else if ("+audit_time".equals(sort)) {
            queryWrapper.orderByAsc("audit_time");
        } else if ("-audit_time".equals(sort)) {
            queryWrapper.orderByDesc("audit_time");
        } else if ("+comment_num".equals(sort)) {
            queryWrapper.orderByAsc("comment_num");
        } else if ("-comment_num".equals(sort)) {
            queryWrapper.orderByDesc("comment_num");
        }else if ("+like_num".equals(sort)) {
            queryWrapper.orderByAsc("like_num");
        } else if ("-like_num".equals(sort)) {
            queryWrapper.orderByDesc("like_num");
        } else {
            queryWrapper.orderByDesc("createtime"); //默认申请时间降序
        }

        //当前页 页面大小
        IPage<Wall> page = new Page<Wall>(pageNum, pageSize);

//        queryWrapper.orderByDesc("audit_time"); //根据审核时间降序排列

        IPage<Wall> wallIPage = wallMapper.selectPage(page, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", wallIPage.getCurrent());//当前页
        map.put("total", wallIPage.getTotal());//总记录数
        map.put("pages", wallIPage.getPages());//总页数
        map.put("pageSize", wallIPage.getSize());//页面大小
        map.put("walls", wallIPage.getRecords());//数据
        return map;
    }

    @Override
    public Result getWallTotal() {
        try {
            QueryWrapper<Wall> queryWrapper = new QueryWrapper<>();
            Integer selectCount = wallMapper.selectCount(queryWrapper);
            return Result.succ(selectCount);
        } catch (Exception e) {
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result getWallData() {
        try {
            QueryWrapper<Wall> queryWrapper = new QueryWrapper<>();
            queryWrapper.select("audit_state,count(*) as auditStateCount");
            queryWrapper.groupBy("audit_state");
            List<Map<String, Object>> wallList = wallMapper.selectMaps(queryWrapper);
            for (Map<String, Object> map:wallList){
                if(map.get("audit_state").equals(0)){
                    map.put("stateName","未审核");
                }else if (map.get("audit_state").equals(1)){
                    map.put("stateName","审核通过");
                }else if (map.get("audit_state").equals(2)){
                    map.put("stateName","审核不通过");
                }
            }
            return Result.succ(wallList);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }

    @Override
    public Result findMyWall(WallFindDto wallFindDto, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            if (StringUtils.isNotBlank(userId)){
                User user=userMapper.selectById(userId);
                if (user==null){
                    return Result.fail("用户不存在");
                }
            }else {
                return Result.fail("验证失败");
            }
            int pageNum = wallFindDto.getPageNum() == null ? 1 : wallFindDto.getPageNum();
            int pageSize = wallFindDto.getPageSize() == null ? 8 : wallFindDto.getPageSize();
            QueryWrapper<Wall> queryWrapper = new QueryWrapper<>();

            queryWrapper.eq("user_id", userId);
            queryWrapper.orderByDesc("createtime"); //默认申请时间降序

            //当前页 页面大小
            IPage<Wall> page = new Page<Wall>(pageNum, pageSize);

//        queryWrapper.orderByDesc("audit_time"); //根据审核时间降序排列

            IPage<Wall> wallIPage = wallMapper.selectPage(page, queryWrapper);
            Map<String, Object> map = new HashMap<>();
            map.put("current", wallIPage.getCurrent());//当前页
            map.put("total", wallIPage.getTotal());//总记录数
            map.put("pages", wallIPage.getPages());//总页数
            map.put("pageSize", wallIPage.getSize());//页面大小
            map.put("walls", wallIPage.getRecords());//数据
            return Result.succ(map);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }
}
