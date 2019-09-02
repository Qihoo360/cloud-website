# 部署（Deployment） 

## 定义：

部署（Deployment）对应 kubernetes 的 Deployment 的概念，是一组服务实例（Pod）的组合。用户在 Deployment 对象中描述了所需的状态，Deployment 控制器以一定的策略将实际状态更改为所需状态。

## 状态说明

点击部署，即可进入部署管理页面，部署页面会显示当前部署的所有模版以及当前模版上线的机房。

绿色代表服务正常，如果是黄色表示当前部署尚未达到期望状态，如果是灰色代表链接改集群失败。

![](../images/portal-deployment.png?classes=border,shadow)

## 异常查看

当部署结果出现异常时，机房标签右边会出现一个感叹号，点击感叹号集合查看具体的出错事件。

![](../images/portal-deployment-error.png?classes=border,shadow)

## Pod 列表

点击机房标签可以查看当前部署的 Pod 列表，可以对 Pod 进行一些操作，例如删除 Pod，查看日志，进入容器等。

![](../images/portal-pod.gif?classes=border,shadow)

## 模版编辑

点击创建模版或者基于某个模版克隆，即可进入模版编辑页面。表单默认提供了一些常用的属性的设置，如镜像、环境变量等。

![](../images/portal-deployment-tpl.png?classes=border,shadow)

如果需要自定义一些高级配置，可以点击高级配置按钮 , 通过编辑 Json 或者 Yaml 自定义模版。

![](../images/portal-deployment-tpl-advance.png?classes=border,shadow)

编辑好模版后填写发布说明（发布说明必须填写）点击保存即可。

创建好模版后即可对模版进行发布下线等操作。

## 下线资源

拥有项目下线权限的用户可以下线已上线资源。下线时选择相应的模版和机房即可下线。

![](../images/portal-deployment-offline.png?classes=border,shadow)

> 下线时一定要仔细检查需要下线的机房，避免误下线其他机房资源。


