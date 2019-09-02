# 名词解释

Wayne 平台涉及到的基本概念如下：


| Wayne   | Kubernetes                                                                                                                                                                                                              |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 部门        | Namespace， 为 Kubernetes 集群提供虚拟的隔离作用，详细参考 [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) 。Wayne 的部门可以对应 Kubernetes 的任意 Namespace, 具体参见配置文档。 |
| 项目        | 无 Kubernetes 对应概念。是 Wayne 平台为了组织 Kubernetes 的资源虚拟出来的概念。项目下可以包含 Kubernetes 的资源，例如 Deployment，Service 等                                                                                      |
| 部署        | Deployment，您在 Deployment 对象中描述了所需的状态，Deployment 控制器以受控速率将实际状态更改为所需状态。详细参考 [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) 。                   |
| 状态副本集   | StatefulSet，用来管理有状态应用，可以保证部署和 scale 的顺序，详细参考 [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) 。                                                         |
| 守护进程集   | DaemonSet，保证在每个 Node 上都运行一个容器副本，常用来部署一些集群的日志、监控或者其他系统管理应用，详细参考 [Daemonset](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) 。                      |
| 计划任务   | CronJob，Job负责批处理任务，即仅执行一次的任务，它保证批处理任务的一个或多个容器成功结束。CronJob是基于调度的Job执行将会自动产生多个job，调度格式参考Linux的cron系统，详细参考 [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) 。          |
| 负载均衡 | Service，Kubernetes Service 是一个抽象，它定义了一组逻辑 Pod 和一个访问它们的策略。详细参考 [Service](https://kubernetes.io/docs/concepts/services-networking/service/) 。                                                |
| 路由   | Ingress，是用来聚合集群内服务的方式，对应的是 Kubernetes 的 Ingress 资源，后端使用了 Nginx Controller 来处理具体规则。Ingress 可以给 service 提供集群外部访问的 URL、负载均衡、SSL termination、HTTP 路由等。详细参考 [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) 。 |
| 配置集      | ConfigMap，存放应用的配置信息。详细参考  [ConfigMap](https://kubernetes.io/docs/concepts/configuration/overview/)                                                                             |
| 加密字典     | Secret，存放一些敏感配置，例如密码，证书等信息。详细参考 [Secret](https://kubernetes.io/docs/concepts/configuration/secret/)                          |
| 存储索取  | PersistentVolumeClaim（PVC），满足用户对于持久化存储的需求，用户将 Pod 内需要持久化的数据挂载至存储卷，实现删除 Pod 后，数据仍保留在存储卷内。                                                                          |