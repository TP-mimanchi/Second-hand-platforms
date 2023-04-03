import request from '@/utils/request'

export function login(loginInfo) {
  return request({
    url: '/admin/info/login',
    method: 'post',
    data: loginInfo
  })
}

export function logout() {
  return request({
    url: '/admin/info/logout',
    method: 'delete'
  })
}

export function getInfo() {
  return request({
    url: '/admin/info',
    method: 'get'
  })
}

export function fetchList(query) {
  return request({
    url: '/admin/info/list',
    method: 'get',
    params: query
  })
}

export function changeMyPwd(query) {
  return request({
    url: '/admin/info/changePassword',
    method: 'post',
    params: query
  })
}

export function changeMyUsername(query) {
  return request({
    url: '/admin/info/changeMyUsername',
    method: 'post',
    params: query
  })
}

export function changeRole(query) {
  return request({
    url: '/admin/info/changeRole',
    method: 'post',
    params: query
  })
}

export function deleteAdmin(query) {
  return request({
    url: '/admin/info/deleteAdmin',
    method: 'delete',
    params: query
  })
}

export function addAdmin(query) {
  return request({
    url: '/admin/info/add',
    method: 'post',
    params: query
  })
}
