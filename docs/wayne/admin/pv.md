# 存储（PV）

## 简介

PersistentVolume 配置主要说明如何在 Wayne 平台上创建和管理 PersistentVolume，适合于需要手动管理 PV 的场景。

## 创建

PV 仅允许管理员在后台创建和编辑 PersistentVolume。

后台点击 PV-> 列表-> 创建持久化存储 

目前表单支持的 PV 类型为 RBD 和 Cephfs， 表单不支持的类型可以在高级配置中配置。

> 注意：如果 Cluster 中配置了 rbd 和 cephfs 默认配置，会自动覆盖 PV 类型为 rbd 或者 cephfs 的配置。详见 [集群配置](/admin/cluster)