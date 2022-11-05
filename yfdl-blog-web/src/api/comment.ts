import request from '@/utils/request'

export const commentList=(pageinfo:any,articleId:number)=>{
    return request(`/comment/commentList`,"get",{
        ...pageinfo,
        articleId
    })
}