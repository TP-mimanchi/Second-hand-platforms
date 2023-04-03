package com.mrxu.stucomplarear2.service;

import com.mrxu.stucomplarear2.entity.Image;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mrxu.stucomplarear2.utils.response.Result;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Mr.Xu
 * @since 2022-01-23
 */
public interface ImageService extends IService<Image> {

    Result uploadImage(HttpServletRequest request, MultipartFile[] files);

    void viewImage(HttpServletResponse response, String imageId) throws IOException;

    Result listImages(int page, int size);

    Result deleteById(String imageId);
}
