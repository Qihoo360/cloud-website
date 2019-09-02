# 存储索取（PVC）
## 简介
PersistentVolumeClaim（PVC）是 kubernetes 对持久化存储资源的抽象，使得用户可以在不关心具体存储技术细节的情况下方便使用持久化存储。

## 状态说明

发布 PVC 后，PVC 部署状态中的状态会指示当前 PVC 已上线机房的状态：

- **Pending** PVC 未绑定，需要平台管理员分配 PV 与持久化存储数据卷
- **Bound** PVC 已绑定，可以在容器中使用

![创建 PVC 模板](../images/portal-pvc.png?classes=border,shadow)

## 创建 PVC

点击 PVC，即可进入 PVC 管理页面，该页面会显示所有 PVC 以及当前 PVC 上线的模板和历史模板以及部署状态。

点击 “创建 PVC” 可以新建 PVC；创建 PVC 后，需要创建 PVC 模板具体描述对持久化存储的需求。有 PVC 模板配置示例如下图所示：

![创建 PVC 模板](../images/portal-pvc-tpl.png?classes=border,shadow)

## 使用 PVC

当 PVC 处在 Bound 状态时，可以供容器使用。

### 1. 配置数据卷

在部署中使用 PVC，需要先在`部署管理页面` 使用高级配置编辑部署模板中的 `spec.template.spec.volumes` 字段，添加 PVC 作为该部署的存储卷。`name` 字段是数据卷名称，可以自定 ；`persistentVolumeClaim.claimName` 是在 PVC 管理页面中创建的 PVC 的名称。示例配置如下：

```yaml
spec:
  template:
    spec:
      volumes:
        - name: custom-volume-name
          persistentVolumeClaim:
            claimName: test-storage
```

### 2. 挂载 PVC

然后，继续编辑部署模板，在需要使用 PVC 的容器中挂载上面配置数据卷即可。**注意： `volumeMounts.name` 字段需要填写上方配置的数据卷名称，而不是 PVC 名称**。示例配置如下：

```yaml
spec:
  template:
    spec:
      containers:
        - volumeMounts:
            - mountPath: /your/mount/point/path
              name: custom-volume-name
```
