import request from '@/utils/request'

export const queryArticleList=(queryParams:any,pageinfo:any)=>{

    return request("/article/articleList","get",{
        ...queryParams,
        ...pageinfo
    });

}