import request from '@/utils/request'

export const authorInfoByArticle = (articleId: string) => {
  return request(`/user/authorInfoByArticle`, 'get', {
    articleId
  })
}

export const userInfoByHomePage = (userId: number) => {
  return request('/user/userInfoByHomePage', 'get', {
    userId
  })
}

export const updateUserInfo = (userInfo: object) => {
  return request('/user/updateUserInfo', 'post', {
    ...userInfo
  })
}

export const unbindingEmailAPi = () => {
  return request('/user/unbindingEmail', 'get')
}

export const sendCodeNeedVerify = (email: string) => {
  return request('/user/sendCodeNeedVerify', 'get', {
    email
  })
}

export const updateEmail = (email: string, code: string) => {
  return request('/user/updateEmail', 'get', {
    email,
    code
  })
}

export const updatePassword = (password: string, newPassword: string) => {
  return request('/user/changePassword', 'post', {
    password,
    newPassword
  })
}
