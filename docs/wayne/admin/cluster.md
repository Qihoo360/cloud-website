# 集群配置

## 简介

集群配置主要说明如何在 Wayne 平台上创建和管理集群

## 创建集群

后台点击集群列表-> 创建集群

创建集群字段说明：

- 名称：集群名称，英文简写，后续会使用此名称作为集群调用参数，例如 K8S

- Master : Kubernetes Apiserver 地址

- kubeConfig: 链接 Apiserver 的配置文件。配置示例：

 ``` yaml
kind: Config
apiVersion: v1
preferences: {}
clusters:
  - name: k8s-dev
    cluster:
      server: 'https://10.10.10.10'
      certificate-authority-data: base64encode
users:
  - name: admin
    user:
      client-certificate-data: base64encode
      client-key-data: base64encode
contexts:
  - name: k8s-dev-context
    context:
      cluster: k8s-dev
      user: admin
      namespace: default
current-context: k8s-dev-context
 
 ```

 参考 [Kubernetes 文档](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)

 - 集群状态：目前有两种状态，在线和维护中。集群需要临时维护时，可以把集群状态设置为维护中，避免用户误操作影响维护中的集群。

 - MetaData：集群元数据（可选）

 配置示例

 ```yaml
 # 可选 
 # 由于当前 Wayne 并没有完全管理 Kubernetes 资源（后续会完全管理 Kubernetes 资源），系统集成了 Kubernetes Dashboard 方便查看 Kubernetes 资源。
 # 此地址 schema 必须与平台一致，例如平台使用 https 部署，则 kubernetesDashboard 地址也必须为 https
 kubernetesDashboard: 'http://10.10.10.10'
 # 可选
 # 如果配置了此选项，则当前集群创建 PV 时如果类型为 RBD 会自动替换此配置，避免了每次重复填写 rbd 配置
 rbd:
   monitors:
     - '10.10.10.10:6789'
   fsType: xfs
   pool: k8s_pool
   user: xxx
   keyring: xxx
 # 可选。
 # 如果配置了此选项，则当前集群创建 PV 时如果类型为 cephfs 会自动替换此配置，避免了每次重复填写 cephfs 配置
 cephfs:
   monitors:
     - 10.10.10.10
   user: xxx
   secret: xxx
 # 可选。
 # env：默认增加的环境变量，默认为所有容器添加默认环境变量，如 IDC 等信息。
 env:
   - name: WAYNE_IDC
     value: k8s
 # 可选。
 # imagePullSecrets：默认增加的拉取镜像 Secret，如果是从私有仓库拉取镜像并且需要拉取权限，可以配置此选项。
 imagePullSecrets:
   - name: wayne.cloud-secret

 ```
