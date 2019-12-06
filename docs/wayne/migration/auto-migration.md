# 应用自动迁移

> 目前未支持的资源可通过[应用手动迁移](manual-migration.md)进行其它资源的迁移

## 1.创建项目

选择要迁移的部门（Namespace）, 点击创建项目创建相应的项目。如果要迁到的项目已经存在，跳过此步骤。

![](../images/portal-migration.png?classes=border,shadow)

## 2.迁移资源

这里以 `Deployment` 为例, 演示迁移流程。

进入管理后台,点击 Kubernetes -> Deployment, 点击要迁移的部署，点击迁移按钮。

![](../images/portal-migration-deployment-auto.png?classes=border,shadow)

选择要迁移到的项目，点击确定

![](../images/portal-migration-deployment-deploy-auto.png?classes=border,shadow)

返回前台，进入到刚才选择的项目，发布到相应机房即可。

![](../images/portal-migration-deployment-deploy.png?classes=border,shadow)

