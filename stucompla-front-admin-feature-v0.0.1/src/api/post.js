import request from '@/utils/request'

export function fetchPostList(query) {
  return request({
    url: '/post/list',
    method: 'get',
    params: query
  })
}

export function fetchPostTotal() {
  return request({
    url: '/post/getPostTotal',
    method: 'get'
  })
}

export function fetchPostCountByCategory() {
  return request({
    url: '/post/getPostData',
    method: 'get'
  })
}

export function lockedPost(query) {
  return request({
    url: '/post/lockedPost',
    method: 'post',
    params: query
  })
}

export function unLockPost(query) {
  return request({
    url: '/post/unLockPost',
    method: 'post',
    params: query
  })
}

export function deletePostByAdmin(query) {
  return request({
    url: '/post/deleteByAdmin',
    method: 'delete',
    params: query
  })
}
