<template>
  <div class="sendComment">
 
    <div class="content">
        <div class="input" contenteditable placeholder="请输入评论"></div>
        <div class="footer">
          <div class="emjoys"  :class="{visible:isVisible}"> <span class="emjoybtn" @click="emjoybtnClick"><svg-icon iconClass="表情"></svg-icon> 表情</span>  
            <div class="emjoyForm">
               <div class="list">
                  <div class="item" v-for="item in emjoys">
                    <span>
                      <img :src="item.url" alt="">
                    </span>
                  </div>                
               </div>
            </div>

          </div>
          <div class="sure">
            <el-button type="primary">评论</el-button>
          </div>
        </div>
    </div>
  </div>
</template>

<script lang='ts' setup >
import {reactive, ref ,onMounted,onUnmounted} from 'vue'
let emjoys=ref([])

let isVisible=ref(false)

type Props={
   
        
}

let getEmojys=()=>{
  const modulesFiles=import.meta.glob("@/components/comment/sendComment/emjoy/*.png")
  
  

  const arr=Object.keys(modulesFiles).map((i)=>{
    let fileName = i.replace(/(.*\/)*([^.]+).*/ig,"$2")  //获取文件名 
       
      return {name:fileName,url:i}
        
  })  

  return arr;

}
emjoys.value=getEmojys();


const emjoybtnClick=()=>{
  isVisible.value=!isVisible.value;
 
}






</script>

<style scoped lang='scss'>
  .content{


    .footer{
      margin-top: 8px;
      display: flex;
      align-items: center;
      justify-content: space-between;

      .emjoys{
        position: relative;

        .emjoybtn{
          &:hover{
            color: var(--theme-text5-color);
            cursor: pointer;
          }
        }
      }
    }
  }
  .input{
    font-size: 0;
    transition: all .3s;
    background: #fff;
    border: 1px solid var(--theme-text5-color);
    border-radius: 4px;
    position: relative;
    background: #fff;
    position: relative;
    padding: 8px 12px;
    color: #252933;
    outline: none;
    min-height: 64px;
    box-sizing: border-box;
    line-height: 22px;
    font-size: 14px;
    resize: both;
  }
.emjoyForm{
    display: none;
    position: absolute;
    top: 34px;
    left: 0;
    background: #fff;
    box-shadow: 0 8px 24px rgb(0 0 0 / 16%);
    border-radius: 2px;
    width: 416px;
    padding-top: 10px;

    &::after{
      content: "";
      width: 12px;
      height: 12px;
      background-color: inherit;
      position: absolute;
      left: 24px;
      top: -6px;
      transform: rotate(135deg);
    }

  .list{
    padding-left: 12px;
    padding-bottom: 12px;
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    height: 270px;
    overflow-y: scroll;
    user-select: none;
    .item {
      position: relative;
      width: 32px;
      height: 32px;
      margin-bottom: 8px;
      margin-right: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      

    span {
      /* color: #515767;
    font-size: 13px; */

      img{
        transform: translateZ(0);
        transition: transform .3s;
        display: block;
        height: 28px;

        &:hover{
          transform: scale(1.3);
        }
      }
    }
    }
  }
}

.visible{
  .emjoybtn{
    color: var(--theme-text5-color);
  }
  .emjoyForm{
    display: block;
  }
 
}


</style>