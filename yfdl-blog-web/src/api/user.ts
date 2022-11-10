import request from '@/utils/request'

export const authorInfoByArticle=(articleId:string)=>{
    return request(`/user/authorInfoByArticle`,"get",{
        articleId
    })
}