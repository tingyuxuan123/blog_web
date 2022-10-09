import request from '@/utils/request'

/**
 * 返回所有的分类
 * @returns 所有的分类
 */
export const getAllCategoryList=()=>{

    return request("/category/allCategoryList","get");

}


/**
 * 返回所有的分类详细版本
 * @returns 所有的分类
 */
 export const getAllCategoryDetailList=()=>{

    return request("/category/allCategoryDetailList","get");

}