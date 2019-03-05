# 部署文档

## 使用Kubernetes部署

> 生产环境中推荐使用 kubernetes 部署

### 克隆代码仓库

```bash
$ go get github.com/Qihoo360/wayne
```

### 安装依赖环境（可选）

Wayne 依赖 MySQL 和 RabbitMQ，其中 MySQL 是必须的服务，用户存储系统的各种数据，RabbitMQ 是可选的，主要用户扩展审计功能使用。

```bash
$ kubectl apply -f hack/kubernetes/dependency
```

> 数据未进行持久化，生产环境一定要做数据持久化，避免数据丢失

### 数据库初始化

- 自动初始化(推荐)

Wayne启动会自动创建数据库并初始化数据，使用自动初始化数据库的方式请勿手动创建数据库，否则系统检测到数据库已存在会跳过数据初始化步骤！

- 手动初始化

如果您的环境不允许自动创建数据库，可以使用手动初始化数据的方式。

1.创建数据库

```sql
CREATE DATABASE `wayne` CHARACTER SET utf8 COLLATE utf8_general_ci;
```

2.生成创建表结构sql

```bash
make sqlall
```
生成文件在 _dev/wayne.sql

3.生成数据库初始化sql

```bash
make initdata
```
生成文件在 _dev/wayne-data.sql

### 配置Configmap

在 hack/kubernetes/wayne/configmap.yaml中按照[配置文档](../admin/cluster.md)配置好相关的信息（例如数据库链接等信息）

> 如果使用的是hack/kubernetes/dependency中启动的MySQL 和 RabbitMQ 服务，可以暂时不修改配置文件。默认配置文件中通过集群内部域名访问MySQL 和 RabbitMQ。

### 启动Wayne

```bash
$ kubectl apply -f hack/kubernetes/wayne
```

现在可以通过 **http://yourip:NodePort** 访问Wayne平台，默认管理员账号 admin:admin。


> 由于前后端使用 JWT Token 通信，生产环境一定要重新生成 RSA 文件，确保安全。生成 rsa 加密对命令如下：
```bash
$ ssh-keygen -t rsa -b 2048 -f jwtRS256.key
$ # Don't add passphrase
$ openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub
```

### 配置集群

参考[集群配置](../admin/cluster.md)配置好 Kubernetes 集群访问信息。

### 配置 Namespace 可访问集群

必须配置Namespace可访问集群才可在前台创建相关的资源。

详见[Namespace 配置](../admin/namespace.md)。
