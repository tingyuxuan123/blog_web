import request from '@/utils/request'

export const authorInfoByArticle=(articleId:string)=>{
    return request(`/user/authorInfoByArticle`,"get",{
        articleId
    })
}

export const userInfoByHomePage=(userId:number)=>{
    return request("/user/userInfoByHomePage","get",{
        userId
    })
}