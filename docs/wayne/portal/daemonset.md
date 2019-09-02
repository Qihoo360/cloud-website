# 守护进程集（Daemonset）

## 定义：

守护进程集（DaemonSet）对应于 kubernetes 中的 DaemonSet 的概念，它确保所有（或某些）节点运行 Pod 的副本。

- 随着节点添加到群集中，会将 Pod 添加到群集中。

- 随着节点从群集中删除，这些 Pod 将被垃圾收集。

- 删除 DaemonSet 将清除它创建的 Pod。

## 操作

![示例](../images/daemonset.gif?classes=border,shadow)