package com.mrxu.stucomplarear2.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mrxu.stucomplarear2.entity.Image;
import com.mrxu.stucomplarear2.mapper.ImageMapper;
import com.mrxu.stucomplarear2.service.ImageService;
import com.mrxu.stucomplarear2.utils.Constants;
import com.mrxu.stucomplarear2.utils.IdWorker;
import com.mrxu.stucomplarear2.utils.TextUtils;
import com.mrxu.stucomplarear2.utils.jwt.JWTUtil;
import com.mrxu.stucomplarear2.utils.response.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-01-23
 */
@Slf4j
@Service
public class ImageServiceImpl extends ServiceImpl<ImageMapper, Image> implements ImageService {

    public static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy_MM_dd");

    @Value("${mrxu.stucomplarear2.image.save-path}")//取配置里的值
    private String imagePath;
    @Value("${mrxu.stucomplarear2.image.max-size}")//取配置里的值
    private long maxSize;

    @Autowired
    private IdWorker idWorker;

    @Autowired
    private ImageMapper imageMapper;

    /**
     * 上传的路径：可以配置，在配置文件里配置
     * 上传的内容：命名--可以用ID，-->每天一个文件夹保存
     * 限制文件大小：通过配置文件配置
     * 保存记录到数据库
     * ID/存储路径/URL/原名称/用户ID/状态/创建日期/更新日期
     *
     * @param files
     * @return
     */
    @Override
    public Result uploadImage(HttpServletRequest request, MultipartFile[] files) {
        //访问路径列表
        List imgList = new ArrayList();
        try {
            for (MultipartFile file : files) {
                //获取相关数据，比如说文件类型，文件名称
                String originalFilename = file.getOriginalFilename();
                log.info("originalFilename == > " + originalFilename);

                //判断文件类型，我们只支持图片上传，比如说：png，jpg，gif,jpeg
                String contentType = file.getContentType();
                log.info("contentType -- > " + contentType);
                if (TextUtils.isEmpty(contentType)) {
                    return Result.fail("文件格式错误");
                }
                String type = getType(originalFilename, contentType);
                if (type == null) {
                    return Result.fail("不支持此图片类型");
                }

                //限制文件大小
                long size = file.getSize();
                log.info("maxSize === > " + maxSize + " size === > " + size);
                if (size > maxSize) {
                    return Result.fail("图片最大仅支持" + (maxSize / 1024 / 1024) + "Mb");
                }
                //创建图片的保存目录
                //规则：配置目录/日期/类型/ID.类型
                long currentTimeMillis = System.currentTimeMillis();
                String currentDay = simpleDateFormat.format(currentTimeMillis);
                log.info("current day ==> " + currentDay);
                String dayPath = imagePath + File.separator + currentDay;
                File dayPathFile = new File(dayPath);
                if (!dayPathFile.exists()) {
                    //路径不存在则创建
                    dayPathFile.mkdirs();
                }
                //根据我们定的规则命名
                String targetName = String.valueOf(idWorker.nextId());
                String targetPath = dayPath + File.separator + type + File.separator + targetName + "." + type;
                File targetFile = new File(targetPath);
                if (!targetFile.getParentFile().exists()) {
                    targetFile.mkdirs();
                }

                if (!targetFile.exists()) {
                    targetFile.createNewFile();
                }
                log.info("targetFile -- > " + targetFile);
                //保存文件
                file.transferTo(targetFile);

                //第一个是访问路径 -- 》得对应着解析来
                Map<String, String> result = new HashMap<>();
                String resultPath = currentTimeMillis + "_" + targetName + "." + type;
                result.put("imageId", resultPath);
                //第二个是名称--》alt='图片描述'，如果不写前端可以使用这个名称作为这个描述
                result.put("name", originalFilename);
                Image image = new Image();
                image.setContentType(contentType);
                image.setId(targetName);
                image.setCreateTime(new Date());
                image.setUpdateTime(new Date());
                image.setPath(targetFile.getPath());
                image.setName(originalFilename);
                image.setUrl(resultPath);
                image.setState("1");
                String accessToken = request.getHeader("Authorization");
                //获取token里面的用户ID
                String userId = JWTUtil.getUserId(accessToken);
                image.setUserId(Integer.valueOf(userId));
                imageMapper.insert(image);
                //到这里

                imgList.add("http://localhost:8086/image/" + resultPath);

                //记录文件
                //保存记录到数据库里
                //返回结果：包含图片的名称和访问路径

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Result.succ(imgList);
    }

    /**
     * 获取类型
     *
     * @param name
     * @param contentType
     * @return
     */
    private String getType(String name, String contentType) {
        String type = null;
        if ("image/png".equals(contentType) && name.toLowerCase().endsWith(".png")) {
            type = "png";
        } else if ("image/gif".equals(contentType) && name.toLowerCase().endsWith(".gif")) {
            type = "gif";
        } else if ("image/jpg".equals(contentType) && name.toLowerCase().endsWith(".jpg")) {
            type = "jpg";
        } else if ("image/jpeg".equals(contentType) && name.toLowerCase().endsWith(".jpg")) {
            type = "jpeg";   //.jpg格式 在上传的时候调用file.getContentType()的时候却是.jpeg格式  -->把这个存为jpeg
        } else if ("image/jpeg".equals(contentType) && name.toLowerCase().endsWith(".jpeg")) {
            type = "jpeg";
        }
        return type;
    }

    @Override
    public void viewImage(HttpServletResponse httpServletResponse, String imageId) throws IOException {
        //配置目录已知

        //根据尺寸来动态返回图片给前端
        //好处：减少宽带占用，传输速度快
        //缺点：消耗后台cpu资源
        //推荐做法：上传上来的时候，把图片复制成三个尺寸：大，中，小
        //根据尺寸返回结果即可  自己找框架

        //使用日期的时间戳_ID.类型
        //需要日期
        String[] paths = imageId.split("_");
        String dayValue = paths[0];
        String format = simpleDateFormat.format(Long.parseLong(dayValue));
        log.info("viewImage  format -- > " + format);
        //ID
        String name = paths[1];
        //需要类型
        String type = name.substring(name.lastIndexOf(".") + 1);

        String targetPath = imagePath + File.separator + format + File.separator + type + File.separator + name;
        log.info("get image target path --> " + targetPath);


        File file = new File(targetPath);
        OutputStream outputStream = null;
        FileInputStream fileInputStream = null;
        try {
            httpServletResponse.setContentType("image/jpg");//设置内容类型
            outputStream = httpServletResponse.getOutputStream();
            //读取
            fileInputStream = new FileInputStream(file);
            byte[] buff = new byte[1024];
            int length;
            while ((length = fileInputStream.read(buff)) != -1) {
                outputStream.write(buff, 0, length);
            }
            outputStream.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fileInputStream != null) {
                fileInputStream.close();//关流
            }
            if (outputStream != null) {
                outputStream.close();//关流
            }
        }
    }

    @Override
    public Result listImages(int page, int size) {
        //处理page和size 参数检查
        if (page < Constants.Page.DEFAULT_PAGE) {
            page = Constants.Page.DEFAULT_PAGE;
        }
        if (size < Constants.Page.MIN_SIZE) {
            size = Constants.Page.MIN_SIZE;
        }
        //创建分页条件
        QueryWrapper<Image> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("state", "1");
        //当前页 页面大小
        IPage<Image> iPage = new Page<Image>(page, size);
        queryWrapper.orderByDesc("create_time"); //根据上传时间降序排列

        IPage<Image> imageIPage = imageMapper.selectPage(iPage, queryWrapper);
        Map<String, Object> map = new HashMap<>();
        map.put("current", imageIPage.getCurrent());//当前页
        map.put("total", imageIPage.getTotal());//总记录数
        map.put("pages", imageIPage.getPages());//总页数
        map.put("pageSize", imageIPage.getSize());//页面大小
        map.put("images", imageIPage.getRecords());//数据
        //查询
        //返回结果
        return Result.succ(map);
    }

    /**
     * 删除图片
     * 只改变状态
     *
     * @param imageId
     * @return
     */
    @Override
    public Result deleteById(String imageId) {
        int result = imageMapper.deleteImageByUpdateSteta(imageId);
        if (result > 0) {
            return Result.succ("删除成功");
        }
        return Result.fail("图片不存在");
    }
}
