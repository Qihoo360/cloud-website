# 用户安装步骤

> 本安装步骤为使用 Kubernetes 部署步骤，适用于生产环境

### 克隆代码仓库

```bash
$ go get github.com/Qihoo360/wayne
```

### 安装依赖环境

Wayne 依赖 MySQL ，其中 MySQL 是必须的服务，用户存储系统的各种数据。

```bash
$ kubectl apply -f hack/kubernetes/mysql.yaml
```

> 数据未进行持久化，生产环境一定要做数据持久化，避免数据丢失

### 数据库初始化

- 自动初始化(推荐)

Wayne 启动会自动创建数据库并初始化数据，使用自动初始化数据库的方式请勿手动创建数据库，否则系统检测到数据库已存在会跳过数据初始化步骤！

- 手动初始化

如果您的环境不允许自动创建数据库，可以使用手动初始化数据的方式。

1.创建数据库

```sql
CREATE DATABASE `wayne` CHARACTER SET utf8 COLLATE utf8_general_ci;
```

2.生成创建表结构 SQL

```bash
make sqlall
```

3.生成数据库初始化 SQL

```bash
make initdata
```

### 配置 Configmap

在 hack/kubernetes/wayne-backend.yaml 中按照[配置文档](../dev/configuration.md)配置好Configmap相关的信息（例如数据库链接等信息）

> 如果使用的是hack/kubernetes/mysql.yaml 中启动的 MySQL，可以暂时不修改配置文件。默认配置文件中通过集群内部域名访问 MySQL。

### 启动 Wayne后端

```bash
$ kubectl apply -f hack/kubernetes/wayne-backend.yaml
```

### 启动 Wayne前端

修改hack/kubernetes/wayne-frontend.yaml中的Configmap，找到config.js这个key所对应的内容，将"nodeip"替换为kubernetes集群中任意节点的ip，之后启动前端：

```bash
$ kubectl apply -f hack/kubernetes/wayne-frontend.yaml
```

现在可以通过 **http://nodeip:32000** 访问Wayne平台，默认管理员账号 admin:admin。


> 由于前后端使用 JWT Token 通信，生产环境一定要重新生成 RSA 文件，确保安全。生成 RSA 加密对命令如下：
```bash
$ ssh-keygen -t rsa -b 2048 -f jwtRS256.key
$ # Don't add passphrase
$ openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub
```

### 使用docker-compose启动wayne

此外，也可以直接使用docker-compose在本地启动wayne，流程如下：1.修改hack/docker-compose/conf/config.js ，将"localhostip"替换为本机物理网卡上的真实ip（可以通过浏览器访问）2.通过docker-compose命令启动wayne：

```bash
$ cd hack/docker-compose/
$ docker-compose up -d
```

### 配置集群

参考[集群配置](../admin/cluster.md)配置好 Kubernetes 集群访问信息。

### 配置 Namespace 可访问集群

必须配置 Namespace 可访问集群才可在前台创建相关的资源。

详见[Namespace 配置](../admin/namespace.md)。
