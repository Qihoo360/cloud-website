# 配置文件

## 简介

Wayne 的默认配置是 [app.conf](https://github.com/QIhoo360/wayne/src/backend/conf/app.conf)。实践中用户可以通过在 app.conf 中追加如下字段来包含自定义配置：

```bash
$ include "dev.conf"
```

**基本配置**

[参考 beego 配置](https://beego.me/docs/mvc/controller/config.md)

- appname: App 名称 
- httpport: 应用监听端口
- runmode: 运行模式，开发模式（dev）或者生产模式（prod）
- autorender: 是否模板自动渲染，默认值为 true，对于 API 类型的应用，应用需要把该选项设置为 false，不需要渲染模板。
- copyrequestbody: 是否允许在 HTTP 请求时，返回原始请求体数据字节，默认为 false （GET or HEAD or 上传文件请求除外）。
- EnableDocs: 是否开启文档内置功能，默认是 false
- EnableAdmin: 是否开启进程内监控模块，默认 false 关闭。            
- StaticDir: 静态文件目录设置，此处设置为 public:static
- ShowSql: Log 是否记录 SQL 语句，默认 false

**登录基本配置**

- EnableDBLogin: 是否启用数据库登录
- RsaPrivateKey:  RsaPrivate 文件路径，用于 JWT Token 加密。
- RsaPublicKey: RsaPublicKey 文件路径，用于 JWT Token 解密。
- TokenLifeTime: Token 有效期，秒。

**标签设置**

此处设置会自动在 Deployment，Service 等资源上添加相应 label

- AppLabelKey: 项目名称标签，默认值：wayne-app
- NamespaceLabelKey： 项目所在命名空间标签，默认值：wayne-ns
- PodAnnotationControllerKindLabelKey： 资源类型 Annotation，默认值： wayne.cloud/controller-kind

**数据库配置**

- DBTns: 数据库 Tns，示例：tcp(127.0.0.1:3306)
- DBName: 数据库名称 示例： wayne
- DBUser: 数据库用户名，示例： root
- DBPasswd: 数据库密码，示例：root
- DBLoc: 数据库 Location，示例：Asia%2FShanghai
- DBConnTTL: 数据库心跳时间，秒  示例：30

**Web Shell**

- appKey: 生成 Web Shell Token 的 Key，线上一定要修改此值

**Demo 相关**

- DemoGroupId: 用于添加默认命名空间权限。 默认为 1，访客
- DemoNamespaceId: Demo 命名空间 ID，默认 1

**日志相关**

- LogLevel: 日志级别，示例: 4
- SentryEnable: 是否启用 Sentry，如果启用 Sentry，请设置此值为 true
- SentryDSN: SentryDSN
- SentryLogLevel: 发送 Sentry 的日志级别

**Robin 相关**

> Robin 为手动管理 PV 和存储卷的组件，如果没有此组件，EnableRobin 设置为 false 即可 (目前暂无 Robin 社区版，可以关闭。)

- EnableRobin: 是否启用 Robin 相关功能

**开放平台相关**

- EnableApiKeys: 是否启用开放平台相关功能

**Bus 相关**

> Bus 组件负责处理 Wayne 全部的 发布-订阅 模型的任务，例如账单、审计日志、webhook 等。

- BusEnable: 是否启用 Bus。
- BusRabbitMQURL: RabbitMQURL 地址，示例: amqp://guest:guest@rabbitmq:5672

**Webhook 相关**

- EnableWebhook: 是否启用 webhook，如果启用，请设置为 true
- WebhookClientTimeout: webhook 回调的超时时间
- WebhookClientWindowSize: 允许同时回调的 webhook 窗口大小，额外的回调请求会放在等待队列中

**上线相关配置**

> 采用 Canary/Production 上线模式
  如果项目 metaData 配置了 {"mode":"beta"}，则点击项目详情跳转到 beta 域名

- BetaUrl: https://beta.wayne.cloud
- AppUrl: https://www.wayne.cloud


**Oauth 2.0 登录配置**
```conf
$ [auth.oauth2]
$ enabled = false
$ redirect_url = "https://www.wayne.cloud"
$ client_id = client
$ client_secret = secret
$ auth_url = https://example.com/oauth2/v1/authorize
$ token_url = https://example.com/oauth2/v1/token
$ api_url = https://example.com/oauth2/v1/userinfo
$ api_mapping = name:name,email:email,display:display
```
> 配置中 auth.qihoo 为 Oauth2 示例授权登录，如需使用自定义 Oauth2 授权，需自行实现，参照：
src/backend/oauth2/default.go 的实现

- enabled：是否启用 OAuth2 登录，true or false
- redirect_url：授权回调地址
- client_id： OAuth2 client_id
- client_secret： OAuth2 client_secret
- auth_url： OAuth2 获取 Code URL
- token_url：OAuth2 获取 Token URL
- api_url：OAuth2 获取用户信息 URL
- api_mapping：可选，OAuth2 授权中获取用户信息接口对应的字段，name 为用户名称，email 为用户邮箱，display 为用户别名, 
例如 api_url 中返回的用户名称为 username，则配置为 name:username,email:email,display:display

**LDAP 登录配置**

```conf
$ [auth.ldap]
$ enabled = false
$ ldap_url = ldap://127.0.0.1
$ ldap_search_dn = "cn=admin,dc=example,dc=com"
$ ldap_search_password = admin
$ ldap_base_dn = "dc=example,dc=com"
$ ldap_filter =
$ ldap_uid = cn
$ ldap_scope = 2
$ ldap_connection_timeout = 30
```

- enabled：enable LDAP login, true or false
- ldap_url: The LDAP endpoint URL (e.g. ldaps://ldap.mydomain.com).
- ldap_search_dn: The DN of a user who has the permission to search an LDAP/AD server (e.g. uid=admin,ou=people,dc=mydomain,dc=com).
- ldap_search_pwd: The password of the user specified by ldap_search_dn.
- ldap_base_dn: The base DN to look up a user, e.g. ou=people,dc=mydomain,dc=com.
- ldap_filter:The search filter for looking up a user, e.g. (objectClass=person).
- ldap_uid: The attribute used to match a user during a LDAP search, it could be uid, cn, email or other attributes.
- ldap_scope: The scope to search for a user, 1-LDAP_SCOPE_BASE, 2-LDAP_SCOPE_ONELEVEL, 3-LDAP_SCOPE_SUBTREE. Default is 2.
- ldap_connection_timeout: max connection timeout second.

## 数据库热配置

数据库配置作为配置文件配置的一种补充，可以实现热更新，支持的配置如下：

- system.title: 系统 Nav 显示的 title

- system.image-prefix: Deployment,StatefulSet 等允许的镜像前缀，适用于适用私有仓库并且仅允许从特定私有仓库拉取镜像的场景。使用正则，例如：^gcr.io/.* 表示仅允许拉取 gcr.io/ 开头的镜像

- system.monitor-uri: 系统监控地址，用于从平台直接跳转 Grafana 监控平台，不如为空则不显示跳转监控按钮。URL 中的 {{app.name}} 将会自动替换为当前 App 名称。例如：此项配置为 https://github.com/{{app.name}} ，点击项目名称为 wayne 的查看监控按钮会自动跳转到 https://github.com/wayne

- system.api-name-generate-rule: 资源名称生成规则，默认所有的资源名称都会自动拼接 App 名称，例如 App 名称为 Wayne，创建部署时部署名称会自动拼接 wayne- 前缀。可选值：join，none .join 表示自动拼接，none 表示保持原来的值。

- system.oauth2-title: OAuth2 登录 title，前端登录界面开启 OAuth2 登录后按钮显示的内容，默认为 OAuth 2.0 Login。
