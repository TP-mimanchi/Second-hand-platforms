package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.dto.LetterAddDto;
import com.mrxu.stucomplarear2.dto.LetterVo;
import com.mrxu.stucomplarear2.entity.Letter;
import com.mrxu.stucomplarear2.entity.User;
import com.mrxu.stucomplarear2.mapper.LetterMapper;
import com.mrxu.stucomplarear2.mapper.UserMapper;
import com.mrxu.stucomplarear2.service.LetterService;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.response.Result;
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
 * @since 2022-04-28
 */
@Service
public class LetterServiceImpl extends ServiceImpl<LetterMapper, Letter> implements LetterService {

    @Autowired
    private LetterMapper letterMapper;
    @Autowired
    private UserMapper userMapper;

    @Override
    public Result add(LetterAddDto letterAddDto, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String senderId = JWTUtil.getUserId(accessToken);
            if (letterAddDto.getReceiverId() == null) {
                return Result.fail("接收者ID为空");
            }
            User receiver = userMapper.selectById(letterAddDto.getReceiverId());
            if (receiver == null) {
                return Result.fail("接收方不存在");
            }
            if (receiver.getUserId() == Integer.valueOf(senderId)) {
                return Result.fail("不可以给自己发送");
            }
            if (letterAddDto.getLetterDetail() == null) {
                return Result.fail("内容不能为空");
            }
            Letter letter = new Letter();
            letter.setReceiverId(letterAddDto.getReceiverId());
            letter.setSenderId(Integer.valueOf(senderId));
            letter.setLetterDetail(letterAddDto.getLetterDetail());
            letter.setLetterStatus(0);

            String sessionId = Integer.valueOf(senderId) < letterAddDto.getReceiverId()
                    ? senderId + "_" + letterAddDto.getReceiverId() : letterAddDto.getReceiverId() + "_" + senderId;
            letter.setSessionId(sessionId);
            letterMapper.insert(letter);
            return Result.succ("发送成功");
        } catch (Exception e) {
            System.out.println(e);
            return Result.fail(e.toString());
        }
    }

    /**
     * @param request
     * @return
     */
    @Override
    public Result getMySessionList(HttpServletRequest request) {
        List resultMapList = new ArrayList();
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            //获取当前用户的会话列表（针对每个会话只返回一个最新的私信ID和会话ID）
            List<Map<String, Object>> sessionList = getSessionList(Integer.valueOf(userId));

            for (Map map : sessionList) {
                Map<String, Object> resultMap = new HashMap<>();

                //获取最新私信信息
                Letter letter = letterMapper.selectById((Integer) map.get("letter_id"));
                resultMap.put("letter", letter);

                String sessionId = (String) map.get("session_id");
                //获取当前用户未读私信数
                int unReadCount = getUnReadLetterCount(sessionId,Integer.valueOf(userId));
                resultMap.put("unReadCount", unReadCount);

                //获取会话对方对象
                User targetUser = getLetterTarget(sessionId, Integer.valueOf(userId));
                resultMap.put("targetUser", targetUser);
                resultMapList.add(resultMap);
            }
            return Result.succ(resultMapList);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }

    @Override
    public Result getMyNoticeList(HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            QueryWrapper<Letter> queryWrapper=new QueryWrapper<>();
            queryWrapper.eq("sender_id",0);
            queryWrapper.eq("receiver_id",userId);
            queryWrapper.orderByDesc("create_time");
            List<Letter> noticeList = letterMapper.selectList(queryWrapper);

            //更新状态为已读
            for (Letter letter:noticeList){
                if(letter.getLetterStatus()==0){
                    UpdateWrapper updateWrapper = new UpdateWrapper();
                    updateWrapper.eq("letter_id",letter.getLetterId());
                    updateWrapper.set("letter_status",1);
                    letterMapper.update(null,updateWrapper);
                }
            }
            return Result.succ(noticeList);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }

    @Override
    public Result addNotice(LetterAddDto letterAddDto) {
        try {
            if (letterAddDto.getReceiverId() == null) {
                return Result.fail("接收者ID为空");
            }
            User receiver = userMapper.selectById(letterAddDto.getReceiverId());
            if (receiver == null) {
                return Result.fail("接收方不存在");
            }
            if (letterAddDto.getLetterDetail() == null) {
                return Result.fail("内容不能为空");
            }
            Letter letter = new Letter();
            letter.setReceiverId(letterAddDto.getReceiverId());
            letter.setSenderId(0);
            letter.setLetterDetail(letterAddDto.getLetterDetail());
            letter.setLetterStatus(0);

            String sessionId = 0 + "_" + letterAddDto.getReceiverId();
            letter.setSessionId(sessionId);
            letterMapper.insert(letter);
            return Result.succ("发送成功");
        } catch (Exception e) {
            System.out.println(e);
            return Result.fail(e.toString());
        }
    }

    @Override
    public Result getMyUnReadTotal(HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            QueryWrapper<Letter> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("receiver_id",userId);
            queryWrapper.eq("letter_status",0);
            Integer unReadCount = letterMapper.selectCount(queryWrapper);
            return Result.succ(unReadCount);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }

    @Override
    public Result getMyUnReadLetterTotal(HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            QueryWrapper<Letter> queryWrapper = new QueryWrapper<>();
            queryWrapper.ne("sender_id", 0);
            queryWrapper.eq("receiver_id", userId);
            queryWrapper.eq("letter_status", 0);
            Integer unReadCount = letterMapper.selectCount(queryWrapper);
            return Result.succ(unReadCount);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }

    @Override
    public Result getMyUnReadNoticeTotal(HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);

            QueryWrapper<Letter> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("sender_id", 0);
            queryWrapper.eq("receiver_id", userId);
            queryWrapper.eq("letter_status", 0);
            Integer unReadCount = letterMapper.selectCount(queryWrapper);
            return Result.succ(unReadCount);
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }
    }

    @Override
    public Result getLetterListBySessionId(String sessionId, HttpServletRequest request) {
        try {
            String accessToken = request.getHeader("Authorization");
            //获取token里面的用户ID
            String userId = JWTUtil.getUserId(accessToken);
            String[] ids = sessionId.split("_");
            if (userId.equals(ids[0])||userId.equals(ids[1])) {
                QueryWrapper<Letter> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("session_id",sessionId);
                queryWrapper.ne("sender_id",0);
                queryWrapper.orderByAsc("create_time");
                List<Letter> letterList = letterMapper.selectList(queryWrapper);
                List<LetterVo> letterVoList = new ArrayList<>();
                for(Letter letter:letterList){
                    //更新状态为已读
                    UpdateWrapper<Letter> updateWrapper=new UpdateWrapper<>();
                    updateWrapper.eq("letter_id",letter.getLetterId());
                    updateWrapper.set("letter_status",1);
                    letterMapper.update(null,updateWrapper);

                    //包装成VO
                    LetterVo letterVo = new LetterVo() ;
                    BeanUtils.copyProperties(letter,letterVo);
                    User receiver = userMapper.selectById(letter.getReceiverId());
                    User sender = userMapper.selectById(letter.getSenderId());
                    letterVo.setReceiver(receiver);
                    letterVo.setSender(sender);
                    letterVoList.add(letterVo);
                }
                return Result.succ(letterVoList);
            }else {
                return Result.fail("无权查看别人的聊天");
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            return Result.fail(exception.toString());
        }

    }

    /**
     * 查询当前用户的会话列表（针对每个会话只返回一个最新的私信ID和会话ID）
     *
     * @param userId
     * @return
     */
    private List getSessionList(Integer userId) {
        try {
            QueryWrapper<Letter> queryWrapper = new QueryWrapper<>();
            queryWrapper.select("max(letter_id) as letter_id,session_id");
            queryWrapper.ne("sender_id", 0);
            queryWrapper.and(qw -> qw.eq("sender_id", userId).or().eq("receiver_id", userId));
            queryWrapper.groupBy("session_id");
            queryWrapper.orderByDesc("create_time");
            List<Map<String, Object>> sessionList = letterMapper.selectMaps(queryWrapper);
            return sessionList;
        } catch (Exception exception) {
            exception.printStackTrace();
            return null;
        }
    }


    /**
     * 获取当前用户某个会话未读私信数
     * @param sessionId
     * @param userId
     * @return
     */
    private int getUnReadLetterCount(String sessionId, Integer userId) {
        QueryWrapper<Letter> sessionQueryWrapper = new QueryWrapper<>();
        sessionQueryWrapper.eq("session_id", sessionId);
        sessionQueryWrapper.eq("letter_status", 0);
        sessionQueryWrapper.eq("receiver_id", userId);
        sessionQueryWrapper.ne("sender_id",0);
        Integer unReadCount = letterMapper.selectCount(sessionQueryWrapper);
        unReadCount = unReadCount == null ? 0 : unReadCount;
        return unReadCount;
    }

    /**
     * 获取会话对方对象
     * @param sessionId
     * @param userId
     * @return
     */
    private User getLetterTarget(String sessionId, Integer userId) {
        String[] ids = sessionId.split("_");
        int id0 = Integer.parseInt(ids[0]);
        int id1 = Integer.parseInt(ids[1]);

        if (userId == id0) {
            return userMapper.selectById(id1);
        } else {
            return userMapper.selectById(id0);
        }
    }
}
