<template>
  <div class="myComment">
    <h1>评论</h1>
    <div v-if="comments.length>0" class="comment-item" v-for="comment in comments">
        <img :src="comment.avatar" alt="">
        <div class="content">
          <div class="content-header">
            <span class="username"> {{comment.username}}</span>
            <span class="createTime">{{formatting(comment.createTime)}}</span>
          </div>
          <div class="content-comment">
            {{comment.content}}
          </div>
          <div class="content-footer">
            <span> <svg-icon iconClass="likes"></svg-icon> {{ '点赞' }}</span>
            <span>  <svg-icon iconClass="message"></svg-icon> {{comment.children.length >0 ? comment.children.length : '回复'}}</span>
          </div>
          <div class="replys" v-if='comment.children.length>0'>
              <div class="comment-item" v-for="reply in comment.children">
                <img :src="reply.avatar" alt="">
                <div class="content">
                  <div class="content-header">
                    <span class="username"> {{reply.username}} 回复 {{reply.toCommentUserName }} </span>
                    <span class="createTime">{{formatting(reply.createTime)}}</span>
                  </div>
                  <div class="content-comment">
                    {{reply.content}}
                  </div>
                  <div class="content-footer">
                    <span> <svg-icon iconClass="likes"></svg-icon> {{ '点赞' }}</span>
                    <span>  <svg-icon iconClass="message"></svg-icon> {{ '回复'}}</span>
                  </div>
                </div>
              </div>
          </div>
        </div>

    
    </div>
    <send-comment v-else></send-comment>`
    
  </div>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import type {CommentInfo} from '@/api/apiType'
import {commentList} from '@/api/comment'
import {formatting} from '@/utils/time'
import SendComment from './sendComment/SendComment.vue'

type Props={
    articleId:number
}

let pageinfo={
  pageNum:1,
  pageSize:10
}

let comments=ref<CommentInfo[]>([])

const props=defineProps<Props>()

    console.log(props.articleId);

const getComment=async ()=>{

   const res= await commentList(pageinfo,props.articleId)
   
   comments.value=res.data?.rows;

   console.log(comments.value);
   
}

getComment();


</script>

<style scoped lang='scss'>
  .myComment{
    margin-top: 20px;
    background-color: var(--theme-bg4-color);
    width: 100%;
    /* height: 500px; */
    box-sizing: border-box;
    padding: 20px;

    h1{
      font-size: 18px;
      margin-bottom: 20px;
    }

    .comment-item{
      & ~ .comment-item{
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
      .content{
        width: 100%;
        .content-header{
          width: 100%;
          display: flex;
          justify-content: space-between;

          .createTime{
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
        .content-footer{
          color: var(--theme-text6-color);
          line-height: 28px;
          
          span {
            margin-right: 10px;
            font-size: 14px;
          }
        }
        
      }

      .replys{
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

