# 存储索取（PVC）

## 简介

拥有 PVC_CREATE 权限的用户可以在前台自助创建 PersistentVolumeClaim，管理员用户也可以在后台创建和编辑 PersistentVolumeClaim。

## 创建

进入项目详情点击 PVC，填写容量，访问模式等信息，创建相应的 PVC。PVC 会根据 Label 绑定合适的 PV，如果未绑定成功，管理员在后台创建相应的 PV 即可。

![](../images/admin-pvc.png?classes=border,shadow)