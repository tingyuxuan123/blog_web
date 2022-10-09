import request from '@/utils/request'


export const updateInfo=(userInfo)=>{
    return request("/user/updateInfo",'post',{
        ...userInfo
    })
}

export const updatePassword=(password:string,)=>{
    return request("/user/updatePassword",'post',{
        password
    })
}

export const getRouters=()=>{
    return request("/getRouters",'get')   
}