# 状态副本集（StatefulSet）

## 定义：

StatefulSet(状态副本集）对应于 kubernetes 中的 StatefulSet，相对于 Deployment（部署），StatefulSet 更适合有状态的业务，每个实例（Pod）都是按顺序启动，并且 Pod 的名称都是规律的。
例如 StatefulSet 的名称为 infra-wayne，则使用 StatefulSet 发布的实例名称为 infra-wayne-n，n 为从 0 到 replicas-1 的正整数。

## 操作

![示例](../images/StatefulSet.gif?classes=border,shadow)