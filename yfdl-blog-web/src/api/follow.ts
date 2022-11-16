import request from '@/utils/request'

export const followApi=(followId:number)=>{
    return request(`/follow`,"get",{
        followId
    })
}