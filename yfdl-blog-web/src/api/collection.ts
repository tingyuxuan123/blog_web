import request from '@/utils/request'



export const createCollection=(collection:any)=>{

    return request("/collection/createCollection","post",{
       ...collection
    });

}

export const collectionListApi=()=>{
    return request("/collection/collectionList","get")
}

