import request from '@/utils/request'

export function fetchWallList(query) {
  return request({
    url: '/wall/auditWallList',
    method: 'get',
    params: query
  })
}

export function fetchWallTotal() {
  return request({
    url: '/wall/getWallTotal',
    method: 'get'
  })
}

export function fetchWallCountByState() {
  return request({
    url: '/wall/getWallData',
    method: 'get'
  })
}

export function auditWall(data) {
  return request({
    url: '/wall/audit',
    method: 'post',
    data
  })
}
