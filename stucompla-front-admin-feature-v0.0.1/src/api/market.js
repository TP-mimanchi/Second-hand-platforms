import request from '@/utils/request'

export function fetchGoodsList(query) {
  return request({
    url: '/goods/getList',
    method: 'get',
    params: query
  })
}

export function fetchGoodsTotal() {
  return request({
    url: '/goods/getGoodsTotal',
    method: 'get'
  })
}

export function fetchGoodsCountByCategory() {
  return request({
    url: '/goods/getGoodsByCategory',
    method: 'get'
  })
}

export function fetchOrderTotal() {
  return request({
    url: '/market-order/getOrderTotal',
    method: 'get'
  })
}

export function fetchOrderList(query) {
  return request({
    url: '/market-order/orderList',
    method: 'get',
    params: query

  })
}

export function unShelve(data) {
  return request({
    url: '/goods/unShelve/' + data,
    method: 'post'
  })
}
export function deleteGoods(data) {
  return request({
    url: '/goods/deleteGoods/' + data,
    method: 'post'
  })
}
