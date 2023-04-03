import request from '@/utils/request'

export function fetchCategoryList() {
  return request({
    url: '/category/list',
    method: 'get'
  })
}
