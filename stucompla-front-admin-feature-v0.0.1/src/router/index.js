import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },

  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },

  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [{
      path: 'dashboard',
      name: 'Dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: { title: '学生交流平台管理系统', icon: 'dashboard' }
    }]
  },

  // 人员管理
  {
    path: '/users',
    component: Layout,
    redirect: '/users/userTable',
    name: 'Users',
    meta: { title: '人员管理', icon: 'el-icon-s-help' },
    children: [
      {
        path: 'userTable',
        name: 'UserTable',
        component: () => import('@/views/users/user-table'),
        meta: { title: '用户管理', icon: 'table' }
      },
      {
        path: 'adminTable',
        name: 'AdminTable',
        component: () => import('@/views/users/admin-table'),
        meta: { title: '管理员管理', icon: 'tree' }
      }
    ]
  },

  // 帖子管理
  {
    path: '/posts',
    component: Layout,
    children: [
      {
        path: 'index',
        name: 'Posts',
        component: () => import('@/views/posts/index'),
        meta: { title: '帖子管理', icon: 'form' }
      }
    ]
  },

  // 评论管理
  {
    path: '/comments',
    component: Layout,
    children: [
      {
        path: 'index',
        name: 'Comments',
        component: () => import('@/views/comments/index'),
        meta: { title: '评论管理', icon: 'form' }
      }
    ]
  },

  // 表白墙管理
  {
    path: '/walls',
    component: Layout,
    children: [
      {
        path: 'index',
        name: 'Walls',
        component: () => import('@/views/walls/index'),
        meta: { title: '表白墙审核', icon: 'form' }
      }
    ]
  },
  // 二手交易管理
  {
    path: '/market',
    component: Layout,
    redirect: '/market/goodsTable',
    name: 'Market',
    meta: { title: '二手交易管理', icon: 'el-icon-s-help' },
    children: [
      {
        path: 'goodsTable',
        name: 'GoodsTable',
        component: () => import('@/views/market/goods-table'),
        meta: { title: '商品管理', icon: 'table' }
      },
      {
        path: 'orderTable',
        name: 'OrderTable',
        component: () => import('@/views/market/order-table'),
        meta: { title: '订单管理', icon: 'tree' }
      }
    ]
  },
  // 我的密码
  {
    path: '/myPassword',
    component: Layout,
    children: [
      {
        path: 'index',
        name: 'MyPassword',
        component: () => import('@/views/myPassword/index'),
        meta: { title: '我的密码', icon: 'form' }
      }
    ]
  },

  // 404 page must be placed at the end !!!
  { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () => new Router({
  // mode: 'history', // require service support
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
