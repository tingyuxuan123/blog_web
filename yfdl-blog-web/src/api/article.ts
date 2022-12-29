import request from '@/utils/request'

export const articleList = (queryParams: any, pageinfo: any) => {
  return request('/article/articleList', 'get', {
    ...queryParams,
    ...pageinfo
  })
}

export const articleListByUserId = (
  createBy: number,
  queryParams: any,
  pageinfo: any
) => {
  return request('/article/articleList', 'get', {
    userId: createBy,
    ...queryParams,
    ...pageinfo
  })
}

export const articleDetail = (id: string) => {
  return request(`/article/${id}`, 'get')
}

export const updateViewCount = (id: string) => {
  return request(`/article/updateViewCount/${id}`, 'put')
}

export const articleListByUserLikes = (userId: number) => {
  return request('/article/articleListByUserLikes', 'get', {
    userId
  })
}
