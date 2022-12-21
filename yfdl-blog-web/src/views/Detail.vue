<template>
  <div class="detail">
    <my-content>
      <template #left>
        <div class="left">
          <h1 class="title">{{ detail.title }}</h1>
          <article-user
            class="article-user"
            v-if="info?.createBy"
            :info="info"
          ></article-user>
          <img class="article-thumbnail" :src="detail.thumbnail" alt="" />
          <md
            v-if="detail?.content != undefined"
            :content="detail.content"
            @handle-catalogue="getCatalogue"
          ></md>
          <div class="categoryInfo">
            <div class="category">
              分类：<span>{{ detail.categoryName }}</span>
            </div>
            <div class="tags">
              标签:
              <span v-for="item in detail.tags" :key="item.id">{{
                item.name
              }}</span>
            </div>
          </div>
        </div>
        <my-comment
          v-if="detail.id"
          :article-id="detail.id"
          ref="myComment"
        ></my-comment>
        <div class="article-suspended-panel">
          <el-badge
            :value="detail.likesCount"
            :class="{ likesActive: detail.isLikes }"
          >
            <span @click="likes"> <i class="iconfont icon-like"></i></span>
          </el-badge>

          <el-badge :value="detail.commentCount" class="">
            <span @click="toComment"> <i class="iconfont icon-chat"></i></span>
          </el-badge>
          <span @click="collect" :class="{ collectActive: detail.isCollect }">
            <svg-icon iconClass="collect2"></svg-icon
          ></span>
        </div>
      </template>
      <template #right>
        <myaside>
          <template #default>
            <!-- 用户信息 -->
            <aside-item class="userinfo">
              <template #header>
                <div class="userinfo-top">
                  <div>
                    <img
                      class="avatar"
                      :src="userInfo.avatar"
                      alt=""
                      @click="toUser(userInfo.id)"
                    />
                    <div class="userinfo-top-left">
                      <span class="nickName" @click="toUser(userInfo.id)">{{
                        userInfo.nickName
                      }}</span>
                      <span class="label">
                        <i v-if="userInfo.label">{{ userInfo.label }}</i>
                        <i v-else>这个人很神秘，什么都没留下</i>
                      </span>
                    </div>
                  </div>
                  <div>
                    <el-button v-if="!userInfo.isFollow" @click="follow"
                      >关注</el-button
                    >
                    <el-button @click="follow" class="hasFollow" v-else
                      >已关注</el-button
                    >
                    <el-button>私信</el-button>
                  </div>
                </div>
              </template>
              <template #content>
                <div class="userinfo-bottom">
                  <div>
                    <span> <i class="iconfont icon-like"></i> 获赞点击</span>
                    <span>{{ userInfo.likesCount }}</span>
                  </div>
                  <div>
                    <span> <i class="iconfont icon-eye"></i> 文章被阅读</span>
                    <span>{{ userInfo.readCount }}</span>
                  </div>
                </div>
              </template>
            </aside-item>
            <!-- 相关文章 -->
            <aside-item>
              <template #header> 相关文章 </template>
              <template #content>
                <li>12</li>
                <li>12</li>
                <li>12</li>
              </template>
            </aside-item>
            <!-- 目录 -->
            <div ref="catalogueDom" :class="{ catalogue_sticky: isFixed }">
              <aside-item v-if="cataloguesRef && cataloguesRef.length > 0">
                <template #header>
                  <span>目录</span>
                </template>
                <template #content>
                  <catalogueVue
                    :catalogues="cataloguesRef"
                    :nextheight="0"
                  ></catalogueVue>
                </template>
              </aside-item>
            </div>
          </template>
        </myaside>
      </template>
    </my-content>

    <my-collection
      v-if="VisibleCollection"
      :article-id="parseInt(id as string)"
      @handle-close="
        (isCollect) => {
          VisibleCollection = false
          detail.isCollect = isCollect
        }
      "
      @handle-add-collect="handleAddCollect"
    ></my-collection>
    <add-collect
      v-if="VisibleAddCollect"
      @handle-close="handleAddCollectClose"
    ></add-collect>
  </div>
</template>

