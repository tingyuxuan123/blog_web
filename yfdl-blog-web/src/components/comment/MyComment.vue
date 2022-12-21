<template>
  <div class="myComment" ref="comment">
    <h1>评论</h1>
    <div class="sendComment" v-if="userStore.token">
      <div class="img"><img :src="userStore.userInfo.avatar" alt="" /></div>
      <send-comment
        @sendClick="getComment"
        :commentInfo="sendCommentinfo"
      ></send-comment>
    </div>
    <div class="sendComment" v-else>
      <div class="img">
        <img src="@/assets/icons/svg/notlogin.svg" alt="" />
      </div>
      <div class="tip">
        还为登录，快<span @click="scrollStore.isVisibleLoginForm = true"
          >登录</span
        >发表一下感受吧~
      </div>
    </div>

    <div
      v-if="comments.length > 0"
      class="comment-item"
      v-for="comment in comments"
    >
      <img :src="comment.avatar" alt="" />
      <div class="content">
        <div class="content-header">
          <span class="username"> {{ comment.username }}</span>
          <span class="createTime">{{ formatting(comment.createTime) }}</span>
        </div>
        <div class="content-comment" v-html="comment.content"></div>
        <div class="content-footer">
          <span
            @click="
              () => {
                likes(comment.id, comment)
              }
            "
            :class="{ likesActive: isLike(comment.id) }"
          >
            <svg-icon iconClass="likes"></svg-icon>
            {{ comment.likesCount > 0 ? comment.likesCount : '点赞' }}</span
          >
          <span @click.stop="replyClick(comment)">
            <svg-icon iconClass="message"></svg-icon>
            {{
              comment.children.length > 0 ? comment.children.length : '回复'
            }}</span
          >
        </div>
        <send-comment
          v-if="replyId == comment.id"
          @sendClick="getComment"
          :commentInfo="sendReply"
          @click.stop=""
        ></send-comment>
        <div class="replys" v-if="comment.children.length > 0">
          <div class="comment-item" v-for="reply in comment.children">
            <img :src="reply.avatar" alt="" />
            <div class="content">
              <div class="content-header">
                <span class="username">
                  {{ reply.username }} 回复 {{ reply.toCommentUserName }}
                </span>
                <span class="createTime">{{
                  formatting(reply.createTime)
                }}</span>
              </div>
              <div class="content-comment" v-html="reply.content"></div>
              <div class="content-footer">
                <span
                  @click="
                    () => {
                      likes(reply.id, reply)
                    }
                  "
                  :class="{ likesActive: isLike(reply.id) }"
                >
                  <svg-icon iconClass="likes"></svg-icon>
                  {{ reply.likesCount > 0 ? reply.likesCount : '点赞' }}</span
                >
                <span @click.stop="replyClick2(reply, comment.id)">
                  <svg-icon iconClass="message"></svg-icon> {{ '回复' }}</span
                >
                <send-comment
                  v-if="replyId == reply.id"
                  @sendClick="getComment"
                  :commentInfo="sendReply"
                  @click.stop=""
                ></send-comment>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref, onMounted } from 'vue'
import type { CommentInfo } from '@/api/apiType'
import { commentList, thumbsUp } from '@/api/comment'
import { formatting } from '@/utils/time'
import SendComment from './sendComment/SendComment.vue'
import { useUserStore } from '@/stores/userStore'
import { usescrollStore } from '@/stores/useScroll'
import type { SendCommentInfo } from '@/api/apiType'
import { useRoute } from 'vue-router'
import { isLogin } from '@/utils/utils'
import { likeCommentByArticle } from '@/api/likesComment'

const userStore = useUserStore()
const scrollStore = usescrollStore()
const route = useRoute()

type Props = {
  articleId: number
}

let pageinfo = {
  pageNum: 1,
  pageSize: 10
}

let replyId = ref(0)
onMounted(() => {
  document.addEventListener('click', () => {
    replyId.value = 0
  })
})

let sendCommentinfo = reactive<SendCommentInfo>({
  articleId: parseInt(route.params.id as string),
  type: 0,
  rootId: -1,
  toCommentId: -1,
  toCommentUserId: -1,
  content: ''
})

