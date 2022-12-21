import request from '@/utils/request'

export const createCollection = (collection: any) => {
  return request('/collection/createCollection', 'post', {
    ...collection
  })
}

export const collectionListApi = () => {
  return request('/collection/collectionList', 'get')
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