<script lang="ts" setup>
import { nextTick, reactive, ref, computed, onMounted, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import { articleDetail, updateViewCount } from '@/api/article'
import type { ArticleDetail, AuthorInfoByArticle } from '@/api/apiType'
import { authorInfoByArticle } from '@/api/user'
import md from '@/components/MD.vue'
import MyContent from '@/components/MyContent.vue'
import myaside from '../components/aside/aside.vue'
import ArticleUser from '../components/Detail/articleUser.vue'
import catalogueVue from '@/components/Detail/catalogue.vue'
import AsideItem from '@/components/aside/asideItem.vue'
import MyComment from '@/components/comment/MyComment.vue'
import { copy } from '@/utils/copyObject'
import { isLogin, scrollToTop } from '@/utils/utils'
import { followApi } from '@/api/follow'
import { likesApi } from '@/api/likes'
import MyCollection from '@/components/collection/MyCollection.vue'
import AddCollect from '@/components/collection/AddCollect.vue'
import { cancelCollect } from '@/api/collect'
import { ElMessage } from 'element-plus'
import router from '@/router'

const route = useRoute()
const id = route.params.id || null
let detail = ref<ArticleDetail>({
  id: undefined,
  categoryName: undefined,
  commentCount: undefined,
  createTime: undefined,
  status: undefined,
  summary: undefined,
  tags: [],
  thumbnail: undefined,
  title: undefined,
  viewCount: undefined,
  likesCount: undefined,
  isLikes: false,
  createBy: undefined,
  avatar: undefined,
  nickName: undefined,
  content: undefined,
  isComment: undefined,
  isCollect: false
})

let userInfo = reactive<AuthorInfoByArticle>({
  id: undefined,
  avatar: undefined,
  isFollow: false,
  label: undefined,
  likesCount: undefined,
  nickName: undefined,
  readCount: undefined
})

let cataloguesRef = ref(null)

type Info = {
  id: number
  createBy: number
  avatar: string
  nickName: string
  categoryName: string
  viewCount: number
  createTime: string
}

let info = reactive<Info>({
  id: undefined,
  createBy: undefined,
  avatar: undefined,
  nickName: undefined,
  categoryName: undefined,
  viewCount: undefined,
  createTime: undefined
})

const getarticleDetail = async () => {
  let res = await articleDetail(id as string)
  detail.value = res.data
  // console.log(detail.value);
  info.id = detail.value.id
  info.avatar = detail.value.avatar
  info.categoryName = detail.value.categoryName
  info.createBy = detail.value.createBy
  info.createTime = detail.value.createTime
  info.nickName = detail.value.nickName
  info.viewCount = detail.value.viewCount
}

getarticleDetail()

const getCatalogue = (catalogue: any) => {
  cataloguesRef.value = catalogue
}

let isFixed = ref(false)

//吸顶实现
let catalogueDom = ref(null)

//获取用户信息
const getAuthorInfoByArticle = async () => {
  const res: any = await authorInfoByArticle(id as string)
  copy(res.data, userInfo)
  console.log(res)
}

getAuthorInfoByArticle()

//更新文章观看量；
const updateView = async () => {
  const res: any = await updateViewCount(id as string)
}

updateView()

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})

const handleScroll = () => {
  let scrollTop =
    window.pageYOffset ||
    document.documentElement.scrollTop ||
    document.body.scrollTop

  isFixed.value =
    scrollTop - 15 > catalogueDom.value.getBoundingClientRect().top
      ? true
      : false
  //isFixed.value = scrollTop > 133? true : false;
}

//添加关注
const follow = async () => {
  let b = isLogin()
  if (!b) {
    return
  }
  let res: any = await followApi(userInfo.id)
  userInfo.isFollow = !userInfo.isFollow
}

//点赞
const likes = async () => {
  let b = isLogin()
  if (!b) {
    return
  }

  const res: any = likesApi(parseInt(id as string))
  if (detail.value.isLikes) {
    detail.value.likesCount -= 1
    detail.value.isLikes = false
  } else {
    detail.value.likesCount += 1
    detail.value.isLikes = true
  }
}

//显示收藏夹
let VisibleCollection = ref(false)
const collect = async () => {
  //判断登录
  let b = isLogin()
  if (!b) {
    return
  }

  //判断是否收藏，如果收藏,取消收藏
  if (detail.value.isCollect) {
    let res = await cancelCollect(parseInt(id as string))

    ElMessage({
      message: '已取消收藏！',
      type: 'success'
    })
    detail.value.isCollect = false

    return
  }

  VisibleCollection.value = true
}

//去评论
let myComment = ref(null)

const toComment = () => {
  scrollToTop(myComment.value.comment.offsetTop - 60)
}

