# 部门（Namespace） 

## 简介

这部分主要说明如何在 Wayne 平台上创建和管理部门。
由于 Namespace 可访问集群需在后台配置后前台才可使用相应的集群，因此必须先配置 Namespace 的集群才可在前台创建相关的资源。

## 创建命名空间

后台点击命名空间列表-> 创建命名空间

![](../images/admin-create-namsepace.png?classes=border,shadow)

创建命名空间字段说明：

- 名称：必填，命名空间名称。英文中划线分隔。

- K8S 命名空间 ：必填，对应的 Kubernetes 中 Namespace，如果Kubernetes中没有相应的 Namespace， 需手动在Kubernetes集群中创建改Namespace。

- 可用机房：必填，该 Namespace 可以使用的机房。该 Namespace 下的用户仅可以看到已设置的机房。CPU (核)和内存（G）表示当前 Namespace 最多可使用的资源，0代表无限制。

- 环境变量配置： 可选，默认增加的环境变量，默认为所有容器添加默认环境变量。会覆盖集群中配置的 env

- ImagePullSecrets：可选，默认增加的拉取镜像 Secret，如果是从私有仓库拉取镜像并且需要拉取权限，可以配置此选项。会覆盖集群中配置的 imagePullSecrets

