import request from '@/utils/request'

export function fetchCommentList(query) {
  return request({
    url: '/comment/listByAdmin',
    method: 'get',
    params: query
  })
}

export function fetchCommentTotal() {
  return request({
    url: '/comment/getCommentTotal',
    method: 'get'
  })
}

export function deleteComment(query) {
  return request({
    url: '/comment/deleteByAdmin',
    method: 'delete',
    params: query
  })
}

