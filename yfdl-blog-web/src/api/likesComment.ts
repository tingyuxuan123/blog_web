import request from '@/utils/request'

export const likeCommentByArticle = (articleId: number) => {
  return request(`/LikesComment/likeCommentByArticle`, 'get', {
    articleId
  })
}
