import request from '@/utils/request'

export const commentList = (pageinfo: any, articleId: number) => {
  return request(`/comment/commentList`, 'get', {
    ...pageinfo,
    articleId
  })
}

export const comment = (comment: any) => {
  return request(`/comment`, 'post', {
    ...comment
  })
}

/**
 * 点赞
 */
export const thumbsUp = (commentId: number, articleId: number) => {
  return request('/comment/thumbsUp', 'get', {
    commentId,
    articleId
  })
}
