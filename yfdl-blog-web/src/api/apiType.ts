export  type ArticleListInfo={
    id:number,
    categoryName:string,
    commentCount:number,
    createTime:string,
    status:string,
    summary:string,
    tags:{
        id:number,
        name:string
    }[],
    thumbnail:string,
    title:string,
    viewCount:number,
    likesCount:number,
    createBy:number,
    avatar:string,
    nickName:string
}

export type ArticleDetail={
    id:number,
    categoryName:string,
    commentCount:number,
    createTime:string,
    status:string,
    summary:string,
    tags:{
        id:number,
        name:string
    }[],
    thumbnail:string,
    title:string,
    viewCount:number,
    likesCount:number,
    createBy:number,
    avatar:string,
    nickName:string,
    content:string,
    isComment:string
}

export type CommentInfo ={
    articleId:number,
    children:CommentInfo[]
    content:string,
    createBy:number,
    createTime:string,
    id:number,
    username:string,
    avatar:string,
    rootId:number,
    toCommentId:number,
    toCommentUserAvatar:string,
    toCommentUserName:string,
    toCommentUserId:number

}