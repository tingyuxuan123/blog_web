import request from '@/utils/request'

export const followApi = (followId: number) => {
  return request(`/follow`, 'get', {
    followId
  })
}

export const followListApi = (id: number) => {
  return request('/follow/followList', 'get', {
    id
  })
}
