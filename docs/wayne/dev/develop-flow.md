# 开发者安装步骤
> 如果您是一名开发者，可以阅读这篇文档，了解如何将Wayne部署在开发者环境下

## 环境准备

确保安装了以下软件并将其添加到 $PATH 变量中：

- Golang 1.12+ ([installation manual](https://golang.org/dl/))
- Docker 17.05+ ([installation manual](https://docs.docker.com/install))
- bee  ([installation manual](https://github.com/beego/bee))
- Node.js v11+ and npm 6.5+ ([installation with nvm](https://github.com/creationix/nvm#usage))
- MySQL 5.6+ (Wayne 主要数据都存在 MySQL 中)

## 快速启动

### 开发环境准备
服务依赖 MySQL，若没有可用实例，可通过 Docker 启动本地环境：

使用以下命令启动mysql容器（docker-compose文件参考wayne/hack/docker-compose/docker-compose.yaml）：

```bash
$ docker-compose up -d mysql
```

### 本地启动

克隆 Wayne 仓库到 **$GOPATH/src/github.com/Qihoo360/wayne**

```bash
$ go get github.com/Qihoo360/wayne
```

初始化 Wayne 所需 plugins，执行如下操作：

```bash
$ cd $GOPATH/src/github.com/Qihoo360/wayne
$ git submodule update --init --recursive 
```

创建开发所需配置文件：

```bash
$ touch src/backend/conf/dev.conf
```

> 如果复制 app.conf 中的内容到 dev.conf，必须去掉 include "dev.conf" 否则会出现循环引用导致内存溢出。

> 参考 [配置文件](configuration.md), 正确配置系统启动所需参数。

> 在 dev.conf 中写入数据库等相关配置，dev.conf 会覆盖 app.conf 中的配置

编译后端服务的时候，需要在编译环境开启 go module

Linux
```bash
$ export GO111MODULE=on
```

Windows
```bash
$ set GO111MODULE=on
```

**启动后端服务：**

```bash
$ cd $GOPATH/src/github.com/Qihoo360/wayne && make run-backend
```

**启动前端服务：**

- 安装前端依赖

```bash
$ cd src/frontend && npm install --no-save
```

- 启动前端服务

```bash
$ cd $GOPATH/src/github.com/Qihoo360/wayne && make run-frontend
```

现在你可以通过 http://localhost:4200 访问 Wayne 服务了 !

> 默认管理员账号 admin:admin, 正式环境一定注意修改 admin 密码，详细配置参考配置文档 [集群配置](../admin/cluster.md)

## 构建 Wayne 镜像

** 构建 server 和 ui 编译镜像 **

```bash
$ make build-server-image
$ make build-ui-image
```

**构建发布镜像**
```bash
$ make 
```

> Wayne 的官方镜像将同步到如下仓库:  [360 搜索私有云团队](https://hub.docker.com/u/360cloud/)

> 作为开发者，你还可以参考 Wayne 的发版流程 [发版流程](e-flow.md)

