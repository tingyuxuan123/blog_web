import request from '@/utils/request'

export const insertCollect = (collectionId: Array<any>, articleId: number) => {
  return request('/collect/insertCollect', 'post', {
    collectionId,
    articleId
  })
}

export const cancelCollect = (articleId: number) => {
  return request('/collect/cancelCollect', 'get', {
    articleId
  })
}
