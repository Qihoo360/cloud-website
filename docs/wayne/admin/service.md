# 负载均衡（Service）

## 简介

Service 配置主要说明如何在 Wayne 平台上创建和管理 Service

## 创建

拥有 SERVICE_CREATE 权限的用户可以在前台自助创建 Service，管理员用户也可以在后台创建和编辑 Service。

![](../images/admin-service.png?classes=border,shadow)

元数据说明：

```
{     // 当前 Service 可发布集群
      // 创建时自动生成
	  "clusters": [
          "K8S"
        ]
}
```