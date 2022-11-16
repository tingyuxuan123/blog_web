import request from '@/utils/request'

export const likesApi=(articleId:number)=>{
    return request(`/likes`,"get",{
        articleId
    })
}