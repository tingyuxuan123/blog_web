import request from '@/utils/request'

export const createCollection = (collection: any) => {
  return request('/collection/createCollection', 'post', {
    ...collection
  })
}

export const collectionListApi = (id?: number) => {
  return request('/collection/collectionList', 'get', {
    id
  })
}

export const deleteCollectionApi = (collectionId: number) => {
  return request('/collection/deleteCollection', 'get', {
    collectionId
  })
}

export const updateCollectionApi = (data: any) => {
  return request('/collection/updateCollection', 'post', {
    ...data
  })
}
