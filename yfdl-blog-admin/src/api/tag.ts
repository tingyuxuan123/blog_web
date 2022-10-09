import request from '@/utils/request'

/**
 * 返回所有的标签
 * @returns 标签列表
 */
export const getAllTagList=()=>{

    return request("/tag/tagList","get");

}