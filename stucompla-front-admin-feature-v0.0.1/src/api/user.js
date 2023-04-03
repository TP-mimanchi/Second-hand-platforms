import request from '@/utils/request'

export function fetchList(query) {
  return request({
    url: '/user/list',
    method: 'get',
    params: query
  })
}

export function changeUserPwd(query) {
  return request({
    url: '/user/changePwdByAdmin',
    method: 'post',
    params: query
  })
}

export function lockedUser(query) {
  return request({
    url: '/user/lockedUser',
    method: 'post',
    params: query
  })
}

export function unLockUser(query) {
  return request({
    url: '/user/unLockUser',
    method: 'post',
    params: query
  })
}

export function fetchUserTotal() {
  return request({
    url: '/user/getUserTotal',
    method: 'get'
  })
}
