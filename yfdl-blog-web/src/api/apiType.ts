export type ArticleListInfo = {
  id: number
  categoryName: string
  commentCount: number
  createTime: string
  status: string
  summary: string
  tags: {
    id: number
    name: string
  }[]
  thumbnail: string
  title: string
  viewCount: number
  likesCount: number
  createBy: number
  avatar: string
  nickName: string
}

export type ArticleDetail = {
  id: number
  categoryName: string
  commentCount: number
  createTime: string
  status: string
  summary: string
  tags: {
    id: number
    name: string
  }[]
  thumbnail: string
  title: string
  viewCount: number
  likesCount: number
  isLikes: boolean
  createBy: number
  avatar: string
  nickName: string
  content: string
  isComment: string
  isCollect: boolean
}

export type CommentInfo = {
  articleId: number
  children: CommentInfo[]
  content: string
  createBy: number
  createTime: string
  id: number
  username: string
  avatar: string
  rootId: number
  toCommentId: number
  toCommentUserAvatar: string
  toCommentUserName: string
  toCommentUserId: number
  likesCount: number
}

export type SendCommentInfo = {
  articleId: number
  type: number
  rootId: number
  toCommentId: number
  toCommentUserId: number
  content: string
}

export type AuthorInfoByArticle = {
  id: number
  avatar: string
  isFollow: boolean
  label: string
  likesCount: number
  nickName: string
  readCount: number
}
