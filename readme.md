[带动图部署文档](https://czl-logistics.feishu.cn/docx/OBLXdCYuIodZ86xbJ4zcT9TVnxg)
## 一、CZLOapi-获取key
网址：https://oapi.czl.net
#### 1. 注册与登录
注册送约500汉字的额度，因为太少，所以显示余额为0，实际是可以使用的
#### 2. 获取KEY,把生成的key粘贴出来保存
例子：sk-BdH2ECx9UeUmqI2j86B9E6Cf28Aa4b4dB89fA8580eD3BbAa
## 二、飞书开发平台新建应用
网址：https://open.feishu.cn/app/
#### 1. 新建应用，保存APPID和Secret
例子：cli_a41fe20b2539d00b、0kMAQp1c0ydxrBwkQHT7OgGMeHzXuuwr
#### 2. 前往应用功能-机器人, 创建机器人
#### 3. 获取Encrypt Key和Verification Token
例子：
44xyLjvx1s94sfTCddS8xf4Iif2UrTwZ
DC4rdwPrXTjc3Je12dt75cmk3mTyoX1G
## 三、部署Docker应用
#### 1. 获取docker镜像
``` 
docker pull woodchen/czlchat-feishu:<版本>
版本与模型对应：
3.5-0613:gpt-3.5-turbo-0613
3.5-0613-16k:gpt-3.5-turbo-0613-16k
4.0-0613:gpt-4-0613
```
#### 2. 部署容器
**环境变量**
``` 
1. BOT_NAME:上面添加的应用名称，在示例里是testgpt
2. APP_ID:上面第二步第1小步获取到的
3. APP_SECRET:上面第二步第1小步获取到的
4. OPENAI_KEY:上面第一步第2小步获取到的
5. APP_ENCRYPT_KEY：上面第二步第3小步获取到的
6. APP_VERIFICATION_TOKEN：上面第二步第3小步获取到的
```
**端口**
``` 
容器内端口为9000，外部端口可自定义
```
**命令部署**
``` 
docker run -d \
-e BOT_NAME=<BOT_NAME> \
-e APP_ID=<APP_ID> \
-e APP_SECRET=<APP_SECRET> \
-e OPENAI_KEY=<OPENAI_KEY> \
-e APP_ENCRYPT_KEY=<APP_ENCRYPT_KEY> \
-e APP_VERIFICATION_TOKEN=<APP_VERIFICATION_TOKEN> \
-p <外部端口>:9000 \
woodchen/czlchat-feishu:<版本>
```

#### 3. 反代以供访问
原理都相同
#### 4. 测试访问
访问地址为：https://访问地址/ping
访问显示应该为这样，如不对，请查看docker日志

## 四、飞书开发平台添加调用地址并发布版本
#### 1. 添加事件订阅地址和卡片消息地址
事件订阅格式为：https://访问地址/webhook/event
卡片消息地址为：https://访问地址/webhook/card
如图所示地址，只是因为视频为测试地址，所以保存不成功

#### 2. 添加权限和能力
在事件订阅板块，搜索三个词机器人进群、 接收消息、 消息已读, 把他们后面所有的权限全部勾选。进入权限管理界面，搜索图片, 勾选获取与上传图片或文件资源。 最终会添加下列回调事件:
``` 
- im:resource(获取与上传图片或文件资源)
- im:message
- im:message.group_at_msg(获取群组中所有消息)
- im:message.group_at_msg:readonly(接收群聊中@机器人消息事件)
- im:message.p2p_msg(获取用户发给机器人的单聊消息)
- im:message.p2p_msg:readonly(读取用户发给机器人的单聊消息)
- im:message:send_as_bot(获取用户在群组中@机器人的消息)
- im:chat:readonly(获取群组信息)
- im:chat(获取与更新群组信息)
```

#### 3. 创建版本并发布、审核应用
我这里开启了免审，不然一般会弹出一个审核按钮进入管理后台审核，点击进去审核通过就可以了
## 五、截止这里，已经可以使用了
#### 1. 在机器人消息上点回复即可连续对话
#### 2. 查看余额，此处为CZLOapi的余额
