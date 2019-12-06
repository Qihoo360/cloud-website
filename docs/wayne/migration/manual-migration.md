# 应用手动迁移

## 1.创建项目

选择要迁移的 Namespace, 点击创建项目创建相应的项目。如果要迁到的项目已经存在，直接点击项目详情进入项目。

![](../images/portal-migration.png?classes=border,shadow)

## 2.配置应用

这里以 `Deployment` 为例, 演示迁移流程。

进入项目后，点击`部署`，`创建部署`（部署名称需与 Kubernetes 已存在部署名称一致）, 选择部署可发布的机房以及发布的实例数（实例数发布时也可修改）。

![](../images/portal-migration-deployment.png?classes=border,shadow)

创建好部署后，点击 `创建部署模版` -> `高级配置`

![](../images/portal-migration-deployment-tpl.png?classes=border,shadow)

粘贴 Kubernetes 资源到高级模式模版中 -> 点击保存，填写发布说明。

![](../images/portal-migration-deployment-ace.png?classes=border,shadow)

在部署模版页面点击发布，选择机房，填写发布的实例数即可发布到相应机房。

![](../images/portal-migration-deployment-deploy.png?classes=border,shadow)