let sendReply = reactive<SendCommentInfo>({
  articleId: parseInt(route.params.id as string),
  type: 0,
  rootId: -1,
  toCommentId: -1,
  toCommentUserId: -1,
  content: ''
})

let comments = ref<CommentInfo[]>([])

const props = defineProps<Props>()

const getComment = async () => {
  const res = await commentList(pageinfo, props.articleId)
  comments.value = res.data?.rows
}

getComment()
//回复按钮点击
const replyClick = (comment: CommentInfo) => {
  let b = isLogin()
  if (!b) {
    return
  }

  replyId.value = comment.id

  sendReply.rootId = comment.id
  sendReply.toCommentId = comment.id
  sendReply.toCommentUserId = comment.createBy
}

const replyClick2 = (comment: CommentInfo, rootId: number) => {
  let b = isLogin()
  if (!b) {
    return
  }

  replyId.value = comment.id

  sendReply.rootId = rootId
  sendReply.toCommentId = comment.id //被评论的的评论id
  sendReply.toCommentUserId = comment.createBy //背评论的人
}

//点赞点击
const likes = async (commentId: number, comment: any) => {
  //判斷是否登录
  let b = isLogin()
  if (!b) {
    return
  }

  //判断是否点赞
  if (isLike(commentId)) {
    //如果点赞取消点赞
    likesCommentList.value = likesCommentList.value.filter((item) => {
      return item != commentId
    })

    comment.likesCount -= 1
  } else {
    //反之取消点赞
    likesCommentList.value.push(commentId)
    comment.likesCount += 1
  }

  const res = await thumbsUp(commentId, props.articleId)
}

const comment = ref<HTMLElement>()
defineExpose({ comment })

//获取这篇文章点赞过的评论
let likesCommentList = ref([])

const getLikeCommentByArticle = async () => {
  const res = await likeCommentByArticle(props.articleId)
  likesCommentList.value = res.data
  console.log(likesCommentList.value)
}

//判断是否点赞
const isLike = (commentId: number) => {
  console.log(
    likesCommentList.value.some((item) => {
      return item == commentId
    })
  )

  return likesCommentList.value.some((item) => {
    return item == commentId
  })
}

getLikeCommentByArticle()
</script>

<style scoped lang="scss">
.sendComment {
  display: flex;
  width: 100%;
  margin-bottom: 10px;
  .img {
    width: 60px;
    img {
      width: 40px;
      height: 40px;
      border-radius: 999px;
    }
  }
}
.myComment {
  flex: 1;
  margin-top: 20px;
  background-color: var(--theme-bg4-color);
  width: 100%;
  /* height: 500px; */
  box-sizing: border-box;
  padding: 20px;

  .tip {
    width: 100%;
    height: 70px;
    line-height: 70px;
    text-align: center;
    background-color: #f2f3f5;

    span {
      color: var(--theme-text5-color);
      margin: 0px 5px;
      cursor: pointer;
    }
  }

  h1 {
    font-size: 18px;
    margin-bottom: 20px;
  }

  .comment-item {
    & ~ .comment-item {
      padding-top: 16px;
    }
    width: 100%;
    display: flex;

    img {
      width: 35px;
      height: 35px;
      border-radius: 999px;
      margin-right: 15px;
    }
    .content {
      width: 100%;
      .content-header {
        width: 100%;
        display: flex;
        justify-content: space-between;

        .createTime {
          font-size: 12px;
          color: var(--theme-text3-color);
        }
      }
      .content-comment {
        margin-top: 10px;
        font-size: 14px;
        line-height: 24px;
        color: var(--theme-text3-color);
      }
      .content-footer {
        color: var(--theme-text6-color);
        line-height: 28px;

        span {
          margin-right: 10px;
          font-size: 14px;
          cursor: pointer;
        }
      }

      .likesActive {
        color: var(--theme-text-active-color);
      }
    }

    .replys {
      background-color: var(--theme-bg6-color);
      padding: 16px;
      box-sizing: border-box;
      margin-top: 16px;
      img {
        width: 25px;
        height: 25px;
      }
    }
  }
}
</style>