let VisibleAddCollect = ref(false)

//新建收藏夹
const handleAddCollect = () => {
  VisibleCollection.value = false
  VisibleAddCollect.value = true
}

const handleAddCollectClose = () => {
  VisibleAddCollect.value = false
  setTimeout(() => {
    VisibleCollection.value = true
  })
}

//跳转到用户页面
const toUser = (id: number) => {
  router.push({
    name: 'user',
    params: {
      id
    }
  })
}
</script>

<style scoped lang="scss">
.detail {
  .left {
    padding: 35px;
    box-sizing: border-box;
    background-color: var(--theme-bg4-color);

    .article-user {
      margin-bottom: 20px;
    }

    .article-thumbnail {
      width: 100%;
      margin-bottom: 20px;
    }

    .categoryInfo {
      margin-top: 30px;
      display: flex;
      align-items: center;
      height: 40px;

      .category {
        margin-right: 35px;
        color: var(--theme-text3-color);

        span {
          margin-left: 8px;
          display: inline-block;
          padding: 6px 10px;
          background-color: var(--theme-bg1-color);
          border-radius: 4px;
        }
      }

      .tags {
        span {
          margin-left: 8px;
          margin-right: 12px;
          display: inline-block;
          padding: 6px 10px;
          color: var(--theme-text5-color);
          background-color: var(--theme-bg5-color);
          border-radius: 4px;
        }
      }
    }
  }

  .article-suspended-panel {
    display: flex;
    flex-direction: column;
    position: fixed;
    margin-left: -7rem;
    top: 140px;
    z-index: 2;

    .likesActive {
      ::v-deep(.el-badge__content) {
        top: 8px;
        background-color: var(--theme-bg9-color);
      }

      span {
        color: var(--theme-bg9-color) !important;

        i:hover {
          color: var(--theme-bg9-color) !important;
        }
      }
    }

    ::v-deep(.el-badge__content) {
      top: 8px;
      background-color: var(--theme-bg10-color);
    }

    span {
      cursor: pointer;
      display: flex;
      background-color: var(--theme-bg4-color);
      justify-content: center;
      align-items: center;
      border-radius: 999px;
      width: 40px;
      height: 40px;
      color: var(--theme-text4-color);
      font-size: 18px;
      margin-bottom: 15px;

      i {
        font-size: 18px;

        &:hover {
          color: var(--theme-text3-color);
        }
      }

      svg:hover {
        color: var(--theme-text3-color);
      }
    }

    .collectActive {
      color: var(--theme-text5-color);

      :hover {
        color: var(--theme-text5-color);
      }
    }
  }
}

.title {
  font-size: 28px;
  margin-bottom: 20px;
}

.catalogue_sticky {
  position: fixed;
  box-sizing: border-box;
  width: 300px;
  top: 68px;
  background-color: var(--theme-bg4-color);
}

.userinfo {
  .userinfo-top {
    div:first-child {
      display: flex;

      .avatar {
        width: 40px;
        height: 40px;
        border-radius: 999px;
        margin-right: 10px;
        cursor: pointer;
      }

      .userinfo-top-left {
        flex: 1 1 auto;
        min-width: 0px;
        display: flex;
        flex-direction: column;
        justify-content: space-around;

        .nickName {
          cursor: pointer;
        }

        span {
          font-size: 12px;
          overflow: hidden; //超出文本隐藏
          white-space: nowrap; //不换行，只显示一行
          text-overflow: ellipsis; //超出部分省略号显示
        }
      }
    }

    & > div:last-child {
      margin-top: 15px;
      display: flex;
      justify-content: space-evenly;

      button {
        width: 120px;

        &:first-child {
          background-color: var(--theme-bg9-color);
          color: var(--theme-bg1-color);
        }

        &:last-child {
          background-color: var(--theme-bg5-color);
          color: var(--theme-text5-color);
        }
      }

      .hasFollow {
        background-color: var(--theme-bg1-color) !important;
        color: var(--theme-text2-color) !important;
      }
    }
  }

  .userinfo-bottom {
    display: flex;
    flex-direction: column;

    div:first-child {
      margin-bottom: 8px;
    }

    span {
      font-size: 14px;

      i {
        display: inline-flex;
        width: 25px;
        height: 25px;
        background-color: var(--theme-bg8-color);
        color: var(--theme-text7-color);
        border-radius: 999px;
        justify-content: center;
        align-items: center;
      }
    }
  }
}
</style>
